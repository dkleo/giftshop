<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---This saves the order of the categories--->

<!---loops over each element in the CategoryOrderBox listbox and then update the category with a new
	 order value depending on its location in the listbox--->

<cfloop from = "1" to="#ListLen(form.CategoryOrderBox)#" index="ordercount">
	<cfset ThisCatID = #ListGetAt(form.CategoryOrderBox, ordercount)#>
	<cfquery name = "qrySetOrderValue" datasource="#request.dsn#">
	UPDATE categories
	SET OrderValue = #ordercount#
	WHERE CategoryID = #ThisCatID#
	</cfquery>
</cfloop>

<center><h2>Category Order Was Saved!</h2></center>
<p>
<cflocation url  = "index.cfm?action=ChangeOrder&categoryview=#url.categoryview#&orderupdated=true">





















