<cfinclude template = "../queries/qryfedexsettings.cfm">
<!---Set the total number of packages being shipped equal to the number of items in the cart.  We
treat each item as being shipped seperately--->
<cfif ShippingItems LT 1>
	<cfset Cart.TotalShippingCosts = 0>
</cfif>
<cfif ShippingItems GT 0>
<cfset numPackages = #ShippingItems#>
<cfset TheCartWeight = '#TotalCartWeight#'>
<cfset TotalWeightOfEachPackage = TotalCartWeight / numPackages>
<cfset Cart.TotalShippingCosts = 0>
<cfset today = now()>

<!---FEDEX Settings--->
<cfoutput query = 'qryFEDEXSettings'>
	<cfset CartVar.Account = accountnumber>
	<cfset CartVar.metercode = metercode>
	<cfset DropOffType = DropOffType>
	<!---Get the list of acceptable services the customer can choose--->
	<cfset CurrencyCode = currencycode>
	<cfset ServiceNames = ServiceNames>
	<cfset FromCity = ShipFromCities>
	<cfset FromState = ShipFromStates>
	<cfset FromCountry = ShipFromCountries>
	<cfset FromZip = ShipFromZips>
</cfoutput>


<!---if using multiple shipping points feature figure out closest point of origin to buyer--->
<cfif #qryFEDEXSettings.MultipleShippingPoints# IS 'Yes'>
	<cfif #ListLen(FromState)# GT 1>
	<!---To do this, we need to build a query--->
	<cfset LCities = "">
	<cfset LStates = "">
	<cfset LCountries = "">
	<cfset LZips = "">
	<cfset LShipCharges = "">

	<cfset CheapestShipPoint = QueryNew("")>

	<cfloop index="shipcount" from="1" To="#ListLen(FromState)#">
		<cfset ThisCity = ListGetAt(FromCity, shipcount)>	
		<cfset ThisState = ListGetAt(FromState, shipcount)>
		<cfset ThisCountry = ListGetAt(FromCountry, shipcount)>
		<cfset ThisZip = ListGetAt(FromZip, shipcount)>

		<cfset LCities = ListAppend(LCities, "#ThisCity#", "^")>
		<cfset LStates = ListAppend(LStates, "#ThisState#", "^")>
		<cfset LCountries = ListAppend(LCountries, "#ThisCountry#", "^")>
		<cfset LZips = ListAppend(LZips, "#ThisZip#", "^")>

		<!---Get the rate for this setting--->
		<cfoutput>
		<cf_fedexxml
			function="RateRequest"
			accountnumber="#CartVar.Account#"
			fedexidentifier="#CartVar.MeterCode#"
			servicelevel="FEDEXGROUND"						
			raterequesttype="FDXG"
			shipperzip="#ThisZip#"
			shipperstate="#ThisState#"
			shippercountry="#ThisCountry#"
			shiptozip="#form.ship_zip#"
			shiptostate="#form.ship_state#"
			shiptocountry="#form.ship_country#"
			packageweight="#TotalWeightOfEachPackage#"
			packagecount="#NumPackages#"
			currencycode="#currencycode#"
			packaging="YOURPACKAGING"
			dropofftype="REGULARPICKUP"
			ssresdelivery="1"
			requestlistrates="1"
			debug="False">
			</cfoutput>

			<cfif NOT IsDefined("qAvailServices")>
				<!---error occurred so show the error message---> 
				#fedexerror#<br />
				Description:  #FedexErrorDesc#
			<cfelse>
				<!---No error, so add the charge to the list--->
				<cfoutput query = "qFedexRateQuery">
					<cfset LShipCharges = ListAppend(LShipCharges, "#ListTotalCustomerCharge#", "^")>
				</cfoutput>
			</cfif>
			
	</cfloop>
	
		<cfset ACities = ListToArray(LCities, "^")>
		<cfset AStates = ListToArray(LStates, "^")>
		<cfset ACountries = ListToArray(LCountries, "^")>
		<cfset AZips = ListToArray(LZips, "^")>
		<cfset AShipCharges = ListToArray(LShipCharges, "^")>
		
		<!---Now create a query based on the list values above--->
		<cfset nColumnNumber1 = QueryAddColumn(CheapestShipPoint, "City", ACities)>
		<cfset nColumnNumber2 = QueryAddColumn(CheapestShipPoint, "States", AStates)>
		<cfset nColumnNumber3 = QueryAddColumn(CheapestShipPoint, "Countries", ACountries)>
		<cfset nColumnNumber4 = QueryAddColumn(CheapestShipPoint, "Zips", AZips)>
		<cfset nColumnNumber5 = QueryAddColumn(CheapestShipPoint, "ShipCharges", AShipCharges)>
		
		<cfquery dbtype="query" name="LowestPrice">
		SELECT * 
		FROM CheapestShipPoint 
		ORDER BY ShipCharges DESC
		</cfquery>
		
		<cfoutput query = "LowestPrice">
			<cfset FromCity = '#City#'>
			<cfset FromState = '#States#'>
			<cfset FromCountry = '#Countries#'>
			<cfset FromZip = '#Zips#'>
		</cfoutput>	

	</cfif>
