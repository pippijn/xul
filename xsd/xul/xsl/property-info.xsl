<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://xul.xinutec.org/2011/property">

	<xsl:output omit-xml-declaration="yes"/>
	<xsl:variable name="Longname" select="'Property'"/>
	<xsl:variable name="longname" select="'property'"/>
	<xsl:variable name="Shortname" select="'Prop'"/>
	<xsl:variable name="shortname" select="'prop'"/>
	<xsl:variable name="namespace" select="'http://xul.xinutec.org/2011/property'"/>

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
