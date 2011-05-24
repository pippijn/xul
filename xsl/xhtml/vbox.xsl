<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:vbox">
		<table class="xul-vbox" summary="">
			<xsl:copy-of select="@id"/>
				<xsl:for-each select="*">
					<tr>
						<td>
							<xsl:apply-templates select="."/>
						</td>
					</tr>
				</xsl:for-each>
		</table>
	</xsl:template>

</xsl:stylesheet>
