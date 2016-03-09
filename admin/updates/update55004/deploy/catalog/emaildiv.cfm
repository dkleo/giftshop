<cfparam name = "thecategoryid" default="0">
<!---***for emailing items***--->
<div id = "email_details">
<cfsavecontent variable="emaileditem">
<style>
.emaildiv {font-family: Geneva, Arial, Helvetica, sans-serif;
font: Geneva, Arial, Helvetica, sans-serif;
font-size: 12px;}
</style>

<div id="emaildiv" class="emaildiv">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
	<cfif fileexists('#request.catalogpath#docs#request.bslash#emailitem_header.cfm')>
    <tr>
    <td colspan="2">
    	<cfinclude template = '../docs/emailitem_header.cfm'>
    </td>
    </tr>
    </cfif>
    <tr> 
<cfif NOT qryProducts.showimage IS 'No'>
      <td width="30%" valign="top" height="50" align="center">
      	<cfinclude template = "../queries/qryproductimages.cfm">
        <cfinclude template = "details_mainimage.cfm">
	</td>
</cfif>

<!---If this is a subitem then get it's parent info--->
<cfset ItemParentName = ''>
<cfif len(qryProducts.subof) GT 0>
	<cfquery name = "qryParent" datasource="#request.dsn#">
	SELECT * FROM products WHERE itemid = <cfqueryparam value="#qryProducts.subof#" cfsqltype="cf_sql_varchar">
	</cfquery>

	<cfoutput query = "qryParent">
	<cfset ItemParentName = '#ProductName# - '>
	</cfoutput>
</cfif>
      <td width="70%" height="50" valign="top" align="left">
<cfoutput query = "qryproducts">
	  <cfset ParentName = ProductName>
	   <cfif NOT qryproducts.showtitle IS 'No'>
			<p> <font size = "2">#brand#<br />
	        <b><strong><font size="4">#ItemParentName##ProductName#</font><br>
			<font size="3">#SKU#</font>
	</cfif> 
