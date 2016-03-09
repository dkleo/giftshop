<cfinclude template = "../queries/qrytablefour.cfm">
<cfinclude template = "../queries/qryshippingtypes.cfm">

<cfif NOT ISDEFINED('session.optionselected')>
  
	<cflock type="exclusive" scope="session" timeout="10">
		<cfset session.optionselected = 'None'>
	</cflock>
</cfif>

<cfif ISDEFINED('session.optionselected')>
  
	<cflock type="readonly" scope="session" timeout="10">
		<cfset TempVar.optionselected = '#session.optionselected#'>
	</cflock>
</cfif>

<p><a href="doshipping.cfm?action=EditShippingTypes&ReturnPath=EditFour">Add/Remove Shipping Types</a></p>

<form name="form1" method="POST" action="doshipping.cfm">
<h2>Quantity-based Shipping Table</h2>
<p>Below is your quantity-based shipping table. Use the form to add new options 
  and select the delete link next to an option to delete it. Click on a shipping 
  type to change the information for it. </p>
<p>&nbsp;</p>
<cfif qryShippingTypes.recordcount IS 0>
  <p> <b>You do not have any shipping types defined for this custom shipping table. 
    You must click the link above and add the shipping types you will provide. 
    Shipping types are the different methods of shipping you will provide to your 
    customers. You can have as many as you want. This allows you to offer your 
    customers a choice.</b> </p>
<cfabort>
</cfif>
  <div align="center"> 
    <center>
      <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="75%" id="AutoNumber1">
        <tr>
          <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080">&nbsp;</td>
          <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
            <font color="#FFFFFF">Min Qty</font></td>
          <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
            <font color="#FFFFFF">Max Qty</font></td>
          <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
            <font color="#FFFFFF">Amount</font></td>
        </tr>
        <tr>
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF"><select name = "ShippingType" id="ShippingType">
		  <cfoutput query = "QryShippingTypes"><option <cfif TempVar.optionselected IS #ShippingType#>SELECTED</cfif>>#ShippingType#</option></cfoutput></select>&nbsp;</td>
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF"> 
            <p align="center"> 
              <input name="MinQty" type="text" id="MinQty" size="7">
          </td>
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF"> 
            <p align="center"> 
              <input name="MaxQty" type="text" id="MaxQty" size="7">
          </td>
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF"> 
            <p align="center"><font color="#FFFFFF"> 
              <input type="text" name="Amount" size="9">
              <sup>*</sup></font></td>
        </tr>
      </table>
      <sup><b>*</b></sup><b>Do not enter a symbol. Enter number only.</b> 
    </center>
  </div>
  <div align="center"> 
  	<input type="hidden" name="action" value="AddQty">
    <input type="submit" value="Add Shipping Information" name="UpdateShipping">
  </div>
<p>
  <div align="center"> 
    <center>
      <table border="1" cellpadding="2" cellspacing="0" width="101%" bordercolorlight="#808080" bordercolordark="#808080" bordercolor="#0066FF" style="border-collapse: collapse">
        <tr> 
          <td width="38%" bgcolor="#000080"> <font color="#FFFFFF">Shipping 
            Type</font></td>
          <td width="14%" bgcolor="#000080" align="center"> <font color="#FFFFFF">Min 
            Qty</font></td>
          <td width="14%" bgcolor="#000080" align="center"> <font color="#FFFFFF">Max 
            Qty</font></td>
          <td width="32%" bgcolor="#000080" align="center"> <font color="#FFFFFF">Amount</font></td>
          <td width="10%" bgcolor="#000080" align="center"> <font color="#FFFFFF">Delete</font></td>
        </tr>
        <cfoutput query = "qryTableFour"> 
          <tr> 
            <td width="38%"> 
              <a href="doshipping.cfm?action=EditAQty&ShippingID=#ShippingID#"> 
              #ShippingType#</a></td>
            <td width="14%" align="center">#MinQty#</td>
            <td width="14%" align="center">#MaxQty#</td>
            <td width="32%" align="center"><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(Amount, "Local")#<cfelse>#LSCurrencyformat(Amount, "Local")#</cfif></td>
            <td width="10%" align="center"><a href="doshipping.cfm?action=DeleteQty&ShippingID=#ShippingID#">Delete</a></td>
          </tr>
        </cfoutput> 
      </table>
    </center>
  </div>
  </form>
  
  <script language="javascript">
<!--
//--------------------------------------------------------------------------
  document.form1.ShippingType.focus()
//--------------------------------------------------------------------------
// -->
</script>

