<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet SYSTEM "xsl.dtd">
<xsl:stylesheet version="1.0">

	<xsl:template match="x:hbox">
		<xsl:choose>
			<xsl:when test="count(*)">
				<table class="xul-hbox" summary="">
					<xsl:copy-of select="@id"/>
					<tr>
						<xsl:for-each select="*">
							<td>
								<xsl:apply-templates select="."/>
							</td>
						</xsl:for-each>
					</tr>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<div class="xul-hbox">
					<xsl:copy-of select="@id"/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
