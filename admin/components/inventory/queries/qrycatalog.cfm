<!---If there is no search passed then query the items in this category--->
<cfif request.dbtype IS 'mysql'>
		<cfquery name = "qryCatalog" datasource="#request.dsn#">
		SELECT * FROM products JOIN product_categories ON products.itemid = product_categories.itemid
		<cfif SortOption IS 'OutOfStock'>
        WHERE products.unitsinstock < 1
        	<cfif viewtype IS 'OptionsOnly'>AND products.isoption = 1</cfif>
            <cfif viewtype IS 'ProductsOnly'>AND products.isoption = 0</cfif>
		<cfelseif SortOption IS 'Featured'>
        WHERE IsFeatured = 'Yes'
        	<cfif viewtype IS 'OptionsOnly'>AND products.isoption = 1</cfif>
            <cfif viewtype IS 'ProductsOnly'>AND products.isoption = 0</cfif>       
        <cfelseif SortOption IS 'Inactive'>
        WHERE product_categories.categoryid = 0
        	<cfif viewtype IS 'OptionsOnly'>AND products.isoption = 1</cfif>
            <cfif viewtype IS 'ProductsOnly'>AND products.isoption = 0</cfif>
        <cfelseif SortOption IS 'All'>
        	<cfif viewtype IS 'OptionsOnly'>WHERE products.isoption = 1</cfif>
            <cfif viewtype IS 'ProductsOnly'>WHERE products.isoption = 0</cfif>
        <cfelse>
        <!---otherwise select the category called--->
        WHERE product_categories.categoryid = #sortoption#
        	<cfif viewtype IS 'OptionsOnly'>AND products.isoption = 1</cfif>
            <cfif viewtype IS 'ProductsOnly'>AND products.isoption = 0</cfif>
        </cfif>
		GROUP BY products.productid
		<cfif NOT ISDEFINED('url.orderby')>
		  ORDER By ProductName ASC 
		</cfif>
		<cfif ISDEFINED('url.orderby')>
		  ORDER By #url.orderby# ASC 
		</cfif>	
		</cfquery>

		<!---query for search--->       
        <cfquery name = "qryCatalog" dbtype="query">
        SELECT * 
        FROM qryCatalog
        WHERE LOWER(ProductID) LIKE '%#lcase(SearchQuery)#%' OR LOWER(ProductName) LIKE '%#lcase(SearchQuery)#%' OR LOWER(sku) LIKE '%#lcase(SearchQuery)#%' 
        </cfquery>
</cfif>

<!---MSACCESS--->
<cfif request.dbtype IS 'msaccess'>
	<cfif searchquery IS 'null'>
        <cfquery name = "qryAllItems" datasource="#request.dsn#">
        SELECT * FROM products
		<cfif viewtype IS 'OptionsOnly'>WHERE products.isoption = 1</cfif>
        <cfif viewtype IS 'ProductsOnly'>WHERE products.isoption = 0</cfif>
        </cfquery>
        
        <cfset collist = qryAllItems.Columnlist>
        <cfset collist = replacenocase(collist, "itemid", "products.itemid", "ALL")>
               
        <cfquery name = "qryCatalog" datasource="#request.dsn#">
		SELECT #collist# FROM products 
		<cfif NOT sortoption IS 'All' AND NOT sortoption IS 'OutOfStock' AND NOT sortoption IS 'Featured'
		AND NOT sortoption IS 'Inactive'>
        LEFT JOIN product_categories ON products.itemid = product_categories.itemid
		</cfif>
		<cfif SortOption IS 'OutOfStock'>WHERE products.unitsinstock < 1 AND len(products.subof) < 1
		<cfelseif SortOption IS 'Featured'>
        WHERE IsFeatured = 'Yes' AND len(products.subof) < 1
        <cfelseif SortOption IS 'Inactive'>
        WHERE product_categories.categoryid = 0 AND len(products.subof) < 1
        <cfelseif SortOption IS 'All'>
        WHERE len(subof) < 1
		<cfelse>
        <!---otherwise select the category called--->
        WHERE product_categories.categoryid = #sortoption# AND len(products.subof) < 1
        </cfif>
		<cfif NOT ISDEFINED('url.orderby')>
		  ORDER By products.ProductName ASC 
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



















