<cftry>
<link rel="stylesheet" type="text/css" href="../../controlpanel.css">
<h2 align="left">Store footer</h2>
<cfif NOT ISDEFINED('url.action') AND NOT ISDEFINED('form.action')>
<cfinclude template="forms/frmstorefooter.cfm">
</cfif>

<cfif ISDEFINED('form.action')>
<cfif form.action IS 'Update'>
  <cfinclude template = 'actions/actupdate.cfm'>
</cfif>
</cfif>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>







