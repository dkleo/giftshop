<cfoutput><h2>Fedex Labels for #url.OrderNumber#</h2></cfoutput>
<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfinclude template = "../queries/qryfedexsettings.cfm">

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

<cfif NOT DropOffType IS 'REGULARPICKUP' AND NOT DropOffType IS 'REQUESTCOURIER' AND NOT DropOffType IS 'DROPBOX' AND NOT DropOffType IS 'BUSINESSSERVICECENTER' AND NOT DropOffType IS 'STATION'>
	<cfset DropOffType = 'REGULARPICKUP'>
</cfif>

<cfset ShipFromCompany = #qryCompanyInfo.CompanyName#>
<cfif len(ShipFromCompany) LT 1>
	<cfset ShipFromCompany = None>
</cfif>
<cfset ShipFromName = #qryCompanyInfo.ContactName#>
<cfset ShipFromAddress = #qryCompanyInfo.Address#>
<cfset ShipFromAddress2 = #qryCompanyInfo.Apt#>
<cfset ShipFromCity = #qryCompanyInfo.City#>
<cfset ShipFromState = #qryCompanyInfo.State#>
<cfset ShipFromZip = #qryCompanyInfo.Zip#>
<cfset ShipFromCountry = #qryCompanyInfo.Country#>
<cfset ShipFromPhone = #qryCompanyInfo.PhoneNumber1#>
<cfset ShipFromPhone = replacenocase(shipfromphone, "-", "", "ALL")>
<cfset ShipFromPhone = replacenocase(shipfromphone, "(", "", "ALL")>
<cfset ShipFromPhone = replacenocase(shipfromphone, ")", "", "ALL")>

<cfset ThisOrderID = #url.OrderID#>

<cfquery name = "qryOrder" datasource="#request.dsn#">
SELECT * FROM orders WHERE OrderID = #ThisOrderID#
</cfquery>

<!---Get the customers phone number--->
<cfquery name = "qryCustomer" datasource="#request.dsn#">
SELECT * FROM customerhistory WHERE CustomerID = #qryOrder.CustomerID#
</cfquery>

<cfset ShipService = 'FEDEXGROUND'>
<!---Check for valid shipping type...if not valid send via ground--->
<cfoutput query = "qryOrder">
	<cfset ShipService = #ShippingMethod#>
</cfoutput>

<cfif NOT ShipService IS 'STANDARDOVERNIGHT' AND NOT ShipService IS 'PRIORITYOVERNIGHT' AND NOT ShipService IS 'FIRSTOVERNIGHT' AND NOT ShipService IS 'FEDEX2DAY' AND NOT ShipService IS 'FEDEXEXPRESSSAVER' AND NOT ShipService IS 'FEDEXGROUND' AND NOT ShipService IS 'GROUNDHOMEDELIVERY'>
<cfset ShipService = 'FEDEXGROUND'>
</cfif>
	
<cfset phonenumber = '5555555555'>

<cfoutput query = "qryCustomer">
	<cfset phonenumber = #phonenumber#>
</cfoutput>

<cfset phonenumber = replacenocase(phonenumber, "-", "", "ALL")>
<cfset phonenumber = replacenocase(phonenumber, "(", "", "ALL")>
<cfset phonenumber = replacenocase(phonenumber, ")", "", "ALL")>
<cfset phonenumber = replacenocase(phonenumber, " ", "", "ALL")>

<cfif len(phonenumber) LT 10>
	<cfset phonenumber = '5555555555'>
</cfif>

<!---create a query for this order that contains the packagenumbers, trackingnumbers, and methods each was shipped--->
<cfset qShipping = QueryNew("")>

<!---convert each list in the db to an array--->
<cfset AShipped = ListToArray(qryOrder.CrtShipped, "^")>
<cfset ATracking = ListToArray(qryOrder.CrtTrackingNumbers, "^")>
<cfset APackageNumber = ListToArray(qryOrder.CrtPackageNumber, "^")>
<cfset AItemID = ListToArray(qryOrder.CrtItemID, "^")>

<!---Convert each array into a query column--->
<cfset nColumnNumber1 = QueryAddColumn(qShipping, "ShippedBY", "CF_SQL_VARCHAR", AShipped)>
<cfset nColumnNumber2 = QueryAddColumn(qShipping, "Tracking", "CF_SQL_VARCHAR", ATracking)>
<cfset nColumnNumber3 = QueryAddColumn(qShipping, "PackageNumber", "CF_SQL_VARCHAR", APackageNumber)>
<cfset nColumnNumber4 = QueryAddColumn(qShipping, "ItemID", "CF_SQL_VARCHAR", AItemID)>

<!---Query each unique package that was shipped via fedex and get it's weight (only ones that havent already been shipped)--->
<cfquery name = "qPackages" dbtype="query">
SELECT DISTINCT PackageNumber FROM qShipping WHERE tracking = '0'
</cfquery>

