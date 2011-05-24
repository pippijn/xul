ATTRIBUTES	:= $(patsubst mdn/XUL/%,xml/%,$(wildcard mdn/XUL/Attribute/*))
ELEMENTS	:= $(patsubst mdn/XUL/%,xml/Element/%,$(shell find mdn/XUL -maxdepth 1 -type f))
METHODS		:= $(patsubst mdn/XUL/%,xml/%,$(wildcard mdn/XUL/Method/*))
PROPERTIES	:= $(patsubst mdn/XUL/%,xml/%,$(wildcard mdn/XUL/Property/*))

XULELEMENT	:= xml/XULElement.xml

../xul.xsd: xsl/xsd.xsl xulref.xml
	xsltproc --output $@ $< xulref.xml

xulref.xml: mdn-update attributes elements methods properties $(shell find xsd -type f) $(XULELEMENT)
	@echo "  CAT   " $@
	@echo '<!DOCTYPE xulref SYSTEM "xsd/xulref.dtd">' > $@
	@echo '<xulref xmlns="http://xul.xinutec.org/2011/xulref">' >> $@
	@cat $(ATTRIBUTES) $(PROPERTIES) $(METHODS) $(ELEMENTS) $(XULELEMENT) >> $@
	@echo '</xulref>' >> $@
	@xmllint --output $@ --format $@
	@xmllint --noout --valid --schema xsd/xulref.xsd $@ #|| $(RM) $@

mdn-update:
	$(MAKE) -C mdn

attributes: $(ATTRIBUTES)
elements: $(ELEMENTS)
methods: $(METHODS)
properties: $(PROPERTIES)

$(XULELEMENT): xsl/xul-element-info.xsl mdn/XUL_element_attributes.xml
	@./transform $+ $@

xml/Attribute/%.xml: xsl/attribute-info.xsl mdn/XUL/Attribute/%.xml
	@./transform $+ $@

xml/Element/%.xml: xsl/element-info.xsl mdn/XUL/%.xml
	@./transform $+ $@

xml/Method/%.xml: xsl/method-info.xsl mdn/XUL/Method/%.xml
	@./transform $+ $@

xml/Property/%.xml: xsl/property-info.xsl mdn/XUL/Property/%.xml
	@./transform $+ $@
