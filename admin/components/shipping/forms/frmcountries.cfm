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

function CheckUSCanada(field)
{
	field[33].checked = true ;
	field[179].checked = true ;
}

function CheckEuropeCountries(field)
{
	field[0].checked = true ;
	field[2].checked = true ;
	field[10].checked = true ;
	field[17].checked = true ;
	field[23].checked = true ;
	field[28].checked = true ;
	field[44].checked = true ;
	field[45].checked = true ;
	field[46].checked = true ;
	field[47].checked = true ;
	field[56].checked = true ;
	field[58].checked = true ;
	field[60].checked = true ;
	field[61].checked = true ;
	field[67].checked = true ;
	field[69].checked = true ;
	field[70].checked = true ;
	field[81].checked = true ;
	field[82].checked = true ;
	field[85].checked = true ;
	field[87].checked = true ;
	field[105].checked = true ;
	field[110].checked = true ;
	field[118].checked = true ;
	field[125].checked = true ;
	field[132].checked = true ;
	field[142].checked = true ;
	field[142].checked = true ;
	field[143].checked = true ;
	field[147].checked = true ;
	field[155].checked = true ;
	field[156].checked = true ;
	field[159].checked = true ;
	field[166].checked = true ;
	field[167].checked = true ;
	field[175].checked = true ;
	field[183].checked = true ;
	field[191].checked = true ;
}



//  End -->
</script>

<cfinclude template="../queries/qrysellingareas.cfm">
<h4 align="center">Countries</h4>
<p>&nbsp;</p><form name="myform" method="post" action="doshipping.cfm">
  <table width="100%" border="1" cellspacing="0" cellpadding="2">
    <tr>
      <td valign="Top">
	  	<cfset ColumnCount = 0>  
		<cfoutput query = "qrysellingareas"> 
		<cfloop index = 'Mycount' From = "1" To = "#ListLen(Countries)#">
		<cfset ColumnCount = ColumnCount + 1>
		<cfset IsThisChecked = 'No'>
		<cfset ThisCountry = #ListGetAt(Countries, mycount)#>
		<cfset ThisCountryCode = #ListGetAt(CountryCodes, mycount)#>
			<!---check to see if it's on the list...if so then check the box--->
			<cfloop index = 'Mycount2' From="1" To="#ListLen(SelectedCCodes)#">
				<cfset FindCountryCode = #ListGetAt(SelectedCCodes, mycount2)#>
				<cfif FindCountryCode IS #ThisCountryCode#>
				<cfset IsThisChecked = 'Yes'>
 				</cfif>	
			</cfloop>
	    <input type="checkbox" name="ChoiceBox" value="#ThisCountryCode#" <cfif IsThischecked IS 'Yes'>CHECKED</cfif>>
	      #ThisCountry#<br>
		<cfif ColumnCount IS 40><cfset ColumnCount=0></td><td valign="Top"></cfif>
		</cfloop>
	     </cfoutput> 
	</td>
   </tr>
  </table>
	     
  <p align = "Center"> 
    <input type="button" name="Submit2" value="Check All" onclick = "checkAll(document.myform.ChoiceBox)">
    &nbsp;&nbsp; 
    <input type="button" name="Submit3" value="Check None" onClick="uncheckAll(document.myform.ChoiceBox)">
    &nbsp;&nbsp; 
    <input type="button" name="Submit4" value="Check US and Canada" onClick="CheckUSCanada(document.myform.ChoiceBox)">
    &nbsp;&nbsp; 
    <input type="button" name="Submit5" value="Check European Countries" onClick="CheckEuropeCountries(document.myform.ChoiceBox)">
  </p>
  <p align = "Center">
    <input type="hidden" name="action" value="UpdateCountries">
    <input type="submit" name="Submit" value="Update Countries">
  </p>
    </form>


