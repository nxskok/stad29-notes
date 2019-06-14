all: slides_d29.pdf

show: slides_d29.pdf
	evince slides_d29.pdf &



#CHAPTERS = slides_d29 bOutline bRegression bRscript bLogistic bSurvival bAnova bAncova bManova bProfile bDiscrim\
#bCluster bMDS bPrincomp bFactor timeseries bMultiway bggplot

RMDS = $(wildcard *.Rmd)

slides_d29.pdf: slides_d29.tex
	lualatex --interaction=nonstopmode slides_d29
	lualatex --interaction=nonstopmode slides_d29

slides_d29.tex: slides_d29.md 
	/usr/lib/rstudio/bin/pandoc/pandoc +RTS -K512m -RTS slides_d29.md --to beamer --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash\
                --output slides_d29.tex --slide-level 2 --variable theme=AnnArbor --variable colortheme=dove --highlight-style tango\
                --pdf-engine xelatex --self-contained 


slides_d29.md: slides_d29.Rmd bRegression.Rmd bLogistic.Rmd bSurvival.Rmd bAnova.Rmd bAncova.Rmd bManova.Rmd bProfile.Rmd\
               bDiscrim.Rmd bCluster.Rmd bMDS.Rmd bPrincomp.Rmd bFactor.Rmd time-series.Rmd\
               bMultiway.Rmd
	Rscript -e "knitr::knit('slides_d29.Rmd')"

%.R: %.Rmd
	Rscript -e "knitr::purl(\"$^\")"

#%.Rmd: %.Rnw convert.pl # don't make these anymore
#	perl convert.pl $< > $@
#	Rscript -e "styler::style_file(\"$@\")"


force:
	touch slides_d29.Rnw
	make

## old 

#makefile .SUFFIXES: .tex .pdf .Rnw .R
#
#MAIN = slides-sw
#
#RNWINCLUDES = bOutline bRIntro bInference bRegression bRscript bLogistic bSurvival bAnova bAncova bManova bProfile bMultivRegression bDiscrim bCluster bMDS bPrincomp bFactor bTimeSeries bKriging bMultiway bggplot
#TEX = $(RNWINCLUDES:=.tex)
#RFILES = $(RNWINCLUDES:=.R)
#RNWFILES = $(INCLUDES:=.Rnw)
#
#all: $(MAIN).pdf
#
#$(MAIN).pdf: $(TEX) $(MAIN).tex
#
#R: $(RFILES)
#
#show: all
#	evince $(MAIN).pdf &
#
#edit: $(MAIN).tex
#	emacsclient -c $(MAIN).tex &
#
#.Rnw.R:
#	R CMD Stangle --encoding=utf-8 $<
#
#.Rnw.tex:
##	R CMD Sweave --encoding=utf8 $<
#	Rscript -e "library(knitr); knit(\"$<\")"
#
#.tex.pdf:
#	pdflatex $<
##	bibtex $*
#	pdflatex $<
##	pdflatex $<
#
#clean:
#	rm -fv $(MAIN).pdf $(MAIN).tex $(TEX) $(RFILES)
#	rm -fv *.aux *.dvi *.log *.toc *.bak *~ *.blg *.bbl *.lot *.lof
#	rm -fv *.nav *.snm *.out *.pyc \#*\# _region_* _tmp.* *.vrb
#	rm -fv Rplots.pdf *.RData
#
#gflr.pdf: gflr.tex
#	pdflatex gflr.tex
#
#gflr.tex: gflr.Rnw
#	Rscript -e "knitr::knit(\"gflr.Rnw\")"
