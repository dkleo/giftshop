<cftry>
<link href="../../controlpanel.css" rel="stylesheet" type="text/css" />

<cfparam name = "action" default="tickets">

<cfswitch expression="#action#">
    <cfcase value="tickets">
        <cfinclude template = "forms/frmtickets.cfm">
    </cfcase>
    <cfcase value="readticket">
        <cfinclude template = "actions/actreadticket.cfm">
    </cfcase>
    <cfcase value="replytoticket">
        <cfinclude template = "actions/actpostresponse.cfm">
    </cfcase>
    <cfcase value="closeticket">
        <cfinclude template = "actions/actcloseticket.cfm">
    </cfcase>
    <cfcase value="closedtickets">
        <cfinclude template = "forms/frmclosedtickets.cfm">
    </cfcase>
</cfswitch>
<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>







