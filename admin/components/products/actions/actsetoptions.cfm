<!---remove all options from this item--->

<cfquery name = "qryDeleteOptions" datasource="#request.dsn#">
DELETE FROM products_options
WHERE itemid = #form.itemid#
</cfquery>

<cfif isdefined('form.optionchecked')>
	<cfloop from = "1" to="#listlen(form.optionchecked)#" index="i">
		<cfset thisoption = listgetat(form.optionchecked, i)>
        
        <cfquery name = "qryInsertOption" datasource="#request.dsn#">
        INSERT INTO products_options
        (itemid, optionid)
        VALUES
        (#form.itemid#, #thisoption#)
        </cfquery>
	</cfloop>
</cfif>

<cfif isdefined('form.listoptions')>
	<cfquery name = "Updateoptions" datasource="#request.dsn#">
	UPDATE products
	SET listoptions = 'No'
	WHERE ItemID = #form.ItemID#
	</cfquery>
</cfif>

<cfif NOT isdefined('form.listoptions')>
	<cfquery name = "Updateoptions" datasource="#request.dsn#">
	UPDATE products
	SET listoptions = 'Yes'
	WHERE ItemID = #form.ItemID#
	</cfquery>
</cfif>
    
<!---Make all items in this category have this same option drop down box--->
<cfif IsDefined('Form.MakeSame')>
	<cfif NOT form.SameCategory IS 'Entire Catalog'>
		<cflock scope = "session" timeout="10" type="exclusive">
			<cfset session.SortOption = form.SameCategory>
		 </cflock>

	   <!---get the other items in this category--->
        <cfinclude template = "../queries/qrycatalog.cfm">

		<cfloop query = "qryCatalog">

            <cfquery name = "qryDeleteOptions" datasource="#request.dsn#">
            DELETE FROM products_options
            WHERE itemid = #qryCatalog.itemid#
            </cfquery>
            
            <cfif isdefined('form.optionchecked')>
                <cfloop from = "1" to="#listlen(form.optionchecked)#" index="i">
                    <cfset thisoption = listgetat(form.optionchecked, i)>
                    
                    <cfquery name = "qryInsertOption" datasource="#request.dsn#">
                    INSERT INTO products_options
                    (itemid, optionid)
                    VALUES
                    (#qryCatalog.itemid#, #thisoption#)
                    </cfquery>
                </cfloop>
            </cfif>			

			<!---If the options aren't to be listed then update that too--->
			<cfif isdefined('form.listoptions')>
				<cfquery name = "Updateoptions" datasource="#request.dsn#">
				 UPDATE products
				 SET listoptions = 'No'
				 WHERE ItemID = #qryCatalog.ItemID#
				</cfquery>
			</cfif>

			<cfif NOT isdefined('form.listoptions')>
				<cfquery name = "Updateoptions" datasource="#request.dsn#">
					UPDATE products
					SET listoptions = 'Yes'
					WHERE ItemID = #qryCatalog.ItemID#
				</cfquery>
			</cfif>
            
		</cfloop>
	</cfif>

<!---if all are to be made the same in the entire catalog then loop over entire catalog--->
	<cfif form.SameCategory IS 'Entire Catalog'>
		
	   <!---get the other items in this category--->
        <cfquery name = "qryCatalog" datasource="#request.dsn#">
        SELECT * FROM products
        </cfquery>

		<cfloop query = "qryCatalog">

            <cfquery name = "qryDeleteOptions" datasource="#request.dsn#">
            DELETE FROM products_options
            WHERE itemid = #qryCatalog.itemid#
            </cfquery>
            
            <cfif isdefined('form.optionchecked')>
                <cfloop from = "1" to="#listlen(form.optionchecked)#" index="i">
                    <cfset thisoption = listgetat(form.optionchecked, i)>
                    
                    <cfquery name = "qryInsertOption" datasource="#request.dsn#">
                    INSERT INTO products_options
                    (itemid, optionid)
                    VALUES
                    (#qryCatalog.itemid#,#thisoption#)
                    </cfquery>
                </cfloop>
            </cfif>			

			<!---If the options aren't to be listed then update that too--->
			<cfif isdefined('form.listoptions')>
				<cfquery name = "Updateoptions" datasource="#request.dsn#">
				 UPDATE products
				 SET listoptions = 'No'
				 WHERE ItemID = #qryCatalog.ItemID#
				</cfquery>
			</cfif>

			<cfif NOT isdefined('form.listoptions')>
				<cfquery name = "Updateoptions" datasource="#request.dsn#">
					UPDATE products
					SET listoptions = 'Yes'
					WHERE ItemID = #qryCatalog.ItemID#
				</cfquery>
			</cfif>
            
		</cfloop>
	</cfif>
</cfif><!---end if make the same is found--->

<cfif ISDEFINED('form.WasSearch')>
	<cfoutput>
    	<cflocation url="doproducts.cfm?action=edit&ItemID=#form.ItemID#&WasSearch=yes">
    </cfoutput>
</cfif>

<cfif NOT ISDEFINED('form.WasSearch')>
	<cfoutput>
    	<cflocation url="doproducts.cfm?action=edit&ItemID=#form.ItemID#">
    </cfoutput>
</cfif>
















