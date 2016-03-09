<cfinclude template = "../queries/qryupssettings.cfm">
<cfinclude template = "../queries/qrysellingareas.cfm">

  
<p><strong> Multiple Shipping Points</strong></p>
  
<p>Since you have selected to ship from multiple shipping points, you will need 
  to specify which locations you ship from.<br>
  Use the drop down boxes below to select the state/province and country you ship 
  from. Fill in the zip or postal code in the text box provided. The information 
  will be added to your list. When you are done click on the Finished Button below.</p>
<p><strong>Please Note: You can only use this option if you are shipping from 
  within the United States or Canada. </strong></p>
<form name="globe" Method = "POST" action="doshipping.cfm">
	City: <input type="text" Name="City">
	<br>
	State/Province: 
    <cfif qryStates.recordcount GT 0>
	<select name="region">
		 <cfloop query = "qryCountries">
			<cfquery name = "qryGetStates" dbtype="query">
			SELECT * FROM qryStates WHERE country = '#qryCountries.id#'
			</cfquery>
			<cfif NOT qryGetStates.recordcount IS 0>
				<cfif qryCountries.recordcount GT 1>
					<cfoutput><option value="N-A" style="background:##FFFFCC;">#Ucase(qryCountries.Country)#</option></cfoutput>
				</cfif>
				<cfoutput query = "qryGetStates">
					<option value="#qryGetStates.statecode#">#State#</option>
				</cfoutput> 
			</cfif>
		</cfloop>
    </select>
	<cfelse>
		State/Province <input type = "text" Name= "Region" size="35">
	</cfif>
    <br>
    Country: 
    <select name="country">  
          <option value = "CA">Canada</option>
		  <option value = "US">United States</option>
    </select>
    Postal Code: 
    <input name="ZipCode" type="text" id="ZipCode" size="6">
    <input type="hidden" value="AddShippingPoint" name="action">
    <input type="submit" name="Submit" value="Add Shipping Point">
    <br>
  </p>
  </form>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0">
  <tr bgcolor="#003399">
    <td width="26%"><font color="#FFFFFF"><strong>City</strong></font></td>
    <td width="26%"><div align="center"><b> <font color="#FFFFFF"> State/Province</font></b></div></td>
    <td width="21%"><div align="center"><strong><font color="#FFFFFF"> Country</font></strong></div></td>
    <td width="14%"><div align="center"><font color="#FFFFFF"><strong>Zip Code</strong></font></div></td>
    <td width="16%"><div align="center"></div></td>
  </tr>
  <cfif NOT qryUPSSettings.ShipFromZips IS 0>
    <cfloop index = "MyCount" From = "1" To = "#ListLen(qryUPSSettings.ShipFromZips)#">
      <cfset ThisCity = #ListGetAt(qryUPSSettings.ShipFromCities, MyCount)#>
      <cfset ThisState = #ListGetAt(qryUPSSettings.ShipFromStates, MyCount)#>
      <cfset ThisCountry = #ListGetAt(qryUPSSettings.ShipFromCountries, MyCount)#>
      <cfset ThisZip = #ListGetAt(qryUPSSettings.ShipFromzips, MyCount)#>
      <cfoutput> 
        <tr>
          <td>#ThisCity#</td>
          <td><div align="center">#ThisState#</div></td>
          <td><div align="center">#ThisCountry#</div></td>
          <td><div align="center">#ThisZip#</div></td>
          <td><div align="center"><a href = "doshipping.cfm?action=DeleteShippingPoint&PointID=#MyCount#">Delete</a></div></td>
        </tr>
      </cfoutput> 
    </cfloop>
  </cfif>
</table>

  <p></p>
<p> </p>

<form name="form1" method="post" action="doshipping.cfm">
    <input type="hidden" Name="Action" Value="FinishUPSSetup">
    <input type="submit" name="Submit" value="Finished">
  </form>
<p>&nbsp;</p>
