%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE: myclass.cls
%
% This file demonstrates the configuration of the sheet title and the exercises
% in documents that use the 'exercss' document class.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myclass}%
	[2020/04/19 Layout customization example for 'exercss']

\RequirePackage{pgfopts}
\RequirePackage{xcolor}

% Load 'exercss' as the base document class
% and pass all options to it.
\ProcessPgfOptions*
\LoadClass[]{exercss}

\colorlet{myred}{blue!30!red}
\colorlet{myblue-dark}{blue!70!black}
\colorlet{myblue-light}{blue!8}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONFIGURATION OF THE SHEET TITLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tcbset{
	% simply set the style you like for '/exercss/sheet title'
	% See the tcolorbox documentation for details.
	/exercss/sheet title/.style={
		% either start from scratch or from another template
		/exercss/plain, % here, we use a plain style
		% TITLE -------------------------------------------
		attach boxed title to bottom center,
		title={Hausaufgaben},
		coltitle=myblue-dark,
		fonttitle=\Large\bfseries,
		boxed title style={colframe=myred},
		% BODY --------------------------------------------
		boxsep=5pt,
		coltext=myblue-dark,
		colback=myblue-light,
		fontupper=\rmfamily,
		% DECORATION --------------------------------------
		borderline north={1.7pt}{-12pt}{myred},
		borderline south={1.7pt}{-12pt}{myred},
		enlarge bottom by=1cm,
	},
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONFIGURATION OF THE EXERCISE ENVIRONMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Each \begin{exercise} ... \end{exercise} wraps the content in a tcolorbox
% that uses the style /exercss/exercise/box.
% You can override the default style via the '.style' handler, as below, or
% extend (build upon) it via the '.append style' handler.
\tcbset{
	/exercss/exercise/box/.style={
		% TITLE -------------------------------------------
		attach boxed title to top left,
		coltitle=myblue-dark,
		fonttitle=\bfseries\boldmath,
		boxed title style={
			frame hidden,
			borderline west={6pt}{0pt}{myred},
			left=6pt,
			colback=myblue-light,
		},
		% BODY --------------------------------------------
		top=5pt,
		% DECORATION --------------------------------------
		borderline south={2pt}{-10pt}{myred},
		enlarge bottom by=10pt,
	},
}

% There are some layout aspects within each exercise that can be set via
% keys passed to \exerciseLayout.
\exerciseLayout{
	% Label is the base style for all entries in the sheet title,
	% the enumeration labels for exercises, subexercises and subsubexercises
	% and also for headers and footers.
	%
	% The 'label' layouter is applied first such that more specific layouters
	% may override its behavior.
	label={\sffamily},
	exercise={\color{myred}},
	exercise title={\color{myblue-dark}(},
	exercise title after={)},
	exercise number={\Roman},
	exercise number after={.},
	subexercise={\color{myred}\bfseries},
	subexercise number={\arabic},
	subexercise number after={.},
	subsubexercise={\color{myred}\bfseries},
	subsubexercise number={\alph},
	subsubexercise number after={.},
	header={\color{myred}},
	footer={\color{myred}},
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF CONFIGURATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
