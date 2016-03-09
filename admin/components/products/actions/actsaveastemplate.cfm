<!---if not name is given just give it the productname--->
<cfif len(trim(form.template_name)) IS 0>
	<cfset form.template_name = form.newproductname>
</cfif>

<!---remove duplicate templates first--->
<cfquery name = "qDeleteDuplidate" datasource="#request.dsn#">
DELETE FROM products_templates
WHERE itemid = #findproduct.itemid#
</cfquery>

<cfquery name = "qDeleteDuplidate" datasource="#request.dsn#">
DELETE FROM product_categories_templates
WHERE itemid = #findproduct.itemid#
</cfquery>

<!---Insert The New Product template into the database --->
<cfquery name = "InsertProduct" Datasource = "#request.dsn#">
Insert INTO products_templates
(itemid, productid, productname, price, BriefDescription, Details, UnitsInStock, UnitsSold, ImageURL, ThumbNail, 
IsFeatured, weight, shippingcosts, supplierid, timesviewed, ChargeTaxes, ShowQuantity, 
ChargeShipping, CanBackOrder, showprice, showlistprice, showwsprice, showvoldiscounts, showimage, showaddtocartbutton,
showtitle, fordervalue, issubscription, DateAdded, sku, brand, subof, status, listprice, wholesaleprice, isgift, availability, mfg, reviews, upc, OneClickOrdering)
VALUES
(#findproduct.itemid#, '#form.Newproductid#', '#form.template_name#', '#form.NewPrice#', '#form.BriefDescription#', '#form.Details#',
#UnitStock#, 0, '#Photo#', '#ThumbNail#', 'No', '#form.weight#', 
'#form.ShippingCosts#', '#form.supplier#', '0', '#form.ChargeTaxes#', '#form.ShowQuantity#', '#form.ChargeShipping#', 
'#CanBackOrder#', '#ashowprice#', '#ashowlistprice#', '#ashowwsprice#', '#form.showvoldiscounts#', '#ashowimage#',
'#form.showaddtocartbutton#', '#ashowtitle#', #NextItemOrderVal#, '#form.issubscription#', #CreateODBCdatetime(insertdate)#, '#form.sku#', '#newbrand#', '#thissubof#', '#itemstatus#', '#form.newlistprice#', '#form.newwholesaleprice#', '#form.isgift#', '#newavailability#', '#newmfg#', 0, '#form.upc#', '#form.OneClickOrdering#')
</cfquery>

<!---Insert into categories by looping over the categorylist--->
<cfif len(thissubof) LT 1>
<cfset CategoryList = "|" & #replace(form.Category, ",", "|", "ALL")# & "|">
	<cfloop from = "1" to = "#listlen(CategoryList, '|')#" index="c">
		<cfset thiscat = listgetat(CategoryList, c, "|")>
		
		<cfquery name = "qryInsertCategoryEntry" datasource="#request.dsn#">
		INSERT INTO product_categories_templates
		(itemid, categoryid, ordervalue)
		VALUES
		(#FindProduct.itemid#, #thiscat#, #NextItemOrderVal#)
		</cfquery>
	</cfloop>
</cfif>