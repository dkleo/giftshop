<!---This is included in the frmReviewOrer.cfm file to allow shipping charges to be updated based on options
created in one of the custom shipping tables.  A Customer can select which type of shipping they want and then
update the order--->
<form method="Post" <cfoutput>action="index.cfm?action=updateshipping&CartToken=#CartToken#"</cfoutput>>
<!---Allow the shipping costs to be updated based on the options given--->

<input type = "hidden" value="UpdateShipping" Name="action">

<!---If shipping price is updated pass back all the variables to the same form--->
<cfif isdefined('form')>
  <CFLOOP COLLECTION="#Form#" ITEM="VarName">
    <cfoutput>
    <cfif NOT VarName IS 'UPSShipping'>
        <span style="font-weight: bold">
          <input type="hidden" name="#VarName#" value="#evaluate(varname)#">
          </span>
    </cfif>
    </cfoutput>
  </CFLOOP>
</cfif>

<cfif isdefined('url')>
  <CFLOOP COLLECTION="#url#" ITEM="VarName">
    <cfoutput>
    <cfif NOT VarName IS 'UPSShipping'>
        <span style="font-weight: bold">
          <input type="hidden" name="#VarName#" value="#evaluate(varname)#">
         </span>
    </cfif>
    </cfoutput>
  </CFLOOP>
</cfif>

<cfif ISDEFINED('TheShippingMethod')>
<!---Tracks what method the customer chose for shipping if the shipping is based on weight
	  ...there is a drop down shown on the checkout form that they can choose from--->
  <input type = "hidden" Value = "#TheShippingMethod#" Name="ShippingMethod">
</cfif>

<!---If UPS caluclations are on then display shipping options--->
<cfif shipmethodused IS '10'>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr> 
        <td width="100%"> 
		<cfif isdefined("response")>
			<!---show it if they don't just do ground shipments--->
            <cfif NOT qryUPSSettings.ServiceNames IS '03,11'>
		        <table width="100%" border="0" align="Left" cellpadding="4" cellspacing="0">
                  <tr> 
                    <td colspan="2" align="left" Class="TableTitles" style="border-left: 2px solid rgb(0,0,0); border-right: 2px solid rgb(0,0,0); border-Top: 2px solid rgb(0,0,0)"><strong>Change Shipping Method</strong></td>
                  </tr>
                  <tr> 
                    <td width="100%" align="left" style="border-left: 2px solid rgb(0,0,0); border-right: 2px solid rgb(0,0,0); border-bottom: 2px solid rgb(0,0,0)"> 
                      <cfset ServicesList = '#qryUPSSettings.ServiceCodes#'> 
					  <cfset ServiceNames = '#qryUPSSettings.ServiceNames#'> 
                      <p> <br>
                        <select name="UPSShipping">
                          <cfoutput query = "response">
                            <cfif ServicesList CONTAINS '#ServiceCode#'>
                              <cfif request.EnableEuro IS 'Yes'>
                                <cfset totalrate = rate + cart.Surcharges>
                                <option value="#Service#, #totalrate#" <cfif Service IS #Cart.DefaultService#>selected="selected"</cfif>>#Service# - #lseurocurrencyformat(rate, "Local")#</option>
                              </cfif>
                              <cfif request.EnableEuro IS 'No'>
                                <cfset totalrate = rate + cart.Surcharges>
                                <option value="#Service#, #totalrate#" <cfif Service IS #Cart.DefaultService#>selected="selected"</cfif>>#Service# 
                                  - #lscurrencyformat(rate, "Local")#</option>
                              </cfif>
                            </cfif>
                          </cfoutput>
                        </select>
                        
                        <input type="submit" name="Submit2" value="Update Shipping">
                      </td>
                  </tr>
                </table>
            </cfif>
          </cfif> </td>
      </tr></table>
</cfif>

<!---End UPS Table--->

