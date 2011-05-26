<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:output
		method="xml"
		omit-xml-declaration="yes"
		encoding="ISO-8859-1" 
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="../../src/xsd/xhtml/xhtml1-strict.dtd"/>

	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="x:*/@title"/></title>
				<link rel="stylesheet" type="text/css" href="../../global/skin.css"/>
				<script type="text/javascript" src="../../global/xul.js"/>
			</head>
			<body>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="html:*">
		<xsl:element name="{name()}" namespace="">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>


</xsl:stylesheet>
