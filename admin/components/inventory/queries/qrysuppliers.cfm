<cfquery name = "qrySuppliers" Datasource = "#request.dsn#">
	SELECT * From contacts
	Order By CompanyName ASC
</cfquery>




















