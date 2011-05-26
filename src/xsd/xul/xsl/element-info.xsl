<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://xul.xinutec.org/2011/xulref">

	<xsl:output omit-xml-declaration="yes"/>

	<xsl:template match="content">
		<xsl:variable name="attrlinks" select="body/h3[normalize-space(text()) = 'Attributes']/following-sibling::p/span[contains(text(), 'XULAttrInc')]"/>
		<xsl:variable name="proplinks" select="body/h3[normalize-space(text()) = 'Properties']/following-sibling::p/span[contains(text(), 'XULPropInc')]"/>
		<xsl:variable name="methlinks" select="body/h3[normalize-space(text()) = 'Methods']/following-sibling::p/span[contains(text(), 'XULMethInc')]"/>

		<element name="{@title}" inherits="XULElement">
			<xsl:apply-templates select="$attrlinks"/>
			<xsl:apply-templates select="$proplinks"/>
			<xsl:apply-templates select="$methlinks"/>
			<documentation source="https://developer.mozilla.org/en/XUL/{@title}">
				<div xmlns="http://www.w3.org/1999/xhtml">
				</div>
			</documentation>
		</element>
	</xsl:template>

	<xsl:template match="span[contains(text(), 'XULAttrInc')]">
		<attr ref="attr-{substring-before(substring-after(text(), 'XULAttrInc(&quot;'), '&quot;)')}"/>
	</xsl:template>

	<xsl:template match="span[contains(text(), 'XULPropInc')]">
		<prop ref="prop-{substring-before(substring-after(text(), 'XULPropInc(&quot;'), '&quot;)')}"/>
	</xsl:template>

	<xsl:template match="span[contains(text(), 'XULMethInc')]">
		<meth ref="meth-{substring-before(substring-after(text(), 'XULMethInc(&quot;'), '&quot;)')}"/>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
