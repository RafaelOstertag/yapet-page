
SUBDIRS = scripts

FRAGASS = scripts/bin/fragass
FRAGASS_TEMPLATE = -template templates/html_template.html

GENERATED_FRAGMENTS_DIR = work/generated_fragments
YAPET_SRC_DIR = work/yapet

HTML_TEMPLATE = templates/html_template.html

all: buildsubdirs buildhtml copydoc

clean: cleansubdirs cleanhtml
	rm -rf work
	rm -f untar-yapet work-dir

buildsubdirs:
	currdir=`pwd` ; for d in $(SUBDIRS) ; do cd "$$d" && $(MAKE) all && cd "$$currdir" ; done

buildhtml: public_html/index.html public_html/news.html public_html/downloads.html public_html/manual.html

public_html/index.html: $(HTML_TEMPLATE) work-dir $(GENERATED_FRAGMENTS_DIR)/index.xml
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $(GENERATED_FRAGMENTS_DIR)/index.xml > $@

public_html/manual.html: $(HTML_TEMPLATE) work-dir $(GENERATED_FRAGMENTS_DIR)/manual.xml
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $(GENERATED_FRAGMENTS_DIR)/manual.xml > $@

public_html/news.html: $(HTML_TEMPLATE) untar-yapet work-dir $(GENERATED_FRAGMENTS_DIR)/news.xml
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $(GENERATED_FRAGMENTS_DIR)/news.xml > $@

public_html/downloads.html: $(HTML_TEMPLATE) work-dir $(GENERATED_FRAGMENTS_DIR)/downloads.xml
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $(GENERATED_FRAGMENTS_DIR)/downloads.xml > $@

untar-yapet: yapet.tar.xz work-dir
	gtar -C $(YAPET_SRC_DIR) --strip-components 1 -xf yapet.tar.xz
	@touch $@

$(GENERATED_FRAGMENTS_DIR)/news.xml:
	scripts/newsfragment.sh $(YAPET_SRC_DIR)/NEWS $(GENERATED_FRAGMENTS_DIR)

$(GENERATED_FRAGMENTS_DIR)/manual.xml:
	scripts/manualfragment.sh $(YAPET_SRC_DIR)/doc/yapet.html $(GENERATED_FRAGMENTS_DIR)

$(GENERATED_FRAGMENTS_DIR)/index.xml: templates/index.tmpl
	scripts/bin/indexfrag > $@

$(GENERATED_FRAGMENTS_DIR)/downloads.xml: templates/downloads.tmpl
	scripts/bin/downloadfrag > $@

copydoc: untar-yapet
	mkdir -p public_html/doc
	cp $(YAPET_SRC_DIR)/doc/*.html public_html/doc

work-dir:
	mkdir -p $(YAPET_SRC_DIR)
	mkdir -p $(GENERATED_FRAGMENTS_DIR)
	mkdir -p work/tmp
	@touch $@

cleansubdirs:
	currdir=`pwd` ; for d in $(SUBDIRS) ; do cd "$$d" && $(MAKE) clean && cd "$$currdir" ; done

cleanhtml:
	rm -f public_html/*.html

.PHONY: buildsubdirs
