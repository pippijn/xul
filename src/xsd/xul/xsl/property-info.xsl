<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://xul.xinutec.org/2011/xulref">

	<xsl:output omit-xml-declaration="yes"/>
	<xsl:variable name="Longname" select="'Property'"/>
	<xsl:variable name="longname" select="'property'"/>
	<xsl:variable name="Shortname" select="'Prop'"/>
	<xsl:variable name="shortname" select="'prop'"/>
	<xsl:variable name="namespace" select="'http://xul.xinutec.org/2011/property'"/>

	<xsl:include href="fragments/attrprop.xsl"/>

</xsl:stylesheet>
