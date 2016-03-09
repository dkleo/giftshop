<cfparam name = "expiresselect" default="Never">
<cfparam name = "expireson" default="">

<cfinclude template = "../queries/qrycompanyinfo.cfm"> <!---To Get the button settings--->

<!---to check for duplicates--->
<cfif NOT form.oldsku IS form.sku>
	<cfquery name = "qryDuplicates" datasource="#request.dsn#">
	SELECT * FROM products WHERE sku = '#form.sku#'
	</cfquery>
	
	<cfif qryDuplicates.recordcount GT 0>
	ERROR:  You have duplicated a SKU number.  SKU numbers must be unique!  Hit your browsers
	back button and change the sku number before trying to add this item again.
	<cfabort>
</cfif>
</cfif>
<cfif request.ShippingType IS '5' OR request.ShippingType IS '10' OR request.ShippingType IS '11' OR request.ShippingType IS '12'>

<cfif form.weight LT .01>
	ERROR:  If you are using real-time shipping calculations, weights cannot be less than .01.  Please enter a valid value for the weight in decimal format.
	<cfabort>
</cfif>

</cfif>

<cfif form.newproductid IS ''>
Error:  You must provide a value for the Product ID field. <a href="javascript:history.go(-1);">Click here to go Back</a>
<cfabort>
</cfif>

<cfif form.sku IS ''>
Error:  You must provide a sku number for this item. <a href="javascript:history.go(-1);">Click here to go Back</a>
<cfabort>
</cfif>

<cfif ISDEFINED('form.category')>
<cfif #ListLen(form.category)# IS 0>
Error:  You failed to assign this product ot a category!  Please choose a category to place
this product in. <a href="javascript:history.go(-1);">Click here to go Back</a>
<cfabort>
</cfif>
</cfif>

<cfif NOT ISDEFINED('form.category')>
Error:  You failed to assign this product ot a category!  Please choose a category to place
this product in. <a href="javascript:history.go(-1);">Click here to go Back</a>
<cfabort>
</cfif>

<cfif #ListLen(form.category)# GREATER THAN 1 AND #form.Category# CONTAINS 'Inactive'>
Error:  You assigned this item to inactive, but you have also assigned it to one ore more
categories.  This is not allowed.  You must either set the item to inactive or set it to
one ore more categories. <a href="javascript:history.go(-1);">Click here to go Back</a>
<cfabort>
</cfif>

<cfif NOT IsNumeric(form.newprice)><b><font size="2" face="Verdana">
Error:  Price must be a numeric value. Therefore, you cannot enter a dollar sign
or other symbol. <a href="javascript:history.go(-1);">Click here to go Back</a>
<cfabort>
</cfif>

<cfif NOT Isdefined('form.newproductname')><b><font size="2" face="Verdana">
Error:  You must provide a value for the Product Name. <a href="javascript:history.go(-1);">Click here to go Back</a>
<cfabort>
</cfif>

<cfif form.newproductname IS ''><b><font size="2" face="Verdana">
Error:  You must provide a value for the Product Name. <a href="javascript:history.go(-1);">Click here to go Back</a>
<cfabort>
</cfif>

<cfif len(form.weight) LT 1>
It does not appear you specified a weight for this item.  You MUST specify a weight if you are doing shipping prices based weight or using real-time shipping quotes.
<cfabort>
</cfif>

<cfset CategoryList = "^" & #replace(form.Category, ",", "^", "ALL")# & "^">

