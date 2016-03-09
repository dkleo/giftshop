<cfquery name = "qrySearchOrders" Datasource = "#request.dsn#">
SELECT *
FROM orders
WHERE OrderNumber LIKE '%#form.SearchBox#%' <cfif isdate(form.searchbox)>OR DateOfOrder LIKE '%#form.SearchBox#%'</cfif>
</cfquery>

<cfquery name = "qrySearchCustomers" Datasource = "#request.dsn#">
SELECT *
FROM customerhistory
WHERE FirstName LIKE '%#form.SearchBox#%' OR LastName LIKE '%#form.SearchBox#%'
OR Address LIKE '%#form.SearchBox#%' OR PhoneNumber LIKE '%#form.SearchBox#%' 
</cfquery>

















