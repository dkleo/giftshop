<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<CFQUERY Name ="VerifyUserPass" datasource = "#request.dsn#">
SELECT UserName, pword FROM users 
WHERE UserName = '#form.EditThisUser#' AND pword = '#form.ChangePasswordOld#' 
</CFQUERY>

<CFIF #VerifyUserPass.recordcount# IS 0>
Invalid user CustPassword. You must supply the correct current user CustPassword in order to change 
it.
<cfabort>
</cfif>

<CFIF NOT #form.ChangePasswordNew# IS #ChangePasswordConfirm#>
The New CustPassword and the Confirmation CustPassword are not the same. The CustPassword 
was not changed. If you wish to change the CustPassword, please make sure that the 
New CustPassword and the Confirmed CustPassword are the same. 
<cfabort>
</cfif>

<CFQUERY Name = "UpdateUserInfo" Datasource = "#request.dsn#">
UPDATE users 
SET pword = '#form.ChangePasswordNew#',
UserName = '#form.ChangeUserName#'
WHERE UserName = '#form.EditThisUser#' 
</CFQUERY>

<cfcookie name="admin_username" value="#form.ChangeUserName#">
<cfcookie name="admin_password" value="#form.ChangePasswordNew#">

<p align="center"><b>New password and/or username was set!</b></p>







