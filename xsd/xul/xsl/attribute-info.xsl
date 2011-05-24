<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://xul.xinutec.org/2011/attribute">

	<xsl:output omit-xml-declaration="yes"/>
	<xsl:variable name="Longname" select="'Attribute'"/>
	<xsl:variable name="longname" select="'attribute'"/>
	<xsl:variable name="Shortname" select="'Attr'"/>
	<xsl:variable name="shortname" select="'attr'"/>
	<xsl:variable name="namespace" select="'http://xul.xinutec.org/2011/attribute'"/>

	<xsl:include href="fragments/attrprop.xsl"/>

	<xsl:template name="documentation">
		<xsl:param name="name"/>

		<documentation source="https://developer.mozilla.org/en/XUL/{$Longname}/{$name}">
			<div xmlns="http://www.w3.org/1999/xhtml">
			<!--
				<dl>
					<xsl:apply-templates select="@*|node()"/>
				</dl>
				<xsl:apply-templates select="following-sibling::*"/>
			-->
			</div>
		</documentation>
	</xsl:template>

</xsl:stylesheet>
