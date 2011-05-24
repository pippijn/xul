<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://xul.xinutec.org/2011/xulref">

	<xsl:output omit-xml-declaration="yes"/>

	<xsl:template match="content">
		<element name="XULElement" abstract="true">
			<!--<attr ref="attr-onblur"/>-->
			<!--<attr ref="attr-onbroadcast"/>-->
			<attr ref="attr-onclick"/>
			<!--<attr ref="attr-onclose"/>-->
			<attr ref="attr-oncommand"/>
			<attr ref="attr-oncommandupdate"/>
			<!--<attr ref="attr-oncontextmenu"/>-->
			<!--<attr ref="attr-ondblclick"/>-->
			<!--<attr ref="attr-ondragdrop"/>-->
			<!--<attr ref="attr-ondragenter"/>-->
			<!--<attr ref="attr-ondragexit"/>-->
			<!--<attr ref="attr-ondraggesture"/>-->
			<!--<attr ref="attr-ondragover"/>-->
			<!--<attr ref="attr-onfocus"/>-->
			<attr ref="attr-oninput"/>
			<!--<attr ref="attr-onkeydown"/>-->
			<!--<attr ref="attr-onkeypress"/>-->
			<!--<attr ref="attr-onkeyup"/>-->
			<attr ref="attr-onload"/>
			<!--<attr ref="attr-onmousedown"/>-->
			<!--<attr ref="attr-onmousemove"/>-->
			<!--<attr ref="attr-onmouseout"/>-->
			<!--<attr ref="attr-onmouseover"/>-->
			<!--<attr ref="attr-onmouseup"/>-->
			<!--<attr ref="attr-onoverflow"/>-->
			<!--<attr ref="attr-onoverflowchanged"/>-->
			<attr ref="attr-onpopuphidden"/>
			<attr ref="attr-onpopuphiding"/>
			<attr ref="attr-onpopupshowing"/>
			<attr ref="attr-onpopupshown"/>
			<attr ref="attr-onselect"/>
			<!--<attr ref="attr-onunderflow"/>-->
			<!--<attr ref="attr-onunload"/>-->

			<xsl:apply-templates select="body/p[1]/span"/>
			<documentation source="https://developer.mozilla.org/en/XUL_element_attributes">
				<div xmlns="http://www.w3.org/1999/xhtml">
				</div>
			</documentation>
		</element>
	</xsl:template>

	<xsl:template match="body/p[1]/span">
		<attr ref="attr-{substring-before(substring-after(text(), 'XULAttrInc(&quot;'), '&quot;)')}"/>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
