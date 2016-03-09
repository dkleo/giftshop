<cfparam name="ReturnPath" Default="EditCustom">

<cfinclude template="../queries/qryshippingtypes.cfm">
<div>
<cfform method="POST" action="doshipping.cfm?ReturnPath=#ReturnPath#">
    
  <h2>Shipping Types</h2>
  <p><cfif ReturnPath IS 'EditCustom'><a href="doshipping.cfm?action=EditCustom">Click here to go back to 
    your shipping table</a></cfif>
	<cfif ReturnPath IS 'EditOne'><a href="doshipping.cfm?action=EditOne">Click here to go back to 
    your shipping table</a></cfif>
	<cfif ReturnPath IS 'EditTwo'><a href="doshipping.cfm?action=EditTwo">Click here to go back to 
    your shipping table</a></cfif></p>
	<cfif ReturnPath IS 'EditFour'><a href="doshipping.cfm?action=EditQuantityTable">Click here to go back to 
    your shipping table</a></cfif></p>
  <p>Ues the form below to add shipping Types to your list below. You will use 
    these shipping types to build your custom shipping table.</p>
    
  <div align="left"></div>
  <div align="center">
    <center>
        
      <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="##111111" width="75%" id="AutoNumber1">
        <tr> 
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##000080"><b> 
            <font color="##FFFFFF">Shipping Type</font></b></td>
          <td width="25%" align="center" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##000080"><b> 
            <font color="##FFFFFF">Available To</font></b></td>
        </tr>
        <tr> 
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
            <input name="ShippingType" type="text" id="ShippingType" size="35"> 
          </td>
          <td width="25%" style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4" bordercolor="##000000" bgcolor="##0066FF"> 
            <p align="center"> 
              <select name="AvailableTo" id="AvailableTo">
                <option value="All" SELECTED>Everyone (All)</option>
                <option value="US">US Only (US)</option>
                <option value="USCA">US and Canada (USCA)</option>
                <option value="CA">Canada Only (CA)</option>
                <option value="INT">International (INT)</option>
              </select>
          </td>
        </tr>
      </table>
        </center>
  </div>
  <p align="center">
  <input type="hidden" value="AddShippingType" name="action">
  <input type="submit" value="Add Shipping Type" name="UpdateShipping"></p>
</cfform>
<form method="POST" action="doshipping.cfm">
<div align="center"> 
    <center>
    <table border="1" cellpadding="2" cellspacing="0" width="101%" bordercolorlight="#808080" bordercolordark="#808080" bordercolor="#0066FF" style="border-collapse: collapse">
      <tr> 
        <td width="38%" bgcolor="#000080"> <strong><font color="#FFFFFF">Shipping 
          Type</font></strong></td>
        <td width="14%" bgcolor="#000080" align="center"> <strong><font color="#FFFFFF">Available 
          To </font></strong></td>
        <td width="10%" bgcolor="#000080" align="center"> <strong><font color="#FFFFFF">Delete</font></strong></td>
      </tr>
      <cfoutput query = "qryShippingTypes"> 
        <tr> 
          <td width="38%"> 
            #Shippingtype#</td>
          <td width="14%" align="center">#AvailableTo#</td>
          <td width="10%" align="center"><a href="doshipping.cfm?action=DeleteShippingType&ShippingID=#ID#&ReturnPath=#ReturnPath#">Delete</a></td>
        </tr>
      </cfoutput> 
    </table>
    </center>
  </div>
<p><font size="2">&nbsp;</p> 

