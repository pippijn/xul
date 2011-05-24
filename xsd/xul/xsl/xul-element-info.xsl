<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://xul.xinutec.org/2011/element">

	<xsl:output omit-xml-declaration="yes"/>

	<xsl:template match="content">
		<element name="XULElement" abstract="true">
			<attr ref="attr-onclick"/>
			<attr ref="attr-oncommand"/>
			<attr ref="attr-onload"/>
			<attr ref="attr-onselect"/>

			<xsl:apply-templates select="body/p[1]/span"/>
			<documentation source="https://developer.mozilla.org/en/XUL_element_attributes">
				<div xmlns="http://www.w3.org/1999/xhtml">
				</div>
			</documentation>
		</element>
	</xsl:template>

	<xsl:template match="body/p[1]/span">
		<attr ref="attr-{substring-before(substring-after(text(), 'XULAttrInc(&quot;'), '&quot;)')}"/>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
