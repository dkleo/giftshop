<!---this query is used to get the columns from the products table--->

<cfquery name = "qColumns" datasource="#request.dsn#" maxrows="1">
SELECT * FROM products
</cfquery>