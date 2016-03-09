<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfparam name = "expiresselect" default="Never">
<cfparam name = "expireson" default="">

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

<cfset CategoryList = "|" & #replace(form.Category, ",", "|", "ALL")# & "|">

<cfset thissubof = "">
<cfset itemstatus = 'active'>

	<!---If the productid is in use assign the subof value to that productid, if not then set it to nothing 
	(meaning it's not a sub item--->
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
listoptions = '#form.listoptions#',
showprice = '#form.showprice#',
showimage = '#form.showimage#',
showtitle = '#form.showtitle#',
showwsprice = '#form.showwsprice#',
showlistprice = '#form.showlistprice#',
showvoldiscounts = '#form.showvoldiscounts#',
issubscription = '#form.issubscription#',
showaddtocartbutton = '#form.showaddtocartbutton#',
unitsinstock = '#form.unitsinstock#',
sku = '#form.sku#',
status = '#itemstatus#',
subof = '#thissubof#',
isgift = '#form.isgift#',
brand = '#newbrand#',
mfg = '#newmfg#',
availability = '#newavailability#',
OneClickOrdering = '#form.OneClickOrdering#',
AskForShipping = '#form.askforshipping#',
isoption = #form.isoption#
WHERE ItemID = #form.ItemID#
</cfquery>

<cfset unitstock = form.unitsinstock>

<!---Set which categories this belongs to--->
<!---Remove the item category references first (that way if it's a sub item it won't be counted
and it won't show up--->
<cfif len(thissubof) LT 1>
    <cfquery name = "qryDeleteFromCategories" datasource="#request.dsn#">
    DELETE FROM product_categories
    WHERE itemid = #form.itemid#
    </cfquery>

	<!---Loop over category list and insert a record for each category the item belongs to--->
    <cfloop from = "1" to = "#listlen(CategoryList, '|')#" index="c">
        <cfset thiscat = listgetat(CategoryList, c, "|")>
        
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
  
<!---If it's marked as a subscription item then insert info for it--->
<cfif form.issubscription IS 'Yes'>
	<!---If this item is being changed to a subscription item then insert it, otherwise update it--->
	<cfif form.r_id IS '0'>
		<cfif form.issubscription IS 'Yes'>
            <cfquery name = "qryInsertSubscription" datasource="#request.dsn#">
            INSERT INTO products_subscriptions
            (itemid, r_name, r_startupfee, r_fee, r_frequency, r_expiresin)
            VALUES
            ('#form.itemid#', '#form.newproductname#', '#form.newprice#', '#form.r_fee#', '#form.r_frequency#', '#form.r_expiresin#')
            </cfquery>
        </cfif>
	<cfelse>
        <cfquery name = "qryInsertSubscription" datasource="#request.dsn#">
        UPDATE products_subscriptions
        SET r_name = '#form.newproductname#' , 
        r_startupfee = '#form.newprice#', 
        r_fee = '#form.r_fee#', 
        r_frequency = '#form.r_frequency#',
        r_expiresin = '#form.r_expiresin#'
		WHERE r_id = #form.r_id#
        </cfquery>    
    </cfif>
</cfif>

<!---write the details html to the server--->
<cfif directoryexists('#request.catalogpath##request.bslash#docs#request.bslash#products#request.bslash#')>
	<cfif NOT directoryexists('#request.catalogpath#docs#request.bslash#products#request.bslash#')>
    	<cfdirectory action="create" directory="#request.catalogpath#docs#request.bslash#products#request.bslash#">
    </cfif>
	
    <cffile action="write" file="#request.catalogpath#docs#request.bslash#products#request.bslash#item#form.itemid#.cfm" output="#form.details#">

<cfelse>
	Failed to write the details HTML because the path #request.catalogpath#docs#request.bslash#products#request.bslash# seems to be inaccessible.  Please check your setting.
	<p>&nbsp;</p>
</cfif>

<cfset photo = ''>
<cfset thumbnail = ''>
<cfset ashowprice = form.showprice>
<cfset ashowwsprice = form.showwsprice>
<cfset ashowlistprice = form.showlistprice>
<cfset ashowimage = form.showimage>
<cfset ashowtitle = form.showtitle>
<cfset nextitemorderval = form.ordervalue>
<cfset insertdate = now()>

<cfset findproduct.itemid = form.itemid>
<cfif isdefined('form.saveastemplate')>
	<cfinclude template = "actsaveastemplate.cfm">
</cfif>

<h2>Editing an Item</h2>
<p><strong>Item was updated!</strong>
<cfif NOT ISDEFINED('form.WasSearch')>
<p><strong><a href="doproducts.cfm?#<cfoutput>#form.ItemID#</cfoutput>">Back 
  to products</a></strong></cfif>
<cfif ISDEFINED('form.WasSearch')>
<p><strong><a href="doproducts.cfm?action=Search#<cfoutput>#form.ItemID#</cfoutput>">Back 
  to products</a></strong></cfif>