<!---If FEDEX caluclations are on then display shipping options--->
<cfif shipmethodused IS '11'>
<cfif isdefined('qAvailServices')>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr> 
        <td width="100%"> 
		<cfif isdefined("qAvailServices")>
			<!---show it if they don't just do ground shipments--->
            <cfif NOT qryFEDEXSettings.ServiceNames IS 'FEDEXGROUND'>
		        <table width="100%" border="0" align="left" cellpadding="4" cellspacing="0">
                  <tr> 
                    <td colspan="2" align="left" Class="TableTitles" style="border-left: 2px solid rgb(0,0,0); border-right: 2px solid rgb(0,0,0); border-Top: 2px solid rgb(0,0,0)"><strong>Change Shipping Method </strong></td>
                  </tr>
                  <tr> 
                    <td width="100%" align="left" style="border-left: 2px solid rgb(0,0,0); border-right: 2px solid rgb(0,0,0); border-bottom: 2px solid rgb(0,0,0)"> 
                      <cfset ServicesList = '#qryFEDEXSettings.ServiceCodes#'> 
					  <cfset ServiceNames = '#qryFEDEXSettings.ServiceNames#'> 
                      <p> <br>
						<select Name="UPSShipping">
                          <cfloop query = "qAvailServices">
							 <cfquery dbtype="query" name="qServiceDesc">
								SELECT * FROM qServiceLevelFdx 
								WHERE ServiceLevelCode = '#Service#'
							 </cfquery> 
                            
							 <cfoutput>
							 <cfif ServicesList CONTAINS '#Service#'>
                             <cfset totalrate = ListNetTotalCharge + cart.Surcharges>
							 <cfif request.EnableEuro IS 'Yes'>
								<option SELECTED value="#Service#, #totalrate#" <cfif Service IS #Cart.DefaultService#>selected="selected"</cfif>>
								#qServiceDesc.ServiceLevelDesc# - #lseurocurrencyformat(totalrate, "Local")#</option>
                              </cfif>
                              <cfif request.EnableEuro IS 'No'>
                                <option SELECTED value="#Service#, #totalrate#" <cfif Service IS #Cart.DefaultService#>selected="selected"</cfif>>		
								#qServiceDesc.ServiceLevelDesc# - #lscurrencyformat(totalrate, "Local")#</option>
                              </cfif>
							  </cfif>
							  </cfoutput>
                         </cfloop> 
                        </select>
                        <input type="submit" name="Submit2" value="Update Shipping">
                        </td>
                  </tr>
                </table>
            </cfif>
          </cfif> </td>
      </tr></table>
</cfif>
</cfif>
<!---End FEDEX Table--->

