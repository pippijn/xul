ATTRIBUTES	:= $(patsubst mdn/xml/XUL/%,xml/%,$(wildcard mdn/xml/XUL/Attribute/*.xml))
ELEMENTS	:= $(patsubst mdn/xml/XUL/%,xml/Element/%,$(shell find mdn/xml/XUL -maxdepth 1 -name "*.xml"))
METHODS		:= $(patsubst mdn/xml/XUL/%,xml/%,$(wildcard mdn/xml/XUL/Method/*.xml))
PROPERTIES	:= $(patsubst mdn/xml/XUL/%,xml/%,$(wildcard mdn/xml/XUL/Property/*.xml))

XULELEMENT	:= xml/XULElement.xml

DEPENDENCIES	:= $(patsubst slax/%.slax,xsl/%.xsl,$(wildcard slax/fragments/*.slax)) $(wildcard xsd/* xsd/fragments/*)

../xul.xsd: xsl/xsd.xsl xulref.xml
	@echo "  XSLT  " $@
	@xsltproc --output $@ $+
	@xmllint --noout --dtdvalid ../XULSchema.dtd $@

xulref.xml: attributes elements methods properties $(shell find xsd -type f) $(XULELEMENT)
	@echo "  CAT   " $@
	@echo '<!DOCTYPE xulref SYSTEM "xsd/xulref.dtd">' > $@
	@echo '<xulref xmlns="http://xul.xinutec.org/2011/xulref">' >> $@
	@cat _onselect.xml $(ATTRIBUTES) $(PROPERTIES) $(METHODS) $(ELEMENTS) $(XULELEMENT) >> $@
	@echo '</xulref>' >> $@
	@xmllint --output $@ --format $@
	@xmllint --noout --valid --schema xsd/xulref.xsd $@ #|| $(RM) $@

attributes: $(ATTRIBUTES)
elements: $(ELEMENTS)
methods: $(METHODS)
properties: $(PROPERTIES)

$(XULELEMENT): xsl/xul-element-info.xsl mdn/xml/XUL_element_attributes.xml $(DEPENDENCIES)
	@./transform $@ $+

xml/Attribute/%.xml: xsl/attribute-info.xsl mdn/xml/XUL/Attribute/%.xml $(DEPENDENCIES)
	@./transform $@ $+

xml/Element/%.xml: xsl/element-info.xsl mdn/xml/XUL/%.xml $(DEPENDENCIES)
	@./transform $@ $+

xml/Method/%.xml: xsl/method-info.xsl mdn/xml/XUL/Method/%.xml $(DEPENDENCIES)
	@./transform $@ $+

xml/Property/%.xml: xsl/property-info.xsl mdn/xml/XUL/Property/%.xml $(DEPENDENCIES)
	@./transform $@ $+

xsl/%.xsl: slax/%.slax
	@echo "  SLAX  " $@
	@slaxproc -o $@ -x $<
