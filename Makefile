
LATEX=pdflatex -shell-escape -interaction=nonstopmode -file-line-error
RM=rm -rf 

TEXS_W_BIB=$(wildcard *_full_*.tex)
TEXS_WO_BIB=$(wildcard *_short_*.tex)
TEXS = $(TEXS_W_BIB) $(TEXS_WO_BIB)
BUILDDIR_W_BIB:=build_w
BUILDDIR_WO_BIB:=build_wo
BUILDDIRS = $(BUILDDIR_W_BIB) $(BUILDDIR_WO_BIB)
PDFS=$(addprefix $(BUILDDIR_W_BIB)/,$(TEXS_W_BIB:.tex=.pdf)) $(addprefix $(BUILDDIR_WO_BIB)/,$(TEXS_WO_BIB:.tex=.pdf))

all: $(PDFS)
	echo Build all 
	mv $(BUILDDIR_W_BIB)/*.pdf .
	mv $(BUILDDIR_WO_BIB)/*.pdf .
	$(RM) $(BUILDDIRS)


$(BUILDDIR_W_BIB)/%.pdf: $(BUILDDIR_W_BIB)/%.aux $(BUILDDIR_W_BIB)/%.bbl 
	(cd $(BUILDDIR_W_BIB) && $(LATEX) $(basename $(<F)))         

$(BUILDDIR_WO_BIB)/%.pdf: $(BUILDDIR_WO_BIB)/%.aux 
	(cd $(BUILDDIR_WO_BIB) && $(LATEX) $(basename $(<F)))  

$(BUILDDIR_W_BIB)/%.tex : $(TEXS_W_BIB)
	mkdir -p  $(BUILDDIR_W_BIB)
	cp $(TEXS_W_BIB) $(BUILDDIR_W_BIB)

$(BUILDDIR_WO_BIB)/%.tex : $(TEXS_WO_BIB)
	mkdir -p  $(BUILDDIR_WO_BIB)
	cp $(TEXS_WO_BIB) $(BUILDDIR_WO_BIB)

$(BUILDDIR_W_BIB)/%.aux: $(BUILDDIR_W_BIB)/%.tex 
	(cp -R includes $(BUILDDIR_W_BIB)         \
	 && cp -R data $(BUILDDIR_W_BIB)             \
	 && cd $(BUILDDIR_W_BIB)                     \
	 && $(LATEX) $(basename $(<F)))

$(BUILDDIR_WO_BIB)/%.aux: $(BUILDDIR_WO_BIB)/%.tex 
	(cp -R includes $(BUILDDIR_WO_BIB)         \
	 && cp -R data $(BUILDDIR_WO_BIB)             \
	 && cd $(BUILDDIR_WO_BIB)                     \
	 && $(LATEX) $(basename $(<F)))

$(BUILDDIR_W_BIB)/%.bbl: $(BUILDDIR_W_BIB)/%.aux 
	(cd $(BUILDDIR_W_BIB) && bibtex $(basename $(<F)))

.PHONY: clean distclean


distclean: clean 
	$(RM) $(PDFS)