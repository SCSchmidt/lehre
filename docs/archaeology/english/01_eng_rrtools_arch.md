# RRtools - Tools für Reproducible Research

The package rrtools has been developed by Ben Marwick et al to make it
easier to create an R project, in which all data, analyses and paper get
collected.It’s easy to give this compendium to other people so that they
can recreate the analysis: <https://github.com/benmarwick/rrtools>

Rrtools uses the structure of an usual R package, which is used as a
kind of “plug in” within R. So don’t get confused if I use R package and
R project within this context synonymously.

#### Installation

First we need to install rrtools. This package is stored on github,
therefore we will use the function `install_github` from the package
`devtools`. Usually devtools is installed together with the R
installation.

Because in this session we need the package devtools only once, we can
call it using `devtools::`+ the needed functon. This way we don’t need
the `library()`-call.

So to install rrtools we write:

``` r
devtools::install_github("benmarwick/rrtools") 
```

Now, we want to use rrtools. We call the function `use_compendium()`. It
will create a new R project at the path we give as an argument to the
function. The path needs to be given in “quotation marks” and needs to
be complete (on Windows starting with C: or D: … on Linux /home/… and
don’t ask me about Macs). The last part (here: “pkgname”) will be the
name of the new R project:

``` r
rrtools::use_compendium("C:/Hier/kommt/ein/Pfadname/pkgname")
```

Usually, after running this function, the new project is created and
opens by itself. You should see in the upper right hand corner your new
package name. If this doesn’t work, navigate to your new project in your
file system and open the Rproj-file.

## What happened?

rrtools installed the structure of a normal R package, with some files
already with default values given. There is e.g. the DESCRIPTION - file,
which you can see in the “files” viewer on the lower right hand side.
Here you can (and should) store a few Metadata information on your
project.

There is the name of the package, one sentence what the package should
do (title) and the author information, which you should always update.

If you want to publish the code of this package one day, you absolutely
should give a license! These make clear how others might use your code
and how to cite you. Next to encoding I suggest to write UTF-8,
shouldn’t it be there already. If you need other writing systems than
the Latin one other encoding systems might be sensible, but UTF-8 is a
standard.

This is an example what is written in my DESCRIPTION file of the R
project “Lehre” where I gather my scripts for teaching:

``` r
Package: lehre
Title: In diesem Paket wird Lehrmaterial zu Statistischen Methoden zur Verfügung gestellt.
Version: 0.0.0.9000
Authors@R:
    person(given = "Sophie C.",
           family = "Schmidt",
           role = c("aut", "cre"),
           email = "s.c.schmidt@uni-koeln.de")
Description: Verschiedene Rmd-Dateien mit Hinweisen zu ggplot, statistischen Tests, reproduzierbarer Wissenschaft in Archäologie und Biologie.
License: What license it uses
ByteCompile: true
Encoding: UTF-8
LazyData: true
Imports: bookdown
```

Now, once you saved your changes. We wish to continue working with
rrtools to set up the folder structure I was talking about.

``` r
library(rrtools)
use_analysis()
```

Stuff happens! In the console rrtools explains what it does. There is
now a file structure, which starts in the folder you created with
`use_compendium()` and some example templates and the first
RMD-document. This is the folder structure:

    analysis/
    |
    ├── paper/
    │   ├── paper.Rmd       # that's the main document
    │   └── references.bib  # bibliography information

    ├── figures/            # place for images created by R
    |
    ├── data/
    │   ├── raw_data/       # make sure to never overwrite anythin in here
    │   └── derived_data/   # save any data you changed in any way here
    |
    └── templates
        ├── journal-of-archaeological-science.csl
        |                   # cs = "citation style language" defines the way your bibliography is styled
        ├── template.docx   # templage how the docx created from your paper.Rmd will look like
        └── template.Rmd

-   You can use `paper.Rmd` right away and render it with `bookdown`. In
    it you will find:
    -   a “YAML header” , where a `references.bib` (your bibliography
        database) and a `csl` are linked to
    -   the colophon, which is relevant if you use git
-   The `references.bib` - document has only one entry to show the
    format. You can add other bibliography entries just after a blank
    line.
