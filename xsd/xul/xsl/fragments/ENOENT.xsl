<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="error.xsl"/>

	<xsl:template name="ENOENT">
		<xsl:param name="what"/>

		<xsl:call-template name="error">
			<xsl:with-param name="what">
				Could not find <xsl:value-of select="$what"/>.
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
