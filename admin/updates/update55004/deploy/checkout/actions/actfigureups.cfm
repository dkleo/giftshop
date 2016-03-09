<cfinclude template = "../queries/qryUPSSettings.cfm">

<!---Set the total number of packages being shipped equal to the number of items in the cart.  We
treat each item as being shipped seperately--->
<cfif ShippingItems LT 1>
	<cfset Cart.TotalShippingCosts = 0>
</cfif>
<cfif ShippingItems GT 0>
<cfset numPackages = #ShippingItems#>
<cfset TheCartWeight = '#TotalCartWeight#'>
<cfset TotalWeightOfEachPackage = TotalCartWeight / numPackages>

<!---UPS Settings--->
<cfoutput query = 'qryUPSSettings'>
	<cfset request.AccessKey = "#AccessKey#">
	<cfset request.UPSUserid = "#UserName#">
	<cfset request.UPSPassword = "#CustPassword#">
	<cfset request.UPSAccountNumber = "#AccountNumber#">
	<!---Get the list of acceptable services the customer can choose--->
	<cfset ServiceNames = '#ServiceNames#'>
	<cfset FromCity = '#ShipFromCities#'>
	<cfset FromState = '#ShipFromStates#'>
	<cfset FromCountry = '#ShipFromCountries#'>
	<cfset FromZip = '#ShipFromZips#'>
</cfoutput>


<cfif #qryUPSSettings.MultipleShippingPoints# IS 'Yes'>
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
		<cf_upsmx
			accesslicensenumber="#request.AccessKey#"
			userid="#request.UPSUserID#"
			Password="#request.UPSPassword#"
			requestaction="Rate"
			requestoption="Shop"
			pickuptypecode="03"		
			shipmentshipperaddresspostalcode="#ThisZip#"
			shipmentshiptoaddresspostalcode="#trim(form.Ship_Zip)#"
			shipmentshiptoaddresscountrycode="#form.ship_country#"
			packagepackagingtypecode="02"
			packagedescription="Shopping cart"
			packageweight="#TotalWeightOfEachPackage#"
			additionalhandling="0"
			numberofpackages="#NumPackages#"
			mode="live"
			variable="response">

			<cfif structKeyExists(response, 'error')>
				<!---error occurred so show the error message---> 
				#response.error.errordescription#		
			<cfelse>
				<!---No error, so add the charge to the list--->
				<cfset LShipCharges = ListAppend(LShipCharges, "#response.rate#", "^")>				
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

<cf_upsmx
	accesslicensenumber="#request.AccessKey#"
	userid="#request.UPSUserID#"
	password="#request.UPSPassword#"
	requestaction="Rate"
	requestoption="Shop"
	pickuptypecode="03"		
	shipmentshipperaddresspostalcode="#FromZip#"
	shipmentshiptoaddresspostalcode="#trim(form.ship_zip)#"
	shipmentshiptoaddresscountrycode="#form.ship_country#"
	packagepackagingtypecode="02"
	packagedescription="Shopping cart"
	packageweight="#TotalWeightOfEachPackage#"
	additionalhandling="0"
	numberofpackages="#NumPackages#"
	mode="live"
	variable="response">

<cfif NOT isdefined('response')>
	<cfset response = querynew(servicecode,rate)>
	We are sorry, but the UPS server could not be reached for a real-time shipping quote at this time.  Wait a minute and hit refresh or proceed with checkout and we will email you a price quote including shipping.<p>
</cfif>

<cfif structKeyExists(response, 'error')> 
	<cfoutput>#response.error.errordescription# (FROM:  #FromZip# To: #form.ship_zip#</cfoutput>
<cfelse>

	<cfloop query = "response">
			<cfif #response.ServiceCode# IS '03' OR #response.servicecode# IS '11'>
				<cfset Cart.TotalShippingCosts = #response.rate#>
				<cfset request.ShipFromState = #FromState#>
				<cfset request.ShipFromCountry = #FromCountry#>
				<cfset Cart.DefaultService = #Service#>
			</cfif>
	</cfloop>

</cfif>
<!---End UPS Caclulations--->
</cfif>


