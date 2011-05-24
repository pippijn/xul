<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:image">
		<img class="xul-image">
			<xsl:copy-of select="@id"/>
			<xsl:copy-of select="@src"/>
			<xsl:attribute name="alt">
				<xsl:value-of select="@src"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</img>
	</xsl:template>

</xsl:stylesheet>
