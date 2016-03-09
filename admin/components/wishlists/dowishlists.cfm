<cftry>
<link href="../../controlpanel.css" rel="stylesheet" type="text/css" />

<cfif request.EnableWishLists IS 'No'>
	<strong>You do not have the wish list feature enabled.  To enable it, go to the settings and enable it under Catalog Settings
    </strong>
	<cfabort>
</cfif>

<cfif not isdefined('form.action') AND not isdefined('url.action')>
	<cfinclude template = "forms/frmwishlists.cfm">
</cfif>

<cfif isdefined('url.action')>
	<cfif url.action IS 'DeleteList'>
		<cfinclude template = "actions/actdeletewishlist.cfm">
	</cfif>
	
	<cfif url.action IS 'Viewlist'>
		<cfinclude template = "forms/frmviewwishlist.cfm">	
	</cfif>
</cfif>
<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>







