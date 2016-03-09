<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qryProducts" datasource="#request.dsn#">
SELECT * FROM products
WHERE itemid = #url.deleteid#
</cfquery>

<!---Delete the product after confirmation--->
<cfif NOT isdefined ('url.Confirm')>
  <p align = "center">Confirm Delete</p>
  <p align = "center"><cfoutput query="qryproducts">You are deleting #ProductName#</cfoutput></p>
  
	<p align="center"><strong>Are you sure you want to delete this Product?</strong><br>
    <cfoutput><a href="doproducts.cfm?action=Delete&DeleteID=#url.DeleteID#&Confirm=Yes<cfif ISDEFINED('url.WasSearch')>&WasSearch=Yes</cfif>">Yes</a></cfoutput> 
    | <a href="doproducts.cfm<cfif ISDEFINED('url.WasSearch')>?action=search</cfif>">No</a>
    <cfabort>
    </p>
</cfif>

<cfif isdefined('url.Confirm')>

    <cfquery name = "Deleteproduct" datasource = "#request.dsn#">
    DELETE FROM products 
    WHERE ItemID = #url.DeleteID# 
    </cfquery>
    
    <cfquery name = "Deleteproduct" datasource = "#request.dsn#">
    DELETE FROM product_categories 
    WHERE ItemID = #url.DeleteID# 
    </cfquery>

    <cfquery name = "Deleteproduct" datasource = "#request.dsn#">
    DELETE FROM product_reviews 
    WHERE ItemID = #url.DeleteID# 
    </cfquery>

    <cfquery name = "Deleteproduct" datasource = "#request.dsn#">
    DELETE FROM products_images 
    WHERE ItemID = #url.DeleteID# 
    </cfquery>
    
    <!---delete the details files for this one if it exists--->
    <cfif fileexists('#request.catalogpath#docs#request.bslash#products#request.bslash#item#url.Deleteid#.cfm')>
        <cffile action = "delete" file="#request.catalogpath#docs#request.bslash#products#request.bslash#item#url.deleteid#.cfm">
    </cfif>
    
    <cfif NOT ISDEFINED('url.WasSearch')>
    	<cflocation url="doproducts.cfm">
    </cfif>
    
    <cfif ISDEFINED('url.WasSearch')>
    	<cflocation url="doproducts.cfm?action=search">
    </cfif>

</cfif>















