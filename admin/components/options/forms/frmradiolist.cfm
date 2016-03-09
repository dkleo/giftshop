<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function checkAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}

function uncheckAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}
-->
</SCRIPT>

<cfif ISDEFINED('url.NewRadioList')>
	<cflock scope="session" type="exclusive" timeout="10">
		<cfset session.OptionNames="">
		<cfset session.OptionPrices= "">
		<cfset session.OptionWeights = "">
		<cfset session.DefaultValue = "">
		<cfset session.OptionSize = "0">
        <cfset session.OptionItemIds = "">
		<cfset session.OptionFor = "0">
		<cfset session.IsEditing = 'No'>
	</cflock>
</cfif>

<!---If they are editing something, then make a variable so it can update it--->
<cfif ISDEFINED('url.OptionID')>
 <cflock scope="session" type="exclusive" timeout="10">	
	<cfset session.EditID = #url.optionid#>
	<cfset session.IsEditing = 'Yes'>
	<cfset session.OptionFor = "#url.ItemID#">
 </cflock>
</cfif>

<cfif NOT ISDEFINED('session.IsEditing')>
 <cflock scope="session" type="exclusive" timeout="10">	
	<cfset session.IsEditing = 'No'>
 </cflock>
</cfif>

<cfif NOT ISDEFINED('Session.EditID')>
 <cflock scope="session" type="exclusive" timeout="10">	
	<cfset session.EditID = 0>
 </cflock>
</cfif>

<cfif session.EditID IS 0>
 <cflock scope="session" type="exclusive" timeout="10">	
	<cfset session.IsEditing = 'No'>
 </cflock>
</cfif>

<cflock scope="session" type="readonly" timeout="10">	
  <cfset TempVar.EditID = #Session.EditID#>
  <cfset TempVar.ItemID = #Session.OptionFor#>
  <cfset TempVar.IsEditing = Session.IsEditing>
</cflock>

<!---Default Values--->
<cfparam name="AddCaption" default="">
<cfparam name="AddPrice" default="0.00">
<cfparam name="AddWeight" default="0.00">
<cfparam name="AddSize" default="0">
<cfparam name="AddItemid" default="">
<cfparam name="AddErrorLine" default="">
<cfparam Name="AddErrorMessage" default="">
<cfparam Name="EditErrorLine" default="">
<cfparam Name="EditErrorMessage" default="">
<cfparam Name="CaptionError" default="">

<!---If they are editing it then find the option in the database and get the values--->
<cfif ISDEFINED('url.OptionID')>
	<cfquery name = "GetOption" datasource="#request.dsn#">
	SELECT * FROM options
	WHERE OptionID = #url.OptionID#
	</cfquery>

	<cfoutput query = "GetOption">
	 <cflock scope="session" type="exclusive" timeout="10">	
		<cfset session.OptionNames=#ItemsList#>
		<cfset session.OptionPrices=#PriceList#>
		<cfset session.OptionWeights=#WeightsList#>
		<cfset session.OptionSize=#Height#>
        <cfset session.OptionItemids=#itemidslist#>
		<cfset session.Caption=#Caption#>
		<cfset session.CartCaption=#CartCaption#>
		<cfset session.DefaultValue= #FieldValue#>
	 </cflock>
	</cfoutput>
</cfif>

<cfif NOT isdefined('session.OptionNames')>
<cflock scope="session" type="exclusive" timeout="10">
	<cfset session.OptionNames="">
	<cfset session.OptionPrices= "">
	<cfset session.OptionWeights = "">
    <cfset session.OptionItemIDs = "">
	<cfset session.OptionSize = "1">
</cflock>
</cfif>

<cfif NOT ISDEFINED('session.Caption')>
	<cfset Session.Caption = ''>
</cfif>

<cfif NOT ISDEFINED('session.CartCaption')>
	<cfset Session.CartCaption = ''>
</cfif>

