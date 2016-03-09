<cfset NeverExpires = 'No'>

<cfif form.ExpireSelect IS 'Never'>
	<cfset NeverExpires = 'Yes'>
	<cfset ExpiresOn = '3099-01-01'>
</cfif>

<cfif NOT form.ExpireSelect IS 'Custom' AND NOT form.ExpireSelect IS 'Never'>
	<cfset ExpiresOn = '#form.ExpireSelect#'>
<cfelse>
	<cfset ExpiresOn = '#dateformat(form.ExpiresOn, "yyyy-mm-dd")#'>
</cfif>

<cfquery name = "UpdateItem" Datasource = '#request.dsn#'>
UPDATE products
SET ExpiresOn = #createodbcdate(ExpiresOn)#,
NeverExpires = '#NeverExpires#',
Permissions = '#form.SetPermissions#',
ExpireSelect = '#form.ExpireSelect#'
WHERE ProductID = '#form.ProductID#'
</cfquery>

<cfif form.actiontype IS 'Add'>
<p align="center">The new item was added to your database!</p>
<p align="center"><a href="doproducts.cfm?action=add">Add Another One</a></p>
</cfif>

<cfif form.actiontype IS 'Update'>
<p align="center"><strong>Item was updated!</strong>
<p align="center"><strong><a href="doproducts.cfm">Back to products</a></strong>
</cfif>















