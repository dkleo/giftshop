<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---If the current user is logged in then don't allow them to delete their own username/CustPassword--->
<cfquery name = "CheckUsers" datasource="#request.dsn#">
SELECT * FROM users
WHERE Userid = #url.userid#
</cfquery>

<cfif cookie.admin_username IS CheckUsers.Username>
<center>You cannot delete a user that you are logged in under</center>
<cfabort>
</cfif>

<cfquery name = "DeleteUser" datasource="#request.dsn#">
DELETE FROM users
WHERE userid = #url.userid#
</cfquery>

<cflocation url = "index.cfm">















