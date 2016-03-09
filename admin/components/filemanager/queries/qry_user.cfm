<!---Get this persons userinfo--->
<cfquery name = "qry_UserSession" datasource="#request.dsn#" username="#request.dsnun#" password="#request.dsnpw#">
SELECT UserName FROM user_sessions WHERE sessionid = '#mytoken#'
</cfquery>

<cfquery name = "qry_User" datasource="#request.dsn#" username="#request.dsnun#" password="#request.dsnpw#">
SELECT UserName FROM users WHERE UserName = '#qry_UserSession.Username#'
</cfquery>



















