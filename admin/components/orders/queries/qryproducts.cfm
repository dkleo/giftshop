<cflock scope="Session" type="Readonly" timeout="10">
  <cfset TempVar.SortOption = '#session.SortOption#'>
</cflock>

<cfif NOT ISDEFINED('url.ItemID')>

<cfif NOT ISDEFINED('form.SearchQuery') AND NOT ISDEFINED('url.SearchQuery')>

	<cfif NOT TempVar.SortOption IS 'Featured' AND NOT TempVar.SortOption IS 'OutofStock' 
		AND NOT TempVar.SortOption IS 'All' AND NOT TempVar.SortOption IS 'Inactive'>
		<cfquery name = "qryAllproducts" Datasource = "#request.dsn#">
		SELECT * FROM products 
		</cfquery>		
	</cfif>

	<cfif TempVar.SortOption IS 'Featured'>
		<cfquery name = "qryproducts" Datasource = "#request.dsn#">
		SELECT * FROM products 
   	    WHERE IsFeatured = 'Yes'
		<cfif NOT ISDEFINED('url.orderby')>
		  ORDER By ProductName ASC 
		</cfif>
		<cfif ISDEFINED('url.orderby')>
		  ORDER By #url.orderby# ASC 
		</cfif>
		</cfquery>
	</cfif>
	
	<cfif TempVar.SortOption IS 'Inactive'>
		<cfquery name = "qryproducts" Datasource = "#request.dsn#">
		SELECT * FROM products 
   	    WHERE Category = '^0^'
		<cfif NOT ISDEFINED('url.orderby')>
		  ORDER By ProductName ASC 
		</cfif>
		<cfif ISDEFINED('url.orderby')>
		  ORDER By #url.orderby# ASC 
		</cfif>
		</cfquery>
	</cfif>

	<cfif TempVar.SortOption IS 'OutOfStock'>
		<cfquery name = "qryproducts" Datasource = "#request.dsn#">
		SELECT * FROM products 
		WHERE UnitsInStock < 1 
		<cfif NOT ISDEFINED('url.orderby')>
		  ORDER By ProductName ASC 
		</cfif>
		<cfif ISDEFINED('url.orderby')>
		  ORDER By #url.orderby# ASC 
		</cfif>
		</cfquery>
	</cfif>

    <cfif ISDEFINED('form.NewProductID')>
		<cfquery name = "qryproducts" Datasource = "#request.dsn#">
		SELECT * FROM products 
		WHERE ProductID = '#form.NewProductID#'
		</cfquery>
	</cfif>

	<cfif ISDEFINED('url.ItemID')>
		<cfquery name = "qryproducts" Datasource = "#request.dsn#">
		SELECT * FROM products 
		WHERE ItemID = #url.itemid# 
		</cfquery>
	</cfif>

	<cfif TempVar.SortOption IS 'All'>
	  <cfquery name = "qryproducts" Datasource = "#request.dsn#">
	  SELECT * FROM products 
	  <cfif ISDEFINED('url.ItemID')>
		WHERE ItemID = #url.itemid# 
	  </cfif>
		<cfif NOT ISDEFINED('url.orderby')>
		  ORDER By ProductName ASC 
		</cfif>
		<cfif ISDEFINED('url.orderby')>
		  ORDER By #url.orderby# ASC 
		</cfif>
	  </cfquery>
	</cfif>
		
	<cfif ISDEFINED('url.DeleteID')>
	  <cfquery name = "qryproducts2" Datasource = "#request.dsn#">
		  SELECT * FROM products WHERE ItemID = #url.Deleteid# 
	  </cfquery>
	</cfif>
</cfif>

<cfif ISDEFINED('form.SearchQuery')>
	<cfquery name = "qryproducts" Datasource = "#request.dsn#">
	SELECT * 
	FROM products
	WHERE ProductID LIKE '%#form.SearchQuery#%' OR ProductName LIKE '%#form.SearchQuery#%' 
	</cfquery>
</cfif>

<cfif ISDEFINED('url.SearchQuery')>
	<cfquery name = "qryproducts" Datasource = "#request.dsn#">
	SELECT * 
	FROM products
	WHERE ProductID LIKE '%#url.SearchQuery#%'  OR ProductName LIKE '%#url.SearchQuery#%' 
	</cfquery>
</cfif>

