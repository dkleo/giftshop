<!---this query selects just one product if an itemid is passed in.--->
<cfquery name = "qryAllproducts" Datasource="#request.dsn#">
SELECT *
FROM products
ORDER By fOrderValue DESC
</cfquery>

<cfquery name = "qryproducts" Datasource="#request.dsn#">
SELECT *
FROM products
<cfif ISDEFINED('url.itemid')>WHERE ItemID = #url.itemid#</cfif>
<cfif ISDEFINED('form.itemid')>WHERE ItemID = #form.Itemid#</cfif>
<cfif ISDEFINED('TheItemID')>WHERE ItemID = #TheItemID#</cfif>
</cfquery>






