</cfoutput>
	  <!---Show the volume discount chart if one exists for this product--->
    <cfif NOT qrydiscounts.recordcount IS 0>
	<cfif NOT qryProducts.showvoldiscounts IS 'No'>
      <p>&nbsp;</p>
      <table width="95%" border = "1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000">
        <tr class="TableTitles"> 
          <td colspan="2">  
              <p><strong><a name="DiscountCharges"></a>Pricing</strong></p>
            </td>
        </tr>
        <tr> 
          <td width = "28%" height="32"><font size="2"><strong>Quantity 
              Ordered</strong></font></td>
          <td width = "31%"><font size="2"><strong>Price Each 
              </strong></font></td>
        </tr>
		<tr>
		<td height="32"><font size="2"><cfloop query="qrydiscounts" startrow="1" endrow="1"><cfoutput><cfset LastQ = #MinQ# - 1>#LastQ#</cfoutput></cfloop> or less</font></td>
		<td><font size="2"><cfoutput><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(qryproducts.Price, "Local")# 
        <cfelse>#LSCurrencyformat(qryproducts.Price, "Local")#</cfif></cfoutput></font></td>
		</tr>
		<cfset CurrentRow = 0>
        <cfoutput query = "qrydiscounts"> 
		<cfset CurrentRow = CurrentRow + 1>
		<cfset NextRow = CurrentRow + 1>
          <tr> 
            <td height="32"><font size="2">#MinQ# <cfloop query="qrydiscounts" StartRow="#NextRow#" EndRow="#NextRow#"><cfset LastQ = #MinQ# - 1> to #LastQ#</cfloop>
			<cfif CurrentRow IS qrydiscounts.RecordCount> or more</cfif></font></td>
            <cfif DiscountType IS 'Amount Off'>
              <cfset DiscountPrice = #qryproducts.Price# - #AmountOff#>
            </cfif>
            <cfif DiscountType IS 'Percent Off'>
              <cfset DiscountPrice = 	((#qryproducts.Price# * MinQ) - ((#qryproducts.Price# * #MinQ#) * #AmountOff#)) / #MinQ#>
            </cfif>
            <td><font size="2"> 
                <cfif request.EnableEuro IS 'Yes'>
                  #LSEuroCurrencyformat(DiscountPrice, "Local")# 
                  <cfelse>
                  #LSCurrencyformat(DiscountPrice, "Local")# 
                </cfif>
                </font></td>
            <cfset TotalPrice = #DiscountPrice# * #MinQ#>
          </tr>
        </cfoutput> </table>
	  </cfif>    
	</cfif>


<!---See if there are any subitems...if so then don't show an add to cart button, list then
below just above the details section.--->
<cfquery name = "qrySubs" datasource="#request.dsn#">
SELECT * FROM products WHERE subof = <cfqueryparam value="#qryproducts.itemid#" cfsqltype="cf_sql_varchar"> 
AND unitsinstock > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
ORDER BY price DESC
</cfquery>

<cfif qrySubs.recordcount GT 0>
<h4>Price:  See below</h4>
</cfif>

<cfoutput query = "qryproducts">

<cfset theitemid = itemid>
<cfinclude template = "../cart/crtcheckforsale.cfm">

<cfif qrySubs.recordcount IS 0>
 <cfif qrydiscounts.recordcount IS 0><!---If there are no vol discounts show the price--->
        <cfif NOT Price IS 0><!---If the price is not equal to zero show it--->
			<cfif NOT qryproducts.showprice IS 'no'><!---If the option of showing the price is no then don't show it--->
			  <cfif NOT OriginalPrice IS SalePrice>ON SALE!</cfif>
			  <br>
			  <h3>		  
					  <cfif SalePrice IS OriginalPrice>
						<cfif request.EnableEuro IS 'Yes'>
						  #LSEuroCurrencyformat(OriginalPrice, "Local")#
						  <cfelse>
						  #LSCurrencyformat(OriginalPrice, "Local")#
						</cfif>
					  </cfif>
					  <cfif NOT SalePrice IS OriginalPrice>
						<cfif request.EnableEuro IS 'Yes'>
						  <s><font color="##FF0000">#LSEuroCurrencyformat(OriginalPrice, "Local")#</font></s> 
							  <cfelse>
						  <s><font color="##FF0000">#LSCurrencyformat(OriginalPrice, "Local")#</font></s>
					    </cfif>
						<br>
						<cfif request.EnableEuro IS 'Yes'>
						  #LSEuroCurrencyformat(SalePrice, "Local")# 
							  <cfelse>
						  #LSCurrencyformat(SalePrice, "Local")#
					    </cfif>
					</cfif>		  
			  </h3> 
		</cfif>
    </cfif>
</cfif>
</cfif> <!---End if there are subs--->	  
        </strong></b><br>

<cfset isstocked = 'Yes'>

<!---If there are no sub items then show the availability--->
<cfif qrySubs.recordcount IS 0>
<!---If inventory is turned on and the user wants to show how many are available then show
item availability here--->
<cfif NOT request.EnableInventory IS 'No'>
	<cfif NOT request.ShowItemAvailability IS 'No'>
		<p> <b>Availability:</b>
		<cfif UnitsInStock LT 1 AND CanBackOrder IS 'No'><b><font color="##FF0000">Out of stock!</font></b><cfset isstocked = 'No'></cfif>	
		<cfif UnitsInStock LT 1 AND NOT CanBackOrder IS 'No'><b><font color="##0066CC">Back Order Only</font></b><cfset isstocked = 'Yes'></cfif>	
		<cfif NOT UnitsInStock LT 1><font color="##009900">#UnitsInStock# Available* </font>
		</cfif>
		<cfset isstocked = 'Yes'></p>
	  </cfif>
</cfif>

</cfif><!---cfif for the subs--->

</cfoutput>
<p>
 
  <!---If there are subitems under this on then this is the master item, so display all of them under this one with add to cart buttons--->
  
 <cfif qrySubs.recordcount GT 0>
  <tr>
  <td colspan="2" width="100%">
  	<table width="100%" cellpadding="4" cellspacing="0">
	<tr>
		<td width="25%" bgcolor="#CCCCCC"><strong>SKU</strong></td>
		<td bgcolor="#CCCCCC"><strong>Item</strong></td>
		<td width="10%" align="center" bgcolor="#CCCCCC"><strong>Price</strong></td>
	</tr>
  <cfoutput query = "qrySubs">
	<tr>
		<td width="15%">#SKU#</td>
		<td>#ProductName#</td>
		<td width="10%" align="center"><cfif request.EnableEuro IS 'Yes'>
		  #LSEuroCurrencyformat(Price, "Local")#
		  <cfelse>
		  #LSCurrencyformat(Price, "Local")#
		  </cfif></td>
	</tr>	
</cfoutput>
	</table>
  </td>
  </tr> 
</cfif>

<!---Show the product details--->  
	<cfoutput query = "qryproducts">
        <cfif NOT Details IS ''>
        <tr> 
          <td height="75" colspan="2" valign="top" align="left"><p><br>
		  #Details# 
		  </td>
        </tr>
        </cfif>
    </cfoutput>
	<cfif fileexists('#request.catalogpath#docs#request.bslash#emailitem_footer.cfm')>
    <tr>
    <td colspan="2">
    	<cfinclude template = '../docs/emailitem_footer.cfm'>
    </td>
    </tr>
    </cfif>
</table>
</div>
</cfsavecontent>
<!---***END EMAIL DIV***--->
</div>