<cfif ISDEFINED('session.OptionNames')>
	<cflock scope="session" type="ReadOnly" timeout="10">
		<cfset TempVar.OptionNames = Session.OptionNames>
		<cfset TempVar.OptionPrices = Session.OptionPrices>
		<cfset TempVar.OptionWeights = Session.OptionWeights>
        <cfset TempVar.OptionItemIDs = Session.OptionItemIDs>
		<cfset TempVar.DefaultValue = Session.DefaultValue>	
		<cfset AddSize = Session.OptionSize>
	</cflock>
</cfif>

<cfif ISDEFINED('form.Caption')>
	<cflock scope="session" type="exclusive" timeout="10">
		<cfset Session.Caption = '#form.Caption#'>
		<cfset Session.CartCaption = '#form.CartCaption#'>
	</cflock>
</cfif>

<cfif ISDEFINED('session.Caption')>
	<cflock scope="session" type="ReadOnly" timeout="10">
		<cfset TempVar.Caption = '#Session.Caption#'>
		<cfset TempVar.CartCaption = '#Session.CartCaption#'>
	</cflock>
</cfif>


<cfinclude template="../queries/qryproducts.cfm">
<cfoutput query = "qryProducts">
	<cfset OptionFields = #formFields#>
</cfoutput>

<table width="90%" border="4" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000" height="300">
<cfif ISDEFINED('url.itemid')>
<cfoutput query = "qryProducts">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="4">
      <tr>
        <td><span class="style3"><span style="font-size: 14pt">Options for #ProductName#</span></span></td>
      </tr>
</cfoutput>
</cfif>
<tr>
<td>

  <div align="center">
      <p align="left"><strong><font size="4">Radio Button List Builder:</font></strong></p>
      <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
		<form method="POST" name = "AddForm" action="dooptions.cfm">
        <tr>
          <td bgcolor="#0066CC"><div align="center"><strong><font color="#FFFFFF">Add 
              To Drop Down</font></strong> </div></td>
          <td valign="top" bgcolor="#0066CC"><div align="center"><font color="#FFFFFF"><strong>Preview</strong></font></div></td>
        </tr>
        <tr>
          <td width="53%">
		  <cfoutput><font color="##FF0000"><b>#AddErrorMessage#</b></font></cfoutput>
		  <cfoutput>
            <table border="0" width="100%">
              <tr <cfif AddErrorLine IS 1>bgcolor="##FF0000"</cfif>> 
                <td width="30%" align="right">Option Name</td>
                <td width="70%"><input name="ThisOptionName" type="text" size="35" maxlength="255" Value="#AddCaption#"></td>
              </tr>
              <tr <cfif AddErrorLine IS 2>bgcolor="##FF0000"</cfif>>
                <td align="right"> Add To Price:</td>
                <td> <input type="text" name="ThisOptionPrice" size="13" value="#AddPrice#">
                  (Number only)</td>
              </tr>
              <tr <cfif AddErrorLine IS 3>bgcolor="##FF0000"</cfif>> 
                <td width="30%" align="right">Add To Weight</td>
                <td width="70%"><input name="ThisOptionWeight" type="text" id="ThisOptionWeight" value="#AddWeight#" size="13">
                  (Number only)</td>
			  </tr>
                <tr>
                  <td><div align="right">Item ID (optional)</div></td>
                  <td><input name="ThisOptionItemid" type="text" id="ThisOptionItemid" size="15" /> 
                    <cfoutput><input type = "button" value="Select Product" onclick="javascript: OpenFileBrowser('#request.adminpath#components/products/forms/selectproduct.cfm?fname=AddForm&ffield=ThisOptionItemid')" /></cfoutput></td>
                </tr>
              <tr> 
                <td colspan="2"> <input type="hidden" name="action" value="AddRadioItem"> 
                  <p align="center"> 
					<cfif ISDEFINED('url.itemid')><cfoutput><input type="hidden" name = "itemid" value="#url.Itemid#" /></cfoutput></cfif>
                    <input type="submit" value="Add Item to Drop Down" name="B1">
                </td>
              </tr>
              <tr> 
                <td colspan="2"> </td>
              </tr>
  			</table>
			 </cfoutput> 
         </td>
          <td width="47%" valign="middle" bgcolor="#FFFFCC"> <div align="left"> 
              <p><strong></strong></p>
              <p> 
               <cfif NOT ListLen(TempVar.OptionNames) IS 0>
                    <cflock scope="session" type="readonly" timeout="10">
                      <cfloop index="LoopCount" from="1" to="#ListLen(TempVar.OptionNames, "^")#">
                        <cfset ThisOptionName = #ListGetAt(TempVar.OptionNames, LoopCount, "^")#>
                        <cfoutput>
 						  <input type="radio" name="RadioPreview" value="#ThisOptionName#">#ThisOptionName#<br>
                        </cfoutput> 
                      </cfloop>
                    </cflock>
                </cfif>
              </p>
            </div>
           </td>
        </tr>
	</form>
	</table>
  </div>

