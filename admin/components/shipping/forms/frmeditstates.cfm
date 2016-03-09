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
<cfinclude template = "../queries/qrystates.cfm">

<cfparam name = "SelectedCountry" default="1">

<h2>States/Provinces/Regions</h2>
<form name = "NewState" method="post" <cfoutput>action="doshipping.cfm?action=addstate"</cfoutput>>
New: 
  <input type = "text" name="state" value="" />
  Abbreviation: 
  <input type = "text" name = "statecode" /> 
<select name="Country">
	<cfoutput query = "qryCountries">
		<option <cfif SelectedCountry IS ID>SELECTED</cfif> value = "#id#">#Country#</option>
	</cfoutput>
</select>
<input type = "submit" name="submit" value="Add" />
</form>

<form name = "statelist" <cfoutput>action="doshipping.cfm?action=states_setshow"</cfoutput> method="post">
<table width="457" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td colspan="3" bgcolor="#FFFFFF">
	    <input type="button" name="CheckAllBtn" value="Check All" onclick = "checkAll(document.statelist.ShowThese)"> <input type="button" name="CheckNoneBtn" value="Uncheck All" onclick = "uncheckAll(document.statelist.ShowThese)"></td>
    <td bgcolor="#FFFFFF"><input type="submit" name="Submit2" value="Save Settings" /></td>
  </tr>
  <tr>
    <td width="214" bgcolor="#006699"><span style="color: #FFFFFF; font-weight: bold">State/Province/Region</span></td>
    <td width="105" bgcolor="#006699"><div align="center" style="color: #FFFFFF; font-weight: bold">Short Form </div></td>
    <td width="67" bgcolor="#006699"><div align="center" style="color: #FFFFFF; font-weight: bold">Show?</div></td>
    <td width="39" bgcolor="#006699"><div align="center" style="color: #FFFFFF; font-weight: bold"></div></td>
  </tr>
<cfloop query = "qryCountries">
	<cfquery name = "qryGetStates" dbtype="query">
	SELECT * FROM qryStates WHERE country = '#qryCountries.id#'
	</cfquery>
	
	<cfif NOT qryGetStates.recordcount IS 0>
	<tr>
		<td bgcolor="#00CCCC"><cfoutput><span style="font-weight: bold">#qryCountries.Country#</span></cfoutput></td>
	    <td colspan = "3" bgcolor="#00CCCC"><div align="right"></div></td>
      </tr>
	<cfoutput query = "qryGetStates">
	  <tr>
		<td>#state#</td>
		<td align="center">#stateCode#</td>
		<td align="center"><input type = "CheckBox" value="#id#" Name="ShowThese" <cfif ShowThis IS 'yes'>CHECKED</cfif>></td>
		<td align="center"><a href = "doshipping.cfm?action=deletestate&stateid=#id#">Delete</a></td>
	  </tr>
	  </cfoutput>
	  <tr>
	    <td>&nbsp;</td>
	    <td align="center">&nbsp;</td>
	    <td align="center">&nbsp;</td>
	    <td align="center"><input type="submit" name="Submit22" value="Save Settings" /></td>
	    </tr>
	</cfif>
</cfloop>
</table>
<p>&nbsp;</p>

<script language="javascript">
<!--
//--------------------------------------------------------------------------
  document.NewState.state.focus()
//--------------------------------------------------------------------------
// -->
</script>

