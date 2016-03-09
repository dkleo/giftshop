<cfinclude template = "../queries/qryproducts.cfm">

<!---find the next itemid and auto generate a productid for this item--->
<cfquery name = "FindProduct" datasource="#request.dsn#">
SELECT MAX(ItemID) 
AS MaxID 
FROM products
</cfquery>

<cfset nextID = #FindProduct.MaxID# + 1> 
<cfset NewSku = "#qryProducts.sku#-#nextid#">
<cfset NewName = "Copy of #qryProducts.productname#">
<cfset NewProductID = "#qryProducts.ProductID#-#nextid#">

<cfset datetimestamp = now()>

<!---Insert a new row for this product--->
<cfquery name = "qry_CopyColumn" datasource = "#request.dsn#">
INSERT INTO products
(itemid, sku, productid, DateAdded, productname, reviews, UnitsSold, UnitsInStock)
VALUES
(#nextID#, '#newsku#', '#newproductid#', #CreateODBCdatetime(datetimestamp)#, '#newname#', 0, 0, #request.DefaultStockValue#)
</cfquery>

<!---Loop over each column and update it with the value of the one we are copying from--->
<cfloop from = "1" to = "#listlen(qryProducts.columnlist)#" index="i">
<cfset thiscol = listgetat(qryProducts.columnlist, i)>
<cfset thisval = 'qryProducts.#thiscol#'>
<cfset thisval = replace(evaluate(thisval), "'", "", "ALL")>

<cfif NOT thiscol IS 'ItemID' AND NOT thiscol IS 'ProductID' AND NOT thiscol IS 'OrderValue' AND NOT thiscol IS 'DateAdded' AND NOT thiscol IS 'Sku' AND NOT thiscol IS 'ProductName' AND NOT thiscol IS 'ExpiresOn' AND NOT thiscol IS 'rating' AND NOT thiscol IS 'reviews'>
	<cfquery name = "qry_CopyColumn" datasource = "#request.dsn#">
		UPDATE products
		SET #thiscol# = '#thisval#'
		WHERE itemid = #Nextid#
	</cfquery>
</cfif>
</cfloop>

<!---Insert this into the same category--->
<cfquery name = "qryCategory" datasource="#request.dsn#">
SELECT * FROM product_categories
WHERE itemid = #url.itemid#
</cfquery>

<cfloop query = "qryCategory">
	<cfquery name = "qInsertIntoCategory" datasource="#request.dsn#">
	INSERT INTO product_categories
	(itemid, categoryid)
	VALUES
	(#NextID#, #qryCategory.categoryid#)
	</cfquery>
</cfloop>

<cflocation url="doproducts.cfm?action=edit&itemid=#nextid#">















