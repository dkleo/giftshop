<cfparam name="update_folder" default="update55004">

<cfset initialDir = "#request.catalogpath#admin#request.bslash#updates#request.bslash##update_folder##request.bslash#deploy">
<cfset deploypath = "admin#request.bslash#updates#request.bslash##update_folder##request.bslash#deploy">

<cfdirectory directory="#initialDir#" recurse="yes" name="files" sort="directory asc">

<cfloop query="files">
	<cfif type IS 'file'>
		<cfset copyfrom_path = directory>
        <!---we get the copyto_path based on the deploypath above--->
        <cfset copyto_path = replacenocase(directory, deploypath, '')>
        
        <!---copy each file and overwrite it.--->
        <cffile action = "copy" 
        source="#copyfrom_path##request.bslash##name#" 
        destination="#copyto_path##name#" 
        nameconflict="overwrite" 
        mode="777">
	</cfif>
</cfloop>

<cfquery name = "qUpdateVersion" datasource="#request.dsn#">
UPDATE versioninfo SET build = '004'
</cfquery>

<div style="padding:8px;">
<div style="border: 1px #006600 solid; padding:6px;">
<cffile action = "read" file="#request.catalogpath#admin#request.bslash#updates#request.bslash##update_folder##request.bslash#readme.txt" variable="readmefile">
<cfoutput>
<pre>
#readmefile#
</pre>
</cfoutput>
<br />&nbsp;<br />
</div>
</div>
--->