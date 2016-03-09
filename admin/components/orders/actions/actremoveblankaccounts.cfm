<cfif listlen(form.BlankAccountsList, '^') GT 0>
	<cfloop from = "1" to = "#listlen(form.BlankAccountsList, '^')#" index = "BlankCount">
		<cfset ThisCustomerID = ListGetAt(form.BlankAccountsList, BlankCount, "^")>
		
			<cfquery name="qryRemoveBlankAccounts" datasource="#request.dsn#">
				DELETE FROM customerhistory
				WHERE CustomerID = #ThisCustomerID#
			</cfquery>
	</cfloop>
</cfif>

<cflocation url = "doorders.cfm?action=ViewCustomers">



















