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

function CheckUSStates(field)
{
for (i = 0; i < 51; i++)
	field[i].checked = true ;
}

function CheckCanada(field)

{
for (i = 56; i < 69; i++)
	field[i].checked = true ;
}

//  End -->
</script>


<cfinclude template="../queries/qrysellingareas.cfm">
<h4 align="center">States/Provinces</h4>
<form name="myform" method="post" action="doshipping.cfm">
  <table width="100%" border="1" cellspacing="2" cellpadding="2">
    <tr>
      <td valign="Top" nowrap>
	<cfset ColumnCount = 0>  
	<cfoutput query = "qrysellingareas"> 
	<cfloop index = 'Mycount' From = "1" To = "#ListLen(States)#">
	<cfset ColumnCount = ColumnCount + 1>
	<cfset IsThisChecked = 'No'>
	<cfset ThisState = #ListGetAt(States, mycount)#>
	<cfset ThisStateCode = #ListGetAt(StateCodes, mycount)#>
		<!---check to see if it's on the list...if so then check the box--->
		<cfloop index = 'Mycount2' From="1" To="#ListLen(SelectedSCodes)#">
				<cfset FindStateCode = #ListGetAt(SelectedSCodes, mycount2)#>
				<cfif FindStateCode IS #ThisStateCode#>
				<cfset IsThisChecked = 'Yes'>
 				</cfif>	
		</cfloop>
	<cfset RealCount = #MyCount# - 1>
    <input type="checkbox" name="ChoiceBox" value="#ThisStateCode#" <cfif IsThischecked IS 'Yes'>CHECKED</cfif>>
      #ThisState#<br>
	<cfif ColumnCount IS 15><cfset ColumnCount=0></td><td valign="Top" nowrap></cfif>
	</cfloop>
      </cfoutput> 
	</td>
   </tr>
  </table>
  <p align="center"> 
    <input type="button" name="Submit22" value="Check All" onclick = "checkAll(document.myform.ChoiceBox)">
    &nbsp;&nbsp; 
    <input type="button" name="Submit3" value="Check None" onClick="uncheckAll(document.myform.ChoiceBox)">
    &nbsp;&nbsp; 
    <input type="button" name="Submit2" value="Check 50 US States" onClick="CheckUSStates(document.myform.ChoiceBox)">
	&nbsp;&nbsp; 
    <input type="button" name="Submit4" value="Check Canadian Provinces" onClick="CheckCanada(document.myform.ChoiceBox)">
	&nbsp;&nbsp; 
  </p>
  <p align="center">
    <input type="hidden" name="action" value="UpdateStates">
    <input type="submit" name="Submit" value="Update States/Provinces">
  </p>

      </form>
