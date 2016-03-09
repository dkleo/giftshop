<!---attempts to assign products imported to categories --->
<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Assigning Items to Category Specified.  Please wait!';
</script>

<!---get only products that were imported--->
<cfif form.cat_assignmethod IS 'selectone'>
    <cfquery name = "qryCatalog" datasource="#request.dsn#">
    SELECT itemid,importkey FROM products WHERE importkey <> 'NONE'
    </cfquery>
    
    <cfset totalrecordstoimport = qryCatalog.recordcount>
    <cfset progresscount = 0>

<!---***if they are importing into a specific category then insert each item into the specified category***--->
	<cfloop query = "qryCatalog">
		<cfset progresscount = progresscount + 1>
       
		<!---because itemid's are unique and there might be some left over data in there, delete any records for currently passed
		itemid--->
		<cfquery name = "qryRemoveExisting" datasource="#request.dsn#">
        DELETE FROM product_categories
        WHERE itemid = #qryCatalog.ItemID#
        </cfquery>
		
        <!---insert record to assign to the category--->
		<cfquery name = "qryInsertIntoCategory" datasource="#request.dsn#">
        INSERT INTO product_categories
        (categoryid, itemid)
        VALUES
        (#form.DefaultCategory#, #qryCatalog.ItemID#)
        </cfquery>
    
		<!---Modify the progress bar--->
    
        <cfset ProgressPercentage = ProgressCount / TotalRecordsToImport>
        <cfset ProgressPercentage = ProgressPercentage * 100>
        <cfset ProgressPercentage = #Round(ProgressPercentage)#>
        
        <cfset NegProgress = 100 - ProgressPercentage>
        
        <cfoutput>
        
        <cfif ProgressPercentage LT 100>
        <script language="JavaScript">
            document.getElementById('progpos').style.width = "#ProgressPercentage#%";
            document.getElementById('progneg').style.width = "#NegProgress#%";
            document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Inserted into Categories';
        </script>
        </cfif>
        
        <cfif ProgressPercentage IS 100>
        <script language="JavaScript">
            document.getElementById('progpos').style.width = "#ProgressPercentage#%";
            document.getElementById('progneg').style.width = "#NegProgress#%";
            document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Process Completed!';
        </script>
        </cfif>
        </cfoutput>  
        <!---end progress bar update--->			
    
    </cfloop>
</cfif>

<!---***If they specified a column to determine what categories the products get assigned to, then use that***--->
<cfif form.cat_assignmethod IS 'usecolumn'>

	<!---select the chosen column from the import table--->
	<cfquery name = "qryTempData" datasource="#request.dsn#">
    SELECT CAT_IMPRT_ID,#form.category_guide# FROM temp_import
    </cfquery>
    
    <cfset totalrecordstoimport = qryTempData.recordcount>
    <cfset progresscount = 0>
    
	<cfloop query = "qryTempData">
		<cfset progresscount = progresscount + 1>

        <!---get currently passed items itemid--->
        <cfquery name = "qryProduct" datasource="#request.dsn#">
        SELECT itemid FROM products WHERE importkey = 'ImportRow#qryTempData.CAT_IMPRT_ID#'
        </cfquery>

		<cfset thisitemid = qryProduct.itemid>
        
        <!---get the value of the currently passed category--->
        <cfset ColName = "qryTempData.#form.category_guide#">
        <cfset ColValue = evaluate(ColName)>

		<!---doublecheck the category data and see if it's a list.  
		If it contains a different delimter (and not theirs) then they specified then change the delimter to what they said 
		it should be--->        
		<cfif NOT ColValue CONTAINS form.catval_del>
        	<cfset ColValue = replace(ColValue, ",", form.catval_del, "ALL")>
        	<cfset ColValue = replace(ColValue, "|", form.catval_del, "ALL")>
        	<cfset ColValue = replace(ColValue, "^", form.catval_del, "ALL")>
        </cfif>                       

        <!---loop over the value passed above and insert the item into the category (form.catval_del determins the delimiter)--->
        <cfloop from = "1" to = "#listlen(ColValue, form.catval_del)#" index="catcount">
        
            <cfset thiscategory = listgetat(ColValue, catcount, form.catval_del)>
            
           
            <!---if the categories are named, then we need to query the category table and find the id for this category--->
            <cfif form.catval_type IS 'type_name'>
                <cfquery name = "qryFindCategoryID" datasource="#request.dsn#">
                SELECT categoryid, categoryname FROM categories
                WHERE categoryname = '#thiscategory#'
                </cfquery>
                
                <!---if the category name is not found then the item is set to inactive--->
                <cfset thiscategoryid = 0>
                <cfoutput query = "qryFindCategoryID">
                    <cfset thiscategoryid = qryFindCategoryID.categoryid>
                </cfoutput>
            <cfelse>
                <!---otherwise, it is the id of the category so use that--->
                <cfquery name = "qryFindCategoryID" datasource="#request.dsn#">
                SELECT categoryid, categoryname FROM categories
                WHERE categoryid = #thiscategory#
                </cfquery>
                
                <!---if the categoryid is not found then the item is set to inactive--->
                <cfset thiscategoryid = 0>
                <cfoutput query = "qryFindCategoryID">
                    <cfset thiscategoryid = qryFindCategoryID.categoryid>
                </cfoutput>                         
            </cfif>      
            
            <!---insert the item into the category--->
            <cfquery name = "qryInsertIntoCategory" datasource="#request.dsn#">
            INSERT INTO product_categories
            (categoryid, itemid)
            VALUES
            (#thiscategoryid#, #thisitemid#) 
            </cfquery>
			            
		</cfloop>
			
			<!---Modify the progress bar--->
        
            <cfset ProgressPercentage = ProgressCount / TotalRecordsToImport>
            <cfset ProgressPercentage = ProgressPercentage * 100>
            <cfset ProgressPercentage = #Round(ProgressPercentage)#>
            
            <cfset NegProgress = 100 - ProgressPercentage>
            
            <cfoutput>
				<cfif ProgressPercentage LT 100>
                <script language="JavaScript">
                    document.getElementById('progpos').style.width = "#ProgressPercentage#%";
                    document.getElementById('progneg').style.width = "#NegProgress#%";
                    document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Inserted Into Categories';
                </script>
                </cfif>
                
                <cfif ProgressPercentage IS 100>
                <script language="JavaScript">
                    document.getElementById('progpos').style.width = "#ProgressPercentage#%";
                    document.getElementById('progneg').style.width = "#NegProgress#%";
                    document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Process Completed!';
                </script>
                </cfif>
            </cfoutput>  
            <!---end progress bar update--->	

    </cfloop>
</cfif>















