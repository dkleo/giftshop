<cfif ISDEFINED('TempVar.EditID')>
<cfquery name = "qryFindProduct" Datasource = "#request.dsn#">
SELECT * 
FROM products
WHERE ItemID = #TempVar.EditID#
</cfquery>
</cfif>

<cfif ISDEFINED('url.ItemID')>
<cfquery name = "qryFindProduct" Datasource = "#request.dsn#">
SELECT * 
FROM products
WHERE ItemID = #URL.ItemID#
</cfquery>
</cfif>















