.SUFFIXES: .tex .pdf .Rnw .R

MAIN = master
RNWINCLUDES = chapter1 chapter2 chapter3
TEX = $(RNWINCLUDES:=.tex)
RFILES = $(RNWINCLUDES:=.R)
RNWFILES = $(INCLUDES:=.Rnw)

all: $(MAIN).pdf
	$(MAIN).pdf: $(TEX) $(MAIN).tex

R: $(RFILES)

view: all
	evince $(MAIN).pdf &

.Rnw.R:
	R CMD Stangle $<

.Rnw.tex:
	R CMD Sweave $<

.tex.pdf:
	pdflatex $<
#	bibtex $*
#	pdflatex $<
#	pdflatex $<

clean:
	rm -fv $(MAIN).pdf $(MAIN).tex $(TEX) $(RFILES)
	rm -fv *.aux *.dvi *.log *.toc *.bak *~ *.blg *.bbl *.lot *.lof
	rm -fv *.nav *.snm *.out *.pyc \#*\# _region_* _tmp.* *.vrb
	rm -fv Rplots.pdf *.RData
