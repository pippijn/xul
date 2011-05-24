SHELL		:= /bin/bash

PACKAGES	:= xerces-c libxml-2.0 libxslt

CXXFLAGS	:= $(shell pkg-config --cflags $(PACKAGES)) -ggdb3
LDFLAGS		:= $(shell pkg-config --libs $(PACKAGES)) -ltidy
CPPFLAGS	:= -DSRCDIR='"$(CURDIR)"' -MD

define TESTS
$(foreach x,					\
  $(wildcard xsl/*.xsl),			\
  $(patsubst					\
    testsuite/%.xul,				\
    testsuite/out/%.$(basename $(notdir $x)),	\
    $(filter-out %.xinclude.xul %.valid.xul,	\
      $(wildcard testsuite/*.xul))))
endef

all: build

BUILD = compiler xsd/xul.xsd $(STYLESHEETS)

xsd/xul.xsd: $(shell find xsd/xul -maxdepth 2 -type f)
	$(MAKE) -C xsd/xul

compiler: $(patsubst %.cpp,%.o,$(wildcard src/*.cpp))
	$(LINK.cpp) -o $@ $^

check: $(TESTS)

clean:
	$(RM) $(TESTS) compiler
	$(RM) $(STYLESHEETS)

define XSLT
STYLESHEETS += $1.xsl
$1.xsl: $$(shell find $1 -name "*.xsl")
	@echo "Generating $$@"
	@echo '<?xml version="1.0"?>' > $$@
	@echo '<!DOCTYPE stylesheet SYSTEM "xsl.dtd">' >> $$@
	@echo '<xsl:stylesheet version="1.0">' >> $$@
	@for i in $$+; do echo -e "\t<xsl:include href='$$$${i/xsl\/}'/>" >> $$@; done
	@echo '</xsl:stylesheet>' >> $$@

endef

$(foreach x,$(shell find xsl -mindepth 1 -maxdepth 1 -type d),$(eval $(call XSLT,$x)))

testsuite/out/%.xhtml:	testsuite/%.xul $(BUILD) ; ./compiler $(suffix $@) $< $@
testsuite/out/%.xul:	testsuite/%.xul $(BUILD) ; ./compiler $(suffix $@) $< $@

stylesheets: $(STYLESHEETS)
build: $(BUILD)

-include $(wildcard src/*.d)
