<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name="SetTheme" datasource="#request.dsn#">
UPDATE customstyles
SET themetouse = '#url.themename#'
</cfquery>

<cfif NOT directoryexists('#request.CatalogPath##request.bslash#docs_backup')>
	<cfdirectory action="create" directory="#request.CatalogPath##request.bslash#docs_backup">
</cfif>

<cfif NOT url.themename IS 'A_Custom_Theme'>
	<!---if there are homepage, header, and footer files for this theme backup original and then copy them over to the docs folder--->
	<cfset rightnow = dateformat(now(), "mmddyyyy")>
	<cfset timenow = timeformat(now(), "hhmmss")>
	<cfset rightnow = "#rightnow##timenow#">
	
	<!---Add the absolute path to image references in the header, footer, and homepage and write to their docs folder--->
	<!---If they are included in this theme--->
	<cfif fileexists('#request.CatalogPath#themes#request.bslash##url.themename##request.bslash#docs#request.bslash#homepage.htm')>
		<!---backup original--->
		<cffile action="rename" source="#request.CatalogPath#docs#request.bslash#homepage.htm" destination="#request.CatalogPath#docs_backup#request.bslash#homepageBak_#rightnow#.htm">
		
		<cffile action = "read" file="#request.CatalogPath#themes#request.bslash##url.themename#\docs\homepage.htm" variable="homefile">
		<cfset homefile = replacenocase(homefile, '"images/', '"#request.AbsolutePath#images/', "ALL")>
		<cffile action = "write" file="#request.CatalogPath#docs\homepage.htm" output="#homefile#">
	</cfif>
	
	<cfif fileexists('#request.CatalogPath#themes\#url.themename#\docs\header.htm')>
		<cffile action="rename" source="#request.CatalogPath#docs\header.htm" destination="#request.CatalogPath#docs_backup\headerBak_#rightnow#.htm">
		
		<cffile action = "read" file="#request.CatalogPath#themes\#url.themename#\docs\header.htm" variable="headfile">
		<cfset headfile = replacenocase(headfile, '"images/', '"#request.AbsolutePath#images/', "ALL")>
		<cffile action = "write" file="#request.CatalogPath#docs\header.htm" output="#headfile#">
	</cfif>
	
	<cfif fileexists('#request.CatalogPath#themes\#url.themename#\docs\footer.htm')>
		<cffile action="rename" source="#request.CatalogPath#docs\footer.htm" destination="#request.CatalogPath#docs_backup\footerBak_#rightnow#.htm">
		
		<cffile action = "read" file="#request.CatalogPath#themes\#url.themename#\docs\footer.htm" variable="footfile">
		<cfset footfile = replacenocase(footfile, '"images/', '"#request.AbsolutePath#images/', "ALL")>
		<cffile action = "write" file="#request.CatalogPath#docs\footer.htm" output="#footfile#">
	</cfif>
	
	<!---copy images if there are some--->
	<cfif directoryexists('#request.CatalogPath#themes\#url.themename#\docs\images\')>
		<cfdirectory action="list" directory="#request.CatalogPath#themes\#url.themename#\docs\images\" name="qryImages">
		
		<cfquery name="WithoutDotParents" dbtype="Query">
			SELECT  	*
			FROM    	qryImages
			WHERE   	Name <> '.'
			AND			Name <> '..'
			ORDER BY 	Type
		</cfquery>
		
		<cfquery name = "qryFileNames" dbtype="query">
		SELECT * FROM WithoutDotParents WHERE type = 'File'
		ORDER BY Name ASC
		</cfquery>
		
		<cfloop query = "qryFileNames">
			<cffile action = "copy" source="#request.CatalogPath#themes\#url.themename#\docs\images\#name#" destination="#request.CatalogPath#images\#name#" nameconflict="overwrite">
		</cfloop>
	</cfif>
	<p>
	<center><h2>You Have Changed Your Theme!</h2></center>
    </p>
	<p>
	<cfoutput><iframe width="100%" height="480" src="#request.HomeURL#"></iframe></cfoutput>
</p>
<cfelse>
	<p>
	<center><h2>Your Theme Has Been Removed!</h2></center>
    </p>
	<p>
	<cfoutput><iframe width="100%" height="480" src="#request.HomeURL#"></iframe></cfoutput>    
</cfif>


<cfset funcpath = replace(request.absolutepath, "/", "", "ALL")>
<cfif NOT len(funcpath) IS 0>
	<cfset funcpath = "#funcpath#.">
</cfif>

<cfinvoke component="#funcpath#admin.functions.dumpsettings" method="WriteSettings" returnvariable="outputmsg">
	<cfinvokeargument name="cfdsn" value="#request.dsn#">
	<cfinvokeargument name="path" value="#request.catalogpath#">
</cfinvoke>







