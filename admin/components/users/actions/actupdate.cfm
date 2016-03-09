<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset change_password = 'No'>
<cfif len(trim(form.newpassword)) GT 0>
	<cfif NOT form.newpassword IS form.newpassword_confirm>
        <h2><font color="#FF0000">Error</font></h2>
        Password and confirmation password did not match.  User password was not updated.
        
		<cfabort>
	<cfelse>
    	<cfset change_password = 'Yes'>
	</cfif>
</cfif>

<!---encryp password--->
<cfif change_password IS 'Yes'>

	<cfset enc_password = #encrypt(form.newpassword, request.seedstring)#>
    <cfset enc_password = #replace(enc_password, "/", "//", "ALL")#>
    <cfset enc_password = #replace(enc_password, "\", "\\", "ALL")#>

</cfif>

<cfquery name = "UpdateUser" datasource="#request.dsn#">
UPDATE users
SET <cfif change_password IS 'yes'>pword='#enc_password#', </cfif>
userlevel='#form.userlevel#'
WHERE userid = #form.userid#
</cfquery>

<cflocation url = "index.cfm">















