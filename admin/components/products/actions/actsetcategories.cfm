<!---remove the items from the current category first--->

<!---if they are not assigning items to inactive status then process normally--->
<cfif form.assignto NEQ '0'>

<!---remove all items listed first...this way if there are any unchecked they will be removed from this category (and the items gets set to inactive
if it's removed from all categories.--->
<cfif isdefined('form.removeditems')>
    <cfloop from = "1" to="#listlen(form.removeditems)#" index="rcount">
            <cfset thisitem = listgetat(form.removeditems, rcount)>
            <cfinclude template = "../queries/qry_itemcategories.cfm">
            
            <cfoutput query = "qryItemCategories2">
                <cfset CategoryList = #category#>
            </cfoutput>
            
            <!---first part deals with old category assignments method for backward compatability--->
            <!---remove this item from the category in the products table unless they have assignto set to inactive--->
            	<cfset remcat = '#form.assignto#^'>
            	<cfset NewCategoryList = replace(CategoryList, remcat, '', 'ALL')>
                <cfset thestatus = 'active'>
                
                <!---if the newcategorylist has zero elelments this this item should be set to inactive--->
			    <cfif listlen(NewCategoryList, "^") IS 0>
                	<cfset NewCategoryList = "^0^">
                	<cfset thestatus = 'inactive'>
				</cfif>

				<!---update category listing for backward compatability--->
                <cfquery name = "UpdateCategoryList" datasource="#request.dsn#">
                UPDATE products
                SET category = '#NewCategoryList#',
                status = '#thestatus#'
                WHERE itemid=#thisitem#
                </cfquery>								
                
				<!---remove item from category--->
                <cfquery name = "qryDeleteFromCategories" datasource="#request.dsn#">
                DELETE FROM product_categories
                WHERE itemid = #thisitem# AND categoryid = #form.assignto#
                </cfquery>               
    </cfloop>
</cfif>

<!---add any items into the selected category if applicable--->
<cfif isdefined('form.selecteditems')>
	<cfloop from = "1" to="#listlen(form.selecteditems)#" index="itemcount">
		<cfset thisitem = listgetat(form.selecteditems, itemcount)>
		
		<cfinclude template = "../queries/qry_itemcategories.cfm">
		
		<cfoutput query = "qryItemCategories2">
			<cfset CategoryList = #category#>
		</cfoutput>
		
		<!---Set categorylist to empty if this one is inactive (so it won't be inactive anymore)--->
		<cfif CategoryList IS '^0^'>
			<cfset CategoryList = ''>												
		</cfif>
		
	        <!---add this item into this category--->
			<cfset remcat = '#form.assignto#^'>
            <cfset NewCategoryList = replace(CategoryList, remcat, '', 'ALL')>        
			<cfset NewCategoryList = ListAppend(NewCategoryList, #form.AssignTo#, "^")>
    
            <cfquery name = "UpdateCategoryList" datasource="#request.dsn#">
            UPDATE products
            SET category = '#NewCategorylist#',
            status = 'active'
            WHERE itemid = #thisitem#
            </cfquery>

			<!---delete it first to prevent duplicate entries--->
            <cfquery name = "qryRemoveFromInactive" datasource="#request.dsn#">
            DELETE FROM product_categories
            WHERE itemid = #thisitem# AND categoryid = #form.assignto#
            </cfquery>
                                    
            <cfquery name = "qryInsertCategoryEntry" datasource="#request.dsn#">
            INSERT INTO product_categories
            (itemid, categoryid)
            VALUES
            (#thisitem#, #form.assignto#)
            </cfquery>
			
            <!---remove any with categoryid set to 0 so it's not inactive anymore--->
            <cfquery name = "qryRemoveFromInactive" datasource="#request.dsn#">
            DELETE FROM product_categories
            WHERE itemid = #thisitem# AND categoryid = 0
            </cfquery>
            
	</cfloop>
</cfif>

<!---now check on each one...if no entry is found in product_categories then insert a reference to it in product_categories and set categoryid to 0
indicating it's inactive--->
<cfloop from = "1" to="#listlen(form.removeditems)#" index="rcount">
    <cfset thisitem = listgetat(form.removeditems, rcount)>
	
    <cfquery name = "qryItemsInCategories" datasource="#request.dsn#">
    SELECT * FROM product_categories
    WHERE itemid = #thisitem#
    </cfquery>
    
    <cfif qryItemsInCategories.recordcount IS 0>
        <!---item wasn't found so set it to inactive--->
        <cfquery name = "qryInsertCategoryEntryInactive" datasource="#request.dsn#">
        INSERT INTO product_categories
        (itemid, categoryid)
        VALUES
        (#thisitem#, 0)
        </cfquery>

	</cfif>
                  
</cfloop>

</cfif><!---end if not assignto is inactive--->

<!---if it's set to inactive (form.assignto is 0) then remove the items from all categories--->
<cfif form.assignto IS '0'>
<cfif isdefined('form.selecteditems')>
	<cfloop from = "1" to="#listlen(form.selecteditems)#" index="itemcount">
        <cfset thisitem = listgetat(form.selecteditems, itemcount)>
        
        <cfquery name = "UpdateCategoryList" datasource="#request.dsn#">
        UPDATE products
        SET category = '^0^',
        status = 'inactive'
        WHERE itemid=#thisitem#
        </cfquery>													
    
        <!---Remove this item from all categories and assign it to 0 (inactive)--->
        <cfquery name = "qryDeleteFromCategories" datasource="#request.dsn#">
        DELETE FROM product_categories
        WHERE itemid = #thisitem#
        </cfquery>
        
        <cfquery name = "qryInsertCategoryEntry" datasource="#request.dsn#">
        INSERT INTO product_categories
        (itemid, categoryid)
        VALUES
        (#thisitem#, 0)
        </cfquery>
                
	</cfloop>
</cfif>
</cfif>

<cflocation url = "doproducts.cfm?action=categories&assignto=#form.assignto#&sortoption=#form.sortoption#&updated=yes">
