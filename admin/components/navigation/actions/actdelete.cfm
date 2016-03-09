<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Check if it has sublinks...if so, then do not allow them to delete it--->
<cfquery name = "qrySubs" datasource="#request.dsn#">
SELECT * FROM nav_links WHERE sublinkof = '#url.delid#'
</cfquery>

<cfif qrySubs.recordcount GT 0>
	<p>
    <div align="center">
	<h2>This menu item has one or more sublinks. <br />
    You must either remove or move the sublinks before deleting it.</h2>
	<cfoutput><a href = "index.cfm?mView=#mView#&nView=#nView#&level=#level#">Go back</a></cfoutput>
	</div>
    <cfabort>
</cfif>

<cfquery name = "qryDeleteLink" datasource="#request.dsn#">
DELETE FROM nav_links WHERE id = #url.delid#
</cfquery>

<cflocation url = "index.cfm?&mView=#mView#&nView=#nView#&level=#level#">
