<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


<cfheader name="Content-disposition" value="attachment;filename=#url.filename#">
<cfcontent type="text/html" file="#request.catalogpath##url.dir##url.filename#">




