<cfset thissubof = "">
<cfset itemstatus = 'active'>

	<!---If the productid is in use.  If so then assign
	the subof value to that productid, if not then set it to nothing (meaning it's a standalone item
	--->
		<cfquery name = "qryParent" datasource="#request.dsn#">
		SELECT * FROM products WHERE productid = '#form.newproductid#'
		</cfquery>
	
	<cfloop query = "qryParent">
	<cfif NOT qryParent.itemid IS form.itemid>
		<cfif len(qryParent.subof) IS 0>
			<!---This is the parent--->
			<cfset thissubof = #qryParent.itemid#>
		</cfif>
	</cfif>
	</cfloop>

<cfif thissubof IS ''>
	<cfset itemstatus = 'active'>
	<!---Loop over the category list, if one is set to 0, then remove all the others and set the list to 0 and set the status to inactive--->
	
	<cfloop from = "1" to = "#listlen(CategoryList, '^')#" index="c">
		<cfset thiscat = listgetat(CategoryLIst, c, "^")>
		<cfif thiscat is '0'>
			<cfset CategoryList = '0'>
			<cfset itemstatus = 'inactive'>
		</cfif>
	</cfloop>
</cfif>

<!---Update Product info in database--->
<cfquery name = "UpdateProduct" Datasource = #request.dsn#>
UPDATE products
SET productid='#form.Newproductid#', 
productname='#form.NewProductName#', 
price='#form.NewPrice#', 
listprice='#form.NewListPrice#',
wholesaleprice='#Form.NewWholesaleprice#',
BriefDescription='#form.BriefDescription#',
Category='#CategoryList#',
Details='#form.Details#',
Weight = '#form.weight#',
ShippingCosts = '#form.ShippingCosts#',
SupplierID = '#form.Supplier#',
ChargeTaxes = '#form.ChargeTaxes#',
ShowQuantity = '#form.ShowQuantity#',
ChargeShipping = '#form.ChargeShipping#',
CanBackOrder = '#form.CanBackOrder#',
OrderValue = '#form.OrderValue#',
listoptions = '#form.listoptions#',
<cfif ISDEFINED('form.showprice')>showprice = 'Yes',</cfif>
<cfif NOT ISDEFINED('form.showprice')>showprice = 'No',</cfif>
<cfif ISDEFINED('form.showimage')>showimage = 'Yes',</cfif>
<cfif NOT ISDEFINED('form.showimage')>showimage = 'No',</cfif>
<cfif ISDEFINED('form.showtitle')>showtitle = 'Yes',</cfif>
<cfif NOT ISDEFINED('form.showtitle')>showtitle = 'No',</cfif>
<cfif ISDEFINED('form.showwholesaleprice')>showwsprice = 'Yes',</cfif>
<cfif NOT ISDEFINED('form.showwholesaleprice')>showwsprice = 'No',</cfif>
<cfif ISDEFINED('form.showlistprice')>showlistprice = 'Yes',</cfif>
<cfif NOT ISDEFINED('form.showlistprice')>showlistprice = 'No',</cfif>
showvoldiscounts = '#form.showvoldiscounts#',
issubscription = '#form.issubscription#',
showaddtocartbutton = '#form.showaddtocartbutton#',
sku = '#form.sku#',
status = '#itemstatus#',
subof = '#thissubof#',
isgift = '#form.isgift#'
WHERE ItemID = #form.ItemID#
</cfquery>

<!---Set which categories this belongs to--->
<!---Remove the item category references first (that way if it's a sub item it won't be counted
and it won't show up--->
<cfif len(thissubof) LT 1>
<cfquery name = "qryDeleteFromCategories" datasource="#request.dsn#">
DELETE FROM product_categories
WHERE itemid = #form.itemid#
</cfquery>

<!---Loop over category list and insert a record for each category the item belongs to--->
<cfloop from = "1" to = "#listlen(CategoryList, '^')#" index="c">
	<cfset thiscat = listgetat(CategoryList, c, "^")>
	
	<cfquery name = "qryInsertCategoryEntry" datasource="#request.dsn#">
	INSERT INTO product_categories
	(itemid, categoryid)
	VALUES
	(#form.itemid#, #thiscat#)
	</cfquery>
</cfloop>
</cfif>

<!---If it's a subitem then don't assign it to any categories--->
<cfif len(thissubof) GT 0>
	<cfquery name = "qDeleteCategories" datasource="#request.dsn#">
	DELETE FROM product_categories
	WHERE itemid = #form.itemid#
	</cfquery>
</cfif>
<cfif NOT form.issubscription IS 'Yes'>
<p align="center"><strong>Item was updated!</strong>
<cfif NOT ISDEFINED('form.WasSearch')>
<p align="center"><strong><a href="doproducts.cfm?#<cfoutput>#form.ItemID#</cfoutput>">Back 
  to products</a></strong></cfif>
<cfif ISDEFINED('form.WasSearch')>
<p align="center"><strong><a href="doproducts.cfm?action=Search#<cfoutput>#form.ItemID#</cfoutput>">Back 
  to products</a></strong></cfif>
</cfif>
  
<cfif form.issubscription IS 'Yes'>
	Since this is a subscription item, you will need to fill in some additional information below:
	
	<cfquery name = "qryproducts" datasource="#request.dsn#">
		SELECT * FROM products
		WHERE ItemID = #form.ItemID#
	</cfquery>
	
	<cfset expireson = #qryproducts.expireson#>
	<cfset expiresselect = #qryproducts.expireselect#>
	
	<form name = "form1" action="doproducts.cfm" method="POST">
	
	<cfoutput><input type = "hidden" name="ProductID" Value="#form.NewProductID#"></cfoutput>
	<input type = "hidden" name="ActionType" Value="Update">

	  <cfoutput>
  	   <cfset TodaysDate = Now()>
	   <cfset TodaysDate = #dateformat(TodaysDate, "yyyy-mm-dd")#>
	Expires on: 
    <select name="ExpireSelect">
      <option value = "Never" <cfif expiresselect IS 'Never'>selected</cfif>>Never</option>
      <option value = "Custom" <cfif expiresselect IS 'custom'>selected></cfif>>Specify a date ---></option>
      <option value = '#dateformat(DateAdd("m", 1, TodaysDate), "yyyy-mm-dd")#' <cfif expiresselect IS '#DateAdd("m", 1, TodaysDate)#'>selected</cfif>>1 
      Month From Now</option>
      <option value = '#dateformat(DateAdd("m", 3, TodaysDate), "yyyy-mm-dd")#' <cfif expiresselect IS '#DateAdd("m", 3, TodaysDate)#'>selected></cfif>>3 
      Months From Now</option>
      <option value = '#dateformat(DateAdd("m", 6, TodaysDate), "yyyy-mm-dd")#' <cfif expiresselect IS '#DateAdd("m", 6, TodaysDate)#'>selected></cfif>>6 
      Months From Now</option>
      <option value = '#dateformat(DateAdd("yyyy", 1, TodaysDate), "yyyy-mm-dd")#' <cfif expiresselect IS '#DateAdd("yyyy", 1, TodaysDate)#'>selected></cfif>>1 
      Year From Now</option>
      <option value = '#dateformat(DateAdd("yyyy", 2, TodaysDate), "yyyy-mm-dd")#' <cfif expiresselect IS '#DateAdd("yyyy", 2, TodaysDate)#'>selected></cfif>>2 
      Years From Now</option>
    </select>
    </cfoutput>
	<cfoutput><input name="ExpiresOn" type="text" id="ExpiresOn" size="10" Value='#expireson#'></cfoutput><a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=ExpiresOn&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false"><img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a>
	<p>Permissions:<br>
	<cfoutput>
	<cf_PermissionsCategoryTree Directory="/"
		ShowCurrentView="Yes"
		Datasource="#request.dsn#"
		SelectedItem="#qryProducts.Permissions#"
		ShowBullet="No"
		ProductID="#form.Newproductid#">
	</cfoutput>
	<input type="hidden" name="action" value="SetSubscriptionItem">
	<input name = "submit" value="Set Subscription Information" Type="submit">
  </form>
</cfif>















