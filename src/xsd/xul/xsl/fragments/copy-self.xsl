<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">

	<xsl:template match="@*">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*">
		<xsl:element name="{name()}" namespace="http://www.w3.org/1999/xhtml">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="h1/@name"/>
	<xsl:template match="h2/@name"/>
	<xsl:template match="h3/@name"/>
	<xsl:template match="h4/@name"/>

	<xsl:template match="pre/@function"/>

	<xsl:template match="dl/div">
		<dd>
			<div>
				<xsl:apply-templates select="@*|*"/>
			</div>
		</dd>
	</xsl:template>

	<xsl:template match="ul/p">
		<li>
			<xsl:apply-templates select="@*|*"/>
		</li>
	</xsl:template>

	<xsl:template match="div[@class = 'noinclude']">
		<xsl:apply-templates/>
	</xsl:template>

</xsl:stylesheet>
