# Customize Layout for Homework (_exercss.cls_)

_De gustibus non est disputandum_. This document describes how to change some key layout aspects. If you want to change the style permanently (for multiple homework), it is probably best to create your own document class that loads _exercss.cls_ and applies the wanted changes. If you don't know how to do this, simply copy the example [myclass.cls](myclass.cls) and change it according to your needs. This file may also serve as an overview of the aspects discussed below.

One of my main design goals for the class _exercss.cls_ was to allow even students with few LaTeX skills to easily customize some aspects of the key layout _without_ bothering about all the logical stuff around it. By default, the class itself has - intentionally - a rather minimal design. 

Currently, the document class supports easy customization of the following aspects:

- [sheet title layout](#sheet-title-layout)
- [exercise layout](#exercise-layout)
- [exercise labels](#exercise-labels) (also for sub- and subsubexercises)

The sheet title as well as each exercise are wrapped in a `tcolorbox` and therefore allow easy modification of a wide range of layout properties. In the examples below we use only a few of these properties. Fore more details, see the (comprehensive) documentation of this excellent package [tcolorbox (CTAN)](https://www.ctan.org/pkg/tcolorbox).

Before discussing these aspects, let us briefly mention to some general options.

## General options

Labels (text in the sheet title, names like 'Exercise'/'Aufgabe'/..., the numbers of exercises/subexercises/subsubexercises as well as headers and footers) are typeset in _sans serif_ font family (and boldface) while the main text uses a _roman_ font family.

If you want to use a _roman_ font family also for these labels, you can simply pass the `roman` option to the document class:

```tex
\documentclass[roman]{exercss}
```

## Sheet title layout

The sheet title is wrapped in a `tcolorbox` that applies the key `/exercss/sheet title`. Extending or redefining this key, you can change the layout of the box.

```tex
\tcbset{
	/exercss/sheet title/.style={
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
```

## Exercise layout

Each `exercise` environment is wrapped in a `tcolorbox` that applies the key `/exercss/exercise/box`. Extending or redefining this key, you can change the layout of these boxes.

```tex
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
```

Some layout aspects (font, color, ...) of the exercise title and the enumeration labels of exercises, sub- and subsubexercises can be set too. To this end, use the `\exerciseLayout` command and the corresponding keys.

```tex
\exerciseLayout{
	label={\sffamily},
	exercise={\color{myred}},
	exercise title={\color{myblue-dark}(},
	exercise title after={)},
	subexercise={\color{myred}\bfseries},
	subsubexercise={\color{myred}\bfseries},
	header={\color{myred}},
	footer={\color{myred}},
}
```

The key `label` defines the base style for all labels as described above (not just enumeration labels but also sheet title, headers/footers, ...). So, if you want to set all these labels in small caps and only the exercise name and title (wrapped in parentheses) in blue, you can set the following keys.

```tex
\exerciseLayout{
	label={\scshape},
	exercise={\color{myblue-dark}},
	exercise title={\color{myblue-dark}(},
	exercise title after={)},
}
```

## Exercise labels

By default, the document class applies the following enumeration scheme:

- exercises are labeled by Arabic numerals,
- subexercises are labeled alphabetically and
- subsubexercises are labeled by Roman numerals.

All enumeration labels are followed by a closing parenthesis: _1), b), iii)_. Furthermore, exercises titles are wrapped in brackets, if present.

This behavior can be changed using the `\exerciseLayout` command and the keys below. The next code snippet, for instance, applies the following enumeration scheme:

- exercises are labeled by Roman numerals,
- subexercises are labeled by Arabic numerals and
- subsubexercises are labeled alphabetically.

All enumeration labels are followed by a period.

```tex
\exerciseLayout{
	exercise number={\Roman},
	exercise number after={.},
	subexercise number={\arabic},
	subexercise number after={.},
	subsubexercise number={\alph},
	subsubexercise number after={.},
}
```


