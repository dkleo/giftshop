<cfparam name = "expiresselect" default="Never">
<cfparam name = "expireson" default="">
<cfparam name = "UnitsInStock" default="#request.defaultstockvalue#">
<cfparam name = "Photo" default = 'nopic.jpg'>
<cfparam name = "Thumbnail" default = 'nopic.jpg'>

<!---Adds a product to the database--->
<cfinclude template = "../queries/qryproducts.cfm">

<!---to check for duplicates--->
<cfquery name = "qryDuplicates" datasource="#request.dsn#">
SELECT * FROM products WHERE sku = '#form.sku#'
</cfquery>

<cfif qryDuplicates.recordcount GT 0>
	ERROR:  You have duplicated a SKU number.  SKU numbers must be unique!  Hit your browsers
	back button and change the sku number before trying to add this item again.
	<cfabort>
</cfif>

<!---Error Checks--->

<cfif NOT IsNumeric(form.newprice)>
	Error:  Price must be a numeric value. Therefore, you cannot enter a dollar sign
	or other symbol. <a href="javascript:history.go(-1);">Click here to go Back</a>
	<cfabort>
</cfif>

<cfif NOT Isdefined('form.newproductname')>
	Error:  You must provide a value for the Product Name. <a href="javascript:history.go(-1);">Click here to go Back</a>
	<cfabort>
</cfif>

<cfif form.newproductid IS ''>
	Error:  You must provide a value for the Product ID field. <a href="javascript:history.go(-1);">Click here to go Back</a>
	<cfabort>
</cfif>

<cfif form.sku IS ''>
	Error:  You must provide a sku number for this item. <a href="javascript:history.go(-1);">Click here to go Back</a>
	<cfabort>
</cfif>

<cfif form.newproductname IS ''>
	Error:  You must provide a value for the Product Name. <a href="javascript:history.go(-1);">Click here to go Back</a>
	<cfabort>
</cfif>

<cfif NOT ISDEFINED('form.category')>
	Error:  You must assign a category to this product.  Nothing was added! <a href="javascript:history.go(-1);">Click here to go Back</a>
	<cfabort>
</cfif>

<cfif len(form.weight) LT 1>
	It does not appear you specified a weight for this item.  You MUST specify a weight if you are doing shipping prices based weight or using real-time shipping quotes.
	<cfabort>
</cfif>

<cfif request.ShippingType IS '5' OR request.ShippingType IS '10' OR request.ShippingType IS '11' OR request.ShippingType IS '12'>
	<cfif form.weight LT .01>
		ERROR:  If you are using real-time shipping calculations, weights cannot be less than .01.  Please enter a valid value for the weight in decimal format.
		<cfabort>
	</cfif>
</cfif>

	<cfset thissubof = ''>

	<cfquery name = "qryParent" datasource="#request.dsn#">
	SELECT * FROM products WHERE productid = '#form.newproductid#'
	</cfquery>
	
	<cfloop query = "qryParent">
		<cfif len(qryParent.subof) IS 0>
			<!---This is the parent--->
			<cfset thissubof = #qryParent.itemid#>
		</cfif>
	</cfloop>

<!---If it's not a sub item then assign it it's own image if one was specified--->
<cfif len(thissubof) LT 1>
<cfif NOT form.filecontents IS ''>
<!---Upload the image to the large directory directory--->
	<cffile action="Upload"
	FileField = "form.filecontents"
	Destination = "#request.catalogpath#photos#request.bslash#large#request.bslash#"
	NameConflict = "overwrite"
	Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg, image/png">
	
	<cfset Photo = '#cffile.Serverfile#'>
	<cfset Thumbnail = '#cffile.Serverfile#'>
</cfif>
</cfif>

<!---Get their settings for custom buttons--->
<cfoutput query = "qryCompanyInfo">
<cfset ButtonURL = '#addtocartbuttonurl#'>
</cfoutput>

