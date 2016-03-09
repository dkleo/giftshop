<h2>Image Import Wizards Step 2</h2>

<cfif form.import_method IS 'imageurl'>
	<cfinclude template = "../actions/actfindonimageurl.cfm">
</cfif>

<cfif form.import_method IS 'sku'>
	<cfinclude template = "../actions/actfindonsku.cfm">
</cfif>

<cfif form.import_method IS 'productname'>
	<cfinclude template = "../actions/actfindonname.cfm">
</cfif>

<center><strong>Image import complete!</strong></center>



















