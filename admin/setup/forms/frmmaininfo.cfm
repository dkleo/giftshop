<h2>Store Information</h2>
<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfinclude template = "../queries/qrysellingareas.cfm">
<cfif ISDEFINED('url.updated')>
  <strong><font color="#FF0000">Settings were saved.</font></strong> 
</cfif>
<cfoutput Query="qryCompanyInfo"> 
<form name="MainInfo" method="POST" action="dosetup.cfm">
  <table width="100%" border="0" cellpadding="6" cellspacing="0">
    <tr>
      <td colspan="2" bgcolor="##000000"><strong><font color="##FFFFFF">Main Settings </font></strong></td>
    </tr>
    <tr> 
      <td width="27%"><strong>Company Name:</strong></td>
      <td width="73%"> <input type="text" name="CompanyName" size="53" value="#CompanyName#">      </td>
    </tr>
    <tr>
      <td><strong>First Name: </strong></td>
      <td><input type="text" name="FirstName" size="30" value="#FirstName#" /></td>
    </tr>
    <tr>
      <td><strong>Last Name: </strong></td>
      <td><input type="text" name="LastName" size="30" value="#LastName#" /></td>
    </tr>
    <tr> 
      <td width="27%"><strong>Address:</strong></td>
      <td width="73%"> <input type="text" name="Address" size="39" value="#Address#">      </td>
    </tr>
    <tr> 
      <td width="27%"><strong>Apt or Suite Number:</strong></td>
      <td width="73%"> <input type="text" name="Apt" size="10" value="#Apt#">      </td>
    </tr>
    <tr> 
      <td width="27%"><strong>City:</strong></td>
      <td width="73%"> <input type="text" name="City" size="36" value="#City#">      </td>
    </tr>
    <tr> 
      <td width="27%"><strong>State/Province:</strong></td>
      <td width="73%">
      <select name="State">
  	  <option value="N-A">SELECT STATE/PROVINCE</option>
	 <cfloop query = "qryCountries">
		<cfquery name = "qryGetStates" dbtype="query">
		SELECT * FROM qryStates WHERE country = '#qryCountries.id#'
		</cfquery>
		
		<cfif NOT qryGetStates.recordcount IS 0>
			<cfif qryCountries.recordcount GT 1>
				<option value="N-A" style="background:##FFFFCC;">#Ucase(qryCountries.Country)#</option>
			</cfif>
			<cfloop query = "qryGetStates">
				<option value="#qryGetStates.statecode#" <cfif qryGetStates.statecode IS qryCompanyInfo.State>SELECTED</cfif>>#State#</option>
			</cfloop> 
		</cfif>
	</cfloop>
	  </select>
      <!---<select name="State">
                  <cfloop query = "qrysellingareas">
				  		<option value = "None" <cfif #qryCompanyInfo.state# IS 'None'>SELECTED</cfif>>None</option>
                    <cfloop index = 'Mycount' from = "1" to = "#ListLen(States)#">
                      <cfset ThisState = #ListGetAt(States, mycount)#>
                      <cfset ThisStateCode= #ListGetAt(StateCodes, mycount)#>
                      <option value = "#ThisStateCode#" <cfif #qryCompanyInfo.State# IS #ThisStateCode#>SELECTED</cfif>>#ThisState#</option>
                    </cfloop>
	      </cfloop>
      </select>---></td>
    </tr>
    <tr> 
      <td width="27%"><strong>Zip/Postal Code: </strong></td>
      <td width="73%"> <input type="text" name="Zip" size="13" value="#Zip#">
      (If applicable)</td>
    </tr>
    <tr>
      <td><strong>Country:</strong></td>
      <td>
	  <select name="Country">
			<cfloop query = "qrycountries">
				<option value="#qrycountries.countrycode#" <cfif qryCompanyInfo.country IS #qrycountries.countrycode#>SELECTED</cfif>>#qrycountries.country#</option>
			</cfloop>	 
      </select>
	  <!---<select name="Country">
                  <cfloop query = "qrysellingareas"> 
                    <cfloop index = 'Mycount' from = "1" to = "#ListLen(Countries)#">
                      <cfset ThisCountry = #ListGetAt(Countries, mycount)#>
                      <cfset ThisCountryCode= #ListGetAt(CountryCodes, mycount)#>
                      <option value = "#ThisCountryCode#" <cfif #ThisCountryCode# IS #qryCompanyInfo.Country#>SELECTED</cfif>>#ThisCountry#
					  </option>
                    </cfloop>
                  </cfloop> 
      </select>---></td>
    </tr>
    <tr> 
      <td width="27%"><strong>Email Address</strong>:</td>
      <td width="73%"> <input type="text" name="EmailAddress" size="40" value="#EmailAddress#"><a href = "#request.AdminPath#helpdocs/email_address.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a>      </td>
    </tr>
    <tr> 
      <td width="27%"><strong>Phone Number 1 :&nbsp; </strong></td>
      <td width="73%"> <input type="text" name="Phone1" size="21" value="#PhoneNumber1#">      </td>
    </tr>
    <tr> 
      <td width="27%"><strong>Phone Number 2 :&nbsp; </strong></td>
      <td width="73%"> <input type="text" name="Phone2" size="21" value="#PhoneNumber2#">      </td>
    </tr>     
<!---    <tr>
      <td><strong>License ID: </strong></td>
      <td><input type="text" name="licenseid" size="21" value="#LicenseID#" />
	  <a href = "#request.AdminPath#helpdocs/license_id.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
    </tr>--->
	<tr>
      <td>&nbsp;</td>
      <td><a href = "#request.AdminPath#/help/index.cfm?action=view&contentid=24" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")></a></td>
    </tr>
  </table>
</cfoutput> 
   <input type="hidden" name="action" value="UpdateCompanyInfo">
   <input type="hidden" name="licenseid" value="free" />
   <input type="submit" value="Update Information" name="UpdateButton">
</form>







