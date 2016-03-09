<!---side-by-side view of items in a category--->
<cfparam name = "category" default = "0">
<cfif NOT qryCatalog.RecordCount IS 0>
<tr>
	<td>
<cfset prodcount = 0>

<table align="center" border="0" cellpadding="0" cellspacing="6" width="100%">
<cfset mycount = 0>
<tr>
<td></td>
</tr>
<tr>

<cfloop query = "qryCatalog" startrow="#start#" endrow="#end#">

<cfinclude template = "../queries/qryreviews.cfm">

<cfquery name = "ProductQuery" datasource="#request.dsn#">
SELECT * FROM products WHERE itemid = <cfqueryparam value="#qryCatalog.Itemid#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput query = "ProductQuery">

	<cfif request.use_urlrewrite IS 'Yes'>
        <cfset prod_link = "#request.absolutepath##urlrw#?category=#url.category#&viewby=#viewby#&sortorder=#sortorder#&carttoken=#carttoken#">
    <cfelse>
		<cfset prod_link = "index.cfm?carttoken=#carttoken#&action=ViewDetails&ItemID=#ItemID#&category=#url.category#&viewby=#viewby#&sortorder=#sortorder#">
    </cfif>

	<!---for pricing levels--->
    <cfif request.pricinglevel GT 0>
        
        <cfset levelprice = ProductQuery.price>
        
        <cfquery name = "qPrice" datasource="#request.dsn#">
        SELECT * FROM products_pricing
        WHERE itemid = '#ProductQuery.itemid#'
        AND level = #request.pricinglevel#
        </cfquery>
        
        <cfoutput query = "qPrice">
            <cfset levelprice = qPrice.price>
        </cfoutput>
    </cfif>

      <td valign="top">
        <center>
        <table width="130" height="225" align = "center" border="0" cellpadding="3" cellspacing="0" class="Image_Window">
          <!--DWLayoutTable-->
          <tr> 
            <td valign="top" width="130">
			<Table align = "center" border="0">
            <tr>
			<td valign="top" align="center" width="130"><p align="center">
            <cfinclude template = "../queries/qrycompanyinfo.cfm">
            
          <!---query images for this item and get the first one to 
			use for the thumbnail--->
            <cfset thisitemid = productquery.itemid>
            <cfinclude template = "../queries/qryProductimages.cfm">
            			
            <cfif qry_ProductImages.recordcount IS 0>
                <cfset TheThumbnail = "photos/small/nopic.jpg">
            </cfif>
            
            <cfloop query = "qry_ProductImages" startrow="1" endrow="1">
                <cfset TheThumbnail = "photos/small/#qry_ProductImages.iFileName#">
            </cfloop>
            
	           <div style="vertical-align:middle; text-align:center">
               <a href = "#prod_link#"><img src="#TheThumbnail#" Alt="Click for more information" border="0" <cfif qry_ProductImages.tinywidth GT 75>width="75"</cfif> /></a>
				</div>  
            </td>
			</tr>
			<tr>
			<td valign="top" height="81" width="130"><p align="center">
			<a href = "#prod_link#"><b>#replace(ProductName, "/", "/ ", "ALL")#</b></a><b><br>
			<cfif NOT request.ShowProductID IS 'No'>
			Sku: #sku#<br />
			</cfif>
            <cfinclude template = "showrating.cfm"><b>
            

			<!---CHECK FOR A SALE--->
            <cfset OriginalPrice = '#Price#'>

			<cfif request.pricinglevel GT 0>        
                <cfset OriginalPrice = levelprice>
            </cfif>

            <cfset TheItemID = '#ItemID#'>
            <cfset TheCategoryID = '#Category#'>           
            <cfset SalePrice = OriginalPrice>
            <cfset TodaysDate = #Now()#>
            <cfset TodaysDate = dateformat(TodaysDate, "mm/dd/yyyy")>
            
            <cfif NOT ProductQuery.isgift IS 'Yes'>
                <cfinclude template = "../cart/crtCheckForSale.cfm">
            </cfif>
            <!---END CHECK FOR A SALE--->

			<cfif OriginalPrice GT 0>
                  <cfif SalePrice IS OriginalPrice>
                  <p align="center">
                    <cfif request.EnableEuro IS 'Yes'>
                      #LSEuroCurrencyformat(OriginalPrice, "Local")#
                      <cfelse>
                      #LSCurrencyformat(OriginalPrice, "Local")#
                    </cfif>
                  </cfif>
                  <cfif NOT SalePrice IS OriginalPrice>
                  <center>
                      <font color="##FF0000" size="1">ON SALE</font>
                    <br />
                    <cfif request.EnableEuro IS 'Yes'><font size = "3">
                      #LSEuroCurrencyformat(SalePrice, "Local")# 
                          <cfelse>
                      #LSCurrencyformat(SalePrice, "Local")#</font>
                    </cfif>
                    </center>
                </cfif><!---End if original price GT 0--->				
            </cfif>	
            </p>
            
<!---if it's out of stock show that it is (if inventory is turned on or it's a doba item--->

<p>	
<cfif NOT request.EnableInventory IS 'No'>
	<cfif UnitsInStock LT 1>
		<center><font color="##FF0000">Out of Stock</font></center>
	</cfif>
</cfif>

</td>
</tr>
</Table>
</td>
</tr>
</table></center>
</td>
<cfset mycount = mycount + 1>
<cfif mycount IS #request.SideBySideCols#>
<tr>
<cfset mycount = 0>
</tr></cfif>
</cfoutput>
</cfloop>
<tr>
<td>
</td></tr>
</table>
</cfif>



