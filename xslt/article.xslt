<?xml version="1.0"?>
<xsl:transform version="1.0"
	       xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:t="http://www.w3.org/1999/xhtml">

  <xsl:output
      method="html"
      omit-xml-declaration="yes"
      standalone="yes"
      indent="yes"
      /> 

  <!--
      Extract all section 1 <div>s from a docbook xhtml article
  -->
  <xsl:template match="/">
    <xsl:for-each
	select="t:html/t:body/t:div[@class='article']/t:div[@class='sect1']">
      <xsl:copy-of select="."/>
    </xsl:for-each>
  </xsl:template>
</xsl:transform>
