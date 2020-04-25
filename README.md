# LaTeX classes for exercises, reports and theses

This repository provides document classes for LaTeX that target student reports, homework and theses. Although already usable, both classes are still in an early stage and will be enhanced soon. This is even more true for this documentation. Sorry, but currently my main goal is simply to provide an access point to students.

**Language support.** The document class for homework (_exercss.cls_) currently supports only English and German labels out of the box but it's not very hard to add your own ones.

**Layout customization.** One of my main design goals for this class was to allow even students with few LaTeX skills to easily customize some aspects of the key layout _without_ bothering about all the logical stuff around it. By default, the class itself has - intentionally - a rather minimal design. If you don't like it this way, maybe it can still provide a good base to build upon. [Customize layout for homework](examples/CustomizeLayoutExercss.md) explains how to configure certain layout aspects and also provides a more [colorful example](examples/exercss-layout-konfiguration.pdf).

## Some questions

Now that you have found this place, you might ask yourself one of the following two questions, which I'll try to answer below.

- Do I want to use _these_ classes?
- How can I use these classes?

### Do I want to use _these_ classes?

Maybe you first want to have a glance at the examples and the screenshots below to get an impression of how the classes can be used what the outcome may look like.

- **Homework (_exercss.cls_):** 
	- [default layout](examples/exercss-beispiel.pdf)
	- [custom layout for homework](examples/exercss-layout-konfiguration.pdf)
- **Thesis (_exerthss.cls_):** TODO

### How can I use these classes?

I start with a description for LaTeX/Git newbies. If that doesn't suit you, you probably know what to do anyway ... Perhaps, I elaborate on other ways later.

**Get the document classes.** Simply download the document class descriptions. Technically, there are two files, named _exerthss.cls_ and _exercss.cls_. The former is the base class and as such required. The latter extends the former and is necessary only if you want to use it for solutions to homework. (In a sense, you can read _exercss_ as _exercises_ and _exerthss_ as _exercises and theses_; I wasn't able to come up with a better name quickly.)

**Compose a document.** Either use an already existing document (you can copy one from the examples) and set the document class to _exerthss_ or _exercss_, depending on your use case, or create a new one like the following document _test.tex_:

```tex
\documentclass{exerthss}

\usepackage[utf8]{inputenc}
\usepackage{fontenc}

\begin{document}
	Enter some content here!
\end{document}
```

Then, as usual, you compile the document (using `latexmk test` or whatever you prefer). Note that your LaTeX compiler has to be able to find the document classes. If you don't know better, simply copy them into the same directory as the file that you're compiling. If you want to use these classes in multiple documents, in several places, there are better ways to deal with it (which I perhaps will discuss somewhere in the future).

Naturally, there's not much to see in an almost empty document. What is relevant here, is the first line, which sets _exerthss_ to be the document class. Used like this,  the class will rely on its default options. You change some aspects of the behaviour by providing _options_ to the class. As an example, if you replace the first line by `\documentclass[linenumbers]{exerthss}` the document will contain small line numbers, which may be helpful to discuss a draft of the document.

If you use _exercss_ instead, you should also use specify some meta information (course, group, ...). This is demonstrated in the _examples_ directory.

Both classes build upon the [KOMA-Script](https://www.komascript.de) classes _scrartcl_ (exercises and papers) or _scrbook_ (theses), using DIN-A4 paper and a font size of 11pt as default. Using options, this can be changed however. The following example uses a slightly larger font size, the _scrreprt_ class and line numbers.

```tex
\documentclass[
	linenumbers,
	class=scrreprt,
	fontsize=12pt
]{exerthss}

\usepackage[utf8]{inputenc}
\usepackage{fontenc}

\begin{document}
	Enter some content here!
\end{document}
```

## Known problems

Some LaTeX distributions may be missing some required packages.

A known case is the package [_cm-super_](https://ctan.org/pkg/cm-super). There are several ways to resolve this problem (and similar ones):

- Look for a more complete distribution. I would prefer this. Try [TeX Live 2020](https://www.tug.org/texlive/) for example.
- Download the individual packages. Quick but less sustainable!?
- Use different fonts. I heard that you can add `\usepackage{lmodern}` to the preamble of your document. See a [StackExchange](https://tex.stackexchange.com/questions/1390/latin-modern-vs-cm-super) discussion for more details on the pros and cons of _cm-super_ and _lmodern_.

Other problems might be caused by bugs in my code, although I'm trying to prevent this. If you're pretty sure that the bug is in my code and not in yours, I'd be happy if you would create an issue so that I have a chance to fix it. Thanks!
