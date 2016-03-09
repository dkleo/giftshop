<cfquery name = "qrySuppliers" Datasource = "#request.dsn#">
SELECT *
FROM contacts
Order By CompanyName ASC
</cfquery>















