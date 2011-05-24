<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:label">
		<label class="xul-label">
			<xsl:copy-of select="@id"/>
			<xsl:if test="@control">
				<xsl:attribute name="for">
					<xsl:value-of select="@control"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="@value"/>
			<xsl:apply-templates/>
		</label>
	</xsl:template>

</xsl:stylesheet>
