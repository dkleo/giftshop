<!---loop over the TO list and insert a record for each one in the database--->
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset rightnow = now()>
<cfset TheDateNow = #dateformat(rightnow, "dddd, mmmm d, yyyy")#>
<cfset TheTimeNow = #timeformat(rightnow, "hh:mm tt")#>

<!---Get all affiliates or affiliates in a specific group and then send the message to them--->

<cfif form.sendto IS 'agroup'>
    <cfinclude template = "../queries/qrygroupmembers.cfm">
    
    <cfloop query = "qryGroupMembers">
        
        <cfquery name = "InsertMessages" datasource="#request.dsn#">
        INSERT INTO afl_messages
        (sender, sendername, recipient, subject, body, wasread, datesent, archived, SentTo)
        VALUES
        ('Admin', 'Admin', '#qryGroupMembers.AffiliateID#', '#form.subject#', '#form.body#', 'No', '#TheDateNow# #TheTimeNow#', 'No', '#form.ToField#')
        </cfquery>

		<!---Insert a copy in the sent table--->
        <cfquery name = "InsertSent" datasource="#request.dsn#">
        INSERT INTO afl_messages_sent
        (sender, subject, body, datesent, SentTo)
        VALUES
        ('Admin', '#form.subject#', '#form.body#', '#TheDateNow# #TheTimeNow#', '#form.ToField#')
        </cfquery>    

    </cfloop>
    
</cfif>

<cfif form.sendto IS 'affiliate'>

    <cfoutput>
        
        <cfquery name = "InsertMessages" datasource="#request.dsn#">
        INSERT INTO afl_messages
        (sender, sendername, recipient, subject, body, wasread, datesent, archived, SentTo)
        VALUES
        ('Admin', 'Admin', '#form.ToField2#', '#form.subject#', '#form.body#', 'No', '#TheDateNow# #TheTimeNow#', 'No', '#form.ToField2#')
        </cfquery>
    
        <!---Insert a copy in the sent table--->
        <cfquery name = "InsertSent" datasource="#request.dsn#">
        INSERT INTO afl_messages_sent
        (sender, subject, body, datesent, SentTo)
        VALUES
        ('Admin', '#form.subject#', '#form.body#', '#TheDateNow# #TheTimeNow#', '#form.ToField2#')
        </cfquery>

    </cfoutput>

</cfif>

<center>Your Message has been sent!</center>











