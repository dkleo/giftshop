<cfset tempvariable = StructClear(session)>
<CFCOOKIE name="admin_username" expires="NOW">
<CFCOOKIE name="admin_password" expires="NOW">

<cflocation url = "login.cfm?login=true">





