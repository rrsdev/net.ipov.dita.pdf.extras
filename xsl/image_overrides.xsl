<?xml version='1.0'?>
<!--  Override the image processing (defined in ./demo/fo/xsl/fo/common.xsl ) -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:exsl="http://exslt.org/common"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    extension-element-prefixes="exsl"
    exclude-result-prefixes="opentopic exsl opentopic-index dita2xslfo"
    version="1.1">

    <xsl:template name="placeImage">
        <xsl:param name="imageAlign"/>
        <xsl:param name="href"/>
        <xsl:param name="height"/>
        <xsl:param name="width"/>
        <xsl:apply-templates select="." mode="placeImage">
            <xsl:with-param name="imageAlign" select="$imageAlign"/>
            <xsl:with-param name="href" select="$href"/>
            <xsl:with-param name="height" select="$height"/>
            <xsl:with-param name="width" select="$width"/>
        </xsl:apply-templates>
    </xsl:template>


    <!-- Image placement code! -->
    <xsl:template match="*" mode="placeImage">
        <xsl:param name="imageAlign"/>
        <xsl:param name="href"/>
        <xsl:param name="height"/>
        <xsl:param name="width"/>
        <!--Using align attribute set according to image @align attribute-->
        <xsl:call-template name="processAttrSetReflection">
                <xsl:with-param name="attrSet" select="concat('__align__', $imageAlign)"/>
                <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
            </xsl:call-template>
        <fo:external-graphic src="url({$href})" xsl:use-attribute-sets="image">
            <!--Setting image height if defined-->
            <xsl:if test="$height">
                <xsl:attribute name="content-height">
                <!--The following test was commented out because most people found the behavior
                 surprising.  It used to force images with a number specified for the dimensions
                 *but no units* to act as a measure of pixels, *if* you were printing at 72 DPI.
                 Uncomment if you really want it. -->
                    <!--<xsl:choose>
                        <xsl:when test="not(string(number($height)) = 'NaN')">
                            <xsl:value-of select="concat($height div 72,'in')"/>
                        </xsl:when>
                        <xsl:when test="$height">-->
                            <xsl:value-of select="$height"/>
                        <!--</xsl:when>
                    </xsl:choose>-->
                </xsl:attribute>
            </xsl:if>
            <!--Setting image width if defined-->
            <xsl:if test="$width">
                <xsl:attribute name="content-width">
                    <!--<xsl:choose>
                        <xsl:when test="not(string(number($width)) = 'NaN')">
                            <xsl:value-of select="concat($width div 72,'in')"/>
                        </xsl:when>
                        <xsl:when test="$width">-->
                            <xsl:value-of select="$width"/>
                        <!--</xsl:when>
                    </xsl:choose>-->
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="not($width) and not($height) and @scale">
                <xsl:attribute name="content-width">
                    <xsl:value-of select="concat(@scale,'%')"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="not($width) and not($height) and not(@scale)">
                <xsl:attribute name="inline-progression-dimension.maximum">100%</xsl:attribute>
                <xsl:attribute name="content-width">scale-down-to-fit</xsl:attribute>
            </xsl:if>
        </fo:external-graphic>
    </xsl:template>

</xsl:stylesheet>
