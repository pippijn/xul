<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:caption">
		<div class="xul-caption">
			<xsl:copy-of select="@id"/>
			<xsl:value-of select="@label"/>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

</xsl:stylesheet>
