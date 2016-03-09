<link href="../../controlpanel.css" rel="stylesheet" type="text/css" />
<cfparam name = "action" default = "viewsubscriptions">

<cfswitch expression="#action#">
	<cfcase value="viewsubscriptions">
		<cfinclude template = "forms/frmsubscriptions.cfm">
	</cfcase>
	<cfcase value="addaccounts">
		<cfinclude template = "forms/frmcustomers.cfm">
	</cfcase>
	<cfcase value="addaccount">
		<cfinclude template = "actions/actaddmember.cfm">
	</cfcase>
	<cfcase value="updateaccounts">
		<cfinclude template = "actions/actupdateaccounts.cfm">
	</cfcase>
	<cfdefaultcase>
	    <cfinclude template = "forms/frmSubscriptions.cfm">
    </cfdefaultcase>
</cfswitch>








