<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog"
    xmlns:c="urn:oasis:names:tc:entity:xmlns:xml:catalog"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output indent="yes"/>
    <xsl:key name="id" match="c:group" use="@id"/>

    <xsl:param name="group-id"/>
    <xsl:param name="publicIdStartString"/>
    <xsl:param name="systemIdStartString"/>
    <xsl:param name="targetfile"/>

    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="c:catalog">
        <xsl:copy>
            <xsl:choose>
                <xsl:when test="not(key('id', $group-id))">
                    <xsl:apply-templates/>
                    <xsl:element name="group" namespace="urn:oasis:names:tc:entity:xmlns:xml:catalog">
                        <xsl:attribute name="id">
                            <xsl:value-of select="$group-id"/>
                        </xsl:attribute>
                        <delegatePublic publicIdStartString="{$publicIdStartString}" catalog="file://{$targetfile}"/>
                        <delegateSystem systemIdStartString="{$systemIdStartString}" catalog="file://{$targetfile}"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="c:group">
        <xsl:choose>
            <xsl:when test="@id = $group-id">
                <xsl:copy>
                    <xsl:attribute name="id">
                        <xsl:value-of select="$group-id"/>
                    </xsl:attribute>
                    <delegatePublic publicIdStartString="{$publicIdStartString}" catalog="file://{$targetfile}"/>
                    <delegateSystem systemIdStartString="{$systemIdStartString}" catalog="file://{$targetfile}"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
     </xsl:template>
</xsl:stylesheet>
