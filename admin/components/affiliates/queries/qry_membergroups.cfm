<!---Called from act_assigntogroups.cfm, this file queries the currently selected members groups--->
<cfquery name = "qGetGroups" datasource="#request.dsn#">
SELECT * FROM afl_groups
WHERE id = #thisitem#
</cfquery>












