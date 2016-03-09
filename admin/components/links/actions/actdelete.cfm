<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name="DeleteLink" datasource="#request.dsn#">
DELETE FROM links
WHERE LinkID = #URL.LinkID#
</cfquery>

<cflocation url="dolinks.cfm">