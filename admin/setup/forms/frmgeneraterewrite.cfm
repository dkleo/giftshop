<h2>Rebuild .htaccess</h2>
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---loops over the categories, products, links, and blog entries and inserts corresponding links, then writes the htaccess file--->
<cfquery name = "qProducts" datasource="#request.dsn#">
SELECT * FROM products
</cfquery>

<cfquery name = "qCategories" datasource="#request.dsn#">
SELECT * FROM categories
</cfquery>

<cfquery name = "qLinks" datasource="#request.dsn#">
SELECT * FROM links
</cfquery>

<cfquery name = "qBlog" datasource="#request.dsn#">
SELECT * FROM blog_posts
</cfquery>

<cfquery name = "qNav" datasource="#request.dsn#">
SELECT * FROM nav_links
</cfquery>

<cfquery name = "qComponents" datasource="#request.dsn#">
SELECT * FROM components
</cfquery>

<cfif NOT fileexists('#request.catalogpath#.htaccess')>
	<cffile action = "write" file="#request.catalogpath#.htaccess" output="" mode="777">
</cfif>

<cfdirectory action="list" directory="#request.catalogpath#" name="qryTemplates">

<cffile action = "read" file="#request.catalogpath#config#request.bslash#defaulthtaccess.cfm" variable="htfile">

<!---overwrite with what is there with the default, this clears out all other previous entries--->
<cffile action = "write" file="#request.catalogpath#.htaccess" mode="666" output="#htfile#">
<cffile action = "append" file="#request.catalogpath#.htaccess" output=" " addnewline="yes">

