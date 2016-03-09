<cfquery name = "qryGroups" datasource="#request.dsn#">
SELECT * FROM afl_groups
<cfif isdefined('url.groupid') AND NOT ISDEFINED('TheGroupID')>WHERE groupid = #url.groupid#</cfif>
<cfif isdefined('form.groupid') AND NOT ISDEFINED('TheGroupID')>WHERE groupid = #form.groupid#</cfif>
<cfif isdefined('TheGroupID')>WHERE groupid = #TheGroupID#</cfif>
</cfquery>











