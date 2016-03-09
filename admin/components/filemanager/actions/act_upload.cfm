<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif not filefield IS ''>
	<cfset fullpath = "#request.catalogpath##form.Dir##request.bslash#">
	<cfset fullpath = replacenocase(fullpath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>
	
	<cffile action="upload"
	FileField = "filefield"
	Destination = "#fullpath#"
	NameConflict = "OVERWRITE"
	>
	
	<cfset thefiletype = 'BADFILE'>
	<cfset thefilecontent = ''>
	
	<cfif cffile.ServerFileExt IS 'gif'>
		<cfset thefiletype = 'image'>
	</cfif>
	
	<cfif cffile.ServerFileExt contains 'jpg'>
		<cfset thefiletype = 'image'>
	</cfif>
	
	<cfif cffile.ServerFileExt IS 'htm' OR cffile.ServerFileExt IS 'html' OR cffile.ServerFileExt IS 'txt' OR cffile.ServerFileExt IS 'csv'>
		<cfset thefiletype = 'webpage'>
	</cfif>
	
	<cfif cffile.ServerFileExt IS 'doc'>
		<cfset thefiletype = 'word'>
	</cfif>
	
	<cfif cffile.ServerFileExt IS 'pdf'>
		<cfset thefiletype = 'pdf'>
	</cfif>

	<cfif cffile.ServerFileExt IS 'swf'>
		<cfset thefiletype = 'flash'>
	</cfif>

	<cfif cffile.ServerFileExt IS 'zip'>
		<cfset thefiletype = 'zip'>
	</cfif>

	<cfif cffile.ServerFileExt IS 'rar'>
		<cfset thefiletype = 'rar'>
	</cfif>    	
    
	<cfif cffile.ServerFileExt IS 'avi' OR cffile.ServerFileExt IS 'mpg' OR cffile.ServerFileExt IS 'mov'>
		<cfset thefiletype = 'video'>
	</cfif>
	
	<cfif thefiletype IS 'BADFILE'>
		<!---delete the offending file--->
		<cffile action="delete" file="#fullpath##request.bslash##cffile.Serverfile#">
	
		ERROR:  File name not accepted.  You have attempted to upload a file to the server that is not allowed.<br />
		<cfoutput>Filename: #cffile.ServerFile#</cfoutput>
		<p>
	</cfif>

	<cfif thefiletype IS 'webpage' AND NOT dir contains '#request.bslash#My Pages'>
		<!---delete the offending file--->
		<cffile action="delete" file="#fullpath##request.bslash##cffile.Serverfile#">
	
		ERROR:  You can only upload that type of file to your 'My Pages' folder.<br />
		<cfoutput>Filename: #cffile.ServerFile#</cfoutput>
		<p>
	</cfif>


</cfif>



















