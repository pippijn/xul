<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://xul.xinutec.org/2011/xulref">

	<xsl:output omit-xml-declaration="yes"/>

	<xsl:include href="fragments/ENOENT.xsl"/>
	<xsl:include href="fragments/copy-self.xsl"/>
	<xsl:include href="fragments/parse-util.xsl"/>

	<xsl:template match="content">
		<xsl:apply-templates select="body/dl[1]"/>
	</xsl:template>

	<xsl:template match="body/dl[1]/dt[1]"/>
	<xsl:template match="body/dl[1]/dd[substring(normalize-space(text()), 1, 12) = 'Return type:']"/>

	<xsl:template match="body/dl[1]">
		<xsl:variable name="name" select="substring-before(substring-after(dt[1]/span/text(), 'XULMeth2(&quot;'), '&quot;')"/>
		<xsl:variable name="args" select="substring-before(substring-after(dt[1]/span/text(), '&quot;('), ')&quot;')"/>
		<xsl:variable name="type">
			<xsl:call-template name="parse-type">
				<xsl:with-param name="prefix">Return type:</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>

		<xsl:if test="not($name)"><xsl:call-template name="ENOENT"><xsl:with-param name="what"  select="'method name'"/></xsl:call-template></xsl:if>
		<xsl:if test="not($type)"><xsl:call-template name="ENOENT"><xsl:with-param name="what"  select="'method return type'"/></xsl:call-template></xsl:if>

		<method name="meth-{$name}" type="{$type}">
			<xsl:if test="$args">
				<xsl:call-template name="parse-argument-list">
					<xsl:with-param name="args" select="$args"/>
				</xsl:call-template>
			</xsl:if>
			<documentation source="https://developer.mozilla.org/en/XUL/Method/{$name}">
				<div xmlns="http://www.w3.org/1999/xhtml">
				<!--
					<dl>
						<xsl:apply-templates select="@*|node()"/>
					</dl>
					<xsl:apply-templates select="following-sibling::*"/>
				-->
				</div>
			</documentation>
		</method>
	</xsl:template>

	<xsl:template name="parse-argument-list">
		<xsl:param name="args"/>

		<xsl:choose>
			<xsl:when test="contains($args, ',')">
				<arg name="{normalize-space(substring-before($args, ','))}"/>

				<xsl:call-template name="parse-argument-list">
					<xsl:with-param name="args" select="substring-after($args, ',')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<arg name="{normalize-space($args)}"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
