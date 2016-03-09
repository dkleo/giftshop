<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name="DeleteAllcategories" datasource="#request.dsn#">
DELETE FROM categories
</cfquery>
<cflocation url = "index.cfm">





















