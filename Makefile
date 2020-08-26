LATEX=rubber --pdf
CLEAN=rubber --clean
RM=rm -rf 

TEXS=$(wildcard *.tex)
PDFS=$(TEXS:.tex=.pdf)

all: $(PDFS)
	echo Build all 


%.pdf: %.aux %.bbl 
	$(LATEX) $<          

%.aux: %.tex 
	$(LATEX) $<

%.bbl: %.aux 
	bibtex $<

.PHONY: clean distclean

clean:
	$(CLEAN) $(TEXS)

distclean: clean 
	$(RM) $(PDFS)