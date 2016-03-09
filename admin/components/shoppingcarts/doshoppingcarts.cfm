<cftry>


<cfif NOT ISDEFINED('form.action') AND NOT ISDEFINED('url.action')>
	<cfinclude template = "forms/frmshoppingcarts.cfm">
</cfif>

<cfif isdefined('url.action')>
	<cfif url.action IS 'deletecart'>
		<cfinclude template = 'actions/actdeletecart.cfm'>
	</cfif>
	<cfif url.action IS 'viewcart'>
		<cfinclude template = 'forms/frmviewcart.cfm'>
	</cfif>
	<cfif url.action IS 'deleteall'>
		<cfinclude template = 'actions/actdeleteall.cfm'>
	</cfif>
</cfif>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>









