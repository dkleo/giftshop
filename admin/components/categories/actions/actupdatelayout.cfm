<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name="UpdateLayout" datasource="#request.dsn#">
UPDATE categories
SET CategoryLayout = '#form.CategoryLayout#'
WHERE CategoryID = #form.CategoryID#
</cfquery>

<cflocation url = "index.cfm">





