<!---If one of the Custom Shipping Methods is used, display the shipping options here (if there are more than one--->
<cfif shipmethodused IS '2' OR shipmethodused IS '3' OR shipmethodused IS '5' OR shipmethodused IS '6' OR shipmethodused IS '9'>
<cfif isdefined("Shippingoptions")>
<cfif #ListLen(Shippingoptions, ",")# GT 1>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td width="100%">
        <table width="100%" border="0" align="Left" cellpadding="4" cellspacing="0">
          <tr> 
            <td Class="TableTitles" style="border-left: 2px solid rgb(0,0,0); border-right: 2px solid rgb(0,0,0); border-Top: 2px solid rgb(0,0,0)"><strong>
Change Shipping Method</strong></td>
          </tr>
          <tr> 
            <td style="border-left: 2px solid rgb(0,0,0); border-right: 2px solid rgb(0,0,0); border-bottom: 2px solid rgb(0,0,0)"> 
              <cfset ServiceNames = '#Shippingoptions#'> <cfset ServicePrices = '#ShippingCosts#'> 
              <p> <br>
                  <select Name="UPSShipping">
                  <cfloop index="mycount" from="1" To="#ListLen(Servicenames)#">
                    <cfset ThisServiceName = ListGetAt(ServiceNames, mycount)>
                    <cfset ThisPrice = ListGetAt(ServicePrices, mycount)>
                    <cfset ThisPrice = ThisPrice + cart.Surcharges>
                    <cfif mycount GT 1 AND ThisPrice IS 0>
                      <!---Do nothing since this is not the first value and the price is $0.00--->
                      <cfelse>
                      <!---Check to see if they are eligable for this shipping option.  If so, display it--->
                      <cfquery name = "GetTypes" datasource="#request.dsn#">
                      SELECT * FROM ShippingTypes WHERE ShippingType = '#ThisServiceName#' 
                      </cfquery>
                      <cfset TypeFor = 'All'>
                      <cfoutput query = "GetTypes"> 
                        <cfset TypeFor = '#AvailableTo#'>
                      </cfoutput> <cfoutput> 
                        <cfif TypeFor IS 'All'>
                          <cfif request.EnableEuro IS 'Yes'>
                            <option value="#ThisServiceName#, #ThisPrice#" <cfif ThisServiceName IS #Cart.DefaultService#>SELECTED</cfif>>#ThisServiceName# 
                            - #lseurocurrencyformat(ThisPrice, "Local")#</option>
                          </cfif>
                          <cfif request.EnableEuro IS 'No'>
                            <option value="#ThisServiceName#, #ThisPrice#" <cfif ThisServiceName IS #Cart.DefaultService#>SELECTED</cfif>>#ThisServiceName# 
                            - #lscurrencyformat(ThisPrice, "Local")#</option>
                          </cfif>
                        </cfif>
                        <cfif TypeFor IS 'CA' and Form.ShipCountry IS 'CA'>
                          <cfif request.EnableEuro IS 'Yes'>
                            <option value="#ThisServiceName#, #ThisPrice#" <cfif ThisServiceName IS #Cart.DefaultService#>SELECTED</cfif>>#ThisServiceName# 
                            - #lseurocurrencyformat(ThisPrice, "Local")#</option>
                          </cfif>
                          <cfif request.EnableEuro IS 'No'>
                            <option value="#ThisServiceName#, #ThisPrice#" <cfif ThisServiceName IS #Cart.DefaultService#>SELECTED</cfif>>#ThisServiceName# 
                            - #lscurrencyformat(ThisPrice, "Local")#</option>
                          </cfif>
                        </cfif>
                        <cfif TypeFor IS 'US' and Form.ShipCountry IS 'US'>
                          <cfif request.EnableEuro IS 'Yes'>
                            <option value="#ThisServiceName#, #ThisPrice#" <cfif ThisServiceName IS #Cart.DefaultService#>SELECTED</cfif>>#ThisServiceName# 
                            - #lseurocurrencyformat(ThisPrice, "Local")#</option>
                          </cfif>
                          <cfif request.EnableEuro IS 'No'>
                            <option value="#ThisServiceName#, #ThisPrice#" <cfif ThisServiceName IS #Cart.DefaultService#>SELECTED</cfif>>#ThisServiceName# 
                            - #lscurrencyformat(ThisPrice, "Local")#</option>
                          </cfif>
                        </cfif>
                        <cfif TypeFor IS 'USCA' and Form.ShipCountry IS 'US' OR TypeFor IS 'USCA' AND Form.ShipCountry IS 'CA'>
                          <cfif request.EnableEuro IS 'Yes'>
                            <option value="#ThisServiceName#, #ThisPrice#" <cfif ThisServiceName IS #Cart.DefaultService#>SELECTED</cfif>>#ThisServiceName# 
                            - #lseurocurrencyformat(ThisPrice, "Local")#</option>
                          </cfif>
                          <cfif request.EnableEuro IS 'No'>
                            <option value="#ThisServiceName#, #ThisPrice#" <cfif ThisServiceName IS #Cart.DefaultService#>SELECTED</cfif>>#ThisServiceName# 
                            - #lscurrencyformat(ThisPrice, "Local")#</option>
                          </cfif>
                        </cfif>
                        <cfif TypeFor IS 'INT' and NOT form.ShipCountry IS request.Country>
                          <cfif request.EnableEuro IS 'Yes'>
                            <option value="#ThisServiceName#, #ThisPrice#" <cfif ThisServiceName IS #Cart.DefaultService#>SELECTED</cfif>>#ThisServiceName# 
                            - #lseurocurrencyformat(ThisPrice, "Local")#</option>
                          </cfif>
                          <cfif request.EnableEuro IS 'No'>
                            <option value="#ThisServiceName#, #ThisPrice#" <cfif ThisServiceName IS #Cart.DefaultService#>SELECTED</cfif>>#ThisServiceName# 
                            - #lscurrencyformat(ThisPrice, "Local")#</option>
                          </cfif>
                        </cfif>
                      </cfoutput> 
                    </cfif>
                  </cfloop>
                </select>
                <input type="submit" name="Submit3" value="Update Order">
              </p>
              <p>&nbsp;</p></td>
          </tr>
        </table>
</td>
</tr>
</table>
</cfif>
</cfif>
</cfif>
</form>

<!---End Custom Shipping Table--->