<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif NOT form.newpassword IS form.newpassword_confirm>
	The confirmation password and password field did not match.  User could not be added.
	<cfabort>
<cfelse>
	<cfset enc_password = #encrypt(form.newpassword, request.seedstring)#>
	<cfset enc_password = #replace(enc_password, "/", "//", "ALL")#>
	<cfset enc_password = #replace(enc_password, "\", "\\", "ALL")#>

    <cfquery name = "CheckDuplicateUser" datasource="#request.dsn#">
    SELECT * FROM users
    WHERE username = '#form.NewUsername#'
    </cfquery>
    
    <cfif CheckDuplicateUser.recordcount IS 0>
    <cfquery name = "AddUser" datasource="#request.dsn#">
    INSERT INTO users
    (username, pword, userlevel)
    VALUES
    ('#form.newusername#', '#enc_password#', '#form.userlevel#')
    </cfquery>
	</cfif>

</cfif> 

<cflocation url = "index.cfm">















