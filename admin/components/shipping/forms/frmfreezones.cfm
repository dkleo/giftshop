<cfinclude template="../queries/qryfreezones.cfm">
<cfinclude template="../queries/qrysellingareas.cfm">

<form name="freezones" Method = "POST" action="doshipping.cfm">
  <p><strong>Free Zones </strong> <cfoutput><a href = "#request.AdminPath#helpdocs/shipping_free_zones.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></p>
<cfif qryStates.recordcount IS 0 OR qryCountries.recordcount IS 0>
<p>
<font color="#FF0000"><b><h2>Warning!</h2>  You do not have any states/provinces and/or countries setup to ship to.  If you do not have them setup, your customers will be given a text box and they will have to type their state/province and country into the box.  If you specify tax information here, and they mistype the information, they will not be charged a sales tax.  If you plan on charging taxes, then you should setup the areas you ship to <a href="../components/shipping/doshipping.cfm?action=shippingareas">here</a>.</b></font>
</cfif>
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
    with Postal Code: 
    <input name="zipcode" type="text" id="zipcode" size="10" /> 
    in City/Town/Village named:
    <input name="city" type="text" id="city" size="20" />
<input type="hidden" value="addfreezone" name="action">
    <input type="submit" name="Submit" value="Add">
  </p>
</form>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0">
  <tr bgcolor="#003399"> 
    <td width="26%"><div align="center"><b> <font color="#FFFFFF"> State/Province/Region</font></b></div></td>
    <td width="25%"><div align="center"><strong><font color="#FFFFFF">Country</font></strong></div></td>
    <td width="23%"><div align="center"><strong><font color="#FFFFFF">In Postal Code </font></strong></div></td>
    <td width="20%"><div align="center"><strong><font color="#FFFFFF">In City/Town/Village</font></strong></div></td>
    <td width="10%"><div align="center"><font color="#FFFFFF"><strong>Remove</strong></font> </div>
    <div align="center"><strong><font color="#FFFFFF"> </font></strong></div></td>
  </tr>
  <cfoutput query = "qryfreezones"> 
    <tr> 
      <td><div align="center">#Region#</div></td>
      <td><div align="center">#Country#</div></td>
      <td><div align="center"><cfif NOT zipcode IS ''>#ZipCode#<cfelse>All In Region</cfif></div></td>
      <td><div align="center"><cfif NOT city IS ''>#city#<cfelse>All Applicable</cfif></div></td>
      <td><div align="center"><a href = "doshipping.cfm?action=DeleteFreeZone&id=#id#">Delete</a></div></td>
    </tr>
  </cfoutput> 
</table>

