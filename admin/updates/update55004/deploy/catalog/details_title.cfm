<!---shows the product brand, title and sku--->
<cfset ParentName = ProductName>
<cfif NOT qryproducts.showtitle IS 'No'>
	<cfoutput>
    <div class="details_brand">#brand#</div>
	<div class="details_item_name">#ItemParentName##ProductName#</div>
	<div class="details_sku">#SKU#</div>
	</cfoutput>
</cfif>