<cfinclude template = "../queries/qryupssettings.cfm">
<cfinclude template = "../queries/qrysellingareas.cfm">

<p><strong>Select the State, Country and Zip Code from where you ship your products:</strong></p>
<form name = "myform" action="doshipping.cfm" method="post">
  <table width="44%">
    <cfoutput> 
      <tr>
        <td height="52"><strong>City:</strong></td>
        <td height="52"><input name="City" type="text" id="City" value="#qryUPSSettings.ShipFromCities#" size="20"></td>
      </tr>
      <tr> 
        <td width="35%" height="52"><p><strong>State/Province:</strong></p></td>
        <td width="65%" height="52"> <select name="State">
           <option value = "None" <cfif #qryUPSSettings.ShipFromStates# IS ''>SELECTED</cfif>>None</option>
            <cfloop query = "qryStates">
                <option value = "#qryStates.StateCode#" <cfif #qryUPSSettings.ShipFromStates# IS #qryStates.statecode#>SELECTED</cfif>>#qryStates.state#</option>
              </cfloop>
          </select></td>
      </tr>
      <tr> 
        <td width="35%" height="23"><strong>Zip/Postal Code: </strong></td>
        <td width="65%" height="23"> <input type="text" name="Zip" size="13" value="#qryUPSSettings.ShipFromZips#">
          (If applicable)</td>
      </tr>
      <tr> 
        <td height="57"><strong>Country:</strong></td>
        <td height="57"><select name="Country">
            <cfloop query = "qryCountries">
                <option value = "#qryCountries.CountryCode#" <cfif #qryCountries.CountryCode# IS #qryUPSSettings.ShipFromCountries#>SELECTED</cfif>>#qryCountries.Country#</option>
              </cfloop>
          </select>
          </td>
      </tr>
    </cfoutput> 
  </table>
<p>
<input type = "hidden" Name="Action" Value="UpdateShippingLocation">
<input type="submit" name="Submit" value="Finish Setup"> </p>
</form>

