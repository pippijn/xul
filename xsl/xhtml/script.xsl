<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:script">
		<script type="text/javascript">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</script>
	</xsl:template>

</xsl:stylesheet>
