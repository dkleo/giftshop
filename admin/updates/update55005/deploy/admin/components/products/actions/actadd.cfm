<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfparam name = "expiresselect" default="Never">
<cfparam name = "expireson" default="">
<cfparam name = "UnitsInStock" default="#request.defaultstockvalue#">
<cfparam name = "Photo" default = 'nopic.jpg'>
<cfparam name = "Thumbnail" default = 'nopic.jpg'>
<cfparam name = "template_id" default="0">

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
        <!---Try Uploading the file to the large directory directory--->
        <cfif directoryexists('#request.catalogpath#photos#request.bslash#large#request.bslash#')>
            <cffile action="Upload"
            FileField = "form.filecontents"
            Destination = "#request.catalogpath#photos#request.bslash#large#request.bslash#"
            NameConflict = "overwrite"
            Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg, image/png"
            mode="777">
            
            <cfset Photo = '#cffile.Serverfile#'>
            <cfset Thumbnail = '#cffile.Serverfile#'>
            
        <cfelse>
            <cfset Photo = 'nopic.jpg'>
            <cfset Thumbnail = 'nopic.jpg'>
            
            <center><strong>The image upload failed because the path was not found (#request.catalogpath#photos#request.bslash#large#request.bslash#)</strong></center>
            <center><strong>Check your configuration file and make sure you specified the correct path</strong></center>
        </cfif>
    </cfif>
</cfif>

<cfset itemstatus = 'active'>

<cfif len(form.unitsinstock) GT 0>
	<cfset UnitStock = '#form.UnitsInStock#'>
</cfif>

<cfif UnitsinStock LT 1>
	<cfset UnitStock = 1>
</cfif>

<cfset ashowprice = form.showprice>
<cfset ashowwsprice = form.showwsprice>
<cfset ashowlistprice = form.showlistprice>
<cfset ashowimage = form.showimage>
<cfset ashowtitle = form.showtitle>

<cfset insertdate = now()>

<cfif form.brand IS 'Other'>
	<cfset newbrand = form.otherbrand>
<cfelse>
	<cfset newbrand = form.brand>
</cfif>

<cfif form.mfg IS 'Other'>
	<cfset newmfg = form.othermfg>
<cfelse>
	<cfset newmfg = form.mfg>
</cfif>

<cfif form.availability IS 'Other'>
	<cfset newavailability = form.otheravailability>
<cfelse>
	<cfset newavailability = form.availability>
</cfif>

<!---set next order value--->
<cfset NextItemOrderVal = 1>
<cfoutput query = "qryAllProducts" maxrows="1">
	<cfset NextItemOrderVal = fOrderValue + 1>
</cfoutput>


<!---Insert The New Product into the database --->
<cfquery name = "InsertProduct" Datasource = "#request.dsn#">
Insert INTO products
(productid, productname, price, BriefDescription, Details, UnitsInStock, UnitsSold, ImageURL, ThumbNail, 
IsFeatured, weight, shippingcosts, supplierid, timesviewed, ChargeTaxes, ShowQuantity, 
ChargeShipping, CanBackOrder, showprice, showlistprice, showwsprice, showvoldiscounts, showimage, showaddtocartbutton,
showtitle, fordervalue, issubscription, DateAdded, sku, brand, subof, status, listprice, wholesaleprice, isgift, availability, mfg, reviews, upc, OneClickOrdering, isoption, AskForShipping)
VALUES
('#form.Newproductid#', '#form.NewProductName#', '#form.NewPrice#', '#form.BriefDescription#', '#form.Details#',
#UnitStock#, 0, '#Photo#', '#ThumbNail#', 'No', '#form.weight#', 
'#form.ShippingCosts#', '#form.supplier#', '0', '#form.ChargeTaxes#', '#form.ShowQuantity#', '#form.ChargeShipping#', 
'#CanBackOrder#', '#ashowprice#', '#ashowlistprice#', '#ashowwsprice#', '#form.showvoldiscounts#', '#ashowimage#',
'#form.showaddtocartbutton#', '#ashowtitle#', #NextItemOrderVal#, '#form.issubscription#', #CreateODBCdatetime(insertdate)#, '#form.sku#', '#newbrand#', '#thissubof#', '#itemstatus#', '#form.newlistprice#', '#form.newwholesaleprice#', '#form.isgift#', '#newavailability#', '#newmfg#', 0, '#form.upc#', '#form.OneClickOrdering#', #form.isoption#, '#form.askforshipping#')
</cfquery>

<cfquery name = "FindProduct" datasource="#request.dsn#">
SELECT itemid, productname
FROM products
WHERE sku = '#form.sku#'
</cfquery>

<cfset linkalias = form.newproductname>
<cfset linkalias = replace(linkalias, " ", "-", "ALL")>
<cfset linkalias = replace(linkalias, "'", "", "ALL")>
<cfset linkalias = replace(linkalias, "!", "", "ALL")>
<cfset linkalias = replace(linkalias, "@", "", "ALL")>
<cfset linkalias = replace(linkalias, "$", "", "ALL")>
<cfset linkalias = replace(linkalias, "%", "", "ALL")>
<cfset linkalias = replace(linkalias, "^", "", "ALL")>
<cfset linkalias = replace(linkalias, "*", "", "ALL")>
<cfset linkalias = replace(linkalias, "(", "", "ALL")>	
<cfset linkalias = replace(linkalias, ")", "", "ALL")>
<cfset linkalias = replace(linkalias, "/", "", "ALL")>	
<cfset linkalias = replace(linkalias, "\", "", "ALL")>
<cfset linkalias = replace(linkalias, "|", "", "ALL")>
<cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
<cfset linkalias = replace(linkalias, ">", "", "ALL")>    
<cfset linkalias = replace(linkalias, ";", "", "ALL")>
<cfset linkalias = replace(linkalias, ":", "", "ALL")>
<cfset linkalias = replace(linkalias, '"', "", "ALL")>
<cfset linkalias = replace(linkalias, ".", "", "ALL")>	
<cfset linkalias = replace(linkalias, ",", "", "ALL")> 

<cfset newline = "ReWriteRule ^#linkalias#$ index.cfm?action=viewdetails&itemid=#FindProduct.itemid# ">

<cfquery name = "qSetAlias" datasource="#request.dsn#">
UPDATE products SET urlrw = '#linkalias#'
WHERE itemid = #FindProduct.itemid#
</cfquery>

<cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes">

<!---Insert into categories by looping over the categorylist if this is not a subitem--->
<cfif len(thissubof) LT 1>
<cfset CategoryList = "|" & #replace(form.Category, ",", "|", "ALL")# & "|">
	<cfloop from = "1" to = "#listlen(CategoryList, '|')#" index="c">
		<cfset thiscat = listgetat(CategoryList, c, "|")>
		
		<cfquery name = "qryInsertCategoryEntry" datasource="#request.dsn#">
		INSERT INTO product_categories
		(itemid, categoryid, ordervalue)
		VALUES
		(#FindProduct.itemid#, #thiscat#, #NextItemOrderVal#)
		</cfquery>
	</cfloop>
</cfif>

<!---If it's not a sub item process the images for it (uploaded above)--->
<cfif len(thissubof) LT 1>
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
        
        <cfinclude template = "../photomanager/actions/actprocessimage.cfm">
    
        <!---Insert the information into the database--->
        <cfquery name = "qry_InsertImageInfo" datasource = "#request.dsn#">
        INSERT INTO products_images
        (iFileName, Itemid, iHeight, iWidth, thumbHeight, thumbWidth, tinyHeight, tinyWidth, mediumHeight, mediumWidth, Ordervalue)
        VALUES
        ('#photo#', '#FindProduct.ItemID#', '#iHeight#', '#iWidth#', '#ithumbHeight#', '#ithumbWidth#', '#itinyHeight#', '#itinyWidth#', '#iMediumHeight#', '#iMediumWidth#', #NextOrderValue#)
        </cfquery>
    </cfif>
</cfif> <!---End if it's a sub item--->

<!---If the items was marked as a subscription item then insert info into subscription table (the r_startupfee is set to whatever the price is)
The extra fields are not used in this application.  They are there for expansion/customization purposes only.  Subscription have to be manually
renewed by customers in this application.--->
<cfif form.issubscription IS 'Yes'>
    <cfquery name = "qryInsertSubscription" datasource="#request.dsn#">
    INSERT INTO products_subscriptions
    (itemid, r_name, r_startupfee, r_fee, r_frequency, r_expiresin)
    VALUES
    ('#findproduct.itemid#', '#findproduct.productname#', '#form.newprice#', '#form.r_fee#', '#r_frequency#', '#form.r_expiresin#')
    </cfquery>
</cfif>

<!---write the details html to the server--->
<cfif directoryexists('#request.catalogpath##request.bslash#docs#request.bslash#')>
	<cfif NOT directoryexists('#request.catalogpath#docs#request.bslash#products#request.bslash#')>
    	<cfdirectory action="create" directory="#request.catalogpath#docs#request.bslash#products#request.bslash#" mode="666">
    </cfif>
	
    <cffile action="write" file="#request.catalogpath#docs#request.bslash#products#request.bslash#item#findproduct.itemid#.cfm" output="#form.details#" mode="666">

<cfelse>
	Failed to write the details HTML because the path #request.catalogpath#docs#request.bslash#products#request.bslash# seems to be inaccessible.  Please check your setting.
	<p>&nbsp;</p>
</cfif>

<cfif isdefined('form.saveastemplate')>
	<cfinclude template = "actsaveastemplate.cfm">
</cfif>

<cfoutput>
<h2>Adding a Product</h2>
	<p>The new item was added to your database!</p>
	<p>#form.NewProductName#<br>
	<cfif thissubof IS ''>
		<img src = "#request.HomeURL#photos/small/#photo#">
	<cfelse>
		NOTE: This is a subitem of <i>Product ID #form.NewProductID#</i> because you duplicated a productid.
	</cfif>
<p><a href="doproducts.cfm?action=new&template_id=#template_id#">Add Another One</a></p>
</cfoutput>