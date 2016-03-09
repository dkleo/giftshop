<!---create a temporary variable to keep from accessing the session variable over and over--->
<cflock scope="Session" type="Readonly" timeout="10">
  <cfset TempVar.SortOption = '#session.SortOption#'>
</cflock>

<!---If an particular item is not called then query the database based on the sort option selected--->
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
   	    WHERE Category = '0'
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


<!---Build a query based on teh category that is being viewed.  Have to do this in order to maintain
	compatability with Access and MySQL and allow products to be assigned to multiple categories.  Loop
	over the category list for each product and see if this product is in the currently viewed category.
	If so, add it to the custom query--->
	
<cfif NOT ISDEFINED('form.SearchQuery') AND NOT ISDEFINED('url.SearchQuery')>

  <cfif NOT TempVar.SortOption IS 'Featured' AND NOT TempVar.SortOption IS 'OutofStock' 
	AND NOT TempVar.SortOption IS 'All' AND NOT TempVar.SortOption IS 'Inactive'>
	<!---This code below builds a query of products that match the selected category--->

	<!---Set Vars--->
	<cfset qryproducts = QueryNew("")>
	<cfset listofvars = "">
	<cfset listofcols = "">
	<cfset listofarrays = "">

<cfloop from = "1" to="#listlen(qryAllProducts.columnlist)#" index="lst">
	<cfset thiscol = #listgetat(qryAllProducts.columnlist, lst)#>
	<cfset thisvar = "L#thiscol#">
	<cfset listofvars = ListAppend(listofvars, thisvar, "|")>
	<cfset listofcols = ListAppend(listofcols, thiscol, "|")>
	<cfset "L#thiscol#" = "">
</cfloop>


<cfoutput query = "qryAllProducts">
	<!---Get the category list for this product and loop over the list.  If the list contains
	the selected category, add it to the query of products to display--->
	<cfset CategoryList = '#Category#'>
   <cfloop index="mycount" From="1" To='#ListLen(CategoryList, "^")#'>	

	<cfset ThisCategory = '#ListGetAt(CategoryList, mycount, "^")#'>

	<cfif #ThisCategory# IS '#TempVar.SortOption#'>
	<!---Create lists for each field to be added to the custom query--->	  
			<!---Loop over the list of variables and insert and append to each one--->
			<cfloop from = "1" to="#listlen(listofvars, '|')#" index="v">
				<cfset thisvar = listgetat(listofvars, v, '|')>
				<!---get the corresponding column name in the db--->
				<cfset thiscol = listgetat(listofcols, v, '|')>
				<cfset valuetoget = "qryAllProducts.#thiscol#">
				<cfset "#thisvar#" = listappend(evaluate(thisvar), evaluate(valuetoget), '|')>
			</cfloop>	
	</cfif>
	</cfloop>
	</cfoutput>

	<!---Now make each list an array so it can be converted into a column in the custom query--->
	<cfloop from = "1" to="#listlen(listofvars, '|')#" index="v">
		<cfset thisvar = listgetat(listofvars, v, '|')>
		<cfset thiscol = listgetat(listofcols, v, '|')>
		<cfset thisarray = listtoarray(evaluate(thisvar), '|')>
		<cfset arrayname = "A#thiscol#">
		<cfset "#arrayname#" = #thisarray#>
		<cfset listofarrays = listappend(listofarrays, "#arrayname#", "|")>
	</cfloop>
	
	<!---insert each array into the query--->
	<cfloop from = "1" to="#listlen(listofarrays, '|')#" index="v">
		<cfset thisarray = listgetat(listofarrays, v, '|')>
		<cfset thiscol = listgetat(listofcols, v, '|')>
		<cfset "nColumnNumber#v#" = QueryAddColumn(qryProducts, "#thiscol#", #evaluate(thisarray)#)>
	</cfloop>
  </cfif>
</cfif>

</cfif>
<!---End if no itemid variable is defined--->

<!---an item id was passed to the query so query the database for that particular item--->
<cfif ISDEFINED('url.ItemID')>
	<cfquery name = "qryproducts" datasource="#request.dsn#">
	SELECT * FROM products
	WHERE ItemID = #url.ItemID#
	</cfquery>
</cfif>



