<cfloop query="qProducts">

	<cfset linkalias = qProducts.productname>
    <cfset linkalias = replace(linkalias, " ", "-", "ALL")>
    <cfset linkalias = replace(linkalias, "'", "", "ALL")>
    <cfset linkalias = replace(linkalias, "!", "", "ALL")>
    <cfset linkalias = replace(linkalias, "@", "", "ALL")>
    <cfset linkalias = replace(linkalias, "$", "", "ALL")>
    <cfset linkalias = replace(linkalias, "%", "", "ALL")>
    <cfset linkalias = replace(linkalias, "^", "", "ALL")>
    <cfset linkalias = replace(linkalias, "*", "", "ALL")>
    <cfset linkalias = replace(linkalias, "(", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ")", "", "ALL")>
    <cfset linkalias = replace(linkalias, "/", "", "ALL")>	
    <cfset linkalias = replace(linkalias, "\", "", "ALL")>
    <cfset linkalias = replace(linkalias, "|", "", "ALL")>
    <cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
    <cfset linkalias = replace(linkalias, ">", "", "ALL")>    
    <cfset linkalias = replace(linkalias, ";", "", "ALL")>
    <cfset linkalias = replace(linkalias, ":", "", "ALL")>
    <cfset linkalias = replace(linkalias, '"', "", "ALL")>
    <cfset linkalias = replace(linkalias, ".", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ",", "", "ALL")> 
    
	<cfset newline = "ReWriteRule ^#linkalias#$ index.cfm?action=viewdetails&itemid=#qProducts.itemid# ">

    <cfquery name = "qUpdate" datasource="#request.dsn#">
    UPDATE products SET urlrw = '#linkalias#'
    WHERE itemid = #qProducts.itemid#
    </cfquery>

    <cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes" mode="777">

</cfloop>

<cfloop query="qLinks">

	<cfset linkalias = qLinks.linktitle>
    <cfset linkalias = replace(linkalias, " ", "-", "ALL")>
    <cfset linkalias = replace(linkalias, "'", "", "ALL")>
    <cfset linkalias = replace(linkalias, "!", "", "ALL")>
    <cfset linkalias = replace(linkalias, "@", "", "ALL")>
    <cfset linkalias = replace(linkalias, "$", "", "ALL")>
    <cfset linkalias = replace(linkalias, "%", "", "ALL")>
    <cfset linkalias = replace(linkalias, "^", "", "ALL")>
    <cfset linkalias = replace(linkalias, "*", "", "ALL")>
    <cfset linkalias = replace(linkalias, "(", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ")", "", "ALL")>
    <cfset linkalias = replace(linkalias, "/", "", "ALL")>	
    <cfset linkalias = replace(linkalias, "\", "", "ALL")>
    <cfset linkalias = replace(linkalias, "|", "", "ALL")>
    <cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
    <cfset linkalias = replace(linkalias, ">", "", "ALL")>    
    <cfset linkalias = replace(linkalias, ";", "", "ALL")>
    <cfset linkalias = replace(linkalias, ":", "", "ALL")>
    <cfset linkalias = replace(linkalias, '"', "", "ALL")>
    <cfset linkalias = replace(linkalias, ".", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ",", "", "ALL")> 

	<cfset newline = "ReWriteRule ^#linkalias#$ #qLinks.linkref# ">

    <cfquery name = "qUpdate" datasource="#request.dsn#">
    UPDATE links SET urlrw = '#linkalias#'
    WHERE linkid = #qLinks.linkid#
    </cfquery>

    <cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes" mode="777">
    
</cfloop>

<!---for navigation menus--->
<cfloop query="qNav">

	<cfset linkalias = qNav.linktitle>
    <cfset linkalias = replace(linkalias, " ", "-", "ALL")>
    <cfset linkalias = replace(linkalias, "'", "", "ALL")>
    <cfset linkalias = replace(linkalias, "!", "", "ALL")>
    <cfset linkalias = replace(linkalias, "@", "", "ALL")>
    <cfset linkalias = replace(linkalias, "$", "", "ALL")>
    <cfset linkalias = replace(linkalias, "%", "", "ALL")>
    <cfset linkalias = replace(linkalias, "^", "", "ALL")>
    <cfset linkalias = replace(linkalias, "*", "", "ALL")>
    <cfset linkalias = replace(linkalias, "(", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ")", "", "ALL")>
    <cfset linkalias = replace(linkalias, "/", "", "ALL")>	
    <cfset linkalias = replace(linkalias, "\", "", "ALL")>
    <cfset linkalias = replace(linkalias, "|", "", "ALL")>
    <cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
    <cfset linkalias = replace(linkalias, ">", "", "ALL")>    
    <cfset linkalias = replace(linkalias, ";", "", "ALL")>
    <cfset linkalias = replace(linkalias, ":", "", "ALL")>
    <cfset linkalias = replace(linkalias, '"', "", "ALL")>
    <cfset linkalias = replace(linkalias, ".", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ",", "", "ALL")> 

	<cfset newline = "ReWriteRule ^#linkalias#$ #qNav.linkurl# ">

    <cfquery name = "qUpdate" datasource="#request.dsn#">
    UPDATE nav_links SET urlrw = '#linkalias#'
    WHERE id = #qNav.id#
    </cfquery>

    <cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes" mode="777">
    
</cfloop>

<cfloop query="qCategories">

	<cfset linkalias = qCategories.categoryname>
    <cfset linkalias = replace(linkalias, " ", "-", "ALL")>
    <cfset linkalias = replace(linkalias, "'", "", "ALL")>
    <cfset linkalias = replace(linkalias, "!", "", "ALL")>
    <cfset linkalias = replace(linkalias, "@", "", "ALL")>
    <cfset linkalias = replace(linkalias, "$", "", "ALL")>
    <cfset linkalias = replace(linkalias, "%", "", "ALL")>
    <cfset linkalias = replace(linkalias, "^", "", "ALL")>
    <cfset linkalias = replace(linkalias, "*", "", "ALL")>
    <cfset linkalias = replace(linkalias, "(", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ")", "", "ALL")>
    <cfset linkalias = replace(linkalias, "/", "", "ALL")>	
    <cfset linkalias = replace(linkalias, "\", "", "ALL")>
    <cfset linkalias = replace(linkalias, "|", "", "ALL")>
    <cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
    <cfset linkalias = replace(linkalias, ">", "", "ALL")>    
    <cfset linkalias = replace(linkalias, ";", "", "ALL")>
    <cfset linkalias = replace(linkalias, ":", "", "ALL")>
    <cfset linkalias = replace(linkalias, '"', "", "ALL")>
    <cfset linkalias = replace(linkalias, ".", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ",", "", "ALL")> 

	<cfset linkalias = '#linkalias#-#categoryid#'>    
	<cfset newline = 'ReWriteRule ^#linkalias#$ index.cfm?action=viewcategory&category=#qCategories.categoryid# '>

    <cfquery name = "qUpdate" datasource="#request.dsn#">
    UPDATE categories SET urlrw = '#linkalias#'
    WHERE categoryid = #qcategories.categoryid#
    </cfquery>

    <cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes" mode="777">

</cfloop>

<cfloop query="qBlog">

	<cfset linkalias = qBlog.blog_headlines>
    <cfset linkalias = replace(linkalias, " ", "-", "ALL")>
    <cfset linkalias = replace(linkalias, "'", "", "ALL")>
    <cfset linkalias = replace(linkalias, "!", "", "ALL")>
    <cfset linkalias = replace(linkalias, "@", "", "ALL")>
    <cfset linkalias = replace(linkalias, "$", "", "ALL")>
    <cfset linkalias = replace(linkalias, "%", "", "ALL")>
    <cfset linkalias = replace(linkalias, "^", "", "ALL")>
    <cfset linkalias = replace(linkalias, "*", "", "ALL")>
    <cfset linkalias = replace(linkalias, "(", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ")", "", "ALL")>
    <cfset linkalias = replace(linkalias, "/", "", "ALL")>	
    <cfset linkalias = replace(linkalias, "\", "", "ALL")>
    <cfset linkalias = replace(linkalias, "|", "", "ALL")>
    <cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
    <cfset linkalias = replace(linkalias, ">", "", "ALL")>    
    <cfset linkalias = replace(linkalias, ";", "", "ALL")>
    <cfset linkalias = replace(linkalias, ":", "", "ALL")>
    <cfset linkalias = replace(linkalias, '"', "", "ALL")>
    <cfset linkalias = replace(linkalias, ".", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ",", "", "ALL")> 

	<cfset newline = 'ReWriteRule ^#linkalias#$ index.cfm?template=NA&isplugin=yes&action=blog.blog_showblog&bid=#qBlog.blog_id# '>

    <cfquery name = "qUpdate" datasource="#request.dsn#">
    UPDATE blog_posts SET urlrw = '#linkalias#'
    WHERE id = #qBlog.id#
    </cfquery>

    <cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes" mode="777">
    
</cfloop>

<!---write something for the components--->
<cfloop query="qComponents">

	<cfset linkalias = #urlrw#>

	<cfset newline = 'ReWriteRule ^#linkalias#$ index.cfm?action=#qComponents.action# '>

    <cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes" mode="777">
    
</cfloop>

<!---create some for the pages, uses same rule consistantly.  It's whatever the file name is without the extention and spaces.--->

<cfdirectory action="list" directory="#request.catalogpath#docs" name="qDocs">

<cfloop query="qDocs">

	<cfif qDocs.type IS 'file'>
    	
        <cfset linkalias = replacenocase(qDocs.name, ".cfm", "", "ALL")>
        <cfset linkalias = replacenocase(linkalias, ".htm", "", "ALL")>
        <cfset linkalias = replacenocase(linkalias, ".html", "", "ALL")>
        <cfset linkalias = replacenocase(linkalias, " ", "-", "ALL")>

    	<cfset newline = 'ReWriteRule ^#linkalias#$ index.cfm?page=#qDocs.name# '>

		<cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes" mode="777">
	
    	<!---create an alias for each template--->
       <cfloop query = "qryTemplates">
           	<cfif qryTemplates.type IS 'file'>
        		<cfif qryTemplates.name CONTAINS 'index_' AND NOT qryTemplates.name IS 'index.cfm'>
					<cfset template_alias = replacenocase(qryTemplates.name, ".cfm", "", "ALL")>
                    <cfset template_alias = replacenocase(template_alias, "index_", "", "ALL")>
					<cfset newline = 'ReWriteRule ^#template_alias#/#linkalias#$ #qryTemplates.name#?page=#qDocs.name# '>
                    <cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes" mode="777">
				</cfif>
            </cfif>
       </cfloop>
	</cfif>

</cfloop>
Your .htaccess file has been updated with URL rewrites.  In order to use the URL rewrite feature in Apache, you must turn the feature on.