<cftry>

<h2>Inventory</h2>
<cfif NOT ISDEFINED('form.action') and NOT ISDEFINED('url.action')>
	<cfinclude template = "forms/frminventory.cfm">
</cfif>
<cfif ISDEFINED('url.action')>
	<cfif url.action is 'Exit'>
		<cflocation URL = '#request.AdminPath#'>
	</cfif>
	<cfif url.action IS 'Search'>
		<cfinclude template = 'actions/dspsearchresults.cfm'>
	</cfif>
</cfif>


<cfif ISDEFINED('form.action')>
	<cfif form.action IS 'update'>
		<cfinclude template = "actions/actupdate.cfm">
	</cfif>
	<cfif form.action IS 'Search'>
		<cfinclude template = 'actions/dspSearchResults.cfm'>
	</cfif>
</cfif>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>









