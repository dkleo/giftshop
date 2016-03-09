<!---this queries only items that are options--->
<cfparam name = "searchquery" default="null">
<cflock scope="Session" type="Readonly" timeout="10">
  <cfset TempVar.SortOption = '#session.SortOption#'>
</cflock>

<!---If there is no search passed then query the items in this category--->
<cfif request.dbtype IS 'mysql'>
	<cfif searchquery IS 'null'>
		<cfquery name = "qryCatalog" datasource="#request.dsn#">
		SELECT * FROM products JOIN product_categories ON products.itemid = product_categories.itemid
		<cfif TempVar.SortOption IS 'OutOfStock'>
        WHERE products.unitsinstock < 1 AND products.isoption = 1
		<cfelseif TempVar.SortOption IS 'Featured'>
        WHERE products.IsFeatured = 'Yes' AND products.isoption = 1
        <cfelseif TempVar.SortOption IS 'Inactive'>
        WHERE product_categories.categoryid = 0 AND products.isoption = 1
        <cfelseif TempVar.SortOption IS 'All'>
        WHERE products.isoption = 1
        <cfelse>
        <!---otherwise select the category called--->
        WHERE product_categories.categoryid = #tempvar.sortoption# AND products.isoption = 1
        </cfif>
		GROUP BY products.productid
		<cfif NOT ISDEFINED('url.orderby')>
		  ORDER By ProductName ASC 
		</cfif>
		<cfif ISDEFINED('url.orderby')>
		  ORDER By #url.orderby# ASC 
		</cfif>	
		</cfquery>
        
    <cfelse>
        <cfquery name = "qryCatalog" Datasource = "#request.dsn#">
        SELECT * 
        FROM products
        WHERE LOWER(ProductID) LIKE '%#lcase(SearchQuery)#%' OR LOWER(ProductName) LIKE '%#lcase(SearchQuery)#%' OR LOWER(sku) LIKE '%#lcase(SearchQuery)#%' 
        </cfquery>
     </cfif>   
</cfif>

<!---MSACCESS--->
<cfif request.dbtype IS 'msaccess'>
	<cfif searchquery IS 'null'>
        <cfquery name = "qryAllItems" datasource="#request.dsn#">
        SELECT * FROM products WHERE isoption = 1
        </cfquery>
        
        <cfset collist = qryAllItems.Columnlist>
        <cfset collist = replacenocase(collist, "itemid", "products.itemid", "ALL")>
               
        <cfquery name = "qryCatalog" datasource="#request.dsn#">
		SELECT #collist# FROM products 
		<cfif NOT TempVar.sortoption IS 'All' AND NOT TempVar.sortoption IS 'OutOfStock' AND NOT TempVar.sortoption IS 'Featured'
		AND NOT TempVar.sortoption IS 'Inactive'>
        LEFT JOIN product_categories ON products.itemid = product_categories.itemid
		</cfif>
		<cfif TempVar.SortOption IS 'OutOfStock'>
        WHERE products.unitsinstock < 1 AND len(products.subof) < 1
		<cfelseif TempVar.SortOption IS 'Featured'>
        WHERE IsFeatured = 'Yes' AND len(products.subof) < 1
        <cfelseif TempVar.SortOption IS 'Inactive'>
        WHERE product_categories.categoryid = 0 AND len(products.subof) < 1
        <cfelseif TempVar.SortOption IS 'All'>
        WHERE len(subof) < 1
		<cfelse>
        <!---otherwise select the category called--->
        WHERE product_categories.categoryid = #tempvar.sortoption# AND len(products.subof) < 1
        </cfif>
		<cfif NOT ISDEFINED('url.orderby')>
		  ORDER By products.ProductName ASC 
		</cfif>
		<cfif ISDEFINED('url.orderby')>
		  ORDER BY #url.orderby# ASC 
		</cfif>	
		</cfquery>
        
    <cfelse>
        <cfquery name = "qryCatalog" Datasource = "#request.dsn#">
        SELECT * 
        FROM products
        WHERE LOWER(ProductID) LIKE '%#lcase(SearchQuery)#%' OR LOWER(ProductName) LIKE '%#lcase(SearchQuery)#%' OR LOWER(sku) LIKE '%#lcase(SearchQuery)#%' 
        </cfquery>
     </cfif>   
</cfif>















