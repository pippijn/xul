<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="string-replace">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:param name="by"/>
		<xsl:choose>
			<xsl:when test="contains($text, $replace)">
				<xsl:value-of select="substring-before($text,$replace)"/>
				<xsl:value-of select="$by"/>
				<xsl:call-template name="string-replace">
					<xsl:with-param name="text"
						select="substring-after($text,$replace)"/>
					<xsl:with-param name="replace" select="$replace"/>
					<xsl:with-param name="by" select="$by"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="string-erase">
		<xsl:param name="text"/>
		<xsl:param name="erase"/>

		<xsl:call-template name="string-replace">
			<xsl:with-param name="text" select="$text"/>
			<xsl:with-param name="replace" select="$erase"/>
			<xsl:with-param name="by" select="''"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="string-erase-all">
		<xsl:param name="text"/>
		<xsl:param name="list"/>

		<xsl:variable name="all" select="normalize-space($list)"/>

		<xsl:variable name="return">
			<xsl:choose>
				<xsl:when test="contains($all, ' ')">
					<xsl:call-template name="string-erase-all">
						<xsl:with-param name="text">
							<xsl:call-template name="string-erase">
								<xsl:with-param name="text" select="$text"/>
								<xsl:with-param name="erase" select="substring-before($all, ' ')"/>
							</xsl:call-template>
						</xsl:with-param>
						<xsl:with-param name="list" select="substring-after($all, ' ')"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="string-erase">
						<xsl:with-param name="text" select="$text"/>
						<xsl:with-param name="erase" select="$all"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="$return"/>
	</xsl:template>

</xsl:stylesheet>
