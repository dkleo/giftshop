<cfparam name = "searchquery" default="null">

<!---If there is no search passed then query the items in this category--->
<cfif request.dbtype IS 'mysql'>
    <cfquery name = "qryProducts" datasource="#request.dsn#">
    SELECT * FROM products JOIN product_categories ON products.itemid = product_categories.itemid
    WHERE product_categories.categoryid = #form.categoryid#
    GROUP BY products.productid
    ORDER By ProductName ASC 
    </cfquery>   
</cfif>

<!---MSACCESS--->
<cfif request.dbtype IS 'msaccess'>
    <cfquery name = "qryAllItems" datasource="#request.dsn#">
    SELECT * FROM products
    </cfquery>
    
    <cfset collist = qryAllItems.Columnlist>
    <cfset collist = replacenocase(collist, "itemid", "products.itemid", "ALL")>
           
    <cfquery name = "qryProducts" datasource="#request.dsn#">
    SELECT #collist# FROM products 
    WHERE product_categories.categoryid = #form.categoryid# AND len(products.subof) < 1
    ORDER By products.ProductName ASC 
    </cfquery>       
</cfif>



















