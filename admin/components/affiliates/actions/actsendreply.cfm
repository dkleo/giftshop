<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---loop over the TO list and insert a record for each one in the database--->
<cfif NOT isdefined('form.ToField')>
	You must specify a recipient for this message.  Please hit your browser back button and then select at least one person this message should go to
	<cfabort>
</cfif>

<cfset rightnow = now()>
<cfset TheDateNow = #dateformat(rightnow, "dddd, mmmm d, yyyy")#>
<cfset TheTimeNow = #timeformat(rightnow, "hh:mm tt")#>

<!---Loop over the too field and send to the members in that field--->
<cfloop from="1" to="#listlen(form.ToField)#" index="toCount">
	<cfset CurrentRecipient = listgetat(form.ToField, toCount)>

<cfquery name = "InsertMessages" datasource="#request.dsn#">
INSERT INTO afl_messages
(sender, sendername, recipient, subject, body, wasread, datesent, archived, SentTo)
VALUES
('admin', 'admin', '#CurrentRecipient#', '#form.subject#', '#form.body#', 'No', '#TheDateNow# #TheTimeNow#', 'No', '#form.ToField#')
</cfquery>

</cfloop>

<!---Insert a copy in the sent table--->
<cfquery name = "InsertSent" datasource="#request.dsn#">
INSERT INTO afl_messages_sent
(sender, subject, body, datesent, SentTo)
VALUES
('admin', '#form.subject#', '#form.body#', '#TheDateNow# #TheTimeNow#', '#form.ToField#')
</cfquery>
<center>Your Message has been sent!</center>











