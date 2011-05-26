<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:textbox">
		<input type="text" class="xul-textbox">
			<xsl:copy-of select="@id|@value"/>
			<xsl:apply-templates/>
		</input>
	</xsl:template>

</xsl:stylesheet>
