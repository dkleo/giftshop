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

<cfinclude template = "../queries/qrycountries.cfm">
<h2>Countries</h2>
<form name = "NewCountry" method="post" <cfoutput>action="doshipping.cfm?action=addcountry"</cfoutput>>
New: 
  <input type = "text" name="country" value="" /> 
  Abbreviation: 
  <input type = "text" name = "countrycode" /><input type = "submit" name="submit" value="Add" />
</form>

<form name = "countrylist" <cfoutput>action="doshipping.cfm?action=countries_setshow"</cfoutput> method="post">
<table width="457" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td colspan="3" bgcolor="#FFFFFF">
	    <input type="button" name="CheckAllBtn" value="Check All" onclick = "checkAll(document.countrylist.ShowThese)"> 	    <input type="button" name="CheckNoneBtn" value="Uncheck All" onclick = "uncheckAll(document.countrylist.ShowThese)"></td>
    <td bgcolor="#FFFFFF"><input type="submit" name="Submit2" value="Save Settings" /></td>
  </tr>
  <tr>
    <td width="213" bgcolor="#006699"><span style="color: #FFFFFF; font-weight: bold">Country</span></td>
    <td width="104" bgcolor="#006699"><div align="center" style="color: #FFFFFF; font-weight: bold">Short Form</div></td>
    <td width="69" bgcolor="#006699"><div align="center" style="color: #FFFFFF; font-weight: bold">Show?</div></td>
    <td width="39" bgcolor="#006699"><div align="center" style="color: #FFFFFF; font-weight: bold"></div></td>
  </tr>
<cfoutput query = "qryCountries">
  <tr>
    <td>#country#</td>
    <td align="center">#countryCode#</td>
    <td align="center"><div>
    <input type = "CheckBox" value="#id#" Name="ShowThese" <cfif ShowThis IS 'yes'>CHECKED</cfif>>    </td>
	<td align="center"><a href = "doshipping.cfm?action=deletecountry&countryid=#id#">Delete</a></td>
  </tr>
</cfoutput>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Save Settings" /></td>
  </tr>
</table>
<p>&nbsp;</p>
</form>