<cfloop query = "qPackages">
	<cfquery name = "qPackageContent" dbtype="query">
	SELECT * FROM qShipping WHERE packagenumber = '#qPackages.packagenumber#' AND ShippedBy = 'Fedex'
	</cfquery>
	
	<!---Loop over each item and gets it's weight from the database--->
	<cfset packageweight = 0>
	<cfset packagevalue = 0>
	<cfloop query = "qPackageContent">
	
		<cfquery name = "qWeight" datasource="#request.dsn#">
		SELECT weight,price FROM products WHERE itemid = #qPackageContent.itemid#
		</cfquery>
	
		<cfoutput query = "qWeight">
			<cfset packageweight = packageweight + weight>
			<cfset packagevalue = packagevalue + price>
		</cfoutput>
	</cfloop>
	
	<cfset ThisShipToBusiness = #qryOrder.ShipBusinessName#>
	<cfif len(ThisShipToBusiness) LT 1>
		<cfset ThisShipToBusiness = 'None'>
	</cfif>
	
	<cfset isres = 0>
	
	<cfif ThisShipToBusiness IS 'None'>
		<cfset isres = 0>
	<cfelse>
		<cfset isres = 1>
		<!---It's residential delivery so switch shipservice to GroundHomeDelivery...can we make this more complex, please?--->
		<cfif ShipService IS 'FEDEXGROUND'>
			<cfset ShipService = 'GROUNDHOMEDELIVERY'>
		</cfif>
	</cfif>
	<!---Send the info to fedex about this order and return the shipping label and tracking number for this package--->
	<cfif packageweight GT 0>
		<cf_fedexxml
		function="ShipRequest"
		fedexindentifier="#CartVar.MeterCode#"
		accountnumber="#CartVar.Account#"
		dropofftype="#DropOffType#"
		servicelevel="#ShipService#"
		packagetype="YOURPACKAGING"
		packageweightunit="#qryCompanyInfo.UnitOfMeasure#"
		packageweight="#packageweight#"
		PackageLength="5"
		PackageWidth="5"
		PackageHeight="5"
		PackageUnitOfMeasurement="IN"
		shippercontactname="#ShipFromName#"
		shippercompany="#ShipFromCompany#"
		shipperphone="#left(ShipFromPhone, 10)#"
		shipperstreet="#ShipFromAddress#"
		shipperstreet2="#ShipFromAddress2#"
		shippercity="#ShipFromCity#"
		shipperzip="#ShipFromZip#"
		shipperstate="#ShipFromState#"
		shippercountry="#ShipFromCountry#"
		shiptocontactname="#qryOrder.ShipName#"
		shiptocompany="#ThisShipToBusiness#"
		shiptophone="#left(phonenumber, 10)#"
		shiptostreet="#qryOrder.ShipAddress#"
		shiptostreet2="#qryOrder.ShipAddress2#"
		shiptocity="#qryOrder.ShipCity#"
		shiptostate="#qryOrder.ShipState#"
		shiptozip="#left(qryOrder.ShipZip, 5)#"
		shiptocountry="#qryOrder.ShipCountry#"
		PayorType="SENDER"
		ssresdelivery="#isres#"
		testingenvironment="false"
		DelclaredValue="#packagevalue#"
		MultiPiece="0"
		RequestListRates="1"
		debug="false">
		
		<cfif isdefined('FedexError')>
			<cfif NOT FedexError IS '0'>
				<b>An Error occurred!</b> - <cfoutput>#FedexError# - #fedexerrordesc#</cfoutput>
				<cfabort>
			</cfif>
		</cfif>
				
		<!---If not error then write the tracking number to each of the packages that has this number--->
		<cfloop query = "qShipping">
			<cfif PackageNumber IS qPackages.packagenumber>
				<!---Update the array to reflect the change--->
				<cfset ATracking[#qShipping.CurrentRow#] = '#trackingnumber#'>
			</cfif>
		</cfloop>
		<cfoutput><a href = 'labels/#trackingnumber#.pdf' target="_blank">CLICK HERE TO DOWNLOAD #trackingnumber#</a> - Quoted Cost: $#qFedexRateQuery.TotalCustomerCharge#<br /></cfoutput>
	</cfif>
</cfloop>

<!---Rebuild the qShipping query--->

<cfset qNewShipping = QueryNew("")>

<cfset nColumnNumber1 = QueryAddColumn(qNewShipping, "ShippedBY", "CF_SQL_VARCHAR", AShipped)>
<cfset nColumnNumber2 = QueryAddColumn(qNewShipping, "Tracking", "CF_SQL_VARCHAR", ATracking)>
<cfset nColumnNumber3 = QueryAddColumn(qNewShipping, "PackageNumber", "CF_SQL_VARCHAR", APackageNumber)>
<cfset nColumnNumber4 = QueryAddColumn(qNewShipping, "ItemID", "CF_SQL_VARCHAR", AItemID)>
	
<!---Write the tracking numbers to the order--->
<cfset TrackingNumbersString = ''>
<cfoutput query = "qNewShipping">
	<cfset TrackingNumbersString = listappend(TrackingNumbersString, qNewShipping.tracking, "^")>
</cfoutput>

<cfquery name = "qryUpdateOrder" datasource="#request.dsn#">
UPDATE orders SET crtTrackingNumbers = '#TrackingNumbersString#'
WHERE OrderID = #ThisOrderID#
</cfquery>

<!---Show current tracking numbers if there are some--->
<cfquery name = "qGetTracking" dbtype="query">
SELECT * FROM qShipping WHERE tracking <> '0'
</cfquery>

<cfoutput query = "qGetTracking">
<cfif fileexists('#request.catalogpath#admin#request.bslash#components#request.bslash#orders#request.bslash#labels#request.bslash##tracking#.pdf')>
<a href = 'labels/#tracking#.pdf' target="_blank">CLICK HERE TO DOWNLOAD #tracking#</a><br />
<cfelse>
#tracking# - label was deleted from the server.
</cfif>
</cfoutput>
<p>
<a href = "doorders.cfm">Click here</a> to go back to the orders screen.

	



















