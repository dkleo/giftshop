<cftry>
<!---for gift card/certificate management--->

<cfparam name = "action" default="default">

<cfswitch expression="#action#">
	<cfcase value = "default">
		<cfinclude template = "forms/frmgiftcards.cfm">	
	</cfcase>
	<cfcase value = "vieworder">
		<cfinclude template = "actions/actvieworder.cfm">	
	</cfcase>	
	<cfcase value = "UpdateGiftCards">
		<cfinclude template = "actions/actupdate.cfm">	
	</cfcase>	
	<cfdefaultcase>
		<cfinclude template = "forms/frmGiftCards.cfm">	
	</cfdefaultcase>
</cfswitch>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>









