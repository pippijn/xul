<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:tabs">
		<div class="xul-tabs">
			<xsl:copy-of select="@id"/>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

</xsl:stylesheet>
