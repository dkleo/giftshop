<CFQUERY Name ="qryCustomers" DATASOURCE = #request.dsn#>
 	SELECT *
	FROM customerhistory
	<cfif ISDEFINED('url.CustomerID')>WHERE CustomerID= #url.CustomerID# </cfif>
	<cfif NOT ISDEFINED('SortBy')>
		ORDER BY LastName ASC
	</cfif>
	<cfif ISDEFINED('SortBy')>
		ORDER BY #SortBy# #SortOrder#
	</cfif>
</CFQUERY>

















