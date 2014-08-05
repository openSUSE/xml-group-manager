<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:c="urn:oasis:names:tc:entity:xmlns:xml:catalog"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output indent="yes"/>
    <xsl:key name="id" match="c:group" use="@id"/>

    <xsl:param name="group-id"/>
    <xsl:param name="xmlfile"/>

    <xsl:variable name="xmlfrag" select="document($xmlfile)"/>

    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="c:catalog">
        <xsl:copy>
            <xsl:choose>
                <xsl:when test="not(key('id', $group-id))">
                    <xsl:apply-templates select="$xmlfrag/*"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="group">
                        <xsl:for-each select="c:group[@id=$group-id]/*">
                          <xsl:value-of select="name(.)"/>|<xsl:for-each select="@*"><xsl:value-of select="name(.)"/>=<xsl:value-of select="."/>|</xsl:for-each>
                       </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="file">
                        <xsl:for-each select="$xmlfrag/*/*">
                            <xsl:value-of select="name(.)"/>|<xsl:for-each select="@*"><xsl:value-of select="name(.)"/>=<xsl:value-of select="."/>|</xsl:for-each>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$group = $file">
                            <xsl:message>Nothing to do <xsl:value-of select="$group-id"/> already exists with the same content.</xsl:message>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message terminate="yes">Error: Group <xsl:value-of select="$group-id"/> already exists!</xsl:message>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
