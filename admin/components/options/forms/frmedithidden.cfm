<cfquery name = "FindOption" datasource="#request.dsn#">
SELECT * FROM options
WHERE OptionID = #url.OptionID#
</cfquery>

<cfoutput query = "FindOption">
<cfparam name="TheCaption" default="#Caption#">
<cfparam name="TheCartCaption" default="#CartCaption#">
<cfparam name="ThePrice" default="#OptionPrice#">
<cfparam name="TheWeight" default="#OptionWeight#">
<cfparam name="TheFieldValue" default="#FieldValue#">
<cfparam name="ErrorLine" default="0">
<cfparam name="ErrorMessage" default="">
<cfparam name="TheHeight" default="#Height#">
<cfparam name="ThisIsRequired" default="#IsRequired#">
<cfparam name="TheWidth" Default="#Width#">
</cfoutput>

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
        <td><cfoutput><a href = "dooptions.cfm?action=editoptions&ItemID=#url.itemid#">Go Back</a></cfoutput></td>
    </tr>
</cfoutput>
<tr>
<td valign="top">

<p><font size="4"><strong>Edit Hidden Field</strong></font></p>
<p><font size="2">To create a text box form field that you can use to gather additional 
  information from your customers, fill out the form below and click on the button 
  at the bottom.</font></p>
  <p>
<cfoutput><font color="##FF0000">#ErrorMessage#</font></cfoutput>
</p>
<form name="form1" method="post" action="dooptions.cfm">
  <table width="100%" border="0" cellspacing="0" cellpadding="8">
    <tr <cfif ErrorLine IS 1>bgcolor="#FF0000"</cfif>> 
      <td width="18%">Cart Label:</td>
      <td width="82%"><cfoutput> 
      	  <input type = "hidden" name="caption" value="#thecaption#" />
          <input name="CartCaption" type="text" id="CartCaption" size="45" Value="#TheCartCaption#">
        </cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 2>bgcolor="#FF0000"</cfif>> 
      <td>Price Increase:</td>
      <td><cfoutput> 
          <input name="Price" type="text" id="Price" value="#ThePrice#" size="8">
        </cfoutput></td>
    </tr>
    <tr <cfif ErrorLine IS 3>bgcolor="#FF0000"</cfif>> 
      <td>Weight Increase:</td>
      <td><cfoutput> 
          <input name="Weight" type="text" id="Weight" value="#TheWeight#" size="8">
        </cfoutput></td>
    </tr>
    <tr> 
      <td colspan="2"><div align="center"> 
          <input type="hidden" name="Type" value="Hidden">
          <cfoutput> 
            <input type="hidden" name="OptionID" Value="#url.OptionID#">
          </cfoutput> 
  		  <cfoutput><input type="hidden" name="ItemID" Value="#url.ItemID#"></cfoutput>
          <input type="hidden" name="action" value="UpdateFormField">
          <input type="submit" name="Submit" value="Update The Hidden Field">
        </div></td>
    </tr>
  </table>
</form>
<p><font size="2"></font></p>
</td>
</tr>
</table>
