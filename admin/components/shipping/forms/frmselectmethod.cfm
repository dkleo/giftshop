<!---This form allows the user to select the method by which they want to calculate
shipping--->

<!---Shipping Method Codes:

1 = NOTHING
2 = Based on Total Amount of Order
3 = Based on Percentage of the order
4 = Flat Rate Shipping (FOR US/CANADA) In/Out of State Rates
5 = Weight Calculations (Custom Table)
6 = Based on Quantity of Items Ordered
7 = DISABLED - NO SHIPPING CALCULATIONS
8 = Specify a flat rate for each item
9 = reserved for USPS
10 = UPS
11 = FEDEX
--->

<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfoutput Query="qryCompanyInfo">
<cfset MyShippingMethod = #ShippingType#>
</cfoutput>
<h4>Select the method you would like to use in calculating rates for products you will be shipping. <cfoutput><a href = "#request.AdminPath#helpdocs/shipping_method.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></h4>
<form method="POST" action="doshipping.cfm">
  <table width="100%" border="0" cellspacing="3" cellpadding="3">
    <tr> 
      <td width="5%" height="25"><p> 
          <input type="radio" value="2" name="ShippingType" <cfif #MyShippingMethod# IS '2'>Checked</cfif>>
        </p></td>
      <td width="95%"><strong>Build a table to charge a certain amount based on the total of the order [</strong><a href="doshipping.cfm?action=EditOne">Edit 
        Table</a><strong>]</strong></td>
    </tr>
    <tr> 
      <td><input type="radio" value="3" name="ShippingType" <cfif #MyShippingMethod# IS '3'>Checked</cfif>>      </td>
      <td><strong>Build a table to charge a certain percentage  based on the total of the order  [</strong><a href="doshipping.cfm?action=EditTwo">Edit 
        Table</a><strong>]</strong></td>
    </tr>
    <tr>
      <td><input type="radio" value="9" name="ShippingType" <cfif #MyShippingMethod# IS '9'>Checked</cfif> /></td>
      <td><strong>Build a mixed table (amount/percentage) based on the amount of the order [</strong><a href="doshipping.cfm?action=EditFive">Edit 
      Table</a><strong>]</strong></td>
    </tr>
    <tr> 
      <td width="5%"><input type="radio" name="ShippingType" value="4" <cfif #MyshippingMethod# IS '4'>checked</cfif>>      </td>
      <td width="95%"><strong>Use a flat rate charge: One rate for in state and one rate for 
        out of state orders) [</strong><a href="doshipping.cfm?action=EditFlat">Edit 
        Table</a><strong>]</strong></td>
    </tr>
    <tr> 
      <td><input type="radio" name="ShippingType" value="5" <cfif #MyshippingMethod# IS '5'>checked</cfif>>      </td>
      <td><strong>Build a table to charge a rate based on the total weight of the order [</strong><a href="doshipping.cfm?action=EditCustom">Edit 
        Table</a><strong>]</strong></td>
    </tr>
    <tr> 
      <td><input type="radio" name="ShippingType" value="6" <cfif #MyshippingMethod# IS '6'>checked</cfif>>      </td>
      <td><strong>Build a table to charge a rate based on quantity of items ordered [</strong><a href="doshipping.cfm?action=EditQuantityTable">Edit 
        Table</a><strong>]</strong></td>
    </tr>
    <tr> 
      <td><input type="radio" name="ShippingType" value="8" <cfif #MyshippingMethod# IS '8'>checked</cfif>>      </td>
      <td><strong>Specify a flat shipping rate for each item (You will specify the shipping for each item in the catalog).</strong></td>
    </tr>
    <tr>
      <td><input type="radio" name="ShippingType" value="10" <cfif #MyshippingMethod# IS '10'>checked</cfif>></td>
      <td><strong>Real-Time UPS Shipping Calculations [</strong><a href="doshipping.cfm?action=SetupUPS">Setup</a><strong>]</strong></td>
    </tr>
    <tr>
      <td><input type="radio" name="ShippingType" value="11" <cfif #MyshippingMethod# IS '11'>checked</cfif> /></td>
      <td><span style="font-weight: bold">Real-Time Fedex Shipping Calculations [</span><a href="doshipping.cfm?action=SetupFEDEX">Setup</a><span style="font-weight: bold">]</span></td>
    </tr>
    <tr> 
      <td><input type="radio" name="ShippingType" value="7" <cfif #MyshippingMethod# IS '7'>checked</cfif>>      </td>
      <td><strong>No Shipping on Products you will ship.</strong></td>
    </tr>
  </table>
  <div align="center">
    <input type="hidden" value="SetMethod" Name="Action">
    <input type="Submit" value="Set Shipping Method" Name="S1">
  </div>
</form>
