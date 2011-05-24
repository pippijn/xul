<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:x="http://xul.xinutec.org/2011/xulref"
	xmlns:xul="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	extension-element-prefixes="x"> 

	<xsl:output omit-xml-declaration="yes" indent="yes"/>
	<xsl:key name="parent" match="x:element" use="@name"/>

	<xsl:template match="x:xulref">
		<xs:schema targetNamespace="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul">
			<xs:group name="anyElementStructure">
				<xs:choice>
					<xs:any
						namespace="http://www.w3.org/1999/xhtml"
						processContents="strict"/>
					<xs:any
						namespace="http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"
						processContents="strict"/>
				</xs:choice>
			</xs:group>

			<xsl:apply-templates>
				<xsl:sort select="name()"/>
				<xsl:sort select="@name"/>
			</xsl:apply-templates>
		</xs:schema>
	</xsl:template>

	<xsl:template match="x:attribute">
		<xsl:variable name="name" select="substring-after(@name, '-')"/>
		<xs:attributeGroup name="{$name}">
			<xsl:choose>
				<xsl:when test="contains($name, '.')">
					<xs:attribute name="{substring-after($name, '.')}" type="xs:string"/>
				</xsl:when>
				<xsl:otherwise>
					<xs:attribute name="{$name}" type="xs:string"/>
				</xsl:otherwise>
			</xsl:choose>
		</xs:attributeGroup>
	</xsl:template>

	<xsl:template match="x:element">
		<xsl:if test="@abstract = 'false'">
			<!--<xsl:message>processing <xsl:value-of select="@name"/></xsl:message>-->
			<xs:attributeGroup name="{@name}AttributeGroup">
				<xsl:if test="@inherits">
					<xsl:comment>Inherited from <xsl:value-of select="@inherits"/>:</xsl:comment>
					<xsl:apply-templates select="key('parent', @inherits)/x:attr">
						<xsl:with-param name="derived" select="@name"/>
					</xsl:apply-templates>
				</xsl:if>
				<xsl:comment>Own attributes:</xsl:comment>
				<xsl:apply-templates>
					<xsl:sort select="@ref"/>
				</xsl:apply-templates>
			</xs:attributeGroup>

			<xs:complexType name="{@name}ElementStructure">
				<xs:sequence>
					<xs:group ref="xul:anyElementStructure" minOccurs="0" maxOccurs="unbounded"/>
				</xs:sequence>
			</xs:complexType>

			<xs:complexType name="{@name}ElementType" mixed="true">
				<xs:complexContent>
					<xs:extension base="xul:{@name}ElementStructure">
						<xs:attributeGroup ref="xul:{@name}AttributeGroup"/>
					</xs:extension>
				</xs:complexContent>
			</xs:complexType>

			<xs:element name="{@name}" type="xul:{@name}ElementType"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="x:attr">
		<xsl:param name="derived"/>
		<xsl:variable name="ref" select="@ref"/>

		<xsl:choose>
			<xsl:when test="$derived">
				<!--<xsl:message><xsl:value-of select="concat($derived, ' inherits ', substring-after($ref, '-'), ' from ', ../@name)"/></xsl:message>-->
				<xsl:if test="not(key('parent', $derived)/x:attr[@ref = $ref or substring-after(@ref, '.') = substring-after($ref, '-')])">
					<xs:attributeGroup ref="xul:{substring-after($ref, '-')}"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xs:attributeGroup ref="xul:{substring-after($ref, '-')}"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="documentation"/>
	<xsl:template match="text()"/>

</xsl:stylesheet>
