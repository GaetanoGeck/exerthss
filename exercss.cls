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
	[2020/04/26 Simple class for exercises, building on exerthss]



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
%\newcommand{\exercss@layoutOptions}[1]{%
\newcommand{\exerciseLayout}[1]{%
	\exercssOptions{%
		layout/.cd,%
		#1,%
	}%
}
%\newcommand{\exerciseLayout}[1]{%
	%\exercss@layoutOptions{#1}%
%}
\exerciseLayout{
	% LAYOUT ---------------------------
	layout/.code 2 args={%
		\csgdef{exerthss@layout#1}{#2}%
	},
	layout after/.code 2 args={%
		\csgdef{exerthss@layout#1@after}{#2}%
	},
	%
	label/.style={
		layout={label}{#1},
	},
	exercise number/.style={
		layout={exercise number}{#1},
	},
	exercise number after/.style={
		layout after={exercise number}{#1},
	},
	subexercise number/.style={
		layout={subexercise number}{#1}
	},
	subexercise number after/.style={,
		layout after={subexercise number}{#1}
	},
	subsubexercise number/.style={
		layout={subsubexercise number}{#1},
	},
	subsubexercise number after/.style={
		layout after={subsubexercise number}{#1},
	},
	exercise/.style={layout={exercise}{#1}},
	exercise title/.style={layout={exercise title}{#1}},
	exercise title after/.style={layout after={exercise title}{#1}},
	subexercise/.style={layout={subexercise}{#1}},
	subsubexercise/.style={layout={subsubexercise}{#1}},
	header/.style={layout={header}{#1}},
	footer/.style={layout={footer}{#1}},
	% DEFAULTS ---------------------------------------------
	label={\sffamily\bfseries\boldmath},
	exercise={},
	exercise title={[},
	exercise title after={]},
	subexercise={},
	subsubexercise={},
	header={},
	footer={},
	exercise number={\arabic},
	exercise number after={},
	subexercise number={\alph},
	subexercise number after={)},
	subsubexercise number={\roman},
	subsubexercise number after={)},
}

\exercssOptions{
	roman/.code={
		\csgdef{exerthss@layoutlabel}{\rmfamily\bfseries\boldmath}%
	},
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
	\exerthss@layout{label}{%
		\exerthss@layout{exercise}{%
			\GetTranslation{ggex-exercise}~%
			\exerthss@layout{exercise number}{exercise}%
		}%
	}%
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
		\exerthss@layout{label}{%
			\exerthss@layout{header}{%
				\exercss@courseNameShort, 
				\exercss@insertSheetName%
			}%
		}%
	\fi%
}
\chead{}
\ohead{%
	\ifnum\value{page}=1\else%
		\exerthss@layout{label}{%
			\exerthss@layout{header}{\exercss@insertAuthorsShort}%
		}%
	\fi%
}
\cfoot{%
	\exerthss@layout{label}{%
		\exerthss@layout{footer}{\thepage~/~\pageref{LastPage}}%
	}%
}



%=====================================================================
% INNER SETTINGS (itemize, enumerate, ...)
%=====================================================================
\tcbset{
	/exercss/plain/.style={
		breakable,
		colback=white,
		colbacktitle=white,
		coltitle=black,
		sharp corners,
		enhanced,
		top=0pt,
		right=0pt,
		bottom=0pt,
		left=-3pt,
		boxrule=0pt,
		enlarge top by=0pt,
		enlarge bottom by=0pt,
	},
	/exercss/invisible/.style={
		/exercss/plain,
		frame hidden,
	},
	debug/.style={
	},
	exercise/.style={
		/exercss/invisible,
		title=\exercss@insertExerciseTitle,
		before skip=20pt,
		after skip=20pt,
	},
	/exercss/sheet title default/.style={
		/exercss/invisible,
		colback=gray!10,
		top=10pt,
		bottom=10pt,
		left=5pt,
		right=5pt,
		enlarge bottom by=1.5cm,
	},
	/exercss/sheet title default with borders/.style={
		/exercss/sheet title default,
		borderline north={1pt}{0pt}{gray},
		borderline south={1pt}{0pt}{gray},
	},
	/exercss/sheet title/.style={
		/exercss/sheet title default with borders,
	},
	/exercss/exercise/title/.store in=\exercss@currentExerciseTitle,
	/exercss/exercise/box default/.style={
		fonttitle=\sffamily\bfseries\boldmath,
	},
	/exercss/exercise/box/.style={
		/exercss/exercise/box default,
	},
	/exercss/exercise/.search also=/tcb,
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
	/exercss/sheet title,%
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
	\begin{sheetTitleBox}%
		\begin{minipage}[t]{\textwidth}%
			\begin{minipage}[t]{\sheetTitleLeftWidth}%
				\raggedright%
				\exerthss@layout{label}{%
					\exercss@sheetTitleLeft%
				}%
			\end{minipage}%
			\hfill
			\begin{minipage}[t]{\sheetTitleRightWidth}%
				\raggedleft%
				\exerthss@layout{label}{%
					\exercss@sheetTitleRight%
				}%
			\end{minipage}%
		\end{minipage}%
	\end{sheetTitleBox}%
}

\newcommand{\exercss@insertExerciseTitle}{%
	\exerthss@layout{label}{%
		\exerthss@layout{exercise}{%
			\exercss@insertExerciseName%
		}%
		\expandafter\ifstrempty\expandafter{\exercss@currentExerciseTitle}{}{%
			~%
			\exerthss@layout{exercise title}{%
				\exercss@currentExerciseTitle%
			}%
		}%
	}%
}
\newtcolorbox{exerciseBox}[1][]{exercise,#1}

\newcounter{exercise}
\NewEnviron{exercise}[1][]{%
	\gdef\exercss@currentExerciseTitle{}%
	\stepcounter{exercise}%

	\begin{exerciseBox}[/exercss/exercise/.cd,box/.try,#1]%
		\BODY%
	\end{exerciseBox}%
	\noindent%
}

\newlist{subexercises}{enumerate}{1}
\setlist[subexercises]{%
	label=%
	\exerthss@layout{label}{%
		\exerthss@layout{subexercise}{%
			\exerthss@layout{subexercise number}{*}%
		}%
	}%
}

\newlist{subsubexercises}{enumerate}{1}
\setlist[subsubexercises]{%
	label=%
	\exerthss@layout{label}{%
		\exerthss@layout{subsubexercise}{%
		\exerthss@layout{subsubexercise number}{*}%
		}%
	}%
}



\exerciseMeta{%
	ask for definition,
}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF CLASS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
