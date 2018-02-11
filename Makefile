
SUBDIRS = scripts

all: buildsubdirs buildhtml

clean: cleansubdirs cleanhtml

buildsubdirs:
	currdir=`pwd` ; for d in $(SUBDIRS) ; do cd "$$d" && $(MAKE) all && cd "$$currdir" ; done

buildhtml: public_html/index.html

public_html/index.html: templates/html_template.html fragments/index.xml
	scripts/bin/fragass -template templates/html_template.html -fragment fragments/index.xml > $@

cleansubdirs:
	currdir=`pwd` ; for d in $(SUBDIRS) ; do cd "$$d" && $(MAKE) clean && cd "$$currdir" ; done

cleanhtml:
	rm -f public_html/index.html

.PHONY: buildsubdirs
