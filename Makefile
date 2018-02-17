SUBDIRS = scripts
YAPET_DOWNLOAD_URL=https://yapet.guengel.ch/downloads

FRAGASS = scripts/bin/fragass
FRAGASS_TEMPLATE = -template templates/html_template.html

GENERATED_FRAGMENTS_DIR = work/generated_fragments
YAPET_SRC_DIR = work/yapet

HTML_TEMPLATE = templates/html_template.html

all: buildsubdirs buildhtml buildsitemap

clean: cleansubdirs cleanhtml cleansitemap
	rm -rf work
	rm -f untar-yapet work-dir

buildsubdirs:
	for d in $(SUBDIRS) ; do $(MAKE) -C $$d all ; done

buildhtml: public_html/index.html public_html/news.html public_html/downloads.html public_html/yapet.html public_html/yapet_colors.html public_html/yapet_config.html public_html/csv2yapet.html public_html/yapet2csv.html public_html/readme.html public_html/design.html

buildsitemap: public_html/Sitemap.xml

public_html/Sitemap.xml:
	scripts/sitemap.sh > $@

public_html/index.html: $(GENERATED_FRAGMENTS_DIR)/index.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

public_html/yapet.html: $(GENERATED_FRAGMENTS_DIR)/yapet.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

public_html/yapet_colors.html: $(GENERATED_FRAGMENTS_DIR)/yapet_colors.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

public_html/yapet_config.html: $(GENERATED_FRAGMENTS_DIR)/yapet_config.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

public_html/csv2yapet.html: $(GENERATED_FRAGMENTS_DIR)/csv2yapet.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

public_html/yapet2csv.html: $(GENERATED_FRAGMENTS_DIR)/yapet2csv.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

public_html/news.html: $(GENERATED_FRAGMENTS_DIR)/news.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

public_html/downloads.html: $(GENERATED_FRAGMENTS_DIR)/downloads.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

public_html/readme.html: $(GENERATED_FRAGMENTS_DIR)/readme.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

public_html/design.html: $(GENERATED_FRAGMENTS_DIR)/design.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

yapet.tar.xz:
	latest_release=`scripts/bin/latestversion -package-name yapet` && curl -o yapet.tar.xz $(YAPET_DOWNLOAD_URL)/$$latest_release

untar-yapet: yapet.tar.xz work-dir
	gtar -C $(YAPET_SRC_DIR) --strip-components 1 -xf yapet.tar.xz
	@touch $@

$(YAPET_SRC_DIR)/NEWS: untar-yapet
$(YAPET_SRC_DIR)/doc/%.html: untar-yapet

$(GENERATED_FRAGMENTS_DIR)/news.xml: $(YAPET_SRC_DIR)/NEWS work-dir 
	scripts/newsfragment.sh $< $(GENERATED_FRAGMENTS_DIR)

$(GENERATED_FRAGMENTS_DIR)/yapet.xml: $(YAPET_SRC_DIR)/doc/yapet.html work-dir
	scripts/manualfragment.sh $< "YAPET Manual Page" > $@

$(GENERATED_FRAGMENTS_DIR)/yapet_colors.xml: $(YAPET_SRC_DIR)/doc/yapet_colors.html work-dir
	scripts/manualfragment.sh $< "YAPET Colors Manual Page" > $@

$(GENERATED_FRAGMENTS_DIR)/yapet_config.xml: $(YAPET_SRC_DIR)/doc/yapet_config.html work-dir
	scripts/manualfragment.sh $< "YAPET Configuration Manual Page" > $@

$(GENERATED_FRAGMENTS_DIR)/csv2yapet.xml: $(YAPET_SRC_DIR)/doc/csv2yapet.html work-dir
	scripts/manualfragment.sh $< "Csv2yapet Manual Page" > $@

$(GENERATED_FRAGMENTS_DIR)/yapet2csv.xml: $(YAPET_SRC_DIR)/doc/yapet2csv.html work-dir
	scripts/manualfragment.sh $< "Yapet2csv Manual Page" > $@

$(GENERATED_FRAGMENTS_DIR)/readme.xml: $(YAPET_SRC_DIR)/doc/README.html work-dir
	scripts/articlefragment.sh $< "YAPET Readme" "Readme" > $@

$(GENERATED_FRAGMENTS_DIR)/design.xml: $(YAPET_SRC_DIR)/doc/DESIGN.html work-dir
	scripts/articlefragment.sh $< "YAPET Design" "Design" > $@

$(GENERATED_FRAGMENTS_DIR)/index.xml: templates/index.tmpl work-dir
	scripts/bin/indexfrag -package-name "yapet" -page-title "YAPET - Yet Another Password Encryption Tool" > $@

$(GENERATED_FRAGMENTS_DIR)/downloads.xml: templates/downloads.tmpl work-dir
	scripts/bin/downloadfrag -page-title "YAPET Downloads" > $@

work-dir:
	mkdir -p $(YAPET_SRC_DIR)
	mkdir -p $(GENERATED_FRAGMENTS_DIR)
	mkdir -p work/tmp
	@touch $@

cleansubdirs:
	for d in $(SUBDIRS) ; do  $(MAKE) -C $$d clean ; done

cleanhtml:
	rm -f public_html/*.html

cleansitemap:
	rm -f public_html/Sitemap.xml

.PHONY: buildsubdirs
