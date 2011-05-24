<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="string-replace.xsl"/>

	<xsl:template name="parse-type">
		<xsl:param name="prefix"/>

		<xsl:variable name="search">
			<xsl:choose>
				<xsl:when test="$prefix">
					<xsl:value-of select="$prefix"/>
				</xsl:when>
				<xsl:otherwise>Type:</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="type"
			select="normalize-space(dd[substring(normalize-space(text()), 1, string-length($search)) = $search]/em)"/>

		<xsl:call-template name="string-erase-all">
			<xsl:with-param name="text" select="$type"/>
			<xsl:with-param name="list">
				template.XULElem("
				XULElem("
				interface("
				")
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
