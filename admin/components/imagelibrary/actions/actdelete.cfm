<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Deletes the specified image file--->
<cfif fileexists('#request.catalogpath#images#url.imgsrc#')>
	<cffile action="delete" file="#request.catalogpath#images#url.imgsrc#">
</cfif>
<cflocation url = "doimagelibrary.cfm?action=library&dir=#url.dir#">



















