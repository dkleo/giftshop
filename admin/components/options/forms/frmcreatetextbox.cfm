<cfparam name="TheCaption" default="">
<cfparam name="TheCartCaption" default="">
<cfparam name="ThePrice" default="0.00">
<cfparam name="TheWeight" default="0.00">
<cfparam name="TheFieldValue" default="">
<cfparam name="ErrorLine" default="0">
<cfparam name="ErrorMessage" default="">
<cfparam name="TheHeight" default="5">
<cfparam name="ThisIsRequired" default="No">
<cfparam name="TheWidth" Default="25">
<cfparam name="ItemID" default="">

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

<p><font size="4"><strong>Create a Text Box</strong></font></p>
<p><font size="2">To create a text box form field that you can use to gather additional 
  information from your customers, fill out the form below and click on the button 
  at the bottom.</font></p>
  <p>
<cfoutput><font color="##FF0000">#ErrorMessage#</font></cfoutput>
</p>
<form name="form1" method="post" action="dooptions.cfm">
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr <cfif ErrorLine IS 1>bgcolor="#FF0000"</cfif>> 
      <td width="18%">Caption:</td>
      <td width="82%"><cfoutput><input name="Caption" type="text" id="Caption" size="45" Value="#TheCaption#"></cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 1>bgcolor="#FF0000"</cfif>> 
      <td width="18%">Cart Caption:</td>
      <td width="82%"><cfoutput><input name="CartCaption" type="text" id="CartCaption" size="45" Value="#TheCartCaption#"></cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 2>bgcolor="#FF0000"</cfif>> 
      <td>Price Increase:</td>
      <td><cfoutput><input name="Price" type="text" id="Price" value="#ThePrice#" size="8"></cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 3>bgcolor="#FF0000"</cfif>> 
      <td>Weight Increase:</td>
      <td><cfoutput><input name="Weight" type="text" id="Weight" value="#TheWeight#" size="8"></cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 4>bgcolor="#FF0000"</cfif>> 
      <td>Width (In Pixels):</td>
      <td><cfoutput><input name="Width" type="text" id="Width" size="7" maxlength="2" value="#TheWidth#"></cfoutput></td>
    </tr>
    <tr> 
      <td>Is this a required field?</td>
      <td><select name="isRequired" id="isRequired">
          <option <cfif ThisIsRequired IS 'No'>selected</cfif>>No</option>
          <option <cfif ThisIsRequired IS 'Yes'>selected</cfif>>Yes</option>
        </select></td>
    </tr>
    <tr> 
      <td>Initial Value:</td>
      <td><cfoutput><input name="FieldValue" type="text" id="FieldValue" size="45" Value="#TheFieldValue#"></cfoutput></td>
    </tr>
    <tr> 
      <td colspan="2"><div align="center"> 
          <input type="hidden" name="Type" value="TextBox">
		  <cfoutput><input type="hidden" value="#ItemID#" name="ItemID"></cfoutput>
		  <input type="hidden" name="Action" value="CreateFormField">
          <input type="submit" name="Submit" value="Create The Text Box">
        </div></td>
    </tr>
  </table>
</form>

</td>
</tr>
</table>
