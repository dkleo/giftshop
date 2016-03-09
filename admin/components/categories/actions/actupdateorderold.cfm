<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---loop over the list of Order Values and then update then in the database--->

<cfloop from="1" to="#ListLen(form.CategoryID)#" index="mycount">
<cfset ThisCategoryID = #ListGetAt(form.CategoryID, mycount)#>
<cfset ThisOrderValue = #ListGetAt(form.OrderValue, mycount)#>

<cfquery name="UpdateOrder" datasource="#request.dsn#">
UPDATE categories
SET OrderValue = #ThisOrderValue#
WHERE CategoryID = #ThisCategoryID#
</cfquery>

</cfloop>

<cflocation url = "index.cfm?action=ChangeOrder">





















