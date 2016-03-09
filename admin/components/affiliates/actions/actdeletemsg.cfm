<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfparam name = "wasdoing" default="">

<cfif wasdoing IS 'sentmsgs'>
    <cfquery name = "qdeletemsg" datasource="#request.dsn#">
    DELETE FROM afl_messages_sent
    WHERE msgid = #url.msgid#
    </cfquery>
<cfelse>
    <cfquery name = "qdeletemsg" datasource="#request.dsn#">
    DELETE FROM afl_messages
    WHERE msgid = #url.msgid#
    </cfquery>
</cfif>

<cfif wasdoing IS 'sentmsgs'>
	<cflocation url = "index.cfm?action=messages.viewsent">
<cfelse>
	<cflocation url = "index.cfm?action=messages">
</cfif>