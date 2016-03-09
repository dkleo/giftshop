<!---Show the progress bar--->

<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfparam name = "sendto" default = "all">

<cfoutput>
	<cfparam name = "nl_id" default = "#url.nl_id#">
</cfoutput>


<!---If sending to all then execute this script--->
<cfif sendto IS 'SendToAll'>
	<cfinclude template = "../queries/qry_members.cfm">
	<cfinclude template = "../queries/qry_settings.cfm">
	<cfinclude template = "../queries/qry_published.cfm">
	
        <!---If the user is required to specify an outgoing mail server for the cfmail tag then send it using the settings--->
        <cfif qrySettings.nl_UseServer IS 'Yes'>
            <!---If the user is required to specify an outgoing mail server username/Password then use these settings---->
            <cfif qrySettings.nl_UsePassword IS 'Yes'>		
                <cfmail
                query="qryActiveMembers"
                from='"#request.companyname#" <#qrySettings.nl_email#>' 
                to = '"#qryActiveMembers.name#" <#qryActiveMembers.EmailAddress#>'
                subject="#qryPublished.Subject#" 
                server="#qrySettings.nl_mailserver#" 
                type="html"
                username="qrySettings.nl_mailusername"
                Password="qrySettings.nl_mailpassword">
                #qryPublished.Body#
                </cfmail>
            <cfelse>
                <!---Otherwise just sent it though the specified mail server--->
                <cfmail server="#qrySettings.nl_mailserver#" 
                query="qryActiveMembers"
                from="""#request.companyname#"" <#qrySettings.nl_email#>" 
                to = """#qryActiveMembers.name#"" <#qryActiveMembers.EmailAddress#>" 
                subject="#qryPublished.Subject#" 
                type="html">
                #qryPublished.Body#
                </cfmail>
            </cfif>
        <cfelse>
            <!---Otherwise use cfmail without the server specification--->
            <!---If the user is required to specify an outgoing mail server username/Password then use these settings---->
            <cfif qrySettings.nl_UsePassword IS 'Yes'>		
                <cfmail 
                query="qryActiveMembers"
                from='"#request.companyname#" <#qrySettings.nl_email#>'
                to = '"#qryActiveMembers.name#" <#qryActiveMembers.EmailAddress#>'
                subject="#qryPublished.Subject#" 
                type="html"
                username="qrySettings.nl_mailusername"
                Password="qrySettings.nl_mailpassword">
                #qryPublished.Body#
                </cfmail>
            <cfelse>
                <!---Otherwise just sent it though the specified mail server--->
                <cfmail 
                query="qryActiveMembers"
                from='"#request.companyname#" <#qrySettings.nl_email#>' 
                to = '"#qryActiveMembers.name#" <#qryActiveMembers.EmailAddress#>'
                subject="#qryPublished.Subject#" 
                type="html">
                #qryPublished.Body#
                </cfmail>
            </cfif>	  
		</cfif>
			
</cfif>

<!---Send to a specific group--->
<cfif sendto IS 'SendToGroup'>

	<cfset viewgroup = form.groupid>

	<cfinclude template = "../queries/qry_membersofgroup.cfm">
	<cfinclude template = "../queries/qry_settings.cfm">
	<cfinclude template = "../queries/qry_Published.cfm">


        <!---If the user is required to specify an outgoing mail server for the cfmail tag then send it using the settings--->
        <cfif qrySettings.nl_UseServer IS 'Yes'>
            <!---If the user is required to specify an outgoing mail server username/Password then use these settings---->
            <cfif qrySettings.nl_UsePassword IS 'Yes'>		
                <cfmail
                query="qryMembers"
                from='"#request.companyname#"" <#qrySettings.nl_email#>'
                to = '"#qryMembers.name#" <#qryMembers.EmailAddress#>' 
                subject="#qryPublished.Subject#" 
                server="#qrySettings.nl_mailserver#" 
                type="html"
                username="qrySettings.nl_mailusername"
                Password="qrySettings.nl_mailpassword">
                #qryPublished.Body#
                </cfmail>
            <cfelse>
                <!---Otherwise just sent it though the specified mail server--->
                <cfmail server="#qrySettings.nl_mailserver#" 
                query="qryMembers"
                from='"#request.companyname#"" <#qrySettings.nl_email#>'
                to = '"#qryMembers.name#" <#qryMembers.EmailAddress#>' 
                subject="#qryPublished.Subject#" 
                type="html">
                #qryPublished.Body#
                </cfmail>
            </cfif>
        <cfelse>
            <!---Otherwise use cfmail without the server specification--->
            <!---If the user is required to specify an outgoing mail server username/Password then use these settings---->
            <cfif qrySettings.nl_UsePassword IS 'Yes'>		
                <cfmail 
                query="qryMembers"
                from='"#request.companyname#"" <#qrySettings.nl_email#>'
                to = '"#qryMembers.name#" <#qryMembers.EmailAddress#>' 
                subject="#qryPublished.Subject#" 
                type="html"
                username="qrySettings.nl_mailusername"
                Password="qrySettings.nl_mailpassword">
                #qryPublished.Body#
                </cfmail>
            <cfelse>
                <!---Otherwise just sent it though the specified mail server--->
                <cfmail 
                query="qryMembers"
                from='"#request.companyname#"" <#qrySettings.nl_email#>'
                to = '"#qryMembers.name#" <#qryMembers.EmailAddress#>' 
                subject="#qryPublished.Subject#" 
                type="html">
                #qryPublished.Body#
                </cfmail>
            </cfif>	  
		</cfif>
        
</cfif> <!---end if sending to a group--->

<cfset WasSentOn = Now()>

<cfquery name = "UpdateSentDate" datasource="#request.dsn#">
UPDATE nl_published
SET senton = #CreateODBCDateTime(WasSentOn)#
WHERE id = #qryPublished.id#
</cfquery>

<center>Your Newsletter was emailed successfully!</center>
