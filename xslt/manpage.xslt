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
      Extract the refentry div from a docbook refentry (manpage) xhtml page.
  -->
  <xsl:template match="/">
      <xsl:copy-of select="t:html/t:body/t:div[@class='refentry']"/>
  </xsl:template>
</xsl:transform>
