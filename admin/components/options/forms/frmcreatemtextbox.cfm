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
        <td>
		</td>
      </tr>
</cfoutput>
<tr>
<td valign="top">

<p><font size="4"><strong>Create a Multi-Line Text Box</strong></font></p>
<p><font size="2">To create a multi-line text box form field that you can use 
  to gather additional information from your customers, fill out the form below 
  and click on the button at the bottom.</font></p>
<p>
<cfoutput><font color="##FF0000">#ErrorMessage#</font></cfoutput>
</p>
<form name="form1" method="post" action="dooptions.cfm">
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr <cfif ErrorLine IS 1>bgcolor="#FF0000"</cfif>> 
      <td width="28%">Caption:</td>
      <td width="72%"><cfoutput><input name="Caption" type="text" id="Caption" size="45" Value="#TheCaption#"></cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 1>bgcolor="#FF0000"</cfif>> 
      <td width="28%">Cart Caption:</td>
      <td width="72%"><cfoutput><input name="CartCaption" type="text" id="CartCaption" size="45" Value="#TheCartCaption#"></cfoutput>
	  </td>
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
      <td>Width (Columns):</td>
      <td><input name="Width" type="text" id="Width" value="25" size="7" maxlength="2"></td>
    </tr>
    <tr <cfif ErrorLine IS 5>bgcolor="#FF0000"</cfif>> 
      <td>Height (Rows):</td>
      <td><cfoutput><input name="Height" type="text" id="Height" value="#TheHeight#" size="7" maxlength="2"></cfoutput></td>
    </tr>
    <tr> 
      <td>Is this a required field?</td>
      <td><select name="isRequired" id="isRequired">
          <option selected>No</option>
          <option>Yes</option>
        </select></td>
    </tr>
    <tr> 
      <td>Intial Value:</td>
      <td><textarea name="FieldValue" cols="25" rows="5" id="FieldValue"></textarea></td>
    </tr>
    <tr> 
      <td colspan="2"><div align="center"> 
          <input type="hidden" name="Type" value="TextArea">
  		  <cfoutput><input type="hidden" value="#ItemID#" name="ItemID"></cfoutput>
          <input type="hidden" name="Action" value="CreateFormField">
          <input type="submit" name="Submit" value="Create The Multi-Line Text Box">
        </div></td>
    </tr>
  </table>
</form>
</td>
</tr>
</table>

