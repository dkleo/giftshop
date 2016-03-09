<cfinclude template = "../queries/qrytablethree.cfm">
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


<h2>Custom Shipping Table</h2>
<p><a href="doshipping.cfm?action=EditShippingTypes">Add/Remove Shipping 
  Types</a> | <a href = "../converter/converter.cfm" onClick="NewWindow(this.href,'name','400','250','yes');return false;">Weight Conversion Calculator</a></p>
<p>Below is a table of current shipping options, weights and prices you have setup. 
  Use the form to add new options and select the delete link next to an option 
  to delete it. Click on a shipping type to change the information for it. NOTE: 
  Do not enter any symbols. There is no need to worry about units of measure (See 
  the manual for more details).</p>
<cfif qryShippingTypes.recordcount IS 0>
<p>
<b>You do not have any shipping types defined for your custom shipping table.  You must click the link above
and add the shipping types you will provide.  Shipping types are the different methods of shipping you will
provide to your customers.  You can have as many as you want.  This allows you to offer your customers a 
choice.</b>
</p>
<cfabort>
</cfif>

<form name="form1" id-"form1" method="POST" action="doshipping.cfm">
  <div align="center">
<center>
      <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="75%" id="AutoNumber1">
        <tr> 
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
            <font color="#FFFFFF">Shipping Type</font></td>
          <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
            <font color="#FFFFFF">Min Weight</font></td>
          <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
            <font color="#FFFFFF">Max Weight</font></td>
          <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#000080"> 
            <font color="#FFFFFF">Amount</font></td>
        </tr>
        <tr> 
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF">
		  <select name = "ShippingType" id="ShippingType">
		  <cfoutput query = "QryShippingTypes"><option <cfif TempVar.optionselected IS #ShippingType#>SELECTED</cfif>>#ShippingType#</option></cfoutput></select></td>
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF"> 
            <p align="center"> 
              <input type="text" name="MinWeight" size="7">
              <font color="#FFFFFF"><cfoutput>#request.UnitofMeasure#</cfoutput></font> </td>
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF"> 
            <p align="center"> 
              <input type="text" name="MaxWeight" size="7">
              <font color="#FFFFFF"><cfoutput>#request.UnitofMeasure#</cfoutput></font></td>
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="#000000" bgcolor="#0066FF"> 
            <p align="center"><font color="#FFFFFF">
<input type="text" name="Amount" size="9">
              * </font></td>
        </tr>
      </table>
      <sup>*</sup>Note: Do not enter a currency sybmol. Number only! 
    </center>
  </div>
  <div align="center"> 
  	<input type="hidden" name="action" value="AddCustom">
    <input type="submit" value="Add Shipping Information" name="UpdateShipping">
  </div>
  </form>
  <div align="center"> 
    <center>
      <table border="1" cellpadding="2" cellspacing="0" width="99%" bordercolorlight="#808080" bordercolordark="#808080" bordercolor="#0066FF" style="border-collapse: collapse">
        <tr> 
          <td width="38%" bgcolor="#000080"> <font color="#FFFFFF">Shipping 
            Type</font></td>
          <td width="14%" bgcolor="#000080" align="center"> <font color="#FFFFFF">Min 
            Weight</font></td>
          <td width="14%" bgcolor="#000080" align="center"> <font color="#FFFFFF">Max 
            Weight</font></td>
          <td width="32%" bgcolor="#000080" align="center"> <font color="#FFFFFF">Amount</font></td>
          <td width="10%" bgcolor="#000080" align="center"> <font color="#FFFFFF">Delete</font></td>
        </tr>
        <cfoutput query = "qryTableThree"> 
          <tr> 
            <td width="38%"> 
              <a href="doshipping.cfm?action=EditACustom&ShippingID=#ShippingID#"> 
              #Shippingtype#</a></td>
            <td width="14%" align="center">#MinWeight# #request.UnitofMeasure#</td>
            <td width="14%" align="center">#MaxWeight# #request.UnitofMeasure#</td>
            <td width="32%" align="center"><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(Amount, "Local")#<cfelse>#LSCurrencyformat(Amount, "Local")#</cfif></td>
            <td width="10%" align="center"><a href="doshipping.cfm?action=DeleteCustom&ShippingID=#ShippingID#">Delete</a></td>
          </tr>
        </cfoutput> 
      </table>
    </center>
  </div>
  <p>&nbsp;</p>
  <script language="javascript">
<!--
//--------------------------------------------------------------------------
  document.form1.ShippingType.focus()
//--------------------------------------------------------------------------
// -->
</script>
