<cftry>
<link href="../../controlpanel.css" rel="stylesheet" type="text/css" />
<cfif NOT isdefined('url.action') AND NOT isdefined('form.action')>
	<cfinclude template = "forms/frmbrochures.cfm">
</cfif>

<cfif isdefined('url.action')>
	<cfif url.action IS 'new'>
		<cfinclude template = "forms/frmnew.cfm">
	</cfif>
	<cfif url.action IS 'add'>
		<cfinclude template = "actions/actadd.cfm">
		<cfinclude template = "forms/frmBrochures.cfm">
	</cfif>
	<cfif url.action IS 'edit'>
		<cfinclude template = "forms/frmedit.cfm">
	</cfif>
	<cfif url.action IS 'delete'>
		<cfinclude template = "actions/actdelete.cfm">
	</cfif>
	<cfif url.action IS 'update'>
		<cfinclude template = "actions/actupdate.cfm">
	</cfif>
</cfif>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>









