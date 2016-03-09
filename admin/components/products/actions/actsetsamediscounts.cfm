<!---as a safety feature to prevent accidental change the form field "MakeSame" must be present (it's
the checkbox) in order for this to work--->

<cfif ISDEFINED('form.MakeSame')>
<!---This file gives either all the products in a specific category the same discounts or all products
   in the catalog the same discounts as the one selected on the discounts form.  This is called from the
   discounts form--->

<!---Set the master category--->
<cfset MasterCategory = '#form.SameCategory#'>

<cfquery name="qryFindProduct" datasource="#request.dsn#">
SELECT * FROM products
WHERE itemid = #form.itemid#
</cfquery>

<!---get all other items in this category--->
<cfquery name="qryItemsInCategory" datasource="#request.dsn#">
SELECT * FROM product_categories
WHERE itemid <> #form.itemid# AND categoryid = #MasterCategory#
</cfquery>

<cfquery name="qrydiscounts" datasource="#request.dsn#">
SELECT * FROM discounts
WHERE itemid = '#form.itemid#'
ORDER BY MinQ DESC
</cfquery>

<cfloop query = "qryItemsInCategory">

<!---Loop over each volume discount for the master product and insert a new row into the database
    for each product in the category selected--->
	<cfquery name = "DeleteCurrentdiscountsforThisItem" datasource="#request.dsn#">
	DELETE FROM discounts 
	WHERE ItemID = '#qryItemsInCategory.ItemID#'
	</cfquery>
    <cfset mycount = 0>
	<cfloop query = "qrydiscounts">
		<cfset mycount = mycount + 1>
		<cfquery name="AddDiscount" datasource="#request.dsn#">
		INSERT INTO discounts
		(DiscountType, AmountOff, MinQ, ItemID)
		VALUES
		('#qrydiscounts.DiscountType#', '#qrydiscounts.AmountOff#', '#qrydiscounts.MinQ#', '#qryItemsInCategory.ItemID#')
		</cfquery>
	</cfloop>

</cfloop>

<p align="center"><strong>Discounts Have Been Duplicated!</strong></p>
</cfif>

<cfif NOT isdefined('form.MakeSame')>
<p align="left"><h2>OOPS!</h2></p>
<p align="left"><strong>The button you just pushed makes all items in the specified category have the 
same volume discounts as the selected product!  Nothing was changed, however, because you did not put a
checkmark in the box provided.  If you really wanted to set all the discounts the same as this one, then 
hit your browsers back button and put a checkmark in the box provided, then hit the button again.</strong></p>
</cfif>















