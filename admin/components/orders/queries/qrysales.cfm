<!---Gets every order in the database--->
<CFQUERY Name ="qrySales" DATASOURCE = #request.dsn#>
 	SELECT * FROM orders
	Where Paid = 'yes'
	Order By DateOfOrder ASC
</CFQUERY>

















