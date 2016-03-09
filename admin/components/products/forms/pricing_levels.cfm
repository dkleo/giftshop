<cfparam name = "itemid" default="0">

<!---get item info--->
<cfquery name = "qItem" datasource="#request.dsn#">
SELECT * FROM products where itemid = #itemid#
</cfquery>

<style type="text/css">
<!--
.style3 {color: #FFFFFF; font-weight: bold; }
-->
</style>
<h2><strong>Pricing Levels</strong></h2>
<p>Item Name: <cfoutput>#qItem.productname#</cfoutput><br>
Sku:<br>
  Default Price (level 0):</p>
<form name="form1" method="post" action="">
  <p><strong>Add Price Level</strong></p>
  <p>Level: 
    <input name="level" type="text" id="level" value="1" size="10">
    * 
    Price: 
    <input type="text" name="price" id="price">
    <input type="submit" name="button" id="button" value="Add Pricing Level">
  </p>
  <p>*Specifying a level that already exists will overwrite the price.</p>
</form>
<table width="450" border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td bgcolor="#000000"><span class="style3">Level</span></td>
    <td bgcolor="#000000"><span class="style3">Price</span></td>
    <td bgcolor="#000000">&nbsp;</td>
  </tr>
  <tr>
    <td>#level#</td>
    <td>#price#</td>
    <td><div align="center">Delete</div></td>
  </tr>
</table>
<p>&nbsp;</p>
















