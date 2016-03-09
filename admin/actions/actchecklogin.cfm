<!---If the login form was not used to login, then check for cookies--->
<cfinclude template = "#request.absolutepath#config/admin.cfm">

<cfif len(trim(request.adminpassword)) IS 0>
	<h2>Setup is not yet complete</h2>
    For added security, new installations must now create a master admin and password prior to logging into the control panel.
    To do this, ftp to your website and go to the folder "/config/" and open the file called admin.cfm.  Set the master username and password, save it, and then login to your control panel using 
    the username and password your create.
    <cfabort>
</cfif>

<cfset isloggedin = 'No'>

<!---if none of the variables are found they need to go to the login form--->
<cfif NOT isdefined('form.admin_username')>
	<cfif NOT isdefined('cookie.admin_username')>
		<cfif NOT isdefined('url.login')>
		   <cfoutput>
                 <script language="JavaScript">
                    <!--
                    top.location.replace("#request.adminpath#login.cfm?login=true&is_mobile=#is_mobile#");
                    -->	
                  </script>
            </cfoutput>
            <cfabort>
		</cfif>
    </cfif>
</cfif>

<!---If the login form was used, check the username and Password entered--->
<cfif isdefined('form.admin_username')>
	<cfif NOT isdefined('form.keep_loggedin')>
        <cfcookie name="admin_username" value="#form.admin_username#">
        <cfcookie name="admin_password" value="#form.admin_password#">
    <cfelse>
    <!---otherwise set it to whatever the value is of the form--->
        <cfcookie name="admin_username" expires = "#form.login_remember#" value="#form.admin_username#">
        <cfcookie name="admin_password" expires = "#form.login_remember#" value="#form.admin_password#">
    </cfif>
            	
	<!---check for captcha failure--->
	<cfset strCaptcha = Decrypt(form.captcha_check, request.seedstring, "CFMX_COMPAT","HEX") />

	<cfif strCaptcha NEQ form.vcode>
	   <cfoutput>
             <script language="JavaScript">
                <!--
                top.location.replace("#request.adminpath#login.cfm?login=true&is_mobile=#is_mobile#&login_failed=true&error_msg=Incorrect characters entered for image.");
                -->	
              </script>
        </cfoutput>    
    </cfif>
</cfif>


<cfif NOT isdefined('cookie.admin_username') OR NOT isdefined('cookie.admin_password')>
	   <cfoutput>
             <script language="JavaScript">
                <!--
                top.location.replace("#request.adminpath#login.cfm?login=true&is_mobile=#is_mobile#");
                -->	
              </script>
        </cfoutput>
</cfif>	

<cfset passwordfail = 1> 

<cfif cookie.admin_username IS request.adminusername AND cookie.admin_password IS request.adminpassword>
	 <cfset passwordfail = 0>
	 <cfset qryLoginCheck.userlevel = 'masteradmin'>
	 <cfset qryLoginCheck.username = '#request.adminusername#'>
</cfif>
    
<cfif passwordfail IS 1>        

	<cfset enc_password = #encrypt(cookie.admin_password, request.seedstring)#>
		
    <cfquery name ="qryLoginCheck" datasource = "#request.dsn#">
        SELECT * FROM users
        WHERE UserName = <cfqueryparam value="#cookie.admin_username#" cfsqltype="cf_sql_varchar">
        AND pword = <cfqueryparam value="#enc_password#" cfsqltype="cf_sql_varchar">
    </cfquery>
    
	<cfif #qryLoginCheck.recordcount# IS 0> 
       <CFCOOKIE name="admin_username" expires="NOW" Value="None">
       <CFCOOKIE name="admin_password" expires="NOW" Value="None">
           
       <!---since it doesn't match any then redirect--->    
         <cfoutput>
                 <script language="JavaScript">
                    <!--
                    top.location.replace("#request.adminpath#login.cfm?login=true&is_mobile=#is_mobile#&login_failed=true&error_msg=Invalid Username or Password");
                    -->	
                  </script>
            </cfoutput>

            <cfabort>
     </cfif><!---end if user/password not matching--->
</cfif><!---end if passwordfail IS 1---> 