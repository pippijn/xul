<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:menuseparator">
		<div class="xul-menuseparator">
			<xsl:copy-of select="@id"/>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

</xsl:stylesheet>
