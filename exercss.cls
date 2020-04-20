%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE: exercss.cls
% AUTHOR: Gaetano Geck
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter



%---------------------------------------------------------------------
% IDENTIFY
%---------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exercss}%
	[2020/04/19 Simple class for exercises, building on exerthss]



%---------------------------------------------------------------------
% STRONG DEPENDENCIES
%---------------------------------------------------------------------
\RequirePackage{etoolbox}
\RequirePackage{pgfopts}



%---------------------------------------------------------------------
% OPTIONS FOR THIS CLASS
%---------------------------------------------------------------------
\newcommand{\exercss@classOptions}{%
	exercise%
}
\newcommand{\exercss@addClassOption}[2]{
	\ifx#2\pgfkeysnovalue%
		\edef\exercss@classOptions{\exercss@classOptions,#1}%
	\else%
		\edef\exercss@classOptions{\exercss@classOptions,#1=#2}%
	\fi%
}

\newcommand{\exercssOptions}[1]{%
	\pgfkeys{%
		/exercss/.cd,%
		#1,%
	}%
}
\exercssOptions{
	meta/.is family,
	layout/.is family,
}

%-----------------------------------------------------------
% META-INFORMATION
%-----------------------------------------------------------
\def\exercss@authors{}
\newcommand{\exerciseMeta}[1]{%
	\exercssOptions{%
		meta/.cd,%
		#1,%
	}%
}
\exerciseMeta{%
	course name/.store in=\exercss@courseName,
	course name short/.store in=\exercss@courseNameShort,
	semester/.store in=\exercss@semester,
	sheet number/.store in=\exercss@sheetNumber,
	group/.store in=\exercss@group,
	author/.code={\listadd{\exercss@authors}{#1}},
	authors short/.store in=\exercss@authorsShort,
	%
	sheet title left/.store in=\exercss@sheetTitleLeft,
	sheet title right/.store in=\exercss@sheetTitleRight,
	sheet title left={%
		\exercss@insertWithNewline{\exercss@courseName}%
		\exercss@insertWithNewline[\exercss@sheetNumber]%
			{\exercss@insertSheetName}%
		\exercss@insertWithNewline[\exercss@group]%
			{\exercss@insertGroupName}%
	},
	sheet title right={%
		\exercss@insertAuthors%
	},
	%
	ask/.code={%
		\exerciseMeta{#1=\exerthss@askForDefinition{#1}}%
	},
	ask for definition/.style={
		ask=course name,
		ask=course name short,
		ask=semester,
		ask=sheet number,
		ask=group,
		ask=authors short,
	},
}

%-----------------------------------------------------------
% LAYOUT
%-----------------------------------------------------------
\newcommand{\exercss@layoutOptions}[1]{%
	\exercssOptions{%
		layout/.cd,%
		#1,%
	}%
}
\exercss@layoutOptions{
	% LAYOUT ---------------------------
	layout/.code 2 args={%
		\csgdef{exerthss@layout#1}{#2}%
	},
	layout after/.code 2 args={%
		\csgdef{exerthss@layout#1@after}{#2}%
	},
	%
	layout={sheet title}{\sffamily\bfseries},
	layout={exercise number}{\arabic},
	layout={subexercise number}{\alph},
	layout={subsubexercise number}{\roman},
	layout after={exercise number}{)},
	layout after={subexercise number}{)},
	layout after={subsubexercise number}{)},
	layout={exercise title}{(},
	layout after={exercise title}{)},
	layout={exercise}{\sffamily\bfseries\boldmath},
	layout={subexercise}{\sffamily\bfseries},
	layout={subsubexercise}{\sffamily\bfseries},
	layout={header}{\sffamily},
	layout={footer}{\sffamily},
}

\exercssOptions{
	.unknown/.code={
		\exercss@addClassOption{\pgfkeyscurrentname}{\pgfkeyscurrentvalue}
	},
}

\ProcessPgfOptions*



%---------------------------------------------------------------------
% START FROM exerthss
%---------------------------------------------------------------------
\LoadClass[\exercss@classOptions]{exerthss}



%---------------------------------------------------------------------
% WEAK DEPENDENCIES
%---------------------------------------------------------------------
\RequirePackage{translations}
\DeclareTranslationFallback{ggex-exercise}{Exercise}
\DeclareTranslation{German}{ggex-exercise}{Aufgabe}
\DeclareTranslationFallback{ggex-sheetname}{Homework}
\DeclareTranslation{German}{ggex-sheetname}{Übungsblatt}
\DeclareTranslationFallback{ggex-group}{Group}
\DeclareTranslation{German}{ggex-group}{Gruppe}



%=====================================================================
% HELPERS
%=====================================================================
\newcommand{\exercss@insertWithNewline}[2][]{%
	\ifstrempty{#1}{%
		\exercss@insertWithNewline@Two{#2}{#2}%
	}{%
		\exercss@insertWithNewline@Two{#1}{#2}%
	}%
}
\newcommand{\exercss@insertWithNewline@Two}[2]{%
	\expandafter\ifstrempty\expandafter{#1}{}{#2\\ }%
}
\newcommand*{\exercss@insertSheetName}{%
	\GetTranslation{ggex-sheetname}~\exercss@sheetNumber%
}
\newcommand*{\exercss@insertGroupName}{%
	\GetTranslation{ggex-group}~\exercss@group%
}
\newcommand{\exercss@insertExerciseName}{%
	\GetTranslation{ggex-exercise}~%
	\arabic{exercise}%
}
\newcommand{\exercss@insertAuthorsShort}{%
	\exercss@authorsShort%
}



%=====================================================================
% OUTER SETTINGS
%=====================================================================
\RequirePackage{scrlayer-scrpage}
\RequirePackage{lastpage}
\clearpairofpagestyles
\ihead{%
	\ifnum\value{page}=1\else%
		\exerthss@layout{header}{%
			\exercss@courseNameShort, 
			\exercss@insertSheetName%
		}%
	\fi%
}
\chead{}
\ohead{%
	\ifnum\value{page}=1\else%
		\exerthss@layout{header}{\exercss@insertAuthorsShort}%
	\fi%
}
\cfoot{%
	\exerthss@layout{footer}{\thepage~/~\pageref{LastPage}}%
}



%=====================================================================
% INNER SETTINGS (itemize, enumerate, ...)
%=====================================================================
\tcbset{
	invisible/.style={
		breakable,
		colback=white,
		colbacktitle=white,
		coltitle=black,
		sharp corners,
		frame hidden,
		enhanced,
		top=0pt,
		right=0pt,
		bottom=0pt,
		left=-3pt,
		boxrule=0pt,
		enlarge top by=0pt,
		enlarge bottom by=0pt,
	},
	debug/.style={
	},
	exercise/.style={
		invisible,
		title=\exercss@insertExerciseTitle,
		before skip=20pt,
		after skip=20pt,
	},
}


\AtBeginDocument{%
	\noindent%
	\exercss@sheetTitle%
	\noindent%
}

%-----------------------------------------------------------
% EXCERCISE
%-----------------------------------------------------------
\newtcolorbox{sheetTitleBox}{
	invisible,
	colback=gray!10,
	top=10pt,
	bottom=10pt,
	left=5pt,
	right=5pt,
	borderline north={1pt}{0pt}{gray},
	borderline south={1pt}{0pt}{gray},
	enlarge bottom by=1.5cm,
	/exercss/sheet title/.try,
}
\newlength{\sheetTitleLeftWidth}
\newlength{\sheetTitleRightWidth}
\setlength{\sheetTitleLeftWidth}{0.47\textwidth}
\setlength{\sheetTitleRightWidth}{0.47\textwidth}

\newbool{exercss@listEmpty}
\newcommand{\exercss@insertAuthors}{%
	\booltrue{exercss@listEmpty}%
	\renewcommand*{\do}[1]{%
		\boolfalse{exercss@listEmpty}%
		##1\\
	}%
	\dolistloop{\exercss@authors}%
	\ifbool{exercss@listEmpty}{%
		\exerthss@askForDefinition{author}%
	}{}%
}

\newcommand{\exercss@sheetTitle}{%
	\exerthss@layout{sheet title}{%
		\begin{sheetTitleBox}%
			\begin{minipage}[t]{\textwidth}%
				\begin{minipage}[t]{\sheetTitleLeftWidth}%
					\raggedright%
					\exercss@sheetTitleLeft%
				\end{minipage}%
				\hfill
				\begin{minipage}[t]{\sheetTitleRightWidth}%
					\raggedleft%
					\exercss@sheetTitleRight%
				\end{minipage}%
			\end{minipage}%
		\end{sheetTitleBox}%
	}%
}

\newcommand{\exercss@insertExerciseTitle}{%
	\exerthss@layout{exercise}{%
		\exercss@insertExerciseName%
		\expandafter\ifstrempty\expandafter{\exercss@currentExerciseTitle}{}{%
			~\exerthss@layout{exercise title}{%
				\exercss@currentExerciseTitle%
			}%
		}%
	}%
}
\tcbset{
	/exercss/exercise/title/.store in=\exercss@currentExerciseTitle,
	/exercss/exercise/.search also=/tcb,
}
\newtcolorbox{exerciseBox}[1][]{exercise,#1}

\newcounter{exercise}
\NewEnviron{exercise}[1][]{%
	\gdef\exercss@currentExerciseTitle{}%
	\stepcounter{exercise}%

	\begin{exerciseBox}[/exercss/exercise/.cd,#1]%
		\BODY%
	\end{exerciseBox}%
	\noindent%
}

\newlist{subexercises}{enumerate}{1}
\setlist[subexercises]{
	label=\exerthss@layout{subexercise}{%
		\exerthss@layout{subexercise number}{*}%
	}%
}

\newlist{subsubexercises}{enumerate}{1}
\setlist[subsubexercises]{
	label=\exerthss@layout{subsubexercise}{%
		\exerthss@layout{subsubexercise number}{*}%
	}%
}



\exerciseMeta{%
	ask for definition,
}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF CLASS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
