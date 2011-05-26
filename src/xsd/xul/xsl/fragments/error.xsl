<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="error">
		<xsl:param name="what"/>

		<xsl:message terminate="yes">
			<xsl:value-of select="$what"/>
			Check https://developer.mozilla.org/en/XUL/<xsl:value-of select="$Longname"/>/<xsl:value-of select="/content/@title"/>
			and correct possible errors.
		</xsl:message>
	</xsl:template>

</xsl:stylesheet>
