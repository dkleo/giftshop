<cfparam name = "itemid" default="0">
<cfparam name = "level" default="1">

<cfif isdefined("form.level")>
	<cfif isnumeric(form.level) AND isnumeric(form.price)>	
        <cfquery name="qDelete" datasource="#request.dsn#">
        DELETE FROM products_pricing
        WHERE itemid = '#form.itemid#' AND level = #form.level#
        </cfquery>
        
        <cfquery name="qInsertLevel" datasource="#request.dsn#">
        INSERT INTO products_pricing
        (level, price, itemid)
        VALUES
        (#form.level#, #form.price#, '#form.itemid#')
        </cfquery>

		<cfset level = form.level + 1>

	<cfelse>
    	You must enter numeric values only.  Do not insert a symbol.
    </cfif>
</cfif>

<cfif isdefined('url.delete')>
	<cfquery name = "qDelete" datasource="#request.dsn#">
    DELETE FROM products_pricing WHERE id = #url.id#
    </cfquery>
</cfif>


<!---get item info--->
<cfquery name = "qItem" datasource="#request.dsn#">
SELECT * FROM products where itemid = #itemid#
</cfquery>

<cfquery name = "qPricing" datasource="#request.dsn#">
SELECT * FROM products_pricing
WHERE itemid = '#itemid#'
</cfquery>

<style type="text/css">
<!--
.style3 {color: #FFFFFF; font-weight: bold; }
-->
</style>
<h2><strong>Pricing Levels</strong></h2>
<p>Item Name: <cfoutput>#qItem.productname#</cfoutput><br>
Sku: <cfoutput>#qItem.sku#</cfoutput><br>
  Default Price (level 0): <cfoutput>#qItem.price#</cfoutput></p>
<form name="form1" method="post" action="doproducts.cfm?action=pricinglevels">
  <p><strong>Add Price Level</strong></p>
  <p>Level: 
    <cfoutput><input name="level" type="text" id="level" value="#level#" size="6"></cfoutput>
    * 
    Price: 
    <input name="price" type="text" id="price" size="15">
    <cfoutput><input type = "hidden" name="itemid" value="#itemid#" /></cfoutput>
    <input type="submit" name="button" id="button" value="Add Pricing Level">
  </p>
  <p>*Specifying a level that already exists will overwrite the price.</p>
</form>
<table width="450" border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td width="86" bgcolor="#000000"><span class="style3">Level</span></td>
    <td width="152" bgcolor="#000000"><span class="style3">Price</span></td>
    <td width="176" bgcolor="#000000">&nbsp;</td>
  </tr>
  
  <cfoutput query = "qPricing">
  <tr>
    <td>#level#</td>
    <td>#numberformat(price, "0.00")#</td>
    <td><div align="center"><a href="doproducts.cfm?action=pricinglevels&amp;delete=yes&amp;id=#id#">Delete</a></div></td>
  </tr>
  </cfoutput>
  <cfif qPricing.recordcount IS 0>
  <tr>
  	<td colspan="3"><i>You have no pricing levels setup for this item.</i></td>
  </tr>
  </cfif>
</table>
<p>&nbsp;</p>
