</cfif>
<!---End the multiple points code and now get the rate for this order--->
<cfoutput>

<cfif TheCartWeight LT 150>

<cfset totalpackages = 1>

<cf_fedexxml
	function="ServicesAvailRequest"
	PickupDate="#dateformat(today, 'YYYY-MM-DD')#"
	fedexindentifier="#CartVar.metercode#"
	accountnumber="#CartVar.Account#"
	servicelevel="ALL"
	raterequesttype="FDXE"
	shipperzip="#FromZip#"
	shipperstate="#FromState#"
	shippercountry="#FromCountry#"
	shiptozip="#form.ship_zip#"
	shiptostate="#form.ship_state#"
	shiptocountry="#form.ship_country#"
	packageweight="#TheCartWeight#"
	packagecount="1"
	currencycode="#currencycode#"
	packaging="YOURPACKAGING"
	dropofftype="REGULARPICKUP"
	declaredvalue="#crtTotal#"
	ssresdelivery="1"
	requestlistrates="1"
	debug="False">
<cfelse>

<cfset totalpackages = totalcartweight / 150>
<cfset totalpackages = round(totalpackages)>
<cf_fedexxml
	function="ServicesAvailRequest"
	PickupDate="#dateformat(today, 'YYYY-MM-DD')#"
	fedexindentifier="#CartVar.metercode#"
	accountnumber="#CartVar.Account#"
	servicelevel="ALL"
	raterequesttype="FDXE"
	shipperzip="#FromZip#"
	shipperstate="#FromState#"
	shippercountry="#FromCountry#"
	shiptozip="#form.ship_zip#"
	shiptostate="#form.ship_state#"
	shiptocountry="#form.ship_country#"
	packageweight="#TheCartWeight#"
	packagecount="1"
	currencycode="#currencycode#"
	packaging="YOURPACKAGING"
	dropofftype="REGULARPICKUP"
	declaredvalue="#crtTotal#"
	ssresdelivery="1"
	requestlistrates="1"
	debug="False">

<!---for freight...uncomment this if you are shipping stuff by friend over 150lbs--->    
<!---<cf_fedexxml
	function="RateRequest"
	fedexindentifier="#CartVar.metercode#"
	accountnumber="#CartVar.Account#"
	PickupDate="#dateformat(today, 'YYYY-MM-DD')#"
	dropofftype="REGULARPICKUP"
	servicelevel="FEDEX3DAYFREIGHT"
	raterequesttype="FDXE"
	shipperzip="#FromZip#"
	shipperstate="#FromState#"
	shippercountry="#FromCountry#"
	shiptozip="#form.ship_zip#"
	shiptostate="#form.ship_state#"
	shiptocountry="#form.ship_country#"
	packageweight="150"
	packagecount="1"
	currencycode="#currencycode#"
	packaging="YOURPACKAGING"
	declaredvalue="500"
	ssresdelivery="1"
	requestlistrates="1"
	debug="False">--->
</cfif>
</cfoutput>

<cfif NOT IsDefined("qAvailServices")>
	<cfif fedexerror GT 0>
		<!---error occurred so show the error message---> 
		<cfif fedexerror IS 1>
			<cfinclude template = "actFedexErrorHandle.cfm">
		</cfif>
		<cfif fedexerror IS 2>
			<cfoutput>
			ERROR for FEDEX SHIPPING: (#fedexerror#) We are sorry, but shipping could not been calculated for this order.  
			<br />The website owner	will contact you with a shipping quote after the order has been placed.
			</cfoutput>
		</cfif>
	</cfif>
</cfif>

<cfif IsDefined("qAvailServices")>
  <cfloop query="qAvailServices">
	<cfif Service IS 'FEDEXGROUND'>

<!---	<cfif len(ListNetTotalCharge) GT 0>
		<cfset Cart.TotalShippingCosts = #ListNetTotalCharge#>
	<cfelse>
		<cfset Cart.TotalShippingCosts = #DISCBASETOTALCHARGES#>
	</cfif>--->

	<cfset Cart.TotalShippingCosts = #ListNetTotalCharge# + cart.Surcharges>
	<cfset request.ShipFromState = #FromState#>
	<cfset request.ShipFromCountry = #FromCountry#>
	<cfset Cart.DefaultService = #Service#>
	</cfif>
  </cfloop>

</cfif>

<!---
<cfif IsDefined("qFedexRateQuery")>
  <cfloop query="qFedexRateQuery">
	<cfif len(ListNetTotalCharge) GT 0>
		<cfset Cart.TotalShippingCosts = #ListNetTotalCharge#>
	<cfelse>
		<cfset Cart.TotalShippingCosts = #DISCBASETOTALCHARGES#>
	</cfif>
	<cfset request.ShipFromState = #FromState#>
	<cfset request.ShipFromCountry = #FromCountry#>
	<cfset Cart.DefaultService = 'FEDEX3DAYFREIGHT'>
  </cfloop>
</cfif>--->

</cfif>

<cfif Cart.TotalShippingCosts LT 1>
	<cfset doFallBackMethod = 1>
	<cfinclude template = 'actFigureShipping.cfm'>
</cfif>