<!---Display the items so they can be edited--->
<form name="EditForm" method="POST" action="dooptions.cfm">
  <p align="center"><strong>Modify Items below:</strong></p>
<cfif ListLen(TempVar.OptionNames) IS 0>
      <div align="center">
        <b><font color="##FF0000">There are no items in this drop down to edit</font></b> 
      </div>
  </cfif>
	<font color="##FF0000"><cfoutput><b>#EditErrorMessage#</b></cfoutput></font>

<cfif NOT ListLen(TempVar.OptionNames) IS 0>
  <table width="100%" border="1" cellpadding="4" cellspacing="0" bordercolor="#000000">
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td colspan="3" align="center"><input type="button" name="Button" value="Check All" onclick = "checkAll(document.EditForm.removeoptions)" />        <input type="button" name="Button" value="Check None" onclick = "uncheckAll(document.EditForm.removeoptions)" /></td>
      </tr>
    <tr> 
      <td bgcolor="#0066CC"><div align="center"><font color="#FFFFFF"><strong>Item</strong></font></div></td>
      <td bgcolor="#0066CC"><div align="center"><strong><font color="#FFFFFF">ItemID</font></strong></div></td>
      <td bgcolor="#0066CC"><div align="center"><font color="#FFFFFF"><strong>Price</strong></font></div></td>
      <td bgcolor="#0066CC"><div align="center"><font color="#FFFFFF"><strong>Weight</strong></font></div></td>
      <td align="center" valign="top" bgcolor="#0066CC"><font color="#FFFFFF"><strong>Delete</strong></font></td>
      <td bgcolor="#0066CC"><div align="center"><font color="#FFFFFF"><b>Move</b> </font></div></td>
    </tr>
    <cfloop index="LoopCount" from="1" to="#ListLen(TempVar.OptionNames, "^")#">
	 <cfif ISDEFINED('url.ErrorAt')>
	   <cfset ErrorAtThis = #url.ErrorAt#></cfif>
      <cfset ThisOptionName = #ListGetAt(TempVar.OptionNames, LoopCount, "^")#>
      <cfset ThisOptionPrice = #ListGetAt(TempVar.OptionPrices, LoopCount, "^")#>
      <cfset ThisOptionWeight = #ListGetAt(TempVar.OptionWeights, LoopCount, "^")#>
      <cfset ThisOptionItemid = #ListGetAt(TempVar.OptionItemIDs, LoopCount, "^")#>
      <cfoutput> 
        <tr <cfif EditErrorLine IS Loopcount>bgcolor="##FF0000"</cfif>> 
          <td> <input name="Items#LoopCount#" type="text" Value="#ThisOptionName#" size="45" maxlength="45"></td>
          <td><div align="center"><input name="ItemIDs#LoopCount#" type="text" Value="#ThisOptionItemid#" size="10" maxlength="10">
          </div></td>
          <td> <div align="center"> 
              <input name="Prices#LoopCount#" type="text" Value="#ThisOptionPrice#" size="10">
            </div></td>
          <td><div align="center">
              <input name="Weights#LoopCount#" type="text" value="#ThisOptionWeight#" size="10">
            </div></td>
          <td align="center"><input type = "checkbox" value="#LoopCount#" name="removeoptions" id="removeoptions" /></td>
          <td align="center"><a href = "dooptions.cfm?action=MoveDDItemUp&position=#LoopCount#<cfif isdefined('url.itemid')>&itemid=#itemid#</cfif>">up</a> | <a href = "dooptions.cfm?action=MoveDDItemDown&position=#LoopCount#<cfif isdefined('url.itemid')>&itemid=#itemid#</cfif>">down</a></td>
        </tr>
      </cfoutput> 
    </cfloop>
  </table>
