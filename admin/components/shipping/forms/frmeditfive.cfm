<cfinclude template="../queries/qrytablefive.cfm">
<cfinclude template = "../queries/qryshippingtypes.cfm">

<div>
<form method="POST" action="doshipping.cfm">
  <div align="center">
      <h2>Editing Shipping Table</h2>
  </div>
  <cfoutput query = "qryTableFive"> 
    <div align="center">
    <center>
        <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="##111111" width="75%" id="AutoNumber1">
          <tr> 
            <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##000080"><b> 
              <font color="##FFFFFF">Shipping Type</font></b></td>
              <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##000080"><b> 
                <font color="##FFFFFF">Min Price</font></b></td>
              <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##000080"><b> 
                <font color="##FFFFFF">Max Price</font></b></td>
            <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##000080"><b> 
              <font color="##FFFFFF">Amount </font></b></td>
          </tr>
          <tr> 
            <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
               <select name = "ShippingType" id="ShippingType">
			  <cfloop query = "QryShippingTypes"><option <cfif #qryShippingTypes.ShippingType# IS #qryTableFive.ShippingType#>SELECTED</cfif>>#qryShippingTypes.ShippingType#</option></cfloop></select></td>
            <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
              <p align="center"> 
                <input type="text" name="MinPrice" size="7" value="#MinPrice#">
            </td>
            <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
              <p align="center"> 
                <input type="text" name="MaxPrice" size="7" value="#MaxPrice#">
            </td>
            <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
              <p align="center"><font color="##FFFFFF">
              <input type="text" name="Amount" size="9" value="#Amount#">
              <label>
               <select name="AmountType" id="AmountType">
                 <option value="Price" <cfif AmountType IS 'Price'>SELECTED</cfif>>$</option>
                 <option value="Percent" <cfif AmountType IS 'Percent'>SELECTED</cfif>>%</option>
               </select>
              </label>
</font><span style="color: ##FFFFFF">*</span></td>
          </tr>
        </table>
        <b><sup>*</sup>Note:&nbsp; Do not worry if your currency is not '$'.&nbsp; 
        Just enter a number.</b>
</center>
  </div>
  <p align="center">
  <input type="Hidden" value="#url.shippingid#" name="ShippingID">
  <input type="hidden" value="UpdateFive" name="action">
  <input type="submit" value="Update Custom Table" name="UpdateShipping"></p>
  </cfoutput>
</form>
</div>
