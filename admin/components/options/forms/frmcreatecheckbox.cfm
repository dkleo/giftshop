<cfparam name="TheCaption" default="">
<cfparam name="TheCartCaption" default="">
<cfparam name="ThePrice" default="0.00">
<cfparam name="TheWeight" default="0.00">
<cfparam name="TheFieldValue" default="Unchecked">
<cfparam name="ErrorLine" default="0">
<cfparam name="ErrorMessage" default="">
<cfparam name="TheHeight" default="5">
<cfparam name="ThisIsRequired" default="No">
<cfparam name="ItemID" default="">
<cfparam name="optionitemid" default="">

<cfinclude template="../queries/qryproducts.cfm">
<cfoutput query = "qryProducts">
	<cfset OptionFields = #formFields#>
</cfoutput>

<table width="90%" border="4" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000" height="300">
<cfoutput query = "qryProducts">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="4">
      <tr>
        <td><span class="style3"><span style="font-size: 14pt">Options for #ProductName#</span></span></td>
      </tr>
      <tr>
        <td></td>
      </tr>
</cfoutput>
<tr>
<td valign="top">

<div>
<p><font size="4"><strong>Create a Check Box</strong></font></p>
<p><font size="2">To create a check box form field that you can use to gather 
  additional information from your customers, fill out the form below and click 
  on the button at the bottom.</font></p>
<p>
<cfoutput><font color="##FF0000">#ErrorMessage#</font></cfoutput>
</p>
<form name="form1" method="post" action="dooptions.cfm">
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td>Catalog Item ID (optional)</td>
      <td><input type="text" name="optionitemid" id="optionitemid" /> 
        <cfoutput><input type = "button" value="Select Product" onclick="javascript: OpenFileBrowser('#request.adminpath#components/products/forms/selectproduct.cfm?fname=form1&ffield=optionitemid')" /></cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 1>bgcolor="#FF0000"</cfif>> 
      <td width="28%">Label:</td>
      <td width="72%"><cfoutput><input name="Caption" type="text" id="Caption" size="45" Value="#TheCaption#"></cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 2>bgcolor="#FF0000"</cfif>>
      <td>Cart Label: </td>
      <td><cfoutput>
        <input name="CartCaption" type="text" id="CartCaption" size="45" value="#TheCartCaption#" />
      </cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 2>bgcolor="#FF0000"</cfif>> 
      <td>Price Increase:</td>
      <td><cfoutput><input name="Price" type="text" id="Price" value="#ThePrice#" size="8"></cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 3>bgcolor="#FF0000"</cfif>> 
      <td>Weight Increase:</td>
      <td><cfoutput><input name="Weight" type="text" id="Weight" value="#TheWeight#" size="8"></cfoutput></td>
    </tr>
    <tr> 
        <td>Initial Value:</td>
      <td><select name="FieldValue" id="FieldValue">
            <option <cfif TheFieldValue IS 'Unchecked'>selected</cfif>>Unchecked</option>
            <option <cfif TheFieldValue IS 'Checked'>selected</cfif>>Checked</option>
          </select></td>
    </tr>
    <tr> 
      <td colspan="2"><div align="center"> 
	      <input type="hidden" name="Type" value="CheckBox">
 		  <cfoutput><input type="hidden" value="#ItemID#" name="ItemID"></cfoutput>	 
	  	  <input type="hidden" name="Action" Value="CreateFormField">
          <input type="submit" name="Submit" value="Create The Check Box">
        </div></td>
    </tr>
  </table>
</form>
</div>
</td>
</tr>
</table>
