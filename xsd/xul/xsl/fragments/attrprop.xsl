<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="ENOENT.xsl"/>
	<xsl:include href="copy-self.xsl"/>
	<xsl:include href="parse-util.xsl"/>
	<xsl:include href="string-replace.xsl"/>

	<xsl:template match="content">
		<xsl:apply-templates select="body/dl[1]"/>
	</xsl:template>

	<xsl:template match="body/dl[1]/dt[1]"/>
	<xsl:template match="body/dl[1]/dd[substring(normalize-space(text()), 1, 5) = 'Type:']"/>
	
	<xsl:template match="body/dl[1]">
		<xsl:variable name="name"><xsl:call-template name="parse-name"/></xsl:variable>
		<xsl:variable name="type"><xsl:call-template name="parse-type"/></xsl:variable>

		<xsl:if test="string-length($name) = 0"><xsl:call-template name="ENOENT"><xsl:with-param name="what"  select="'name'"/></xsl:call-template></xsl:if>
		<xsl:if test="string-length($type) = 0"><xsl:call-template name="ENOENT"><xsl:with-param name="what"  select="'type'"/></xsl:call-template></xsl:if>

		<xsl:element name="{$longname}" namespace="{$namespace}">
			<xsl:attribute name="name">
				<xsl:value-of select="concat($shortname, '-', $name)"/>
			</xsl:attribute>
			<xsl:attribute name="type">
				<xsl:value-of select="$type"/>
			</xsl:attribute>
			<xsl:call-template name="documentation">
				<xsl:with-param name="name" select="$name"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>

	<xsl:template name="parse-name">
		<xsl:value-of
			select="substring-before(substring-after(dt[1]/span/text(), concat('XUL', $Shortname, '(&quot;')), '&quot;')"/>
	</xsl:template>

</xsl:stylesheet>
