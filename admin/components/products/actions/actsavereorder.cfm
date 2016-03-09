<!---This saves the order of the categories--->

<!---loops over each element in the CategoryOrderBox listbox and then update the category with a new
	 order value depending on its location in the listbox--->
<cfparam name = "sortoption" default="featured">

<cfif NOT sortoption IS 'Featured'>
    <cfloop from = "1" to="#ListLen(form.CategoryOrderBox)#" index="ordercount">
        <cfset ThisCatID = #ListGetAt(form.CategoryOrderBox, ordercount)#>
    
        <cfquery name = "qrySetOrderValue" datasource="#request.dsn#">
        UPDATE product_categories
        SET OrderValue = #ordercount#
        WHERE ItemID = #ThisCatID# AND categoryid = #SortOption#
        </cfquery> 
        
        <cfquery name = "qrySetOrderValue" datasource="#request.dsn#">
        UPDATE products
        SET fOrderValue = #ordercount#
        WHERE ItemID = #ThisCatID#
        </cfquery>          
         
    </cfloop>
</cfif>

<cfif sortoption IS 'Featured'>
    <cfloop from = "1" to="#ListLen(form.CategoryOrderBox)#" index="ordercount">
        <cfset ThisCatID = #ListGetAt(form.CategoryOrderBox, ordercount)#>
        <cfquery name = "qrySetOrderValue" datasource="#request.dsn#">
        UPDATE products
        SET fOrderValue = #ordercount#
        WHERE ItemID = #ThisCatID#
        </cfquery>   
    </cfloop>
</cfif>

<center><h2>Order saved!</h2></center>
<p>
<cflocation url = "doproducts.cfm?action=ChangeOrder&sortoption=#url.sortoption#&ordersaved=true">















