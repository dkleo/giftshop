<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<CFQUERY Name ="VerifyUserPass" datasource = "#request.dsn#">
SELECT * FROM afl_admin WHERE CustPassword = '#form.ChangePasswordOld#' 
</CFQUERY>

<CFIF #VerifyUserPass.recordcount# IS 0>
Invalid CustPassword. You must supply your current CustPassword in order to change it.
<cfabort>
</cfif>

<CFIF NOT #form.ChangePasswordNew# IS #form.ChangePasswordConfirm#>
The New CustPassword and the Confirmation CustPassword are not the same. The CustPassword 
was not changed. If you wish to change the CustPassword, please make sure that the 
New CustPassword and the Confirmed CustPassword fields are the same. 
<cfabort>
</cfif>

<CFQUERY Name = "UpdateAdminPassword" Datasource = "#request.dsn#">
UPDATE afl_admin
SET CustPassword = '#form.ChangePasswordNew#'
</CFQUERY>

<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.AdminPW = '#form.ChangePasswordNew#'>
</cflock>
<p align="center"><b>New CustPassword was set!</b></p>












