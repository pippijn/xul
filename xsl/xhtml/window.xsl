<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="/x:window">
		<div class="xul-window">
			<xsl:copy-of select="@id"/>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="x:window">
		<div class="xul-window">
			<xsl:copy-of select="@id"/>
			<div class="xul-window-title">
				<xsl:value-of select="@title"/>
			</div>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

</xsl:stylesheet>
