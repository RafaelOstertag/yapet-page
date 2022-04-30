SUBDIRS = scripts
YAPET_DOWNLOAD_URL=https://yapet.guengel.ch/downloads

FRAGASS = scripts/bin/fragass
FRAGASS_TEMPLATE = -template templates/html_template.html

GENERATED_FRAGMENTS_DIR = work/generated_fragments
YAPET_SRC_DIR = work/yapet

HTML_TEMPLATE = templates/html_template.html

PUBLIC_HTML_DIR = public_html

all: buildsubdirs buildhtml buildsitemap

clean: cleansubdirs cleanhtml cleansitemap
	rm -rf work
	rm -f untar-yapet work-dir

buildsubdirs:
	for d in $(SUBDIRS) ; do $(MAKE) -C $$d all ; done

buildhtml: $(PUBLIC_HTML_DIR)/index.html \
	$(PUBLIC_HTML_DIR)/downloads.html \
	$(PUBLIC_HTML_DIR)/readme.html \
	$(PUBLIC_HTML_DIR)/csv2yapet.html \
	$(PUBLIC_HTML_DIR)/yapet_colors.html \
	$(PUBLIC_HTML_DIR)/yapet_config.html \
	$(PUBLIC_HTML_DIR)/yapet.html \
	$(PUBLIC_HTML_DIR)/yapet2csv.html \
	$(PUBLIC_HTML_DIR)/news.html \
	$(PUBLIC_HTML_DIR)/readme.html

buildsitemap: $(PUBLIC_HTML_DIR)/Sitemap.xml

$(PUBLIC_HTML_DIR)/Sitemap.xml:
	env BASE_URL=https://yapet.guengel.ch/ scripts/sitemap.sh > $@

$(PUBLIC_HTML_DIR)/index.html: $(GENERATED_FRAGMENTS_DIR)/index.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

$(PUBLIC_HTML_DIR)/yapet.html: $(GENERATED_FRAGMENTS_DIR)/yapet.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

$(PUBLIC_HTML_DIR)/yapet_colors.html: $(GENERATED_FRAGMENTS_DIR)/yapet_colors.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

$(PUBLIC_HTML_DIR)/yapet_config.html: $(GENERATED_FRAGMENTS_DIR)/yapet_config.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

$(PUBLIC_HTML_DIR)/csv2yapet.html: $(GENERATED_FRAGMENTS_DIR)/csv2yapet.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

$(PUBLIC_HTML_DIR)/yapet2csv.html: $(GENERATED_FRAGMENTS_DIR)/yapet2csv.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

$(PUBLIC_HTML_DIR)/news.html: $(GENERATED_FRAGMENTS_DIR)/news.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

$(PUBLIC_HTML_DIR)/downloads.html: $(GENERATED_FRAGMENTS_DIR)/downloads.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

$(PUBLIC_HTML_DIR)/readme.html: $(GENERATED_FRAGMENTS_DIR)/readme.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

$(PUBLIC_HTML_DIR)/design.html: $(GENERATED_FRAGMENTS_DIR)/design.xml $(HTML_TEMPLATE)
	$(FRAGASS) $(FRAGASS_TEMPLATE) -fragment $< > $@

yapet.tar.xz:
	latest_release=`scripts/bin/latestversion -package-name yapet` && curl -o yapet.tar.xz $(YAPET_DOWNLOAD_URL)/$$latest_release

untar-yapet: yapet.tar.xz work-dir
	tar -C $(YAPET_SRC_DIR) --strip-components 1 -xf yapet.tar.xz
	@touch $@

$(YAPET_SRC_DIR)/NEWS: untar-yapet
$(YAPET_SRC_DIR)/doc/%.html: untar-yapet
$(PUBLIC_HTML_DIR)/includes/%.html: untar-yapet
	mkdir -p $(PUBLIC_HTML_DIR)/includes
	cp $(YAPET_SRC_DIR)/doc/*.html $(PUBLIC_HTML_DIR)/includes/

$(GENERATED_FRAGMENTS_DIR)/news.xml: $(PUBLIC_HTML_DIR)/includes/NEWS.html work-dir 
	scripts/includes.sh $< "YAPET News" > $@

$(GENERATED_FRAGMENTS_DIR)/yapet.xml: $(PUBLIC_HTML_DIR)/includes/yapet.html work-dir
	scripts/includes.sh $< "YAPET Manual Page" > $@

$(GENERATED_FRAGMENTS_DIR)/yapet_colors.xml: $(PUBLIC_HTML_DIR)/includes/yapet_colors.html work-dir
	scripts/includes.sh $< "YAPET Colors Manual Page" > $@

$(GENERATED_FRAGMENTS_DIR)/yapet_config.xml: $(PUBLIC_HTML_DIR)/includes/yapet_config.html work-dir
	scripts/includes.sh $< "YAPET Configuration Manual Page" > $@

$(GENERATED_FRAGMENTS_DIR)/csv2yapet.xml: $(PUBLIC_HTML_DIR)/includes/csv2yapet.html work-dir
	scripts/includes.sh $< "Csv2yapet Manual Page" > $@

$(GENERATED_FRAGMENTS_DIR)/yapet2csv.xml: $(PUBLIC_HTML_DIR)/includes/yapet2csv.html work-dir
	scripts/includes.sh $< "Yapet2csv Manual Page" > $@

$(GENERATED_FRAGMENTS_DIR)/readme.xml: $(PUBLIC_HTML_DIR)/includes/README.html work-dir
	scripts/includes.sh $< "YAPET Readme" > $@

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
	rm -f $(PUBLIC_HTML_DIR)/*.html

cleansitemap:
	rm -f $(PUBLIC_HTML_DIR)/Sitemap.xml

.PHONY: buildsubdirs
