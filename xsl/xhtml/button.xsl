<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:button">
		<button class="xul-button">
			<xsl:copy-of select="@id"/>
			<xsl:attribute name="onclick">
				<xsl:value-of select="@oncommand"/>
			</xsl:attribute>
			<xsl:value-of select="@label|x:description/text()"/>
		</button>
	</xsl:template>

</xsl:stylesheet>
