<cfinclude template="../queries/qrytaxes.cfm">
<cfinclude template="../queries/qrysellingareas.cfm">
<h2>Taxes <cfoutput><a href = "#request.AdminPath#helpdocs/taxes.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></h2>
<form name="globe" Method = "POST" action="dosetup.cfm">
  <p>Use the table below to specify which areas you need to charge a sales tax in. If someone orders from a region listed, the specified sales tax is calculated. Please note that the drop down boxes only show areas that you ship to. If you need to change the areas you ship to <a href="../components/shipping/doshipping.cfm?action=shippingareas">click here</a>. </p>
  
<cfif qryStates.recordcount IS 0 OR qryCountries.recordcount IS 0>
<p>
<font color="#FF0000"><b><h3>Warning!</h3>  You do not have any states/provinces and/or countries setup to ship to.  If you do not have them setup, your customers will be given a text box and they will have to type their state/province and country into the box.  If you specify tax information here, and they mistype the information, they will not be charged a sales tax.  If you plan on charging taxes, then you should setup the areas you ship to <a href="../components/shipping/doShipping.cfm?action=shippingareas">here</a>.</b></font>
</cfif>
  
  <p><span style="font-weight: bold">New Tax: </span><br />
    <cfif qryStates.recordcount GT 0>
	<select name="region">
		<option value = "None" SELECTED>All States/Provinces in...</option>
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
		State/Province <input type = "text" Name= "Region" size="35"> in Country of
	</cfif>
    
	<cfif qryCountries.recordcount GT 0>
    <select name="country">
		<cfloop query = "qrycountries">
		  <cfif qrycountries.showthis IS 'Yes'>
			<cfoutput><option value="#qrycountries.countrycode#">#qrycountries.country#</option></cfoutput>
		  </cfif>
		</cfloop>
    </select>
	<cfelse>
		<input type = "text" name = "Country" size="35" />
	</cfif>
    with zip/postal code (optional)*: 
    <input name="ZipCode" type="text" id="ZipCode" size="6">
    <br />
    charge (in decimal format: 7% = .07):
    <input name="TaxRate" type="text" id="TaxRate" value=".00" size="5" maxlength="5">
    tax
    <input type="hidden" value="addTax" name="action">
    <input type="submit" name="Submit" value="Add to Tax Table">
  </p>
  <p>* Fill in the zip/postal code field if this is for a local sales tax, otherwise just leave 
    it blank to apply the tax to entire state/province. </p>
</form>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0">
  <tr bgcolor="#003399"> 
    <td width="26%"><div align="center"><b> <font color="#FFFFFF"> State/Province/Region</font></b></div></td>
    <td width="21%"><div align="center"><strong><font color="#FFFFFF"> Country</font></strong></div></td>
    <td width="14%"><div align="center"><font color="#FFFFFF"><strong>Zip Code</strong></font></div></td>
    <td width="23%"><div align="center"><strong><font color="#FFFFFF"> % Sales 
        Tax<br>
        (Decimal Format)</font></strong></div></td>
    <td width="16%"><div align="center"></div></td>
  </tr>
  <cfoutput query = "qryTaxes"> 
    <tr> 
      <td><div align="center">#Region#</div></td>
      <td><div align="center">#Country#</div></td>
      <td><div align="center">#ZipCode#</div></td>
      <td><div align="center">#TaxRate#</div></td>
      <td><div align="center"><a href = "dosetup.cfm?action=DeleteTax&TaxID=#TaxID#">Delete</a></div></td>
    </tr>
  </cfoutput> 
</table>








