<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Deletes a user-created widget--->
<cfquery name = "qryDeleteWdiget" datasource="#request.dsn#">
DELETE FROM widgets
WHERE id = #url.id# AND candelete = 'yes'
</cfquery>

<cfset funcpath = replace(request.absolutepath, "/", "", "ALL")>
<cfif NOT len(funcpath) IS 0>   
	<cfset funcpath = "#funcpath#.">
</cfif>

<cfinvoke component="#funcpath#admin.functions.dumpsettings" method="WriteSettings" returnvariable="outputmsg">
	<cfinvokeargument name="cfdsn" value="#request.dsn#">
	<cfinvokeargument name="path" value="#request.catalogpath#">
</cfinvoke>

<cflocation url = "dosetup.cfm?action=widgetsetup">


