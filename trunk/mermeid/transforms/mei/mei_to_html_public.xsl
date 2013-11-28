<?xml version="1.0" encoding="UTF-8"?>

<!-- 
	Conversion of MEI metadata to HTML using XSLT 1.0
	
	Authors: 
	Axel Teich Geertinger & Sigfrid Lundberg
	Danish Centre for Music Publication
	The Royal Library, Copenhagen
	
-->

<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m="http://www.music-encoding.org/ns/mei" 
	xmlns:dcm="http://www.kb.dk/dcm" 
	xmlns:xl="http://www.w3.org/1999/xlink" 
	xmlns:foo="http://www.kb.dk/foo"
	xmlns:exsl="http://exslt.org/common" 
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:zs="http://www.loc.gov/zing/srw/" 
	xmlns:marc="http://www.loc.gov/MARC21/slim" 
	extension-element-prefixes="exsl java" 
	exclude-result-prefixes="m xsl exsl foo java">

	<xsl:output method="xml" encoding="UTF-8" 
		cdata-section-elements="" 
		omit-xml-declaration="yes"/>
	
	<xsl:strip-space elements="*"/>

	<xsl:include href="mei_to_html.xsl"/>
	
	<!-- CREATE HTML DOCUMENT -->
	<xsl:template match="m:mei" xml:space="default">
		<html xml:lang="en" lang="en">
			<head>
				<xsl:call-template name="make_public_html_head"/>
			</head>
			<body class="document_view">
				<div id="all">
					<div id="header">
						<div class="kb_logo">
							<a href="http://www.kb.dk" title="Det Kongelige Bibliotek"><img
								id="KBLogo"
								title="Det Kongelige Bibliotek" 
								alt="KB Logo" src="/editor/images/kb_white.png"></img></a></div>
						<h1>CNW</h1>
						<h2>A Thematic Catalogue of Carl Nielsen&apos;s Works</h2>
						<!--<p>En tematisk-bibliografisk fortegnelse over Carl Nielsens værker</p>
						<div class="line"> </div>-->
					</div>
					<!--
					<div id="menu">
						<div class="change_language">
							<a href="source_description_en.html">[English]</a>
						</div>
						<a href="dcm.htm">Forside</a>
						<a href="dummy.htm">Alfabetisk oversigt</a>
						<a href="dummy.htm">Genreoversigt</a>
						<a href="dummy.htm" class="selected">Avanceret søgning</a>
						<a href="dummy.htm">Om CNW</a>
					</div>-->
					<div id="main" class="main">
						<div class="content_box">
							<div id="backlink"><a href="javascript:history.back();">Back</a></div>
							<xsl:call-template name="make_public_html_body"/>
						</div>
					</div>
					<div id="footer">
						<a href="http://www.kb.dk/dcm" title="DCM" 
							style="text-decoration:none;"><img 
								style="border: 0px; vertical-align:middle;" 
								alt="DCM Logo" 
								src="/editor/images/dcm_logo_small_white.png"/></a>
						2013 Danish Centre for Music Publication | The Royal Library, Copenhagen | <a name="www.kb.dk" id="www.kb.dk" href="http://www.kb.dk/dcm">www.kb.dk/dcm</a>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>


	<!-- MAIN TEMPLATES -->
	<xsl:template name="make_public_html_head">
		<title>HTML Preview</title>

		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8"/>

		<link rel="stylesheet" type="text/css" href="/editor/style/dcm.css"/>
		<link rel="stylesheet" type="text/css" href="/editor/style/cnw.css"/>
		<link rel="stylesheet" type="text/css" href="/editor/style/public_list_style.css"/>
		<link rel="stylesheet" type="text/css" href="/editor/style/mei_to_html_public.css"/>

		<script type="text/javascript" src="/editor/js/toggle_openness.js">
			<xsl:text>
			</xsl:text>
		</script>
	</xsl:template>

	<xsl:template name="make_public_html_body" xml:space="default">
		<!-- main identification -->

		<xsl:variable name="file_context">
			<xsl:value-of select="m:meiHead/m:fileDesc/m:seriesStmt/m:identifier[@type='file_collection']"/>
		</xsl:variable>

		<xsl:variable name="catalogue_no">
			<xsl:value-of select="m:meiHead/m:workDesc/m:work/m:identifier[@type=$file_context]"/>
		</xsl:variable>

		<xsl:if test="m:meiHead/m:workDesc/m:work/m:identifier[@type=$file_context]/text()">
			<div class="info_bar {$file_context}">
				<span class="list_id">
					<xsl:value-of select="$file_context"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$catalogue_no"/>
				</span>
			</div>
		</xsl:if>
		
		<xsl:call-template name="body_main_content"/>

	</xsl:template>


	<!-- SUB-TEMPLATES -->
	
	<xsl:template match="m:relation" mode="relation_link">
		<xsl:element name="a">
			<xsl:attribute name="href">
				<xsl:value-of select="concat('http://',$hostname,'/storage/document.xq?doc=',@target)"/>
			</xsl:attribute>
			<xsl:apply-templates select="@label"/>
			<xsl:if test="not(@label) or @label=''">
				<xsl:value-of select="@target"/>
			</xsl:if>
		</xsl:element>
	</xsl:template>	

</xsl:stylesheet>