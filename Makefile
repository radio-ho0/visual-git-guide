PDFLATEX = pdflatex -halt-on-error -file-line-error
PDF2SVG = pdf2svg
PDF2PNG = convert

FILES := \
    basic-usage \
    checkout-after-detached \
    checkout-b-detached \
    checkout-branch \
    checkout-detached \
    checkout-files \
    commit-amend \
    commit-detached \
    commit-maint \
    commit-master \
    conventions \
    diff \
    merge \
    merge-ff \
    reset \
    reset-commit \
    reset-files

PDF_OUT = $(FILES:=.pdf)
PNG_OUT = $(PDF_OUT:.pdf=.svg.png)
SVG_OUT = $(PDF_OUT:.pdf=.svg)
CRUFT = $(FILES:=.aux) $(FILES:=.log)
EXTRA = index.html

all : pdf png svg
pdf : $(PDF_OUT)
png : $(PNG_OUT)
svg : $(SVG_OUT)

gh-pages : all
	./publish $(PDF_OUT) $(PNG_OUT) $(SVG_OUT) $(EXTRA)

%.pdf : %.tex common.tex
	$(PDFLATEX) $<

%.svg : %.pdf
	$(PDF2SVG) $^ $@

%.svg.png : %.pdf
	$(PDF2PNG) $^ $@

clean :
	$(RM) $(PDF_OUT) $(PNG_OUT) $(SVG_OUT) $(CRUFT)

.PHONY : clean all pdf png svg gh-pages