<cfif NOT ISDEFINED('form.SearchQuery') AND NOT ISDEFINED('url.SearchQuery')>

  <cfif NOT TempVar.SortOption IS 'Featured' AND NOT TempVar.SortOption IS 'OutofStock' 
	AND NOT TempVar.SortOption IS 'All' AND NOT TempVar.SortOption IS 'Inactive'>
	<!---This code below builds a query of products that match the selected category--->
	<cfset LItemID = "">
	<cfset LProductID = "">
	<cfset LProductName = "">
	<cfset LPrice = "">
	<cfset LThumbNail = "">
	<cfset LImageURL = "">
	<cfset LBriefDescription = "">
	<cfset LIsFeatured = "">
	<cfset LCategory = "">
	<cfset LSupplierID = "">	
	<cfset LOrderID = "">
	<cfset LUnitsInstock = "">	
	<cfset LTimesViewed= "">
	<cfset LUnitsSold= "">	
	
	<cfset qryproducts = QueryNew("")>
	
	<cfoutput query = "qryALLproducts">
	
	<!---Get the category list for this product and loop over the list.  If the list contains
	the selected category, add it to the query of products to display--->
	<cfset CategoryList = '#Category#'>
	  <cfloop index="Mycount" From="1" To='#ListLen(CategoryList, "^")#'>	
	<cfset ThisCategory = '#ListGetAt(CategoryList, mycount, "^")#'>
	
	<cfif ThisCategory IS #TempVar.SortOption#>
		  
	<cfset LItemID = ListAppend(LItemID, "#ItemID#", "|")>
	<cfset LProductID = ListAppend(LProductID, "#ProductID#", "|")>
	<cfset LProductName = ListAppend(LProductName, "#ProductName#", "|")>
	<cfset LPrice = ListAppend(LPrice, "#Price#", "|")>
	<cfset LThumbNail = ListAppend(LThumbNail, "#ThumbNail#", "|")>
	<cfset LImageURL = ListAppend(LImageURL, "#ImageURL#", "|")>
	<cfset LBriefDescription = ListAppend(LBriefDescription, "#BriefDescription#", "|")>
	<cfset LIsFeatured = ListAppend(LIsFeatured, "#IsFeatured#", "|")>
	<cfset LCategory = ListAppend(LCategory, "#Category#", "|")>
	<cfset LSupplierID = ListAppend(LSupplierID, "#SupplierID#", "|")>	
	<cfset LOrderID = ListAppend(LOrderID, "#OrderValue#", "|")>
	<cfset LUnitsInStock = ListAppend(LUnitsInStock, "#UnitsInStock#", "|")>		
	<cfset LTimesViewed = ListAppend(LTimesViewed, "#TimesViewed#", "|")>
	<cfset LUnitsSold = ListAppend(LUnitsSold, "#UnitsSold#", "|")>		
	</cfif>
	</cfloop>
	</cfoutput>
	
	<cfset AItemID = ListToArray(LItemID, "|")>
	<cfset AProductID = ListToArray(LProductID, "|")>
	<cfset AProductName = ListToArray(LProductName, "|")>
	<cfset APrice = ListToArray(LPrice, "|")>
	<cfset AThumbNail = ListToArray(LThumbNail, "|")>
	<cfset AImageURL = ListToArray(LImageURL, "|")>
	<cfset ABriefDescription = ListToArray(LBriefDescription, "|")>
	<cfset AIsFeatured = ListToArray(LIsFeatured, "|")>
	<cfset ACategory = ListToArray(LCategory, "|")>
	<cfset ASupplierID = ListToArray(LSupplierID, "|")>
	<cfset AOrderID = ListToArray(LOrderID, "|")>
	<cfset AUnitsInStock = ListToArray(LUnitsInStock, "|")>
	<cfset ATimesViewed = ListToArray(LTimesViewed, "|")>
	<cfset AUnitsSold = ListToArray(LUnitsSold, "|")>	

	<!---Now create a query based on the list values above--->
	<cfset nColumnNumber1 = QueryAddColumn(qryproducts, "ItemID", AItemID)>
	<cfset nColumnNumber2 = QueryAddColumn(qryproducts, "ProductID", AProductID)>
	<cfset nColumnNumber3 = QueryAddColumn(qryproducts, "ProductName", AProductName)>
	<cfset nColumnNumber4 = QueryAddColumn(qryproducts, "Price", APrice)>
	<cfset nColumnNumber5 = QueryAddColumn(qryproducts, "ThumbNail", AThumbNail)>
	<cfset nColumnNumber6 = QueryAddColumn(qryproducts, "BriefDescription", ABriefDescription)>
	<cfset nColumnNumber7 = QueryAddColumn(qryproducts, "IsFeatured", AIsFeatured)>
	<cfset nColumnNumber8 = QueryAddColumn(qryproducts, "ImageURL", AImageURL)>
	<cfset nColumnNumber9 = QueryAddColumn(qryproducts, "Category", ACategory)>
	<cfset nColumnNumber10 = QueryAddColumn(qryproducts, "SupplierID", ASupplierID)>
	<cfset nColumnNumber11 = QueryAddColumn(qryproducts, "OrderValue", AOrderID)>
	<cfset nColumnNumber12 = QueryAddColumn(qryproducts, "UnitsInStock", AUnitsInStock)>
	<cfset nColumnNumber13 = QueryAddColumn(qryproducts, "TimesViewed", ATimesViewed)>
	<cfset nColumnNumber14 = QueryAddColumn(qryproducts, "UnitsSold", ATimesViewed)>
  </cfif>
</cfif>

</cfif>

<cfif ISDEFINED('url.ItemID')>

	<cfquery name = "qryproducts" datasource="#request.dsn#">
	SELECT * FROM products
	WHERE ItemID = #url.ItemID#
	</cfquery>

</cfif>

















