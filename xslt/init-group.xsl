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
            <xsl:apply-templates/>
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
					<xsl:variable name="group-content">
                        <xsl:for-each select="c:group[@id=$group-id]/*">
						  <xsl:value-of select="name(.)"/>|<xsl:for-each select="@*"><xsl:value-of select="name(.)"/>=<xsl:value-of select="."/>|</xsl:for-each>
					   </xsl:for-each>
                    </xsl:variable>
					<xsl:variable name="init-content">delegatePublic|publicIdStartString=<xsl:value-of select="$publicIdStartString"/>|catalog=file://<xsl:value-of select="$targetfile"/>|delegateSystem|systemIdStartString=<xsl:value-of select="$systemIdStartString"/>|catalog=file://<xsl:value-of select="$targetfile"/>|</xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$group-content = $init-content">
                            <xsl:message>Nothing to do <xsl:value-of select="$group-id"/> already exists with the same content.</xsl:message>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message terminate="yes">Error: Group <xsl:value-of select="$group-id"/> already exists!</xsl:message>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