<cfif NOT ISDEFINED('Photo')>
	Your path to the photo directory (<cfoutput>#request.CatalogPath#photos#request.bslash#</cfoutput>) was not accepted.  
	Check the path and also access restrictions. 
	<p>
	<cfabort>
</cfif>

<cfset eGoodsFile = 'None'>

<cfset CategoryList = "^" & #replace(form.Category, ",", "^", "ALL")# & "^">
<cfset itemstatus = 'active'>
<!---Loop over the category list, if one is set to 0, then remove all the others and set the list to 0 and set the status to inactive--->

<cfloop from = "1" to = "#listlen(CategoryList, '^')#" index="c">
	<cfset thiscat = listgetat(CategoryLIst, c, "^")>
	<cfif thiscat is '0'>
		<cfset CategoryList = '0'>
		<cfset itemstatus = 'inactive'>
	</cfif>
</cfloop>

<cfif len(form.unitsinstock) GT 0>
	<cfset UnitStock = '#form.UnitsInStock#'>
</cfif>

<cfif UnitsinStock LT 1>
	<cfset UnitStock = 1>
</cfif>

<cfset ashowprice = 'No'>
<cfset ashowwsprice = 'No'>
<cfset ashowlistprice = 'No'>
<cfset ashowimage = 'No'>
<cfset ashowtitle = 'No'>

<cfif ISDEFINED('form.showprice')><cfset ashowprice = 'Yes'></cfif>
<cfif ISDEFINED('form.showwholesaleprice')><cfset ashowwsprice = 'Yes'></cfif>
<cfif ISDEFINED('form.showlistprice')><cfset ashowlistprice = 'Yes'></cfif>
<cfif ISDEFINED('form.showimage')><cfset ashowimage = 'Yes'></cfif>
<cfif ISDEFINED('form.showtitle')><cfset ashowtitle = 'Yes'></cfif>

<cfset insertdate = now()>

<!---Check to see if there is an item with this productid already.  If so, then 
		make this one a sub item of that one--->

<!---Insert The New Product into the database --->
<cfquery name = "InsertProduct" Datasource = "#request.dsn#">
Insert INTO products
(productid, productname, price, BriefDescription, Details, UnitsInStock, UnitsSold, ImageURL, ThumbNail, 
Category, IsFeatured, weight, shippingcosts, supplierid, timesviewed, ChargeTaxes, ShowQuantity, 
ChargeShipping, CanBackOrder, eGoodFilename, showprice, showlistprice, showwsprice, showvoldiscounts, showimage, showaddtocartbutton,
showtitle, ordervalue, issubscription, DateAdded, sku, brand, subof, status, listprice, wholesaleprice, isgift)
VALUES
('#form.Newproductid#', '#form.NewProductName#', '#form.NewPrice#', '#form.BriefDescription#', '#form.Details#',
#UnitStock#, 0, '#Photo#', '#ThumbNail#', '#CategoryList#', 'No', '#form.weight#', 
'#form.ShippingCosts#', '#form.supplier#', '0', '#form.ChargeTaxes#', '#form.ShowQuantity#', '#form.ChargeShipping#', 
'#CanBackOrder#', '#eGoodsFile#', '#ashowprice#', '#ashowlistprice#', '#ashowwsprice#', '#form.showvoldiscounts#', '#ashowimage#',
'#form.showaddtocartbutton#', '#ashowtitle#', 1, '#form.issubscription#', #CreateODBCdatetime(insertdate)#, '#form.sku#', '#form.brand#', '#thissubof#', '#itemstatus#', '#form.newlistprice#', '#form.newwholesaleprice#', '#form.isgift#')
</cfquery>

<cfquery name = "FindProduct" datasource="#request.dsn#">
SELECT MAX(ItemID) 
AS MaxID 
FROM products
</cfquery>

<!---Insert into categories by looping over the categorylist if this is not a subitem--->
<cfif len(thissubof) LT 1>
	<cfloop from = "1" to = "#listlen(CategoryList, '^')#" index="c">
		<cfset thiscat = listgetat(CategoryList, c, "^")>
		
		<cfquery name = "qryInsertCategoryEntry" datasource="#request.dsn#">
		INSERT INTO product_categories
		(itemid, categoryid)
		VALUES
		(#FindProduct.MaxID#, #thiscat#)
		</cfquery>
	</cfloop>
</cfif>

<cfquery name = "SetNextOrderValue" datasource="#request.dsn#">
UPDATE products
SET OrderValue = #FindProduct.MaxID#
WHERE ItemID = #FindProduct.MaxID#
</cfquery>

<!---If it's not a sub item process the images for it (uploaded above)--->
<cfif len(thissubof) LT 1>
	<cfif isdefined('request.multipleimageupload')>
		<!---Upload an image for the specific product...for store using multiple image feature--->
		<cfif NOT form.FileContents IS ''>
	
			<cfinclude template = "../queries/qrycompanyinfo.cfm">
			<cfinclude template = "../queries/qryitemimages.cfm">
		
			<!---Get the next ordervalue for this image--->
			<cfset LastOrderValue = 0>
			<cfoutput query = "qry_Images">
				<cfset LastOrderValue = #OrderValue#>
			</cfoutput>
		
			<cfset NextOrderValue = LastOrderValue + 1>
			
			<cfinclude template = "../photomanager/actions/actProcessImage.cfm">
		
			<!---Insert the information into the database--->
			<cfquery name = "qry_InsertImageInfo" datasource = "#request.dsn#">
			INSERT INTO products_images
			(iFileName, Itemid, iHeight, iWidth, thumbHeight, thumbWidth, tinyHeight, tinyWidth, mediumHeight, mediumWidth, Ordervalue)
			VALUES
			('#photo#', '#FindProduct.MaxID#', '#iHeight#', '#iWidth#', '#ithumbHeight#', '#ithumbWidth#', '#itinyHeight#', '#itinyWidth#', '#iMediumHeight#', '#iMediumWidth#', #NextOrderValue#)
			</cfquery>
		</cfif>
	</cfif>
</cfif> <!---End if it's a sub item--->

<cfif NOT form.issubscription IS 'Yes'>
<cfoutput>
	<p align="center">The new item was added to your database!</p>
	<p align="center">#form.NewProductName#<br>
	<cfif thissubof IS ''>
		<img src = "#request.HomeURL#photos/small/#photo#">
	<cfelse>
		NOTE: This is a subitem of <i>Product ID #form.NewProductID#</i> because you duplicated a productid.
	</cfif>
<p align="center"><a href="doproducts.cfm?action=add">Add Another One</a></p>
</cfoutput>
</cfif>

<cfif form.issubscription IS 'Yes'>
	Since you have marked this item as a subscription item, you will need to specify the length of the subscription and what category or categories they will have permission to access upon a successful checkout.<form name = "form1" action="doproducts.cfm" method="POST">
	<cfinclude template = "../queries/qryusers.cfm">
	
	<cfoutput><input type = "hidden" name="ProductID" Value="#form.NewProductID#"></cfoutput>
	<input type = "hidden" name="ActionType" Value="Add">

	  <cfoutput>
  	   <cfset TodaysDate = Now()>
	   <cfset TodaysDate = #dateformat(TodaysDate, "yyyy-mm-dd")#>
	Expires on: 
    <select name="ExpireSelect">
      <option value = "Never" <cfif expiresselect IS 'Never'>selected</cfif>>Never</option>
      <option value = "Custom" <cfif expiresselect IS 'custom'>selected></cfif>>Specify 
      a date ---></option>
      <option value = '#dateformat(DateAdd("m", 1, TodaysDate), "yyyy-mm-dd")#' <cfif expiresselect IS '#DateAdd("m", 1, TodaysDate)#'>selected></cfif>>1 
      Month From Now</option>
      <option value = '#dateformat(DateAdd("m", 3, TodaysDate), "yyyy-mm-dd")#' <cfif expiresselect IS '#DateAdd("m", 3, TodaysDate)#'>selected></cfif>>3 
      Months From Now</option>
      <option value = '#dateformat(DateAdd("m", 6, TodaysDate), "yyyy-mm-dd")#' <cfif expiresselect IS '#DateAdd("m", 6, TodaysDate)#'>selected></cfif>>6 
      Months From Now</option>
      <option value = '#dateformat(DateAdd("yyyy", 1, TodaysDate), "yyyy-mm-dd")#' <cfif expiresselect IS '#DateAdd("yyyy", 1, TodaysDate)#'>selected></cfif>>1 
      Year From Now</option>
      <option value = '#dateformat(DateAdd("m", 2, TodaysDate), "yyyy-mm-dd")#' <cfif expiresselect IS '#DateAdd("yyyy", 2, TodaysDate)#'>selected></cfif>>2 
      Years From Now</option>
    </select>
    </cfoutput>
	<cfoutput><input name="ExpiresOn" type="text" id="ExpiresOn" size="10" Value='#expireson#'></cfoutput><a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=ExpiresOn&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false"><img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a>
	<p>Permissions:<br>
	<cf_PermissionsCategoryTree Directory="/"
	ShowCurrentView="Yes"
	Datasource="#request.dsn#"
	SelectedItem=""
	ShowBullet="No"
	ProductID="#form.Newproductid#">
	<input type = "hidden" name = "sku" value = "#form.sku#" />
	<input type="hidden" name="action" value="SetSubscriptionItem">
	<input name = "submit" value="Set Subscription Information" Type="submit">
  </form>
</cfif>
















