<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:description">
		<div class="xul-description">
			<xsl:copy-of select="@id"/>
			<xsl:value-of select="@value"/>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

</xsl:stylesheet>
