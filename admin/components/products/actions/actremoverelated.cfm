<cfset newlist = ''>

<cfquery name = "GetList" datasource="#request.dsn#">
SELECT * FROM products 
WHERE itemid = #url.ritem#
</cfquery>

<cfoutput query = "GetList">
	<cfset newlist = #similaritems#>
</cfoutput>

<cfset newlist = listdeleteat(newlist, url.listcount, "^")>

<cfquery name = "UpdateOrderValues" datasource="#request.dsn#">
UPDATE products
SET similaritems = '#newlist#'
WHERE ItemID = #url.ritem#
</cfquery>

<cflocation url = "doproducts.cfm?action=relateditems&ritem=#url.ritem#">