</cfif>
  <p align="center"> 
    <input type="hidden" value="UpdateRadioListItems" name="Action">
	<cfif ISDEFINED('url.itemid')><cfoutput><input type="hidden" name = "itemid" value="#url.Itemid#" /></cfoutput></cfif>
    <input type="submit" value="Update Items" name="B1">
  </p>
</form>
<form method="POST" action="dooptions.cfm">
  <hr>
<cfif NOT CaptionError IS ''>
    <font color="#FF0000"><strong><cfoutput>#CaptionError#</cfoutput></strong></font> 
  </cfif>
  <p align="center"><strong>Caption: </strong> <cfoutput> 
      <input name="Caption" type="text" size="45" Value="#TempVar.Caption#"><br>
			Cart Caption: <input name="CartCaption" type="text" size="45" value="#TempVar.CartCaption#">
    </cfoutput><br>
    <cfif NOT ListLen(TempVar.OptionNames) IS 0>
      <strong>Set the Default Value to: </strong> 
      <select size="1" name="DefaultValue">
        <cflock scope="session" type="readonly" timeout="10">
          <cfloop index="LoopCount" from="1" to="#ListLen(TempVar.OptionNames, "^")#">
            <cfset ThisOptionName = #ListGetAt(TempVar.OptionNames, LoopCount, "^")#>
            <cfoutput> 
              <option value="#Loopcount#" <cfif #LoopCount# IS #TempVar.DefaultValue#>SELECTED</cfif>>#ThisOptionName#</option>
            </cfoutput> 
          </cfloop>
        </cflock>
      </select>
    </cfif>
  </p>
  <p align="center"><cfoutput><input name="OptionSize" type="hidden" id="OptionSize" value="#AddSize#" size="5"></cfoutput>
    <br>
    <input type="hidden" value="AddRadioList" name="Action">
    <cfif NOT ListLen(TempVar.OptionNames) IS 0>
      <cfif TempVar.IsEditing IS 'No'>
		<cfif ISDEFINED('url.itemid')><cfoutput><input type="hidden" value="#url.ItemID#" name="ItemID"></cfoutput></cfif>
        <input type="submit" value="Create Radio Button List" name="B1">
      </cfif>
      <cfif TempVar.IsEditing IS 'Yes'>
        <cfoutput> 
          <cfif ISDEFINED('url.itemid')><input type="hidden" value="#url.ItemID#" name="ItemID"></cfif>
          <input type="hidden" value="#TempVar.EditID#" name="EditID">
        </cfoutput> 
        <input type="submit" value="Update Radio Button List" name="B1">
      </cfif>
    </cfif>
  </p>
</form>
</td>
</tr>
</table>
<script language="javascript">
<!--
//--------------------------------------------------------------------------
  document.AddForm.ThisOptionName.focus()
//--------------------------------------------------------------------------
// -->
</script>

