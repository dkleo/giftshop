<cftry>

<cfparam name="action" default="">

<cfswitch expression="#action#">

<cfcase value="new">
	<cfinclude template = "forms/frmnewsale.cfm">
</cfcase>
<cfcase value="Edit">
	<cfinclude template = "forms/frmeditsale.cfm">
</cfcase>
<cfcase value="Delete">
	<cfinclude template = "actions/actdeletesale.cfm">
</cfcase>
<cfcase value = "add">
	<cfinclude template = "actions/actaddsale.cfm">
</cfcase>
<cfcase value = "Update">
	<cfinclude template = "actions/actupdatesale.cfm">
</cfcase>
<cfdefaultcase>
	<cfinclude template = "forms/frmsales.cfm">
</cfdefaultcase>
</cfswitch>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>








