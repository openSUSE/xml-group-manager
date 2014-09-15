<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:c="urn:oasis:names:tc:entity:xmlns:xml:catalog">
  
  <xsl:param name="scriptname">xml-group-manager</xsl:param>
  
  <!-- Default template which just copy all nodes -->
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
  
  <xsl:template name="message">
    <xsl:param name="msg"/>
    <xsl:param name="terminate" select="0"/>
    
    <xsl:choose>
      <xsl:when test="$terminate != 0">
        <xsl:message terminate="yes"><xsl:value-of select="concat($scriptname, ': ', $msg)"/></xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message><xsl:value-of select="concat($scriptname, ': ', $msg)"/></xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>