-   You can download another `csl` - document, save it in the same place
    as the old one and then simply replace the entry in the YAML -
    header to the new csl-document (there’s a number of different
    citation styles here: <https://github.com/citation-style-language/>)
-   You can also install the [citr addin](https://github.com/crsh/citr)
    and [Zotero](https://www.zotero.org/) for really easy citation
    management.

More about paper.Rmd you’ll find under [R-Markdown](#rmd)

Just use this R project for everything now. Write the code in “code
chunks” and use “normal text blocks” to document what the code is
supposed to do and how you might interprete the results.

## R Markdown

An *Rmarkdown*- document (Rmd) actually is nothing but a txt-file,
meaning the simpelst form of a text file that you can imagine. If I
write my text with a certain syntax, I can use another program, called
*pandoc*, to create from my Rmd document nicely formatted Word-, html or
PDF files.

What does this mean?

If I mark a line with a \#-symbol before it, it will be rendered as a
header, if I add a - at the beginning, it will create a list and if I
put text in two asterisk (star symbols), it will be made **bold** (or if
you want italics, use *underscores* \_):

![](https://d33wubrfki0l68.cloudfront.net/e3541891e3115642d605aca52e4556d397e95c6f/4e2ba/images/quicktourexample.png)

(Example from the official website)

### Document structure

Let’s start at the beginning of the document. At the very beginning we
need a so called “YAML header”. It starts with three minus signs in
their own line. And it ends with three minus signs in their own line. In
between we can put meta data to our document and some settings:

-   Write the title behind `title:` in quotation marks
-   After `author:` goes your own name in the list setting (make sure
    you keep the indention)
-   `date:` you don’t need to give this, but you may. If you keep “29
    November, 2021” it will always be transformed to the time at which
    you render the document.
-   `output:` is really important. It specifies which kind of document
    you will create from your Rmarkdown. There are a number of
    possibilities, the most important are “html_document”,
    “word_document” and “pdf_document”. Also there are now different
    versions for these basic types. For now just keep
    `bookdown::word_document2:` because it will create docx-files, which
    are probably a good idea at the moment.

You should see the little **Knit**-button at the top of your window for
the rmarkdown document. This one will “knit” your document from RMD to
whatever you said in your YAML-header. If you’re lazy like me, you can
use the short cut control-shift-k.

Now, all of the following is “normal markdown” if you know this. It’s a
markup language similar to LaTeX.

Headers will be ordered by the number of hashtags. One hashtag (\#) will
be the highest ranking header, two hashtags (\#\#) is one level below,
three hashtags (\#\#\#) one level further below. So, e.g. “Document
structure” is a header of third level:
`### Document structure{#dokument-struktur}`.

But, what is this `{#dokument-struktur}`? That’s an anchor. With an
anchor I am able to put links referring from one part of the document to
another one. With this anchor in place I can now link to the heading
“Document structure”. If you now any html - it’s the same principle. If
you now click on [this link](#dokument-struktur) you will jump to the
header “Document structure”. In my markdown it looks like this:
`[this link](#dokument-struktur)`.

That’s really useful and enables interactive documents. An anchor is
always in curly brackets ({}) and starts with an hashtag (\#). There may
be no blank spaces! If you want to link to the anchor, the link will be
written in square brackets \[\] and the anchor put behind in normal
brackets ().

Don’t get confused with all the hashtags! In the text part of a Markdown
document and put at the beginning of a line, it marks a header. You will
need a blank line before and after!

In curly brackets the hashtag will be used for an anchor and in normal
brackets () it’s the link to the anchor.

Now, within the code chunks in Rmarkdown, hashtags mean something else…
but let’s start with the intro on that first:

### Text and Code (the R in RMarkdown)

In an Rmd document there are “normal” text parts, like this one, I am
writing in right now, and so called “Code Chunks”. Code chunks are the
areas, in which I can write R code that will be run once I knit my
document. Code chunks are marked by certain symbols again.

It always starts with three tick marks (\`\`\` = on the German keyboard
next to the back-arrow, on the american keyboard in the upper corner on
the left hand where the \~ is) and curly brackets. Inside the curly
bracket I first write an r – this tells the program that it’s R code
that needs to be evaluated and next I can give the code chunk a name.
This can be very helpful to refer to the code chunk. Next to that I am
able to set parameters for the code chunk, but we’ll not talk about
details at the moment. This part with the tick marks and the curly
bracket needs to go in it’s own line. In the next line I can start
writing code. A code chunk always ends with three tick marks in their
own line as well.

The easiest way to create a Code chunk is via the shortcut Ctrl-Alt-i.

If you are writing your R document you will see the code chunk always
has a slightely darker background than your “normal text” parts.

``` r
# this is a code chunk. I shall write only code in this code chunk.
# everything that is not code needs to to be "commented out" -- meaning I give it a sign, that this is NOT code. The sign for this is -- a hashtag. 
# If I forget this hashtag for marking it as "not code" R will give me problems the moment I knit this document.
```

If I run this Code, the output will be put below my Code chunk. This way
I can see how it would look like in my rendert document:

![](https://d33wubrfki0l68.cloudfront.net/44f781299f23419d5314e5322e7c44393f7190d3/c5915/images/markdownchunk.png)

(If you want to learn more about image embedding, look
[here](#bilder-einfügen))

The parameter of a code chunk are really helpful setting options. You
can make sure whether the code should be written in the rendered
document(`echo = TRUE`) or whether only the output should be shown
(`echo = FALSE`). If a diagram is created, you can say how large it is
supposed to be (fig.height und fig.width). One parameter I always use to
create the scripts is e.g. “`eval = FALSE`”, which says that the code in
this code chunk will not be evaluated – not RUN – when I knit the
document. Otherwise I would install rrtools anew with every knit I do.
Which is not what I want to do.

You can learn more about these different parameters here:
<https://rmarkdown.rstudio.com/lesson-3.html> and here:
<https://yihui.org/knitr/options/>. You can set the parameters as well
with clicking on the little cogwheel symbol you will see on the right
hand side of every code chunk.

One small example for a code chunk with code shown:

``` r
x <- 5+5
x
```

    ## [1] 10

One example where I do not show the code:

    ## [1] 10

Outside of a code chunk, everything will be regarded as normal text. I
can write code here, and nothing happens:

install.packages(“knitr”) doesn’t do anything.

What I can do, though, is call on variables that I defined and embed
small calculations within the normal text. I need a tick mark \` r
“variable name / function call” and again a tick mark ´ just right
inside my sentences. So the variable x I defined is 10. I didn’t write
the number itself but \` r x \`. I can also write \` r x + 10 \` and the
result will be 20 and the program will calculate it “on the fly” for me.
It is not recommended to put difficult or large calculations like this
in the text.

But it is very useful, because this way I don’t make typo errors when
transcribing results. Also, should I have to change my data set a little
bit, the result may change by a small number and it will be updated in
my text all by itself. Of course I need to check whether my
interpretation has to change as well, but at least I may keep a few
sentences of what I wrote before.

### Style guide for the code

To make it easier for future me and for other people to read my code,
here some advice how to write the code. There are different “style
guides”. But I like to use the Style Guide of the “Initiative für
Statistische Analysen in Archäologie Kiel”
(<https://github.com/ISAAKiel/StyleGuide>). Here are some important
points:

1.  Please give blank spaces around the operator signs (`=, +, -, <-`,
    etc.)) , no space before a comma, but one space behind a comma. Do
    not put spaces between a function and the brackets (e.g.`sqrt()`
    don’t do `sqrt ()`)!

2.  Names of data sets and variables should not have any special
    characters (no ä, ö, ü please). Blank spaces should be replaced by
    underscores \_ . Use “speaking” names, not generic ones (e.g. use
    `mean_weight` not just `m`).

3.  A line of code should not be longer than 80 characters. It is istead
    sensible to give a line break after each “comma”. This way it is
    much easier to keep track of all the different arguments and
    parameters. Also it is easier to comment the code:

4.  Comment your code not just in the text parts of Rmarkdown documents
    but inside the code chunks! Especially if you write for someone
    else, but also for future you (tomorrows you…).

-   In front of the code and in its own line you should write some
    longer comments what the code shoud do. E.g.:“\# Create histogram of
    rim diameter of bronze age cups, colour differentiated by phase”
-   in the same line like the code, behind it, you can give very short
    comments on what this line of code does, e.g.:

``` r
library(ggplot2) # load ggplot
library("archdata") # load archaeological data sets
data("BACups") # load data set BACups

# Create histogram of rim diameter of bronze age cups, colour differentiated by phase
ggplot()+
  geom_histogram(data = BACups, 
                 aes(x = RD, # rim diameter on x axis
                     fill = Phase), # colour by dating
                 binwidth = 1, # bin widht of 1 cm shows the curves well
                 na.rm = TRUE) # make sure NAs get removed
```

-   Tipp: Rather comment too much than too little.

1.  Give the code space to breathe. A blank line between units really
    makes it easier to read the code. You can see it in the example. I
    put all the “loading” of stuff together, but then a blank line after
    `data("BACups")`. This shows “something new begins here” in an easy
    way.

### Bilder einfügen

I added images in the text via Markdown. Because they are online I could
add the first one via this code:
`![](https://d33wubrfki0l68.cloudfront.net/44f781299f23419d5314e5322e7c44393f7190d3/c5915/images/markdownchunk.png)`.
To add images that are on my PC somewhere, the structure is more or less
the same: `![](path/to/image/picture.jpg`). It is always first an
exclamation mark, then empty square brackets and then in rounded
brackets the path to the image.

You can add links as [hyper links in the
text](https://rmarkdown.rstudio.com/authoring_quick_tour.html) (Code:
`\[hyper links in the text](https://rmarkdown.rstudio.com/authoring_quick_tour.html`)

or simply like this:
<https://rmarkdown.rstudio.com/authoring_quick_tour.html>.

### Comments

Sometimes it is sensible to add comments to your “normal text” as well.
They should be invisible once you render the document (not transferred
to the PDF or docx file). You can write those in “html-style” with
“arrows”: \<!– This here would be the comment –\>

You can have a look in my Rmd document (unter
<https://github.com/SCSchmidt/lehre/blob/R-Kurs-Koblenz/analysis/paper/01_eng_rrtools_arch.Rmd>)
to see what I commented in the next line.

<!-- Haha. This is invisible -->

## Bibliography management

For rrtools and Rstudio it is recommended to use
[zotero](https://www.zotero.org/). Zotero is a great bibliography
management tool, free and open source.

From zotero (but also from Mendeley, Citavi and co) you can export the
literature you need in different formats. For Markdown you need a
“bib”-file, which is put in the style “bibtex” oder “BibLatex”.
Bib-files are actually also just simple txt-files.

The entry for a book would look like this:

    @book{legendre_2012,
        location = {Amsterdam},
        title = {Numerical Ecology},
        isbn = {978-0-444-53868-0},
        publisher = {Elsevier},
        author = {Legendre, Pierre and Legendre, Louis},
        date = {2012}
    }

`@book` meas: This is a book (not an article).

`legendre_2012` is the ID of this book, with which I can call the
bibliographic information within my markdown document.

`location, title, isbn, publisher, author` and `date` (publication date)
are the information that can be rendered into the bibliography entry

I can add the citation like this R is a great programming language
(Legendre/Legendre 2012).

Actually I wrote: R is a great programming language \[@legendre_2012\].

and pandoc put it automatically in the correct format – within the text
as well as under the heading “bibliography”.

The csl I use is in the citation style named “RGK_archaeology_DGUF”
downloaded from <https://www.dguf.de/203.html> and simply ut in the same
folder as where I have my Rmd-file. Depending on the journal and the
citation style you’re supposed to use you can download the csl file from
[Zotero Style Repository](https://www.zotero.org/styles/) (quite often
someone already created one for the style you need). So, you can use the
same Markdown-document and just change the csl to re-submit your paper
to a different journal because the rendered output docx will have the
new shiny bibliography according to the new citation style.

Also: It is important to cite the creators of the R packages that I use
in my analysis. Therefore, if I need the bib-file entry for a package, I
can simply show it to me with the function `citation()`. This shows the
bibtex - information for citing the ggplot - creators:

``` r
citation("ggplot2")
```

    ## 
    ## To cite ggplot2 in publications, please use:
    ## 
    ##   H. Wickham. ggplot2: Elegant Graphics for Data Analysis.
    ##   Springer-Verlag New York, 2016.
    ## 
    ## A BibTeX entry for LaTeX users is
    ## 
    ##   @Book{,
    ##     author = {Hadley Wickham},
    ##     title = {ggplot2: Elegant Graphics for Data Analysis},
    ##     publisher = {Springer-Verlag New York},
    ##     year = {2016},
    ##     isbn = {978-3-319-24277-4},
    ##     url = {https://ggplot2.tidyverse.org},
    ##   }

I can copy the information in my bib file and give it its own ID there.
In comparison to the “legendre_2012” - example you can see that the
first entry (ID) is missing: I would replace “`Book{,`” with
“`Book{ggplot2,`” in my bib-file and then could use @ggplot2 to cite the
package.

Always cite the packages and at least R core in papers! We use this for
free, let’s at least “pay” with adding to those people’s reputation.
Also, this might be helpful information to those reading our paper.

### Conclusion

Using rrtools we can create a nice folder structre in which we can put
any data, R code and text for our project.

RMarkdown combines Markdown, a markup language with the possibilities to
run R code. The amazing advantage of an Rmarkdown document is it’s
ability to keep interpretative and descriptive text and code in one
document. In this way you can write a paper with calculations, graphs
and analyses, add citations and have it all in one place without loosing
track of anything.

I write all my papers in Rmarkdown (if I’m not using overleaf) and even
my PhD…

### Links

More on Markdown in German:

-   <https://vijual.de/2019/03/11/artikel-mit-markdown-und-pandoc-schreiben/>
    (esp Chapter 1).

-   This is an interactive Markdown tutorial:
    <https://commonmark.org/help/tutorial/>.

Details to Rmarkdown:

-   <http://rmarkdown.rstudio.com>

-   and a nice cheat sheet:
    <https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf>
    .

-   This book is really helpful: <https://bookdown.org/yihui/rmarkdown>.

# Bibliographie

<div id="refs" class="references csl-bib-body">

<div id="ref-legendre_2012" class="csl-entry">

Legendre/Legendre 2012: P. Legendre/L. Legendre, Numerical Ecology
(Amsterdam 2012).

</div>

</div>
