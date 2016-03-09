<cfquery name = "qryOrders" Datasource="#Request.dsn#">
SELECT * FROM orders
WHERE CustomerID = #url.CustomerID#
</cfquery>

<cfif NOT qryOrders.recordcount IS 0>
	<div align="center"><strong>You cannot delete this customer because he/she has orders on file.<br>
	You have to delete the orders first and then delete the customer.</strong></div>
	<cfabort>
</cfif>

<cfif NOT ISDEFINED('url.Confirm')>
  <cfoutput><div align="Center"><strong>Are you sure you want delete this customer? <a href = "doorders.cfm?action=deleteCustomer&Confirm=Yes&CustomerID=#url.CustomerID#">Yes</a> 
    | <a href = "doorders.cfm?action=ViewCustomers">No</a></strong></div></cfoutput>
</cfif>
<cfif ISDEFINED('url.confirm')>
<cfquery name = "DeleteCustomer" Datasource="#Request.dsn#">
DELETE FROM customerhistory
WHERE CustomerID = #url.CustomerID#
</cfquery>

<cflocation url="doorders.cfm?action=ViewCustomers">
</cfif>



















