%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE: exerthss.cls
% AUTHOR: Gaetano Geck
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter



%---------------------------------------------------------------------
% IDENTIFY
%---------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exerthss}[2020/04/19 Simple class for theses]



%---------------------------------------------------------------------
% STRONG DEPENDENCIES
%---------------------------------------------------------------------
\RequirePackage{etoolbox}
\RequirePackage{pgfopts}



%---------------------------------------------------------------------
% OPTIONS FOR THIS CLASS
%---------------------------------------------------------------------
\newcommand{\exerthss@classOptions}{
	a4paper,
	fontsize=11pt,
	headsepline,
	captions=topbeside,
	bibliography=totoc%
}
\newcommand{\exerthss@addClassOption}[2]{
	\ifx#2\pgfkeysnovalue%
		\edef\exerthss@classOptions{\exerthss@classOptions,#1}%
	\else%
		\edef\exerthss@classOptions{\exerthss@classOptions,#1=#2}%
	\fi%
}
\newcommand{\exerthss@class}{scrbook}

\newbool{exerthss@exercise}
\newbool{exerthss@draft}
\newbool{exerthss@lineNumbers}
\newbool{exerthss@noLinkColor}
\newbool{exerthss@hyperrefColor}
\newbool{exerthss@hyperrefFinal}

\newcommand{\exerthssOptions}[1]{%
	\pgfkeys{%
		/exerthss/.cd,%
		#1,%
	}%
}

\exerthssOptions{
	% ----------------------------------------
	% HELPERS
	% ----------------------------------------
	set flag/.code 2 args=\setbool{exerthss@#1}{#2},
	enable/.code=\booltrue{exerthss@#1},
	disable/.code=\boolfalse{exerthss@#1},
	% ----------------------------------------
	% BASIC OPTIONS
	% ----------------------------------------
	hyperreflinkcolor/.store in=\exerthss@linkcolor,
	hyperrefcitecolor/.store in=\exerthss@citecolor,
	hyperrefurlcolor/.store in=\exerthss@urlcolor,
	hyperrefcolors/.default=true,
	hyperrefcolors/.style={
		set flag={hyperrefColor}{#1},
	},
	hyperrefsetcolor/.style={
		hyperreflinkcolor=#1,
		hyperrefcitecolor=#1,
		hyperrefurlcolor=#1,
	},
	%
	linenumbers/.default=true,
	linenumbers/.style={set flag={lineNumbers}{#1}},
	%
	hyperreffinal/.default=true,
	hyperreffinal/.style={
		set flag={hyperrefFinal}{#1},
	},
	hyperrefdraft/.style={
		disable=hyperrefFinal,
	},
	% ----------------------------------------
	% CLASS
	% ----------------------------------------
	class/.store in=\exerthss@class,
	paper/.style={
		class=scrartcl,
	},
	thesis/.style={
		class=scrbook,
	},
	exercise/.style={
		class=scrartcl,
		enable=exercise,
	},
	paper,
	% ----------------------------------------
	% STYLES
	% ----------------------------------------
	draft/.style={
		%hyperrefdraft,
		linenumbers,
	},
	final/.style={
		hyperreffinal,
		linenumbers=false,
	},
	default style/.style={
		final,
		hyperrefcolors,
		hyperreflinkcolor={red!70!blue},
		hyperrefcitecolor={green!50!black},
		hyperrefurlcolor={blue!85!black},
	},
	default style,
	.unknown/.code={
		\exerthss@addClassOption{\pgfkeyscurrentname}{\pgfkeyscurrentvalue}
	},
}

\ProcessPgfOptions*



%---------------------------------------------------------------------
% START FROM KOMA SCRIPT
%---------------------------------------------------------------------
\LoadClass[\exerthss@classOptions]{\exerthss@class}



%---------------------------------------------------------------------
% WEAK DEPENDENCIES
%---------------------------------------------------------------------
\RequirePackage{microtype}
\RequirePackage{calc}
\RequirePackage{environ}
\RequirePackage[inline]{enumitem}
\RequirePackage{xcolor}
\RequirePackage{tabularx}
\RequirePackage[most]{tcolorbox}

\RequirePackage{lineno}
\ifbool{exerthss@lineNumbers}{\linenumbers}{}

\RequirePackage{hyperref}



%===============================================================================
% HELPERS
%===============================================================================
\newcommand{\exerthss@askForDefinition}[1]{%
	\textcolor{red!70!blue}{\texttt{#1} undef.}
}

\newcommand{\exerthss@layout}[2]{%
	{%
		\csuse{exerthss@layout#1}{#2}%
		\ifcsdef{exerthss@layout#1@after}{%
			\csuse{exerthss@layout#1@after}%
		}{}%
	}%
}


%===============================================================================
% OUTER SETTINGS (chapters, sections, subsections, ..., pages)
%===============================================================================



%---------------------------------------------------------------------
% HEAD AND FOOT
%---------------------------------------------------------------------
\setkomafont{pageheadfoot}{\normalfont\normalcolor\sffamily\small}
\setkomafont{pagenumber}{\normalfont\sffamily\small}
\deffootnote[1em]{1em}{1em}{\textsuperscript{\thefootnotemark}}



\ifbool{exerthss@hyperrefFinal}{
	\hypersetup{
		final,
	}
}{%
}
\ifbool{exerthss@hyperrefColor}{
	\hypersetup{
		colorlinks,
		linkcolor={\exerthss@linkcolor},
		citecolor={\exerthss@citecolor},
		urlcolor={\exerthss@urlcolor},
	}
}{%
}



\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF CLASS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
