<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


<!---Write the file to the directory specified--->
<!---Read the contents of the file and then put it in the editor--->
<cfset fullpath = "#request.catalogpath##url.Dir##request.bslash##form.FileName#">
<cfset fullpath = replacenocase(fullpath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfset thecontent = form.filecontents>

<cffile action = "write" file = "#fullpath#" output = "#thecontent#">



















