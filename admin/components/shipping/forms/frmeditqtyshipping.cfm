<cfinclude template="../queries/qrytablefour.cfm">
<cfinclude template = "../queries/qryshippingtypes.cfm">

<form method="POST" action="doshipping.cfm">
  <div align="center">
    <h2>Quantity Shipping Table</h2>
  </div>
  <cfoutput query = "qryTableFour"> 
    <div align="center">
    <center>
        <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="##111111" width="75%" id="AutoNumber1">
          <tr>
            <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##000080">&nbsp;</td>
            <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##000080"><b> 
              <font color="##FFFFFF">Min Qty</font></b></td>
            <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##000080"><b> 
              <font color="##FFFFFF">Max Qty</font> </b></td>
            <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##000080"><b> 
              <font color="##FFFFFF">Amount</font></b></td>
          </tr>
          <tr>
            <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"><div align="center">
                <select name = "ShippingType" id="ShippingType">
                  <cfloop query = "QryShippingTypes">
                    <option <cfif #qryShippingTypes.ShippingType# IS #qryTableFour.ShippingType#>SELECTED</cfif>>#qryShippingTypes.ShippingType#</option>
                  </cfloop>
                </select></div></td>
            <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
              <p align="center"> 
                <input name="MinQty" type="text" id="MinQty" value="#MinQty#" size="7">
            </td>
            <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
              <p align="center"> 
                <input name="MaxQty" type="text" id="MaxQty" value="#MaxQty#" size="7">
            </td>
            <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
              <p align="center"><font color="##FFFFFF"> 
                <input type="text" name="Amount" size="9" value="#Amount#">
                <sup>*</sup></font></td>
          </tr>
        </table>
        <b><sup>*</sup>Note:&nbsp; Do not enter a sybmol. Enter ONLY a number</b> 
      </center>
  </div>
  <p align="center">
  <input type="Hidden" value="#url.shippingid#" name="ShippingID">
  <input type="hidden" value="UpdateQty" name="action">
  <input type="submit" value="Update Table" name="UpdateShipping"></p>
  </cfoutput>
</form>

