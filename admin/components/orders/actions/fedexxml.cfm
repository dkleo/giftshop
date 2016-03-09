<!--- Fedex Gateway common error code: 16437 --->
<!--- 
// Updates //

10/2/07
Updated RateRequest, ServicesAvailRequest
- added support for Alcohol element (usage: SSAlcohol="1")

8/31/07
Updated TrackRequest
- removed CarrierCode (no longer required)
- added undocumented <ShipmentAccountNumber> element

7/7/06
Updated TrackRequest to better handle scan activity array

8/21/06
Added extra error capture to Label creation and processing to better capture malformed XML replies
received from Fedex. These are usually result of an invalid request but not always correctly reported as such
by Fedex API Server.

9/8/06
Added support for Special Services / Dry Ice

9/11/06
TrackRequest - updated to include support for new Fedex Track2 API
RegisterRequest - updated to include better error capture / debugging

9/12/06
Updated Signature POD Request to new PDF letter format, POD Letter is now generated as a full PDF

9/21/06
Fixed issue in ServicesAvailRequest where Saturday Delivery parameter would be ignored

9/25/06
Added extra error capture to rateRequest
Updated DelcaredValue element in Ship Request to reflect Fedex API update (curiously that is now inconsistent with a standard Rate Request)

1/22/07
Updated Signature release support to better handle empty parameters

5/22/07
Updated shipping label formats supported
- Added support for PDF label creation (this is now default lable type created) (creates .pdf file)
- Added support for Zebra thermal label type (creates a .zpl file)

5/24/07
Updated support for generation of Return labels
Simply supply parameter
ReturnShipment="PRINTRETURNLABEL"
to create a return label as opposed to a regular label
 --->
<cfscript>
	// 2.0
	currPath = ExpandPath("*.*");
	tempCurrDir = GetDirectoryFromPath(currPath);
	if ( find('#request.bslash#', tempCurrDir, 1) gte 1 ) { 
		trailingSlash = '#request.bslash#'; 
		dirPathLen = Len(tempCurrDir) - 1;
		currentWorkingDir = Left(tempCurrDir, dirPathLen);
	}
	else { 
		trailingSlash = '/';
		dirPathLen = Len(tempCurrDir) - 1;
		currentWorkingDir = Left(tempCurrDir, dirPathLen);
	}
	
	todaysDateOrig = Now();
	currentDay = DatePart( "d", todaysDateOrig);
	nCurrentDay = DayOfWeek(todaysDateOrig);
	if (nCurrentDay eq 1) {
		//Sunday
		todaysDate = DateAdd("d", 1, todaysDateOrig);
	}
	else if (nCurrentDay eq 7) {
		//Saturday
		todaysDate = DateAdd("d", 2, todaysDateOrig);
	}
	else {
		todaysDate = todaysDateOrig;
	}
		
		pickupDateYear = DatePart("yyyy",todaysDate);
		pickupDateMonth = DatePart("m",todaysDate);
		if ( Len(pickupDateMonth) eq 1 )
			pickupDateMonth = "0"&#pickupDateMonth#;
		pickupDateDay = DatePart("d",todaysDate);
		if ( Len(pickupDateDay) eq 1 ) {
			pickupDateDay = "0"&#pickupDateDay#;
		}
		pickupDate = #pickupDateYear#&"-"&#pickupDateMonth#&"-"&#pickupDateDay#;
		strNow = Now();
		attributes.strDateIdentifier = DatePart("yyyy", strNow) & DatePart("m", strNow) & DatePart("d", strNow) & DatePart("h", strNow) & DatePart("n", strNow);
</cfscript>
<cfparam name="attributes.pickupDate" default="#pickupDate#">
<cfparam name="attributes.ServerFilePath" default="#currentWorkingDir#">
<cfparam name="attributes.TestingEnvironment" default="false">
<cfif attributes.TestingEnvironment eq "TRUE">
  <cfset attributes.FedexServer = "https://gatewaybeta.fedex.com:443/GatewayDC/">
  <cfelse>
  <cfset attributes.FedexServer = "https://gateway.fedex.com:443/GatewayDC/">
</cfif>
<cfparam name="attributes.Debug" default="FALSE">
<cfparam name="attributes.TimeOut" default="60">
<cfparam name="attributes.AccountNumber" default="">
<cfparam name="attributes.FedexIndentifier" default="">
<cfparam name="attributes.RateVersion" default="1.0">
<cfparam name="attributes.TrackVersion" default="1.0">
<cfparam name="attributes.PODVersion" default="2.0">
<cfparam name="attributes.RegisterVersion" default="1.0">
<cfparam name="attributes.XMLVersion" default="1.0">
<cfparam name="attributes.CustTransactionString" default="CustString">
<cfparam name="attributes.DeleteShipmentTransactionString" default="Shipment Delete Request">
<cfparam name="attributes.PackageWeight" default="1">
<cfparam name="attributes.PackageWeightUnit" default="LBS">
<cfparam name="attributes.PackageLength" default="4">
<!--- optional --->
<cfparam name="attributes.PackageWidth" default="4">
<!--- optional --->
<cfparam name="attributes.PackageHeight" default="4">
<!--- optional --->
<cfparam name="attributes.PackageUnitOfMeasurement" default="IN">
<!--- Inches --->
<cfparam name="attributes.HandlingCharge" default="0">
<cfparam name="attributes.Packaging" default="YOURPACKAGING">
<cfparam name="attributes.DropOffType" default="REGULARPICKUP">
<cfparam name="attributes.DeclaredValue" default="99.0">
<cfparam name="attributes.CurrencyCode" default="USD">
<cfparam name="attributes.PayorAccountNumber" default="">
<cfparam name="attributes.PayorCountryCode" default="US">
<cfparam name="attributes.ReferenceCustomerNote" default="">
<cfparam name="attributes.ReferencePONumber" default="">
<cfparam name="attributes.ReferenceInvoiceNumber" default="">
<cfparam name="attributes.ShipperCompany" default="">
<cfparam name="attributes.ShipperContactName" default="">
<cfparam name="attributes.ShipperDept" default="Shipping">
<cfparam name="attributes.ShipperPhone" default="">
<cfparam name="attributes.ShipperPager" default="">
<cfparam name="attributes.ShipperFax" default="">
<cfparam name="attributes.ShipperEmail" default="">
<cfparam name="attributes.ShipperStreet" default="">
<cfparam name="attributes.ShipperStreet2" default="">
<cfparam name="attributes.ShipperCity" default="">
<cfparam name="attributes.ShipperState" default="">
<cfparam name="attributes.ShipperZip" default="">
<cfparam name="attributes.ShipperCountry" default="US">
<!--- required 2 digit country code --->
<cfparam name="attributes.ShipToCompany" default="">
<cfparam name="attributes.ShipToContactName" default="">
<cfparam name="attributes.ShipToDept" default="">
<cfparam name="attributes.ShipToPhone" default="">
<cfparam name="attributes.ShipToPager" default="">
<cfparam name="attributes.ShipToFax" default="">
<cfparam name="attributes.ShipToEmail" default="">
<cfparam name="attributes.ShipToStreet" default="">
<cfparam name="attributes.ShipToStreet2" default="">
<cfparam name="attributes.ShipToCity" default="">
<cfparam name="attributes.ShipToState" default="">
<cfparam name="attributes.ShipToZip" default="">
<cfparam name="attributes.ShipToCountry" default="US">
<cfparam name="attributes.ShipToUrbanization" default="">
<cfparam name="attributes.AddressMatches" default="5">
<!--- Address Validation, number of matches to return --->
<cfparam name="attributes.TrackingNumber" default="">
<cfparam name="attributes.trackingScanDetails" default="1">
<!--- [1 = return all scan activity | 0 = No Scan Activity] --->
<cfparam name="attributes.TrackingServiceType" default="Express">
<cfparam name="attributes.TrackingSearchType" default="TRACKING_NUMBER_OR_DOORTAG"> <!--- [REF] --->
<cfparam name="attributes.TrackStartDate" default="">
<!--- Format: YYYY-MM-DD --->
<cfparam name="attributes.TrackEndDate" default="">
<!--- Format: YYYY-MM-DD --->
<cfparam name="attributes.TrackDateShipped" default="">
<!--- Format: YYYY-MM-DD --->
<cfparam name="attributes.DateShipped" default="#pickupDate#">
<!--- Format: YYYY-MM-DD --->
<cfparam name="attributes.TimeShipped" default="#TimeFormat(Now(),'HH:MM:SS')#">
<!--- Format: HH:MM:SS --->
<cfparam name="attributes.PayorType" default="SENDER">
<cfparam name="attributes.ServiceLevel" default="PRIORITYOVERNIGHT">
<!--- /// Multi-piece shipment (ShipRequest) /// --->
<cfparam name="attributes.MultiPiece" default="0"><!--- [0 - NOT a multi-piece shipment | 1 - IS a multi-piece shipment] --->
<cfparam name="attributes.PackageCount" default="1">
<cfparam name="attributes.PackageSequenceNumber" default="1">
<cfparam name="attributes.ShipmentWeight" default="1">
<cfparam name="attributes.MasterTrackingNumber" default="">
<cfparam name="attributes.MasterFormID" default=""><!--- Special Services --->
<cfparam name="attributes.SSCODType" default=""><!--- ANY | GUARANTEEDFUNDS | CASH --->
<cfparam name="attributes.SSCodAmount" default="">
<cfparam name="attributes.SSCODReturnContactName" default="">
<cfparam name="attributes.SSCODReturnCompany" default="">
<cfparam name="attributes.SSCODReturnDept" default="">
<cfparam name="attributes.SSCODReturnPhone" default="">
<cfparam name="attributes.SSCODReturnStreet1" default="">
<cfparam name="attributes.SSCODReturnStreet2" default="">
<cfparam name="attributes.SSCODReturnCity" default="">
<cfparam name="attributes.SSCODReturnState" default="">
<cfparam name="attributes.SSCODReturnZip" default="">
<cfparam name="attributes.SSCODReturnTracking" default=""><!--- Multi-piece COD shipments only, the tracking number of the first piece is added to the last piece in the shipment --->
<cfparam name="attributes.SSCODReturnReferenceType" default="">
<cfparam name="attributes.SSFutureDayDelivery" default="">
<cfparam name="attributes.SSFutureDayShipment" default="0">
<cfparam name="attributes.SSHoldAtLocation" default="0">
<!--- FDXE Only --->
<cfparam name="attributes.SSHoldAtLocationPhone" default="">
<cfparam name="attributes.SSHoldAtLocationStreet1" default="">
<cfparam name="attributes.SSHoldAtLocationCity" default="">
<cfparam name="attributes.SSHoldAtLocationState" default="">
<cfparam name="attributes.SSHoldAtLocationZip" default="">
<cfparam name="attributes.SSDangerousGoods" default="">
<cfparam name="attributes.SSDryIce" default="0">
<!--- FDXE Only --->
<cfparam name="attributes.SSDryIceWeight" default="">
<!--- FDXE Only --->
<cfparam name="attributes.SSDryIceWeightUnits" default="KGS">
<!--- FDXE Only --->
<cfparam name="attributes.SSResDelivery" default="0">
<!--- FDXE / FDXG Only --->
<cfparam name="attributes.SSSignatureOption" default=""><!--- [DELIVERWITHOUTSIGNATURE | INDIRECT | DIRECT | ADULT] --->
<cfparam name="attributes.SSInsidePickup" default="0">
<!--- FDXE Only --->
<cfparam name="attributes.SSInsideDelivery" default="0">
<!--- FDXE Only --->
<cfparam name="attributes.SSSatPickup" default="0">
<!--- FDXE Only --->
<cfparam name="attributes.SSSatDelivery" default="0">
<!--- FDXE Only --->
<cfparam name="attributes.SSAOD" default="0">
<!--- FDXG Only --->
<cfparam name="attributes.SSAutoPOD" default="0">
<!--- FDXG Only --->
<cfparam name="attributes.SSNonStdContainer" default="0">
<!--- FDXG Only --->
<cfparam name="attributes.UseCustomerBroker" default="0">
<!--- INTL only --->
<cfparam name="attributes.RequestListRates" default="0">
<cfparam name="attributes.RateRequestType" default="FDXE">
<cfparam name="attributes.ReturnShipment" default="">
<!--- Ground Home Delivery --->
<cfparam name="attributes.HomeDeliveryType" default=""><!--- DATECERTAIN | EVENING | APPOINTMENT --->
<cfparam name="attributes.HomeDeliverySigRequired" default="0"><!--- 0 | 1 --->
<cfparam name="attributes.HomeDeliveryDate" default="">
<cfparam name="attributes.HomeDeliveryInstructions" default="">
<cfparam name="attributes.HomeDeliveryPhoneNumber" default=""><!--- Shipment Alert/Notification ShipRequest --->
<cfparam name="attributes.ShipAlertFaxNumber" default="">
<cfparam name="attributes.ShipAlertOptionalMessage" default="">
<cfparam name="attributes.ShipperNotify" default="0"><!---[0 = Disable Shipper Email Notifications | 1 = Enable Shipper Email Notifications]--->
<cfparam name="attributes.ShipperShipAlert" default="0">
<cfparam name="attributes.ShipperDeliveryNotification" default="0">
<cfparam name="attributes.ShipperExceptionNotification" default="0">
<cfparam name="attributes.ShipperLanguageCode" default="en">
<cfparam name="attributes.ShipperLocaleCode" default="">
<cfparam name="attributes.ShipperEmailFormat" default="Text">
<!---Format of email notification [Text | HTML | WIRELESS]--->
<cfparam name="attributes.RecipientNotify" default="0">
<!---[0 = Disable Recipient Email Notifications | 1 = Enable Recipient Email Notifications]--->
<cfparam name="attributes.RecipientShipAlert" default="0">
<cfparam name="attributes.RecipientDeliveryNotification" default="0">
<cfparam name="attributes.RecipientExceptionNotification" default="0">
<cfparam name="attributes.RecipientLanguageCode" default="EN">
<cfparam name="attributes.RecipientLocaleCode" default="">
<cfparam name="attributes.RecipientEmailFormat" default="Text">
<!---Format of email notification [Text | HTML | WIRELESS]--->
<cfparam name="attributes.BrokerNotify" default="0">
<!---[0 = Disable Broker Email Notifications | 1 = Enable Broker Email Notifications]--->
<cfparam name="attributes.BrokerShipAlert" default="0">
<cfparam name="attributes.BrokerDeliveryNotification" default="0">
<cfparam name="attributes.BrokerExceptionNotification" default="0">
<cfparam name="attributes.BrokerLanguageCode" default="EN">
<cfparam name="attributes.BrokerLocaleCode" default="">
<cfparam name="attributes.BrokerEmailFormat" default="Text">
<!---Format of email notification [Text | HTML | WIRELESS]--->
<cfparam name="attributes.Other1Notify" default="0">
<!---[0 = Disable Other Email Notifications | 1 = Enable Other Email Notifications]--->
<cfparam name="attributes.Other1Email" default="">
<cfparam name="attributes.Other1ShipAlert" default="0">
<cfparam name="attributes.Other1DeliveryNotification" default="0">
<cfparam name="attributes.Other1ExceptionNotification" default="0">
<cfparam name="attributes.Other1LanguageCode" default="EN">
<cfparam name="attributes.Other1LocaleCode" default="">
<cfparam name="attributes.Other1EmailFormat" default="Text">
<!---Format of email notification [Text | HTML | WIRELESS]--->
<cfparam name="attributes.SignatureRelease" default="">
<!--- [0 | 1] --->
<cfparam name="attributes.PODLabelType" default="PDF">
<!--- Shipping Label --->
<cfparam name="attributes.LabelType" default="2DCOMMON"><!--- STANDARD | 2DCOMMON --->
<cfparam name="attributes.LabelImageType" default="PDF"><!--- PDF, PNG4X6, ELTRON (EPL), ZEBRA (ZPL) for thermal labels --->
<cfparam name="attributes.LabelStockOrientation" default="NONE"><!--- LEADING, TRAILING, NONE --->
<!--- Thermal Shipping Label only --->
<cfparam name="attributes.ThermalLabelDocTabLocation" default="TOP"><!--- TOP | BOTTOM | NONE --->
<cfparam name="attributes.ThermalLabelType" default="STANDARD"><!--- STANDARD | ZONE001 | BARCODED | NONE --->
<cfparam name="attributes.ThermalLabelZoneNumber" default="">
<cfparam name="attributes.ThermalLabelHeader" default="">
<cfparam name="attributes.ThermalLabelValue" default=""><!--- Ground Close Request --->
<cfparam name="attributes.ReportType" default="MANIFEST"><!--- [MANIFEST | HAZMAT | COD | MULTIWEIGHT] --->

<!--- Thermal Label / ThermalLabelType = ZONE001 ONLY --->
<cfparam name="attributes.ThermalLabelBarcodedSymbology" default="CODE128C"> <!--- CODE128C ---> 

<cfparam name="attributes.CloseDate" default="#pickupDate#">
<!--- Format: YYYY-MM-DD --->
<cfparam name="attributes.CloseTime" default="#TimeFormat(Now(),'HH:MM:SS')#">
<!--- Format: HH:MM:SS --->
<!--- International Shipments --->
<cfparam name="attributes.RecipientTIN" default="">
<cfparam name="attributes.BrokerAccountNumber" default="">
<cfparam name="attributes.BrokerTIN" default="">
<cfparam name="attributes.BrokerName" default="">
<cfparam name="attributes.BrokerCompanyName" default="">
<cfparam name="attributes.BrokerPhoneNumber" default="">
<cfparam name="attributes.BrokerPagerNumber" default="">
<cfparam name="attributes.BrokerFaxNumber" default="">
<cfparam name="attributes.BrokerEmail" default="">
<cfparam name="attributes.BrokerStreet" default="">
<cfparam name="attributes.BrokerStreet2" default="">
<cfparam name="attributes.BrokerCity" default="">
<cfparam name="attributes.BrokerState" default="">
<cfparam name="attributes.BrokerZip" default="">
<cfparam name="attributes.BrokerCountry" default="">
<cfparam name="attributes.DutiesPayorAccountNumber" default="">
<!--- FDXE INTL AccountNumber, Required if Duties Pay Type is THIRDPARTY --->
<cfparam name="attributes.DutiesPayorCountry" default="">
<cfparam name="attributes.DutiesPayorType" default="RECIPIENT"><!--- SENDER, RECIPIENT, THIRDPARTY --->
<cfparam name="attributes.TermsOfSale" default="FOB_OR_FCA"><!--- FOB_OR_FCA, CIF_OR_CIP, CFR_OR_CPT, EXW, DDU, DDP --->
<cfparam name="attributes.PartiesToTransaction" default="0"><!--- 1 is required if the exporter and the consignee of the transaction are related. --->
<cfparam name="attributes.IntlDocumentDesc" default=""><!--- 148 character description of document being shipped. Required field for international document shipments. If multi-piece shipment, this field must be populated in the Master transaction and all Children transactions. --->
<cfparam name="attributes.NAFTAShipment" default="0"><!--- 1 if NAFTA shipment, else 0.if origin and destination countries are US, CA,or MX. --->
<cfparam name="attributes.CountryOfUltimateDestination" default="">
<cfparam name="attributes.TotalCustomsValue" default=""><!--- Format: Two explicit decimal positions (e.g. 100.00). --->
<cfparam name="attributes.SenderTINOrDUNS" default="">
<cfparam name="attributes.SenderTINOrDUNSType" default="">
<!--- SSN, EIN, DUNS --->
<cfparam name="attributes.AESOrFTSRExemptionNumber" default="">
<!--- Valid SED Exemption number if applicable --->
<cfparam name="attributes.CommodityNumberOfPieces" default="1">
<cfparam name="attributes.CommodityDescription" default="">
<cfparam name="attributes.CommodityCountryOfManufacture" default="US">
<cfparam name="attributes.CommodityWeight" default="1.0">
<cfparam name="attributes.CommodityQuantity" default="1">
<cfparam name="attributes.CommodityUnit" default="EA">
<cfparam name="attributes.CommodityUnitPrice" default="1.000000"><!--- 6 decimal places required --->
<cfparam name="attributes.CommodityCustomsValue" default="1.000000"><!--- CommodityQuantity * CommodityUnitPrice 6 decimal places required ---><!--- Fedex Services Global Query --->
<cfset caller.qServiceLevelFdx = QueryNew("ServiceLevelCode, ServiceLevelDesc")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "PRIORITYOVERNIGHT")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Priority Overnight")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "STANDARDOVERNIGHT")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Standard Overnight")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "FIRSTOVERNIGHT")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex First Overnight")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "FEDEX2DAY")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex 2nd Day Air")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "FEDEXEXPRESSSAVER")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Express Saver")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "INTERNATIONALPRIORITY")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International Priority")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "INTERNATIONALECONOMY")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International Economy")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "INTERNATIONALFIRST")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International First")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "FEDEX1DAYFREIGHT")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Next Day Freight")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "FEDEX2DAYFREIGHT")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex 2 Day Freight")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "FEDEX3DAYFREIGHT")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex 3 Day Freight")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "FEDEXGROUND")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Ground")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "GROUNDHOMEDELIVERY")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Ground Home Delivery")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "INTERNATIONALPRIORITYFREIGHT")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International Priority Freight")>
<cfset newRow  = QueryAddRow(caller.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "INTERNATIONALECONOMYFREIGHT")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International Economy Freight")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelCode", "UNKNOWN")>
<cfset temp = QuerySetCell(caller.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International Economy / Unknown")>
<cfparam name="attributes.SuppressWhiteSpace" default="True">
<cfswitch expression="#attributes.function#">
  <!--- // Subscription API 2.5 (docs June 2006) open // --->
  <cfcase value="RegisterRequest">
  <cfscript>
	if ( Len(attributes.ShipperStreet2) gte 1 ) {
		line2Indicator = '<Line2>#attributes.ShipperStreet2#</Line2>';
	}
	else {
		line2Indicator = '';
	}
	if ( Len(attributes.ShipperFax) gte 10 ) {
		faxIndicator = '<FaxNumber>#attributes.ShipperFax#</FaxNumber>';
	}
	else {
		faxIndicator = '';
	}
	if ( Len(attributes.ShipperPager) gte 10 ) {
		pagerIndicator = '<PagerNumber>#attributes.ShipperPager#</PagerNumber>';
	}
	else {
		pagerIndicator = '';
	}
	attributes.XMLRequestInput = '<?xml version="#attributes.XMLVersion#" encoding="UTF-8"?>
	<FDXSubscriptionRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXSubscriptionRequest.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>APT_Subscription_Request</CustomerTransactionIdentifier>
			<AccountNumber>#attributes.AccountNumber#</AccountNumber>
		</RequestHeader>
		<Contact>
			<PersonName>#attributes.ShipperContactName#</PersonName>
			<CompanyName>#attributes.ShipperCompany#</CompanyName>
			<Department>#attributes.ShipperDept#</Department>
			<PhoneNumber>#attributes.ShipperPhone#</PhoneNumber>
			#pagerIndicator#
			#faxIndicator#
			<E-MailAddress>#attributes.ShipperEmail#</E-MailAddress>
		</Contact>
		<Address>
			<Line1>#attributes.ShipperStreet#</Line1>
			#line2Indicator#
			<City>#attributes.ShipperCity#</City>
			<StateOrProvinceCode>#attributes.ShipperState#</StateOrProvinceCode>
			<PostalCode>#attributes.ShipperZip#</PostalCode>
			<CountryCode>#attributes.ShipperCountry#</CountryCode>
		</Address>	
	</FDXSubscriptionRequest>';
	</cfscript>
  <cfhttp method="post" url="#attributes.FedexServer#" resolveurl="yes" port="443" timeout="#attributes.TimeOut#">
    <cfhttpparam name="XML" type="xml" value="#attributes.XMLRequestInput#">
  </cfhttp>
  <cfif IsDefined("cfhttp.FileContent") AND Len(cfhttp.FileContent) gt 10>
    <!--- check if valid response returned --->
    <!--- Debug Mode --->
    <cfif attributes.Debug eq "True">
      <!--- [IF - Debug Mode] --->
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#RegisterRequest.xml" output="#attributes.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#RegisterResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
      <cftry>
        <cfset caller.stFedexRegister = xmlParse(trim(cfhttp.FileContent))>
        <cfdump var="#caller.stFedexRegister#">
        <cfset caller.FedexError = "0">
        <cfset caller.FedexErrorDesc = "Success">
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Fedex returned an invalid XML Response, please check your request">
        </cfcatch>
      </cftry>
      <cfelse>
      <!--- [IF - Debug Mode] --->
      <cftry>
        <cfset caller.stFedexRegister = xmlParse(trim(cfhttp.FileContent))>
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Fedex returned an invalid XML Response, please check your request">
        </cfcatch>
      </cftry>
      <cfif isDefined("caller.stFedexRegister.FDXSubscriptionReply.Error.Code.XmlText")>
        <!--- There was an error get default shipping rate for this service level --->
        <cfset caller.FedexError = "1">
        <cfset caller.FedexErrorDesc = "#caller.stFedexRegister.FDXSubscriptionReply.Error.Message.xmlText#">
        <cfelse>
        <cfset caller.FedexError = "0">
        <cfset caller.FedexErrorDesc = "Success: Fedex Subscription/Register request was successful">
        <cfif IsDefined("caller.stFedexRegister.FDXSubscriptionReply.MeterNumber.xmlText")>
          <cfset caller.FedexIdentifier = caller.stFedexRegister.FDXSubscriptionReply.MeterNumber.xmlText>
          <cfelse>
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Fedex returned a valid response without a valid identifier enclosed, this should never happen?">
        </cfif>
      </cfif>
    </cfif>
    <cfelse>
    <cfset caller.FedexError = "2">
    <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex, XML could not be parsed (Subscription/Register Request)">
  </cfif>
  </cfcase>
  <!--- // Subscription API 2.5 (docs June 2006) close // --->
  <cfcase value="RateRequest">
  <!--- ***** 2.0 ****** --->
  <cfif (len(attributes.AccountNumber) eq 0) OR (len(attributes.AccountNumber) neq 9)>
    <cfabort showerror="Error: You did not provide a valid 9 digit Fedex Account Number">
  </cfif>
  <cfscript>
	if ( (attributes.ServiceLevel eq "FEDEXGROUND" OR attributes.ServiceLevel eq "GROUNDHOMEDELIVERY") ) {
		attributes.RateRequestType = 'FDXG';
	}
	else {
		attributes.RateRequestType = 'FDXE';
	}
	
	SSAlcoholIndicator = '';
	if ( isDefined("attributes.SSAlcohol") AND attributes.SSAlcohol eq 1 ) {
		SSAlcoholIndicator = '<Alcohol>1</Alcohol>';
	}
	
	// Special Services
	SSOpen = '<SpecialServices>';
	SSClose = '</SpecialServices>';
	
	if ( Len(attributes.SSCodAmount) gt 0 AND Len(attributes.SSCODType) gt 0 ) {
	SSCODIndicator = '<COD>
				<CollectionAmount>#Trim(NumberFormat(attributes.SSCodAmount,"99999999999.99"))#</CollectionAmount>
				<CollectionType>#attributes.SSCODType#</CollectionType>
			</COD>';
	}
	else { SSCODIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSHoldAtLocation eq "1" ) {
	SSHoldAtLocIndicator = '<HoldAtLocation>#attributes.SSHoldAtLocation#</HoldAtLocation>';
	}
	else { SSHoldAtLocIndicator = ''; }
	
	if ( attributes.SSDangerousGoods eq "ACCESSIBLE" OR attributes.SSDangerousGoods eq "INACCESSIBLE" ) {
	SSDangGoodsIndicator = '<DangerousGoods>
		<Accessibility>#attributes.SSDangerousGoods#</Accessibility>
	</DangerousGoods>';
	}
	else { SSDangGoodsIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSDryIce eq "1" ) {
	SSDryIceIndicator = '<DryIce>#attributes.SSDryIce#</DryIce>';
	}
	else { SSDryIceIndicator = ''; }
	
	if ( attributes.SSResDelivery eq "1" ) {
	SSResDelivIndicator = '<ResidentialDelivery>#attributes.SSResDelivery#</ResidentialDelivery>';
	}
	else { SSResDelivIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSInsidePickup eq "1" ) {
	SSInsidePickupIndicator = '<InsidePickup>#attributes.SSInsidePickup#</InsidePickup>';
	}
	else { SSInsidePickupIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSInsideDelivery eq "1" ) {
	SSInsideDeliveryIndicator = '<InsideDelivery>#attributes.SSInsideDelivery#</InsideDelivery>';
	}
	else { SSInsideDeliveryIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSSatPickup eq "1" ) {
	SSSaturdayPickupIndicator = '<SaturdayPickup>#attributes.SSSatPickup#</SaturdayPickup>';
	}
	else { SSSaturdayPickupIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSSatDelivery eq "1" ) {
	SSSaturdayDeliveryIndicator = '<SaturdayDelivery>#attributes.SSSatDelivery#</SaturdayDelivery>';
	}
	else { SSSaturdayDeliveryIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXG" AND attributes.SSAOD eq "1" ) {
	SSAODIndicator = '<AOD>#attributes.SSAOD#</AOD>';
	}
	else { SSAODIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXG" AND attributes.SSAutoPOD eq "1" ) {
	SSAutoPODIndicator = '<AutoPOD>#attributes.SSAutoPOD#</AutoPOD>';
	}
	else { SSAutoPODIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXG" AND attributes.SSNonStdContainer eq "1" ) {
	SSNonStandardContainerIndicator = '<NonStandardContainer>#attributes.SSNonStdContainer#</NonStandardContainer>';
	}
	else { SSNonStandardContainerIndicator = ''; }
	
	// SpecialServices/SignatureOption
	SSSignatureOptionIndicator = '';
	SSSignatureReleaseIndicator = '';
	if ( isDefined("attributes.SSSignatureOption") AND len(attributes.SSSignatureOption) gte 3 ) {
		SSSignatureOptionIndicator = '<SignatureOption>#attributes.SSSignatureOption#</SignatureOption>';
		
		// SpecialServices / SignatureRelease
		if ( isDefined("attributes.SignatureRelease") AND len(attributes.SignatureRelease) gte 1 ) {
			SSSignatureReleaseIndicator = '<SignatureRelease>#attributes.SignatureRelease#</SignatureRelease>';
		}
	
	}
	
	if ( Len(SSCODIndicator) neq 0
		OR Len(SSHoldAtLocIndicator) neq 0
		OR Len(SSDangGoodsIndicator) neq 0
		OR Len(SSDryIceIndicator) neq 0
		OR Len(SSResDelivIndicator) neq 0
		OR Len(SSInsidePickupIndicator) neq 0
		OR Len(SSInsideDeliveryIndicator) neq 0
		OR Len(SSSaturdayPickupIndicator) neq 0
		OR Len(SSSaturdayDeliveryIndicator) neq 0
		OR Len(SSAODIndicator) neq 0
		OR Len(SSAutoPODIndicator) neq 0
		OR Len(SSNonStandardContainerIndicator) neq 0 
		OR len(SSSignatureOptionIndicator) neq 0 ) {
	
		SSIndicator = '#SSOpen#
			#SSCODIndicator#
			#SSHoldAtLocIndicator#
			#SSDangGoodsIndicator#
			#SSDryIceIndicator#
			#SSResDelivIndicator#
			#SSInsidePickupIndicator#
			#SSInsideDeliveryIndicator#
			#SSSaturdayPickupIndicator#
			#SSSaturdayDeliveryIndicator#
			#SSAODIndicator#
			#SSAutoPODIndicator#
			#SSNonStandardContainerIndicator#
			#SSSignatureOptionIndicator#
			#SSSignatureReleaseIndicator#
		#SSClose#';
	}
	else {
		SSIndicator = '';
	}
	
	// Home Delivery
	if ( attributes.RateRequestType eq "FDXG" AND 
		( attributes.HomeDeliveryType eq "DATECERTAIN" OR attributes.HomeDeliveryType eq "EVENING" OR attributes.HomeDeliveryType eq "APPOINTMENT" )
	   ) 
	{
		HomeDeliveryIndicator = '<HomeDelivery>
			<Type>#attributes.HomeDeliveryType#</Type>
			<SignatureRequired>#attributes.HomeDeliverySigRequired#</SignatureRequired>
		</HomeDelivery>';
	}
	else { HomeDeliveryIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.UseCustomerBroker eq 1 ) {
		IntlBrokerIndicator = '<International>
			<BrokerSelectOption>#attributes.UseCustomerBroker#</BrokerSelectOption>
		</International>';
	}
	else { IntlBrokerIndicator = ''; }
	
	VariableHandlingChargesIndicator = '';
	// <VariableHandlingCharges></VariableHandlingCharges>
	
	attributes.XMLRequestInput = '<?xml version="#attributes.XMLVersion#" encoding="UTF-8"?>
	<FDXRateRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateRequest.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>AP_Fedex_Rate_Request</CustomerTransactionIdentifier>
			<MeterNumber>#attributes.FedexIndentifier#</MeterNumber>
			<AccountNumber>#attributes.AccountNumber#</AccountNumber>
			<CarrierCode>#attributes.RateRequestType#</CarrierCode>
		</RequestHeader>
		<ShipDate>#attributes.PickupDate#</ShipDate>
		<DropoffType>#attributes.DropOffType#</DropoffType>
		<Service>#attributes.ServiceLevel#</Service>
		<Packaging>#attributes.Packaging#</Packaging>
		<WeightUnits>#attributes.PackageWeightUnit#</WeightUnits>
		<Weight>#trim(attributes.PackageWeight)#</Weight>
		<ListRate>#attributes.RequestListRates#</ListRate>
		<OriginAddress>
			<StateOrProvinceCode>#attributes.ShipperState#</StateOrProvinceCode>
			<PostalCode>#attributes.ShipperZip#</PostalCode>
			<CountryCode>#attributes.ShipperCountry#</CountryCode>
		</OriginAddress>
		<DestinationAddress>
			<StateOrProvinceCode>#attributes.ShipToState#</StateOrProvinceCode>
			<PostalCode>#attributes.ShipToZip#</PostalCode>
			<CountryCode>#attributes.ShipToCountry#</CountryCode>
		</DestinationAddress>
		<Payment>
			<PayorType>#UCase(attributes.PayorType)#</PayorType>
		</Payment>
		<Dimensions>
			<Length>#attributes.PackageLength#</Length>
			<Width>#attributes.PackageWidth#</Width>
			<Height>#attributes.PackageHeight#</Height>
			<Units>#attributes.PackageUnitOfMeasurement#</Units>
		</Dimensions>
		<DeclaredValue>
			<Value>#Trim(NumberFormat(attributes.DeclaredValue,"99999.99"))#</Value>
			<CurrencyCode>#UCase(attributes.CurrencyCode)#</CurrencyCode>
		</DeclaredValue>
		#SSAlcoholIndicator#
		#SSIndicator#
		#HomeDeliveryIndicator#
		#VariableHandlingChargesIndicator#
		#IntlBrokerIndicator#
		<PackageCount>#attributes.PackageCount#</PackageCount>
	</FDXRateRequest>';
	
	</cfscript>
  <cfhttp method="post" url="#attributes.FedexServer#" resolveurl="yes" port="443" timeout="#attributes.TimeOut#">
    <cfhttpparam name="XML" type="xml" value="#attributes.XMLRequestInput#">
  </cfhttp>
  <cfif isDefined("cfhttp.fileContent") AND Len(cfhttp.fileContent) gt 10>
    <!--- check if valid response returned --->
    <!--- Debug Mode --->
    <cfif attributes.Debug eq "True">
      <!--- [IF - Debug Mode] --->
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#RateRequest.xml" output="#attributes.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#RateResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
      <cftry>
        <cfset caller.stFedexRate = xmlParse(Trim(cfhttp.FileContent))>
        <cfdump var="#caller.stFedexRate#">
        <cfset caller.FedexError = "0">
        <cfset caller.FedexErrorDesc = "Success">
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Fedex returned an invalid XML Response, please check your request">
        </cfcatch>
      </cftry>
      <cfelse>
      <!--- [IF - Debug Mode] --->
      <cftry>
        <cfset caller.stFedexRate = xmlParse(Trim(cfhttp.FileContent))>
        <cfset caller.FedexError = "0">
        <cfset caller.FedexErrorDesc = "Success">
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Fedex returned an invalid XML Response, please check your request">
        </cfcatch>
      </cftry>
      <cfif (caller.FedexError eq 0) AND isDefined("caller.stFedexRate.FDXRateReply.Error.Code.XmlText")>
        <!--- There was an error get default shipping rate for this service level --->
        <cfset caller.FedexError = "1">
        <cfset caller.FedexErrorDesc = "#caller.stFedexRate.FDXRateReply.Error.Message.XmlText#">
        <cfelseif caller.FedexError eq 0>
        <!--- 
				** Need to account for different elements returned based on Express, Ground request **
				FDXE
				FDXG
				ALL
				 --->
        <cfset caller.FedexError = "0">
        <cfset caller.FedexErrorDesc = "Success">
        <cfset caller.qFedexRateQuery = QueryNew("DimWeightUsed, Oversize, RateScale, RateZone, CurrencyCode, BilledWeight, DimWeight, 
				DiscBaseFreightCharges, DiscDiscountAmt, DiscNetTotalCharge, DiscBaseTotalCharges, DiscTotalRebate, DiscSurchargeCOD, DiscSurchargeSatPickup, DiscSurchargeDV, DiscSurchargeAOD, DiscSurchargeAD, DiscSurchargeAutoPOD,
					DiscSurchargeHomeDelivery, DiscSurchargeHomeDeliveryDC, DiscSurchargeHomeDeliveryEvening, DiscSurchargeHomeDeliverySig,
					DiscSurchargeNonStd, DiscSurchargeHazMat, DiscSurchargeRes, DiscSurchargeVAT, DiscSurchargeHST, DiscSurchargeGST, DiscSurchargePST,
					DiscSurchargeSatDeliv, DiscSurchargeDG, DiscSurchargeOutOfPickupArea, DiscSurchargeOutOfDeliveryArea, DiscSurchargeInsidePickup, DiscSurchargeInsideDeliv,
					DiscSurchargePryAlert, DiscSurchargeDelivArea, DiscSurchargeFuel, DiscSurchargeFICE, DiscSurchargeOffshore, DiscSurchargeOther, DiscSurchargeTotal, 
				ListBaseFreightCharges, ListDiscountAmt, ListNetTotalCharge, ListTotalRebate, ListSurchargeCOD, ListSurchargeSatPickup, ListSurchargeDV, ListSurchargeAOD, ListSurchargeAD, ListSurchargeAutoPOD,
					ListSurchargeHomeDelivery, ListSurchargeHomeDeliveryDC, ListSurchargeHomeDeliveryEvening, ListSurchargeHomeDeliverySig,
					ListSurchargeNonStd, ListSurchargeHazMat, ListSurchargeRes, ListSurchargeVAT, ListSurchargeHST, ListSurchargeGST, ListSurchargePST,
					ListSurchargeSatDeliv, ListSurchargeDG, ListSurchargeOutOfPickupArea, ListSurchargeOutOfDeliveryArea, ListSurchargeInsidePickup, ListSurchargeInsideDeliv,
					ListSurchargePryAlert, ListSurchargeDelivArea, ListSurchargeFuel, ListSurchargeFICE, ListSurchargeOffshore, ListSurchargeOther, ListSurchargeTotal,
					VariableHandling, ListVariableHandlingCharge, TotalCustomerCharge, ListTotalCustomerCharge, MultiweightVariableHandlingCharge, MultiweightTotalCustomerCharge")>
        <cfset newRow  = QueryAddRow(caller.qFedexRateQuery, 1)>
        <!--- ** Inner CP1 ** Check for existence of estimated charges element --->
        <cfif StructKeyExists(caller.stFedexRate.FDXRateReply, "EstimatedCharges")>
          <!--- FDXE Only --->
          <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges, "DimWeightUsed")>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DimWeightUsed", caller.stFedexRate.FDXRateReply.EstimatedCharges.DimWeightUsed.XmlText, 1)>
            <cfelse>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DimWeightUsed", "", 1)>
          </cfif>
          <!--- FDXG Only --->
          <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges, "Oversize")>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "Oversize", caller.stFedexRate.FDXRateReply.EstimatedCharges.Oversize.XmlText, 1)>
            <cfelse>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "Oversize", "", 1)>
          </cfif>
          <!--- FDXE Only --->
          <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges, "RateScale")>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "RateScale", caller.stFedexRate.FDXRateReply.EstimatedCharges.RateScale.XmlText, 1)>
            <cfelse>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "RateScale", "", 1)>
          </cfif>
          <!--- FDXE Only --->
          <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges, "RateZone")>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "RateZone", caller.stFedexRate.FDXRateReply.EstimatedCharges.RateZone.XmlText, 1)>
            <cfelse>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "RateZone", "", 1)>
          </cfif>
          <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges, "CurrencyCode")>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "CurrencyCode", caller.stFedexRate.FDXRateReply.EstimatedCharges.CurrencyCode.XmlText, 1)>
            <cfelse>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "CurrencyCode", "", 1)>
          </cfif>
          <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges, "BilledWeight")>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "BilledWeight", caller.stFedexRate.FDXRateReply.EstimatedCharges.BilledWeight.XmlText, 1)>
            <cfelse>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "BilledWeight", "", 1)>
          </cfif>
          <!--- Discount Charges element - present in both FDXE and FDXG requests, for FDXG request this is only node returned --->
          <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges, "DiscountedCharges")>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "BaseCharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscBaseFreightCharges", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.BaseCharge.XmlText, 1)>
              <cfset nBaseCharge = caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.BaseCharge.XmlText>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscBaseFreightCharges", "0", 1)>
              <cfset nBaseCharge = 0>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "TotalDiscount")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscDiscountAmt", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.TotalDiscount.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscDiscountAmt", "0", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "NetCharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscNetTotalCharge", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.NetCharge.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscNetTotalCharge", "0", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "TotalRebate")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscTotalRebate", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.TotalRebate.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscTotalRebate", "", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "TotalSurcharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeTotal", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText, 1)>
              <cfset nBaseSurCharge = caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeTotal", "0", 1)>
              <cfset nBaseSurCharge = 0>
            </cfif>
            <cfset nTotalCharge = nBaseCharge + nBaseSurCharge>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscBaseTotalCharges", nTotalCharge, 1)>
            <!--- Anyone for a surcharge or 10 or 100!! --->
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "Surcharges")>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "COD")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeCOD", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.COD.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeCOD", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "SaturdayPickup")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeSatPickup", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.SaturdayPickup.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeSatPickup", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "DeclaredValue")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDV", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.DeclaredValue.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDV", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "AOD")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAOD", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.AOD.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAOD", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "AppointmentDelivery")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAD", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.AppointmentDelivery.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAD", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "AutoPOD")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAutoPOD", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.AutoPOD.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAutoPOD", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDelivery")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDelivery", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDelivery.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDelivery", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliveryDateCertain")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliveryDateCertain.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliveryEveningDelivery")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliveryEveningDelivery.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliverySignature")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliverySignature.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "NonStandardContainer")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeNonStd", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.NonStandardContainer.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeNonStd", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HazardousMaterials")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHazMat", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HazardousMaterials.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHazMat", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "Residential")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeRes", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.Residential.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeRes", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "VAT")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeVAT", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.VAT.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeVAT", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HSTSurcharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHST", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HSTSurcharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHST", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "GSTSurcharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeGST", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.GSTSurcharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeGST", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "PSTSurcharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargePST", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.PSTSurcharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargePST", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "SaturdayDelivery")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeSatDeliv", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.SaturdayDelivery.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeSatDeliv", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "DangerousGoods")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDG", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.DangerousGoods.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDG", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "OutOfPickupOrh2Area")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.OutOfPickupOrh2Area.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "OutOfDeliveryOrh2Area")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.OutOfDeliveryOrh2Area.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "InsidePickup")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsidePickup", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.InsidePickup.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsidePickup", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "InsideDelivery")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsideDeliv", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.InsideDelivery.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsideDeliv", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "PriorityAlert")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargePryAlert", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.PriorityAlert.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargePryAlert", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "DeliveryArea")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDelivArea", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.DeliveryArea.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDelivArea", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "Fuel")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFuel", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.Fuel.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFuel", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "FICE")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFICE", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.FICE.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFICE", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "Offshore")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOffshore", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.Offshore.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOffshore", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "Other")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOther", caller.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.Other.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOther", "", 1)>
              </cfif>
            </cfif>
            <!--- Anyone for a surcharge or 10 or 100!! CLOSE --->
            <cfelse>
            <!--- Discount charges element unavailable - this should not be possible as this is primary charges node --->
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscBaseFreightCharges", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscDiscountAmt", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscNetTotalCharge", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscTotalRebate", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeCOD", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeSatPickup", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDV", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAOD", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAD", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAutoPOD", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDelivery", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeNonStd", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHazMat", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeRes", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeVAT", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHST", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeGST", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargePST", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDG", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsidePickup", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsideDeliv", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDelivArea", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFuel", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFICE", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOffshore", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeTotal", "", 1)>
          </cfif>
          <!--- Discount Charges element - CLOSE --->
          <!--- List Charges element --->
          <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges, "ListCharges")>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "BaseCharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListBaseFreightCharges", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.BaseCharge.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListBaseFreightCharges", "", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "TotalDiscount")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListDiscountAmt", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.TotalDiscount.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListDiscountAmt", "", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "NetCharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListNetTotalCharge", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.NetCharge.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListNetTotalCharge", "", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "TotalRebate")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalRebate", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.TotalRebate.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalRebate", "", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "TotalSurcharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeTotal", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.TotalSurcharge.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeTotal", "", 1)>
            </cfif>
            <!--- Anyone for a surcharge or 10 or 100!! --->
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "Surcharges")>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "COD")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeCOD", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.COD.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeCOD", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "SaturdayPickup")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeSatPickup", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.SaturdayPickup.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeSatPickup", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "DeclaredValue")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDV", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.DeclaredValue.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDV", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "AOD")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAOD", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.AOD.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAOD", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "AppointmentDelivery")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAD", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.AppointmentDelivery.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAD", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "AutoPOD")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAutoPOD", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.AutoPOD.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAutoPOD", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HomeDelivery")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDelivery", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HomeDelivery.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDelivery", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliveryDateCertain")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliveryDateCertain.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliveryEveningDelivery")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliveryEveningDelivery.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliverySignature")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliverySig", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliverySignature.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliverySig", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "NonStandardContainer")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeNonStd", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.NonStandardContainer.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeNonStd", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HazardousMaterials")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHazMat", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HazardousMaterials.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHazMat", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "Residential")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeRes", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.Residential.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeRes", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "VAT")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeVAT", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.VAT.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeVAT", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HSTSurcharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHST", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HSTSurcharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHST", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "GSTSurcharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeGST", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.GSTSurcharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeGST", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "PSTSurcharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargePST", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.PSTSurcharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargePST", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "SaturdayDelivery")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeSatDeliv", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.SaturdayDelivery.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeSatDeliv", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "DangerousGoods")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDG", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.DangerousGoods.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDG", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "OutOfPickupOrh2Area")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfPickupArea", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.OutOfPickupOrh2Area.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfPickupArea", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "OutOfDeliveryOrh2Area")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.OutOfDeliveryOrh2Area.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "InsidePickup")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsidePickup", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.InsidePickup.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsidePickup", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "InsideDelivery")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsideDeliv", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.InsideDelivery.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsideDeliv", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "PriorityAlert")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargePryAlert", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.PriorityAlert.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargePryAlert", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "DeliveryArea")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDelivArea", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.DeliveryArea.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDelivArea", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "Fuel")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFuel", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.Fuel.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFuel", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "FICE")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFICE", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.FICE.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFICE", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "Offshore")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOffshore", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.Offshore.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOffshore", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "Other")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOther", caller.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.Other.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOther", "", 1)>
              </cfif>
            </cfif>
            <cfelse>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListBaseFreightCharges", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListDiscountAmt", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListNetTotalCharge", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalRebate", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeCOD", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeSatPickup", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDV", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAOD", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAD", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAutoPOD", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDelivery", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliverySig", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeNonStd", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHazMat", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeRes", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeVAT", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHST", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeGST", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargePST", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDG", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfPickupArea", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsidePickup", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsideDeliv", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDelivArea", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFuel", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFICE", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOffshore", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeTotal", "", 1)>
          </cfif>
          <!--- List Charges element - CLOSE --->
          <!--- Variable Handling Elements --->
          <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges, "VariableHandling")>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "VariableHandlingCharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "VariableHandling", caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.VariableHandlingCharge.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "VariableHandling", "", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "ListVariableHandlingCharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListVariableHandlingCharge", caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.ListVariableHandlingCharge.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListVariableHandlingCharge", "", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "TotalCustomerCharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "TotalCustomerCharge", caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.TotalCustomerCharge.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "TotalCustomerCharge", "", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "ListTotalCustomerCharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalCustomerCharge", caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.ListTotalCustomerCharge.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalCustomerCharge", "", 1)>
            </cfif>
            <!--- FDXG Only --->
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "MultiweightVariableHandlingCharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightVariableHandlingCharge", caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.MultiweightVariableHandlingCharge.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightVariableHandlingCharge", "", 1)>
            </cfif>
            <!--- FDXG Only --->
            <cfif StructKeyExists(caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "MultiweightTotalCustomerCharge")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightTotalCustomerCharge", caller.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.MultiweightTotalCustomerCharge.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightTotalCustomerCharge", "", 1)>
            </cfif>
            <cfelse>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "VariableHandling", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListVariableHandlingCharge", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "TotalCustomerCharge", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalCustomerCharge", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightVariableHandlingCharge", "", 1)>
            <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightTotalCustomerCharge", "", 1)>
          </cfif>
          <!--- Variable Handling Elements CLOSE --->
          <cfelse>
          <!--- ** Inner CP1 ** Check for existence of estimated charges element not successful --->
          <!--- Charge not retrieved for some reason set empty columns --->
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Fedex returned a valid response without a base rate">
        </cfif>
        <!--- ** Inner CP1 ** Check for existence of estimated charges element close --->
      </cfif>
    </cfif>
    <!--- [END-IF - Debug Mode] --->
    <cfelse>
    <!--- Valid response not received --->
    <cfset caller.FedexError = "2">
    <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex">
  </cfif>
  <!--- check if valid response returned --->
  </cfcase>
  <!--- End Fedex XML rate Request --->
  <!---  Fedex Available services request --->
  <cfcase value="ServicesAvailRequest">
  <!--- ***** 2.0 ****** --->
  <cfscript>
	caller.nTickStage1 = GetTickCount();
	if ( IsDefined("attributes.PackageCount") AND attributes.PackageCount gt 1 ) { 
		attributes.PackageCount = 1;
	}
	
	SSAlcoholIndicator = '';
	if ( isDefined("attributes.SSAlcohol") AND attributes.SSAlcohol eq 1 ) {
		SSAlcoholIndicator = '<Alcohol>1</Alcohol>';
	}
	
	// Special Services
	SSOpen = '<SpecialServices>';
	SSClose = '</SpecialServices>';
	
	if ( Len(attributes.SSCodAmount) gt 0 AND Len(attributes.SSCODType) gt 0 ) {
	SSCODIndicator = '<COD>
				<CollectionAmount>#Trim(NumberFormat(attributes.SSCodAmount,"99999999999.99"))#</CollectionAmount>
				<CollectionType>#attributes.SSCODType#</CollectionType>
			</COD>';
	}
	else { SSCODIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSHoldAtLocation eq "1" ) {
	SSHoldAtLocIndicator = '<HoldAtLocation>#attributes.SSHoldAtLocation#</HoldAtLocation>';
	}
	else { SSHoldAtLocIndicator = ''; }
	
	if ( attributes.SSDangerousGoods eq "ACCESSIBLE" OR attributes.SSDangerousGoods eq "INACCESSIBLE" ) {
	SSDangGoodsIndicator = '<DangerousGoods>
		<Accessibility>#attributes.SSDangerousGoods#</Accessibility>
	</DangerousGoods>';
	}
	else { SSDangGoodsIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSDryIce eq "1" ) {
	SSDryIceIndicator = '<DryIce>#attributes.SSDryIce#</DryIce>';
	}
	else { SSDryIceIndicator = ''; }
	
	if ( attributes.SSResDelivery eq "1" ) {
	SSResDelivIndicator = '<ResidentialDelivery>#attributes.SSResDelivery#</ResidentialDelivery>';
	}
	else { SSResDelivIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSInsidePickup eq "1" ) {
	SSInsidePickupIndicator = '<InsidePickup>#attributes.SSInsidePickup#</InsidePickup>';
	}
	else { SSInsidePickupIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSInsideDelivery eq "1" ) {
	SSInsideDeliveryIndicator = '<InsideDelivery>#attributes.SSInsideDelivery#</InsideDelivery>';
	}
	else { SSInsideDeliveryIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSSatPickup eq "1" ) {
	SSSaturdayPickupIndicator = '<SaturdayPickup>#attributes.SSSatPickup#</SaturdayPickup>';
	}
	else { SSSaturdayPickupIndicator = ''; }
	
	if ( attributes.SSSatDelivery eq "1" ) {
	SSSaturdayDeliveryIndicator = '<SaturdayDelivery>#attributes.SSSatDelivery#</SaturdayDelivery>';
	}
	else { SSSaturdayDeliveryIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXG" AND attributes.SSAOD eq "1" ) {
	SSAODIndicator = '<AOD>#attributes.SSAOD#</AOD>';
	}
	else { SSAODIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXG" AND attributes.SSAutoPOD eq "1" ) {
	SSAutoPODIndicator = '<AutoPOD>#attributes.SSAutoPOD#</AutoPOD>';
	}
	else { SSAutoPODIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXG" AND attributes.SSNonStdContainer eq "1" ) {
	SSNonStandardContainerIndicator = '<NonStandardContainer>#attributes.SSNonStdContainer#</NonStandardContainer>';
	}
	else { SSNonStandardContainerIndicator = ''; }
	
	// SpecialServices/SignatureOption
	SSSignatureOptionIndicator = '';
	SSSignatureReleaseIndicator = '';
	if ( isDefined("attributes.SSSignatureOption") AND len(attributes.SSSignatureOption) gte 3 ) {
		SSSignatureOptionIndicator = '<SignatureOption>#attributes.SSSignatureOption#</SignatureOption>';
		
		// SpecialServices / SignatureRelease
		if ( isDefined("attributes.SignatureRelease") AND len(attributes.SignatureRelease) gte 1 ) {
			SSSignatureReleaseIndicator = '<SignatureRelease>#attributes.SignatureRelease#</SignatureRelease>';
		}
	
	}
	
	if ( Len(SSCODIndicator) neq 0
		OR Len(SSHoldAtLocIndicator) neq 0
		OR Len(SSDangGoodsIndicator) neq 0
		OR Len(SSDryIceIndicator) neq 0
		OR Len(SSResDelivIndicator) neq 0
		OR Len(SSInsidePickupIndicator) neq 0
		OR Len(SSInsideDeliveryIndicator) neq 0
		OR Len(SSSaturdayPickupIndicator) neq 0
		OR Len(SSSaturdayDeliveryIndicator) neq 0
		OR Len(SSAODIndicator) neq 0
		OR Len(SSAutoPODIndicator) neq 0
		OR Len(SSNonStandardContainerIndicator) neq 0 
		OR len(SSSignatureOptionIndicator) neq 0 ) {
	
		SSIndicator = '#SSOpen#
			#SSCODIndicator#
			#SSHoldAtLocIndicator#
			#SSDangGoodsIndicator#
			#SSDryIceIndicator#
			#SSResDelivIndicator#
			#SSInsidePickupIndicator#
			#SSInsideDeliveryIndicator#
			#SSSaturdayPickupIndicator#
			#SSSaturdayDeliveryIndicator#
			#SSAODIndicator#
			#SSAutoPODIndicator#
			#SSNonStandardContainerIndicator#
			#SSSignatureOptionIndicator#
			#SSSignatureReleaseIndicator#
		#SSClose#';
	}
	else {
		SSIndicator = '';
	}
	
	// Home Delivery
	if ( attributes.RateRequestType eq "FDXG" AND 
		( attributes.HomeDeliveryType eq "DATECERTAIN" OR attributes.HomeDeliveryType eq "EVENING" OR attributes.HomeDeliveryType eq "APPOINTMENT" )
	   ) 
	{
		HomeDeliveryIndicator = '<HomeDelivery>
			<Type>#attributes.HomeDeliveryType#</Type>
			<SignatureRequired>#attributes.HomeDeliverySigRequired#</SignatureRequired>
		</HomeDelivery>';
	}
	else { HomeDeliveryIndicator = ''; }
	
	// Request List Rates can only be requested with domestic
	if ( attributes.ShipToCountry neq "US" ) {
		attributes.RequestListRates = 0;
	}
	else if ( Len(attributes.RequestListRates) eq 0 AND attributes.ShipToCountry eq "US" ) {
		attributes.RequestListRates = 1;
	}

	</cfscript>
  <cfparam name="attributes.pickupDate" default="#pickupDate#">
  <cfscript>
	caller.nTickStage2 = GetTickCount();
	attributes.XMLRequestInput = '<?xml version="#attributes.XMLVersion#" encoding="UTF-8"?>
	<FDXRateAvailableServicesRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateAvailableServicesRequest.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>Admin Pro Tools Available Services Request</CustomerTransactionIdentifier>
			<MeterNumber>#attributes.FedexIndentifier#</MeterNumber>
			<AccountNumber>#attributes.AccountNumber#</AccountNumber>
		</RequestHeader>
		<ShipDate>#attributes.PickupDate#</ShipDate>
		<DropoffType>REGULARPICKUP</DropoffType>
		<Packaging>#attributes.Packaging#</Packaging>
		<WeightUnits>#attributes.PackageWeightUnit#</WeightUnits>
		<Weight>#attributes.PackageWeight#</Weight>
		<ListRate>#attributes.RequestListRates#</ListRate>
		<OriginAddress>
			<StateOrProvinceCode>#attributes.ShipperState#</StateOrProvinceCode>
			<PostalCode>#attributes.ShipperZip#</PostalCode>
			<CountryCode>#attributes.ShipperCountry#</CountryCode>
		</OriginAddress>
		<DestinationAddress>
			<StateOrProvinceCode>#attributes.ShipToState#</StateOrProvinceCode>
			<PostalCode>#attributes.ShipToZip#</PostalCode>
			<CountryCode>#attributes.ShipToCountry#</CountryCode>
		</DestinationAddress>
		<Payment>
			<PayorType>#UCase(attributes.PayorType)#</PayorType>
		</Payment>
		<Dimension>
			<Length>#attributes.PackageLength#</Length>
			<Width>#attributes.PackageWidth#</Width>
			<Height>#attributes.PackageHeight#</Height>
			<Units>#attributes.PackageUnitOfMeasurement#</Units>
		</Dimension>
		<DeclaredValue>
			<Value>#Trim(NumberFormat(attributes.DeclaredValue,"99999.99"))#</Value>
			<CurrencyCode>#UCase(attributes.CurrencyCode)#</CurrencyCode>
		</DeclaredValue>
		#SSAlcoholIndicator#
		#SSIndicator#
		#HomeDeliveryIndicator#
		<PackageCount>#attributes.PackageCount#</PackageCount>
	</FDXRateAvailableServicesRequest>';
	</cfscript>
  <cfset caller.nTickStage3 = GetTickCount()>
  <cfhttp method="post" url="#attributes.FedexServer#" resolveurl="yes" port="443" timeout="#attributes.TimeOut#">
    <cfhttpparam name="XML" type="xml" value="#attributes.XMLRequestInput#">
  </cfhttp>
  <cfset caller.nTickStage4 = GetTickCount()>
  <cfif IsDefined("cfhttp.FileContent") AND Len(cfhttp.FileContent) gt 10>
    <!--- check if valid response returned --->
    <cfset caller.nTickStage5 = GetTickCount()>
    <cfif attributes.Debug eq "True">
      <cftry>
        <cfset caller.stFedexAvailableServices = XmlParse(Trim(cfhttp.FileContent))>
        <cfdump var="#caller.stFedexAvailableServices#">
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex, XML could not be parsed">
        </cfcatch>
      </cftry>
      <cffile action="WRITE" file="#attributes.ServerFilePath##request.bslash#Debug#request.bslash#servicesavailablerequest.xml" output="#attributes.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
      <cffile action="WRITE" file="#attributes.ServerFilePath##request.bslash#Debug#request.bslash#servicesavailableresponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
      <cfelse>
      <!--- // [IF-Debug Mode] // --->
      <cftry>
        <cfset caller.stFedexAvailableServices = XmlParse(Trim(cfhttp.FileContent))>
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex, XML could not be parsed">
        </cfcatch>
      </cftry>
      <cfif isDefined("caller.stFedexAvailableServices")>
        <!--- // [IF-2 Check if XML Response could be parsed successfully] // --->
        <cfif IsDefined("caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Error.Code.XmlText")>
          <!--- There was an error get default shipping rate for this service level --->
          <cfset caller.FedexError = "1">
          <cfset caller.FedexErrorDesc = "#caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Error.Message.XmlText#">
          <cfelse>
          <cfset caller.nTickStage7 = GetTickCount()>
          <cfset caller.FedexError = "0">
          <cfset caller.FedexErrorDesc = "Success">
          <!--- Successful response start processing all elements --->
          <cfif IsDefined("caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry")>
            <cfif IsArray(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry.XmlChildren)>
              <cfset caller.qAvailServices = QueryNew("Service, Packaging, DeliveryDate, DeliveryDay, TimeInTransit, DimWeightUsed,
					   Oversize, RateZone, CurrencyCode, BilledWeight, DimWeight, DiscBaseFreightCharges, DiscDiscountAmt, DiscSurchargeTotal, DiscNetTotalCharge, DiscTotalRebate, DiscBaseTotalCharges,
					   ListBaseFreightCharges, ListSurchargeTotal, ListNetTotalCharge, ListTotalRebate")>
              <cfloop index="idxAvs" from="1" to="#ArrayLen(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry)#">
                <cfset newRow  = QueryAddRow(caller.qAvailServices, 1)>
                <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "Service")>
                  <cfset temp = QuerySetCell(caller.qAvailServices, "Service", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].Service.XmlText, idxAvs)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qAvailServices, "Service", "")>
                </cfif>
                <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "Packaging")>
                  <cfset temp = QuerySetCell(caller.qAvailServices, "Packaging", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].Packaging.XmlText, idxAvs)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qAvailServices, "DeliveryDate", "")>
                </cfif>
                <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "DeliveryDate")>
                  <cfset temp = QuerySetCell(caller.qAvailServices, "DeliveryDate", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].DeliveryDate.XmlText, idxAvs)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qAvailServices, "DeliveryDate", "")>
                </cfif>
                <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "DeliveryDay")>
                  <cfset temp = QuerySetCell(caller.qAvailServices, "DeliveryDay", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].DeliveryDay.XmlText, idxAvs)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qAvailServices, "DeliveryDay", "")>
                </cfif>
                <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "TimeInTransit")>
                  <cfset temp = QuerySetCell(caller.qAvailServices, "TimeInTransit", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].TimeInTransit.XmlText, idxAvs)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qAvailServices, "TimeInTransit", "")>
                </cfif>
                <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "EstimatedCharges")>
                  <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "DimWeightUsed")>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "DimWeightUsed", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DimWeightUsed.XmlText, idxAvs)>
                    <cfelse>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "DimWeightUsed", "")>
                  </cfif>
                  <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "Oversize")>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "Oversize", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.Oversize.XmlText, idxAvs)>
                    <cfelse>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "Oversize", "")>
                  </cfif>
                  <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "RateZone")>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "RateZone", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.RateZone.XmlText, idxAvs)>
                    <cfelse>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "RateZone", "")>
                  </cfif>
                  <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "CurrencyCode")>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "CurrencyCode", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.CurrencyCode.XmlText, idxAvs)>
                    <cfelse>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "CurrencyCode", "")>
                  </cfif>
                  <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "BilledWeight")>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "BilledWeight", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.BilledWeight.XmlText, idxAvs)>
                    <cfelse>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "BilledWeight", "")>
                  </cfif>
                  <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "DimWeight")>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "DimWeight", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DimWeight.XmlText, idxAvs)>
                    <cfelse>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "DimWeight", "")>
                  </cfif>
                  <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "DiscountedCharges")>
                    <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges, "BaseCharge")>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "DiscBaseFreightCharges", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.BaseCharge.XmlText, idxAvs)>
                      <cfset nBaseCharge = caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.BaseCharge.XmlText>
                      <cfelse>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "DiscBaseFreightCharges", "")>
                      <cfset nBaseCharge = 0>
                    </cfif>
                    <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges, "TotalDiscount")>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "DiscDiscountAmt", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.TotalDiscount.XmlText, idxAvs)>
                      <cfelse>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "DiscDiscountAmt", "")>
                    </cfif>
                    <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges, "TotalSurcharge")>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "DiscSurchargeTotal", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText, idxAvs)>
                      <cfset nSurCharge = caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText>
                      <cfelse>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "DiscSurchargeTotal", "")>
                      <cfset nSurCharge = 0>
                    </cfif>
                    <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges, "NetCharge")>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "DiscNetTotalCharge", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.NetCharge.XmlText, idxAvs)>
                      <cfelse>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "DiscNetTotalCharge", "")>
                    </cfif>
                    <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges, "TotalRebate")>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "DiscTotalRebate", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.TotalRebate.XmlText, idxAvs)>
                      <cfelse>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "DiscTotalRebate", "")>
                    </cfif>
                    <cfset nTotalCharge = nBaseCharge + nSurCharge>
                    <cfset temp = QuerySetCell(caller.qAvailServices, "DiscBaseTotalCharges", nTotalCharge, idxAvs)>
                    <cfelse>
                    <!--- Discounted Charges element not present --->
                  </cfif>
                  <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "ListCharges")>
                    <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges, "BaseCharge")>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "ListBaseFreightCharges", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges.BaseCharge.XmlText, idxAvs)>
                      <cfelse>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "ListBaseFreightCharges", "")>
                    </cfif>
                    <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges, "TotalSurcharge")>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "ListSurchargeTotal", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges.TotalSurcharge.XmlText, idxAvs)>
                      <cfelse>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "ListSurchargeTotal", "")>
                    </cfif>
                    <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges, "NetCharge")>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "ListNetTotalCharge", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges.NetCharge.XmlText, idxAvs)>
                      <cfelse>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "ListNetTotalCharge", "")>
                    </cfif>
                    <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges, "TotalRebate")>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "ListTotalRebate", caller.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges.TotalRebate.XmlText, idxAvs)>
                      <cfelse>
                      <cfset temp = QuerySetCell(caller.qAvailServices, "ListTotalRebate", "")>
                    </cfif>
                    <cfelse>
                    <!--- List Charges element not present --->
                  </cfif>
                  <cfelse>
                  <!--- EstimatedCharges element not found, this should not be possible but handled anyhow --->
                </cfif>
              </cfloop>
              <cfelse>
              <!--- No array found --->
              <cfset temp = QuerySetCell(caller.qAvailServices, "Service", "")>
              <cfset temp = QuerySetCell(caller.qAvailServices, "DeliveryDate", "")>
              <cfset temp = QuerySetCell(caller.qAvailServices, "DeliveryDate", "")>
              <cfset temp = QuerySetCell(caller.qAvailServices, "DeliveryDay", "")>
              <cfset temp = QuerySetCell(caller.qAvailServices, "TimeInTransit", "")>
              <cfset temp = QuerySetCell(caller.qAvailServices, "DimWeightUsed", "")>
              <cfset temp = QuerySetCell(caller.qAvailServices, "OversizeCharge", "")>
              <cfset temp = QuerySetCell(caller.qAvailServices, "RateZone", "")>
              <cfset temp = QuerySetCell(caller.qAvailServices, "Currency", "")>
              <cfset temp = QuerySetCell(caller.qAvailServices, "BilledWeight", "")>
              <cfset temp = QuerySetCell(caller.qAvailServices, "DimWeight", "")>
            </cfif>
            <!--- Scan data may be valid but not an array --->
            <cfelse>
            <cfif StructKeyExists(caller.stFedexAvailableServices.FDXRateAvailableServicesReply, "Entry")>
              <cfset caller.availSingleStruct = 1>
              <cfset caller.availSingleCity = caller.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan.City.XmlText>
            </cfif>
          </cfif>
          <!--- Successful response start processing all elements close --->
          <cfset caller.nTickStage8 = GetTickCount()>
        </cfif>
        <cfelse>
        <!--- // [IF-2 Check if XML Response could be parsed successfully] // --->
      </cfif>
      <!--- // [END-IF-2 Check if XML Response could be parsed successfully] // --->
    </cfif>
    <!--- // [END-IF-Debug Mode] // --->
    <cfelse>
    <!--- Valid response not received --->
    <cfset caller.FedexError = "2">
    <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex">
  </cfif>
  <!--- Valid response received check end --->
  <cfset caller.nTickStageEnd = GetTickCount()>
  </cfcase>
  <!---  Fedex Available services request close --->
  <!--- // Tracking API 2.5 (docs June 2006) open // --->
  <cfcase value="TrackRequest">
  <cfscript>
	caller.FedexError = 0;
	
	if ( len(attributes.TrackStartDate) neq 0 ) {
	startDateIndicator = '<StartDateRange>#attributes.TrackStartDate#</StartDateRange>';
	}
	else { startDateIndicator = ''; }
	
	if ( len(attributes.TrackEndDate) neq 0 ) {
	endDateIndicator = '<EndDateRange>#attributes.TrackEndDate#</EndDateRange>';
	}
	else { EndDateIndicator = ''; }
	
	if ( len(attributes.TrackDateShipped) neq 0 ) {
	shippedDateIndicator = '<ShipDate>#attributes.TrackDateShipped#</ShipDate>';
	}
	else { shippedDateIndicator = ''; }
	
	// Carrier Type element
	if ( attributes.TrackingServiceType eq "Express" ) {
	carrierIndicator = '<CarrierType>Express</CarrierType>';
	}
	else if ( attributes.TrackingServiceType eq "Ground" ) {
	carrierIndicator = '<CarrierType>Ground</CarrierType>';
	}
	else { carrierIndicator = ''; }
	
	attributes.XMLRequestInput = '<?xml version="#attributes.XMLVersion#" encoding="UTF-8"?>
	<FDXTrack2Request xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXTrack2Request.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>APT2.5_TrackRequest</CustomerTransactionIdentifier>
			<AccountNumber>#attributes.AccountNumber#</AccountNumber>
			<MeterNumber>#attributes.FedexIndentifier#</MeterNumber>
		</RequestHeader>
		<PackageIdentifier>
			<Type>#attributes.TrackingSearchType#</Type>
			<Value>#attributes.TrackingNumber#</Value>
		</PackageIdentifier>
		#startDateIndicator#
		#endDateIndicator#
		#shippedDateIndicator#
		<DestinationCountryCode>#attributes.ShipToCountry#</DestinationCountryCode>
		<DestinationPostalCode>#attributes.ShipToZip#</DestinationPostalCode>
		<ShipmentAccountNumber>#attributes.AccountNumber#</ShipmentAccountNumber>
		<DetailScans>#attributes.trackingScanDetails#</DetailScans>
	</FDXTrack2Request>';
	</cfscript>
  <cfhttp method="post" url="#attributes.FedexServer#" resolveurl="yes" port="443" timeout="#attributes.TimeOut#">
    <cfhttpparam name="XML" type="xml" value="#attributes.XMLRequestInput#">
  </cfhttp>
  <cfif isDefined("cfhttp.fileContent") AND len(cfhttp.fileContent) gt 10>
    <!--- check if valid response returned --->
    <!--- Debug Mode --->
    <cfif attributes.Debug eq "True">
      <cftry>
        <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackRequest.xml" output="#attributes.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
        <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
        <cfcatch type="any">
        </cfcatch>
      </cftry>
      <cftry>
        <cfset caller.stFedexTrackingResponse = xmlParse(Trim(cfhttp.fileContent))>
        <cfdump var="#caller.stFedexTrackingResponse#">
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex, XML could not be parsed (Track2 Request)">
        </cfcatch>
      </cftry>
      <cfelse>
      <cftry>
        <cfset caller.stFedexTrackingResponse = xmlParse(Trim(cfhttp.fileContent))>
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex, XML could not be parsed (Track2 Request)">
        </cfcatch>
      </cftry>
      <cfif caller.FedexError eq 0>
        <!---  
				[trackQuery] Create query trackQuery to hold main tracking details, also stand-alone vars for backward compatibility
				[scanQuery] holds all scan details, if requested
				 --->
        <cfset error = xmlSearch(caller.stFedexTrackingResponse, "/FDXTrack2Reply/Error")>
        <cfset package = xmlSearch(caller.stFedexTrackingResponse, "/FDXTrack2Reply/Package")>
        <cfset event = xmlSearch(caller.stFedexTrackingResponse, "/FDXTrack2Reply/Package/Event")>
        <cfset caller.trackQuery = queryNew("trackingNumber, errorCode, errorDesc, duplicateWaybill, moreDataFlag, trackingNumberUniqueIdentifier,
				statusCode, statusDescription, service, weight, shipmentWeight, weightUnits, packagingDescription, packageSequenceNumber, packageCount, referenceType, referenceValue,
				shipperCity, shipperState, shipperPostcode, shipperCountry, originCity, originState, originPostcode, originCountry, destinationCity, destinationState, destinationPostcode, destinationCountry,
				estimatedPickupDate, estimatedPickupTime, shipDate, totalTransitDistance, distanceToDestination, distanceUnits, estimatedDeliveryDate, estimatedDeliveryTime,
				deliveredDate, deliveredTime, deliveredLocationCode, deliveredLocationDescription, signedForBy, signatureProofOfDeliveryAvailable, PODNotificationsAvailable, exceptionNotificationsAvailable")>
        <cfset caller.scanQuery = queryNew("scanCity, scanState, scanPostcode, scanCountry, scanDate, scanTime, scanType, scanDesc,  exceptionCode, exceptionDesc, scanDeliveryInfo, scanDelayInfo, statusDesc")>
        <!--- NOTE: scanDeliveryInfo, scanDelayInfo, statusDesc [these columns are now deprecated and no longer used] --->
        <cfscript>
				if (arrayLen(error) eq 1) {
					try {
						temp = queryAddRow(caller.trackQuery, 1);
						if (structKeyExists(error[1], "Error")) {
							temp = querySetCell(caller.trackQuery, "errorCode", error[1].Error.Code.xmlText);
							temp = querySetCell(caller.trackQuery, "errorDesc", error[1].Error.Message.xmlText);
						}
						caller.FedexError = 1;
						caller.FedexErrorDesc = "Soft Error: Fedex error returned";
					}
					catch(any excpt) {
						caller.FedexError = 2;
						caller.FedexErrorDesc = "Hard Error: Script threw an exception (possible invalid Fedex Response)";
					}
				}
				if (caller.FedexError eq 0) {
					/*****************************
					 * Initialize legacy variables
					 *****************************/
					caller.TrackingNum = "";
					caller.Service = "";
					caller.ShipDate = "";
					caller.ESTDeliveryDate = "";
					caller.ESTDeliveryTime = "";
					caller.DESTCity = "";
					caller.DESTCountry = "";
					caller.DESTZip = "";
					caller.DESTState = "";
					caller.DeliveryDate = "";
					caller.DeliveryTime = "";
					caller.SignedBy = "";
					caller.Weight = "";
					caller.WeightUnits = "";
					caller.Pieces = "";
					caller.Reference = "";
					caller.TotalPieces = "";
					caller.ScanCount = "";
					
					/**********************
					 * Store package data
					 **********************/
					try {
						for (i=0; i lt arrayLen(package); ) {
							i=i+1;
							temp = queryAddRow(caller.trackQuery, 1);
							if (structKeyExists(package[i], "TrackingNumber")) {
								temp = querySetCell(caller.trackQuery, "trackingNumber", package[i].TrackingNumber.xmlText);
								caller.TrackingNum = package[i].TrackingNumber.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "DuplicateWaybill")) {
								temp = querySetCell(caller.trackQuery, "duplicateWaybill", package[i].DuplicateWaybill.xmlText);
							}
							if (structKeyExists(package[i], "MoreDataFlag")) {
								temp = querySetCell(caller.trackQuery, "moreDataFlag", package[i].MoreDataFlag.xmlText);
							}
							if (structKeyExists(package[i], "TrackingNumberUniqueIdentifier")) {
								temp = querySetCell(caller.trackQuery, "trackingNumberUniqueIdentifier", package[i].TrackingNumberUniqueIdentifier.xmlText);
							}
							if (structKeyExists(package[i], "StatusCode")) {
								temp = querySetCell(caller.trackQuery, "statusCode", package[i].StatusCode.xmlText);
							}
							if (structKeyExists(package[i], "StatusDescription")) {
								temp = querySetCell(caller.trackQuery, "statusDescription", package[i].StatusDescription.xmlText);
							}
							if (structKeyExists(package[i], "Service")) {
								temp = querySetCell(caller.trackQuery, "service", package[i].Service.xmlText);
								caller.Service = package[i].Service.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "Weight")) {
								temp = querySetCell(caller.trackQuery, "weight", package[i].Weight.xmlText);
								caller.Weight = package[i].Weight.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "ShipmentWeight")) {
								temp = querySetCell(caller.trackQuery, "shipmentWeight", package[i].ShipmentWeight.xmlText);
							}
							if (structKeyExists(package[i], "WeightUnits")) {
								temp = querySetCell(caller.trackQuery, "weightUnits", package[i].WeightUnits.xmlText);
								caller.WeightUnits = package[i].WeightUnits.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "PackagingDescription")) {
								temp = querySetCell(caller.trackQuery, "packagingDescription", package[i].PackagingDescription.xmlText);
							}
							if (structKeyExists(package[i], "PackageCount")) {
								temp = querySetCell(caller.trackQuery, "packageCount", package[i].PackageCount.xmlText);
								caller.TotalPieces = package[i].PackageCount.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "PackageSequenceNumber")) {
								temp = querySetCell(caller.trackQuery, "packageSequenceNumber", package[i].PackageSequenceNumber.xmlText);
								caller.Pieces = package[i].PackageSequenceNumber.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "EstimatedPickupDate")) {
								temp = querySetCell(caller.trackQuery, "estimatedPickupDate", package[i].EstimatedPickupDate.xmlText);
							}
							if (structKeyExists(package[i], "EstimatedPickupTime")) {
								temp = querySetCell(caller.trackQuery, "estimatedPickupTime", package[i].EstimatedPickupTime.xmlText);
							}
							if (structKeyExists(package[i], "ShipDate")) {
								temp = querySetCell(caller.trackQuery, "ShipDate", package[i].ShipDate.xmlText);
								caller.ShipDate = package[i].ShipDate.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "TotalTransitDistance")) {
								temp = querySetCell(caller.trackQuery, "totalTransitDistance", package[i].TotalTransitDistance.xmlText);
							}
							if (structKeyExists(package[i], "DistanceToDestination")) {
								temp = querySetCell(caller.trackQuery, "distanceToDestination", package[i].DistanceToDestination.xmlText);
							}
							if (structKeyExists(package[i], "DistanceUnits")) {
								temp = querySetCell(caller.trackQuery, "distanceUnits", package[i].DistanceUnits.xmlText);
							}
							if (structKeyExists(package[i], "EstimatedDeliveryDate")) {
								temp = querySetCell(caller.trackQuery, "estimatedDeliveryDate", package[i].EstimatedDeliveryDate.xmlText);
								caller.ESTDeliveryDate = package[i].EstimatedDeliveryDate.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "EstimatedDeliveryTime")) {
								temp = querySetCell(caller.trackQuery, "estimatedDeliveryTime", package[i].EstimatedDeliveryTime.xmlText);
								caller.ESTDeliveryTime = package[i].EstimatedDeliveryTime.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "DeliveredDate")) {
								temp = querySetCell(caller.trackQuery, "deliveredDate", package[i].DeliveredDate.xmlText);
								caller.DeliveryDate = package[i].DeliveredDate.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "DeliveredTime")) {
								temp = querySetCell(caller.trackQuery, "deliveredTime", package[i].DeliveredTime.xmlText);
								caller.DeliveryTime = package[i].DeliveredTime.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "EstimatedDeliveryTime")) {
								temp = querySetCell(caller.trackQuery, "estimatedDeliveryTime", package[i].EstimatedDeliveryTime.xmlText);
							}
							if (structKeyExists(package[i], "DeliveredLocationCode")) {
								temp = querySetCell(caller.trackQuery, "deliveredLocationCode", package[i].DeliveredLocationCode.xmlText);
							}
							if (structKeyExists(package[i], "DeliveredLocationDescription")) {
								temp = querySetCell(caller.trackQuery, "deliveredLocationDescription", package[i].DeliveredLocationDescription.xmlText);
							}
							if (structKeyExists(package[i], "SignedForBy")) {
								temp = querySetCell(caller.trackQuery, "signedForBy", package[i].SignedForBy.xmlText);
								caller.SignedBy = package[i].SignedForBy.xmlText; //provides legacy version support
							}
							if (structKeyExists(package[i], "SignatureProofOfDeliveryAvailable")) {
								temp = querySetCell(caller.trackQuery, "signatureProofOfDeliveryAvailable", package[i].SignatureProofOfDeliveryAvailable.xmlText);
							}
							if (structKeyExists(package[i], "PODNotificationsAvailable")) {
								temp = querySetCell(caller.trackQuery, "PODNotificationsAvailable", package[i].PODNotificationsAvailable.xmlText);
							}
							if (structKeyExists(package[i], "ExceptionNotificationsAvaiilable")) {
								temp = querySetCell(caller.trackQuery, "exceptionNotificationsAvailable", package[i].ExceptionNotificationsAvailable.xmlText);
							}
							if (structKeyExists(package[i], "OtherIdentifier")) {
								temp = querySetCell(caller.trackQuery, "referenceType", package[i].OtherIdentifier[1].Type.xmlText);
								temp = querySetCell(caller.trackQuery, "referenceValue", package[i].OtherIdentifier[1].Value.xmlText);
								caller.Reference = package[i].OtherIdentifier[1].Value.xmlText; //provides legacy version support
							}
							caller.ScanCount = arrayLen(event); //provides legacy version support
							if (structKeyExists(package[i], "ShipperAddress")) {
								if (structKeyExists(package[i].ShipperAddress, "City")) {
									temp = querySetCell(caller.trackQuery, "shipperCity", package[i].ShipperAddress.City.xmlText);
								}
								if (structKeyExists(package[i].ShipperAddress, "StateOrProvinceCode")) {
									temp = querySetCell(caller.trackQuery, "shipperState", package[i].ShipperAddress.StateOrProvinceCode.xmlText);
								}
								if (structKeyExists(package[i].ShipperAddress, "PostalCode")) {
									temp = querySetCell(caller.trackQuery, "shipperPostcode", package[i].ShipperAddress.PostalCode.xmlText);
								}
								if (structKeyExists(package[i].ShipperAddress, "CountryCode")) {
									temp = querySetCell(caller.trackQuery, "shipperCountry", package[i].ShipperAddress.CountryCode.xmlText);
								}
							}
							if (structKeyExists(package[i], "OriginLocationAddress")) {
								if (structKeyExists(package[i].OriginLocationAddress, "City")) {
									temp = querySetCell(caller.trackQuery, "originCity", package[i].OriginLocationAddress.City.xmlText);
								}
								if (structKeyExists(package[i].OriginLocationAddress, "StateOrProvinceCode")) {
									temp = querySetCell(caller.trackQuery, "originState", package[i].OriginLocationAddress.StateOrProvinceCode.xmlText);
								}
								if (structKeyExists(package[i].OriginLocationAddress, "PostalCode")) {
									temp = querySetCell(caller.trackQuery, "originPostcode", package[i].OriginLocationAddress.PostalCode.xmlText);
								}
								if (structKeyExists(package[i].OriginLocationAddress, "CountryCode")) {
									temp = querySetCell(caller.trackQuery, "originCountry", package[i].OriginLocationAddress.CountryCode.xmlText);
								}
							}
							if (structKeyExists(package[i], "DestinationAddress")) {
								if (structKeyExists(package[i].DestinationAddress, "City")) {
									temp = querySetCell(caller.trackQuery, "destinationCity", package[i].DestinationAddress.City.xmlText);
									caller.DESTCity = package[i].DestinationAddress.City.xmlText; //provides legacy version support
								}
								if (structKeyExists(package[i].DestinationAddress, "StateOrProvinceCode")) {
									temp = querySetCell(caller.trackQuery, "destinationState", package[i].DestinationAddress.StateOrProvinceCode.xmlText);
									caller.DESTState = package[i].DestinationAddress.StateOrProvinceCode.xmlText; //provides legacy version support
								}
								if (structKeyExists(package[i].DestinationAddress, "PostalCode")) {
									temp = querySetCell(caller.trackQuery, "destinationPostcode", package[i].DestinationAddress.PostalCode.xmlText);
									caller.DESTZip = package[i].DestinationAddress.PostalCode.xmlText; //provides legacy version support
								}
								if (structKeyExists(package[i].DestinationAddress, "CountryCode")) {
									temp = querySetCell(caller.trackQuery, "destinationCountry", package[i].DestinationAddress.CountryCode.xmlText);
									caller.DESTCountry = package[i].DestinationAddress.CountryCode.xmlText; //provides legacy version support
								}
							}
						} // close package loop
						caller.FedexError = 0;
						caller.FedexErrorDesc = "Success: Fedex response parsed successfully";
					}
					catch(any excpt) {
						caller.FedexError = 2;
						caller.FedexErrorDesc = "Hard Error: Script threw an exception parsing package element (possible invalid Fedex Response)";
					}
					/******************
					 * Store scan data
					 ******************/
					 if (arrayLen(event) gte 1) {
						 try {
							 for (i=0; i lt arrayLen(event); ) {
								i=i+1;
								temp = queryAddRow(caller.scanQuery, 1);
								/* scanDate, scanTime, scanType, scanDesc, scanDeliveryInfo, scanDelayInfo, statusDesc, scanCity, scanState, scanPostcode, exceptionCode, exceptionDesc */
								if (structKeyExists(event[i], "Date")) {
									temp = querySetCell(caller.scanQuery, "scanDate", event[i].Date.xmlText);
								}
								if (structKeyExists(event[i], "Time")) {
									temp = querySetCell(caller.scanQuery, "scanTime", event[i].Time.xmlText);
								}
								if (structKeyExists(event[i], "Type")) {
									temp = querySetCell(caller.scanQuery, "scanType", event[i].Type.xmlText);
								}
								if (structKeyExists(event[i], "Description")) {
									temp = querySetCell(caller.scanQuery, "scanDesc", event[i].Description.xmlText);
								}
								if (structKeyExists(event[i], "StatusExceptionCode")) {
									temp = querySetCell(caller.scanQuery, "exceptionCode", event[i].StatusExceptionCode.xmlText);
								}
								if (structKeyExists(event[i], "StatusExceptionDescription")) {
									temp = querySetCell(caller.scanQuery, "exceptionDesc", event[i].StatusExceptionDescription.xmlText);
								}
								if (structKeyExists(event[i], "Address")) {
									if (structKeyExists(event[i].Address, "City")) {
										temp = querySetCell(caller.scanQuery, "scanCity", event[i].Address.City.xmlText);
									}
									if (structKeyExists(event[i].Address, "StateOrProvinceCode")) {
										temp = querySetCell(caller.scanQuery, "scanState", event[i].Address.StateOrProvinceCode.xmlText);
									}
									if (structKeyExists(event[i].Address, "PostalCode")) {
										temp = querySetCell(caller.scanQuery, "scanPostcode", event[i].Address.PostalCode.xmlText);
									}
									if (structKeyExists(event[i].Address, "CountryCode")) {
										temp = querySetCell(caller.scanQuery, "scanCountry", event[i].Address.CountryCode.xmlText);
									}
								}
							 } //close scan loop
							 caller.FedexError = 0;
							 caller.FedexErrorDesc = "Success: Fedex response parsed successfully";
						 }
						 catch(any excpt) {
							caller.FedexError = 2;
							caller.FedexErrorDesc = "Hard Error: Script threw an exception parsing scan history element (possible invalid Fedex Response)";
						}
					 }
					
				} // close main loop - check for fedexError
				</cfscript>
      </cfif>
    </cfif>
    <!--- Debug Mode check close --->
    <cfelse>
    <!--- Valid response not received --->
    <cfset caller.FedexError = "2">
    <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex">
  </cfif>
  <!--- Valid response received check end --->
  </cfcase>
  <!--- // Tracking API 2.5 (docs June 2006) close // --->
  <!--- // Signature POD API 2.5 (docs June 2006) open // --->
  <cfcase value="PODOnlineRequest">
  <cfscript>
	caller.FedexError = 0;
	groundConsigneeInidciator = '<ConfigurableGroundConsignee>
		<PersonName>#attributes.ShipToContactName#</PersonName>
		<CompanyName>#attributes.ShipToCompany#</CompanyName>
		<Address>
		  <Line1>#attributes.ShipToStreet#</Line1>
		  <Line2>#attributes.ShipToStreet2#</Line2>
		  <City>#attributes.ShipToCity#</City>
		  <StateOrProvinceCode>#attributes.ShipToState#</StateOrProvinceCode>
		  <PostalCode>#attributes.ShipToZip#</PostalCode>
		  <CountryCode>#attributes.ShipToCountry#</CountryCode>
		</Address>
		<MoreInformation></MoreInformation>
	</ConfigurableGroundConsignee>';

	attributes.XMLRequestInput = '<?xml version="#attributes.XMLVersion#" encoding="UTF-8"?>
	<FDXSPODRequest xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXSPODRequest.xsd">
	<RequestHeader>
		<CustomerTransactionIdentifier>APT_SPOD_Request</CustomerTransactionIdentifier>
		<MeterNumber>#attributes.FedexIndentifier#</MeterNumber>
		<AccountNumber>#attributes.AccountNumber#</AccountNumber>
		<CarrierCode>#attributes.RateRequestType#</CarrierCode>
	</RequestHeader>
	<ShipDate>#attributes.DateShipped#</ShipDate>
	<TrackingNumber>#attributes.TrackingNumber#</TrackingNumber>
	<LanguageCode>#attributes.ShipperLanguageCode#</LanguageCode>
	#groundConsigneeInidciator#
	<ReturnLetterFormat>#attributes.PODLabelType#</ReturnLetterFormat>
	</FDXSPODRequest>';
	</cfscript>
  <cfhttp method="post" url="#attributes.FedexServer#" resolveurl="yes" port="443" timeout="#attributes.TimeOut#">
    <cfhttpparam name="XML" type="xml" value="#attributes.XMLRequestInput#">
  </cfhttp>
  <cfif isDefined("cfhttp.fileContent") AND len(cfhttp.fileContent) gt 10>
    <!--- check if valid response returned --->
    <!--- Debug Mode --->
    <cfif attributes.Debug eq "True">
      <cftry>
        <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#PODRequest.xml" output="#attributes.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
        <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#PODResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
        <cfcatch type="any">
        </cfcatch>
      </cftry>
      <cftry>
        <cfset caller.stFedexPODResponse = xmlParse(trim(cfhttp.fileContent))>
        <cfdump var="#caller.stFedexPODResponse#">
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex, XML could not be parsed (Signature POD Request: DEBUG)">
        </cfcatch>
      </cftry>
      <cfelse>
      <cftry>
        <cfset caller.stFedexPODResponse = xmlParse(Trim(cfhttp.fileContent))>
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex, XML could not be parsed (Signature POD Request)">
        </cfcatch>
      </cftry>
      <cfif caller.FedexError eq 0>
        <cfset error = xmlSearch(caller.stFedexPODResponse, "/FDXSPODReply/Error")>
        <cfset pod = xmlSearch(caller.stFedexPODResponse, "/FDXSPODReply/Letter")>
        <cfif arrayLen(error) eq 1>
          <cfset caller.FedexError = "1">
          <cfset caller.FedexErrorDesc = error[1].Error.Message.xmlText>
          <cftry>
            <cfcatch type="any">
              <cfset caller.FedexError = "2">
              <cfset caller.FedexErrorDesc = "Hard Error: Script error parsing error element returned by Fedex response (Signature POD Request)">
            </cfcatch>
          </cftry>
          <cfelseif arrayLen(pod) eq 1>
          <cftry>
            <cfset binLetter = toBinary("#pod[1].XmlText#")>
            <cffile action="write" file="#attributes.ServerFilePath##trailingSlash#PODImages#trailingSlash##attributes.trackingNumber#.#attributes.PODLabelType#" output="#binLetter#" nameconflict="overwrite">
            <cfset caller.PODImageName = #attributes.trackingNumber# & "." & attributes.PODLabelType>
            <cfset caller.PODLetter = caller.PODImageName>
            <cfset caller.FedexError = 0>
            <cfset caller.FedexErrorDesc = "Success: POD Letter generated">
            <cfcatch type="any">
              <cfset caller.FedexError = "2">
              <cfset caller.FedexErrorDesc = "Hard Error: Script error writing POD letter to disk (Signature POD Request)">
            </cfcatch>
          </cftry>
        </cfif>
      </cfif>
    </cfif>
    <cfelse>
    <cfset caller.FedexError = "2">
    <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex, XML could not be parsed (Signature POD Request)">
  </cfif>
  </cfcase>
  <!--- // Signature POD API 2.5 (docs June 2006) close // --->
  
  <!--- ***** 2.0 ****** --->
  <!--- Ship Request  --->
  <cfcase value="ShipRequest">
  <cfscript>
	if ( (attributes.ServiceLevel eq "FEDEXGROUND" OR attributes.ServiceLevel eq "GROUNDHOMEDELIVERY") ) {
		attributes.RateRequestType = 'FDXG';
	}
	else {
		attributes.RateRequestType = 'FDXE';
	}
	/* ///// INTERNATIONAL SHIPMENT ALL ELEMENTS /////
	<International>
	 <RecipientTIN>#attributes.RecipientTIN#</RecipientTIN> // OPTIONAL //
	 <Broker> // OPTIONAL //
	 	<AccountNumber>#attributes.BrokerAccountNumber#</AccountNumber>
		<TIN>#attributes.BrokerTIN#</TIN>
		<Contact>
			<PersonName>#attributes.BrokerName#</PersonName>
			<CompanyName>#attributes.BrokerCompanyName#</CompanyName>
			<PhoneNumber>#attributes.BrokerPhoneNumber#</PhoneNumber>
			<PagerNumber>#attributes.BrokerPagerNumber#</PagerNumber>
			<FaxNumber>#attributes.BrokerFaxNumber#</FaxNumber>
			<E-MailAddress>#attributes.BrokerEmail#</E-MailAddress>
		</Contact>
		<Address>
			<Line1>#attributes.BrokerStreet#</Line1>
			<Line2>#attributes.BrokerStreet2#</Line2>
			<City>#attributes.BrokerCity#</City>
			<StateOrProvinceCode>#attributes.BrokerState#</StateOrProvinceCode>
			<PostalCode>#attributes.BrokerZip#</PostalCode>
			<CountryCode>#attributes.BrokerCountry#</CountryCode>	
		</Address>
	 </Broker> // OPTIONAL //
	 <ImporterOfRecord> // OPTIONAL, Applicable only for Commercial Invoice. If the consignee and importer are not the same, the importer fields are required.
	 ...
	 </ImporterOfRecord>
	 <DutiesPayment> // Required if PayorType is THIRDPARTY, optional if RECIPIENT. //
	 	<DutiesPayor>
			<AccountNumber>#attributes.DutiesPayorAccountNumber#</AccountNumber>
			<CountryCode>#attributes.DutiesPayorCountry#</CountryCode>
		</DutiesPayor>
		<PayorType>#attributes.DutiesPayorType#</PayorType>
	 </DutiesPayment>
	 <TermsOfSale>#attributes.TermsOfSale#</TermsOfSale> // REQUIRED, EXCEPT IF INTL EXPRESS DOCUMENT //
	 <PartiesToTransaction>#attributes.PartiesToTransaction#</PartiesToTransaction> // REQUIRED, 1 = Related, 0 = Unrelated //
	 <Document>#attributes.IntlDocumentDesc#</Document> // REQUIRED FOR Document Shipments, Description of document being shipped. //
	 <NAFTA>#attributes.NAFTAShipment#</NAFTA> // REQUIRED, ?true? or ?1? if NAFTA shipment, else ?false? or ?0?. May be applicable if origin and destination countries are US, CA, or MX.
	 <CountryOfUltimateDestination>#attributes.CountryOfUltimateDestination#</CountryOfUltimateDestination> // REQUIRED //
	 <TotalCustomsValue>#numberFormat(attributes.TotalCustomsValue, "9.99")#</TotalCustomsValue> // REQUIRED Format: Two explicit decimal positions (e.g. 100.00). //
	 <CommercialInvoice> //OPTIONAL
	 ...
	 </CommercialInvoice>
	 <Commodity> // UNSURE (NOT SPECIFIED) , APPEARS TO BE REQUIRED //
	 ..
	 </Commodity>
	 <SED> // REQUIRED FOR NON-DOCUMENT Shipment exported from the US //
	 	<SenderTINOrDUNS>#attributes.SenderTINOrDUNS#</SenderTINOrDUNS>
		<SenderTINOrDUNSType>#attributes.SenderTINOrDUNSType#</SenderTINOrDUNSType>
		<AESOrFTSRExemptionNumber>#attributes.AESOrFTSRExemptionNumber#</AESOrFTSRExemptionNumber>
	 </SED>
	 <Export> // Required for any International non-document shipments originating in Canada //
	 ..
	 </Export>
	 <ShipmentContent> //OPTIONAL //
	 </ShipmentContent>
	 <RMA>
	  <Number></Number> // OPTIONAL //
	 </RMA>
	</International>
	*/
	
	/* ///// INTERNATIONAL SHIPMENT MIN REQUIRED ELEMENTS /////
	<International>
	 <DutiesPayment> // Required if PayorType is THIRDPARTY, optional if RECIPIENT. //
	 	<DutiesPayor>
			<AccountNumber>#attributes.DutiesPayorAccountNumber#</AccountNumber>
			<CountryCode>#attributes.DutiesPayorCountry#</CountryCode>
		</DutiesPayor>
		<PayorType>#attributes.DutiesPayorType#</PayorType>
	 </DutiesPayment>
	 <TermsOfSale>#attributes.TermsOfSale#</TermsOfSale> // REQUIRED, EXCEPT IF INTL EXPRESS DOCUMENT //
	 <PartiesToTransaction>#attributes.PartiesToTransaction#</PartiesToTransaction> // REQUIRED, 1 = Related, 0 = Unrelated //
	 <Document>#attributes.IntlDocumentDesc#</Document> // REQUIRED FOR Document Shipments, Description of document being shipped. //
	 <NAFTA>#attributes.NAFTAShipment#</NAFTA> // REQUIRED, ?true? or ?1? if NAFTA shipment, else ?false? or ?0?. May be applicable if origin and destination countries are US, CA, or MX.
	 <CountryOfUltimateDestination>#attributes.CountryOfUltimateDestination#</CountryOfUltimateDestination> // REQUIRED //
	 <TotalCustomsValue>#numberFormat(attributes.TotalCustomsValue, "9.99")#</TotalCustomsValue> // REQUIRED Format: Two explicit decimal positions (e.g. 100.00). //
	 <SED> // REQUIRED FOR NON-DOCUMENT Shipment exported from the US //
	 	<SenderTINOrDUNS>#attributes.SenderTINOrDUNS#</SenderTINOrDUNS>
		<SenderTINOrDUNSType>#attributes.SenderTINOrDUNSType#</SenderTINOrDUNSType>
		<AESOrFTSRExemptionNumber>#attributes.AESOrFTSRExemptionNumber#</AESOrFTSRExemptionNumber>
	 </SED>
	</International>
	*/
	
	// International shipment, Using Minimum Required Elements
	if ( attributes.ShipToCountry neq "US" ) {
		IntlIndicator = '<International>
	 <DutiesPayment>
		<PayorType>#attributes.DutiesPayorType#</PayorType>
	 </DutiesPayment>
	 <TermsOfSale>#attributes.TermsOfSale#</TermsOfSale>
	 <PartiesToTransaction>#attributes.PartiesToTransaction#</PartiesToTransaction>
	 <NAFTA>#attributes.NAFTAShipment#</NAFTA>
	 <CountryOfUltimateDestination>#attributes.CountryOfUltimateDestination#</CountryOfUltimateDestination>
	 <TotalCustomsValue>#numberFormat(attributes.TotalCustomsValue, "9.99")#</TotalCustomsValue>
	 <Commodity>
	   <NumberOfPieces>#attributes.CommodityNumberOfPieces#</NumberOfPieces>
	   <Description>#attributes.CommodityDescription#</Description>
	   <CountryOfManufacture>#attributes.CommodityCountryOfManufacture#</CountryOfManufacture>
	   <Weight>#numberFormat(attributes.CommodityWeight, "9.9")#</Weight>
	   <Quantity>#attributes.CommodityQuantity#</Quantity>
	   <QuantityUnits>#attributes.CommodityUnit#</QuantityUnits>
	   <UnitPrice>#numberFormat(attributes.CommodityUnitPrice, "9.999999")#</UnitPrice>
	   <CustomsValue>#numberFormat(attributes.CommodityCustomsValue, "9.999999")#</CustomsValue>
	 </Commodity>
	 <SED>
	 	<SenderTINOrDUNS>#attributes.SenderTINOrDUNS#</SenderTINOrDUNS>
		<SenderTINOrDUNSType>#attributes.SenderTINOrDUNSType#</SenderTINOrDUNSType>
		<AESOrFTSRExemptionNumber>#attributes.AESOrFTSRExemptionNumber#</AESOrFTSRExemptionNumber>
	 </SED>
	</International>';
	}
	else {
		IntlIndicator = '';
	}
	
	// Special Services
	SSOpen = '<SpecialServices>';
	SSClose = '</SpecialServices>';
	
	if ( Len(attributes.SSCodAmount) gt 0 AND Len(attributes.SSCODType) gt 0 ) {
	SSCODIndicator = '<COD>
				<CollectionAmount>#Trim(NumberFormat(attributes.SSCodAmount,"99999999999.99"))#</CollectionAmount>
				<CollectionType>#attributes.SSCODType#</CollectionType>
			</COD>';
	}
	else { SSCODIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSHoldAtLocation eq "1" ) {
	SSHoldAtLocIndicator = '<HoldAtLocation>
			<PhoneNumber>#attributes.SSHoldAtLocationPhone#</PhoneNumber>
			<Address>
				<Line1>#attributes.SSHoldAtLocationStreet1#</Line1>
				<City>#attributes.SSHoldAtLocationCity#</City>
				<StateOrProvinceCode>#attributes.SSHoldAtLocationState#</StateOrProvinceCode>
				<PostalCode>#attributes.SSHoldAtLocationZip#</PostalCode>
			</Address>
		</HoldAtLocation>';
	}
	else { SSHoldAtLocIndicator = ''; }
	
	if ( attributes.SSDangerousGoods eq "ACCESSIBLE" OR attributes.SSDangerousGoods eq "INACCESSIBLE" ) {
	SSDangGoodsIndicator = '<DangerousGoods>
		<Accessibility>#attributes.SSDangerousGoods#</Accessibility>
	</DangerousGoods>';
	}
	else { SSDangGoodsIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSDryIce eq "1" ) {
	SSDryIceIndicator = '<DryIce>
		<WeightUnits>#attributes.SSDryIceWeightUnits#</WeightUnits>
		<Weight>#attributes.SSDryIceWeight#</Weight>
	</DryIce>';
	}
	else { SSDryIceIndicator = ''; }
	
	if ( attributes.SSResDelivery eq "1" ) {
	SSResDelivIndicator = '<ResidentialDelivery>#attributes.SSResDelivery#</ResidentialDelivery>';
	}
	else { SSResDelivIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSInsidePickup eq "1" ) {
	SSInsidePickupIndicator = '<InsidePickup>#attributes.SSInsidePickup#</InsidePickup>';
	}
	else { SSInsidePickupIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSInsideDelivery eq "1" ) {
	SSInsideDeliveryIndicator = '<InsideDelivery>#attributes.SSInsideDelivery#</InsideDelivery>';
	}
	else { SSInsideDeliveryIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSSatPickup eq "1" ) {
	SSSaturdayPickupIndicator = '<SaturdayPickup>#attributes.SSSatPickup#</SaturdayPickup>';
	}
	else { SSSaturdayPickupIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXE" AND attributes.SSSatDelivery eq "1" ) {
	SSSaturdayDeliveryIndicator = '<SaturdayDelivery>#attributes.SSSatDelivery#</SaturdayDelivery>';
	}
	else { SSSaturdayDeliveryIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXG" AND attributes.SSAOD eq "1" ) {
	SSAODIndicator = '<AOD>#attributes.SSAOD#</AOD>';
	}
	else { SSAODIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXG" AND attributes.SSAutoPOD eq "1" ) {
	SSAutoPODIndicator = '<AutoPOD>#attributes.SSAutoPOD#</AutoPOD>';
	}
	else { SSAutoPODIndicator = ''; }
	
	if ( attributes.RateRequestType eq "FDXG" AND attributes.SSNonStdContainer eq "1" ) {
	SSNonStandardContainerIndicator = '<NonStandardContainer>#attributes.SSNonStdContainer#</NonStandardContainer>';
	}
	else { SSNonStandardContainerIndicator = ''; }
	
	if ( attributes.SSFutureDayShipment eq "1" ) {
	SSFutureDayIndicator = '<FutureDayShipment>1</FutureDayShipment>';
	}
	else { SSFutureDayIndicator = ''; }
	
	/* // Email Notification //
	<EMailNotification>
		<ShipAlertFaxNumber>#attributes.ShipAlertFaxNumber#</ShipAlertFaxNumber>
		<ShipAlertOptionalMessage>#attributes.ShipAlertOptionalMessage#</ShipAlertOptionalMessage>
		<Shipper>
			<ShipAlert>#attributes.ShipperShipAlert#</ShipAlert>
			<DeliveryNotification>#attributes.ShipperDeliveryNotification#</DeliveryNotification>
			<ExceptionNotification>#attributes.ShipperExceptionNotification#</ExceptionNotification>
			<Format>#attributes.ShipperEmailFormat#</Format>
			<LanguageCode>#attributes.ShipperLanguageCode#</LanguageCode>
			<LocaleCode>#attributes.ShipperLocaleCode#</LocaleCode>
		</Shipper>
		<Recipient>
			<ShipAlert>#attributes.RecipientShipAlert#</ShipAlert>
			<DeliveryNotification>#attributes.RecipientDeliveryNotification#</DeliveryNotification>
			<ExceptionNotification>#attributes.RecipientExceptionNotification#</ExceptionNotification>
			<Format>#attributes.RecipientEmailFormat#</Format>
			<LanguageCode>#attributes.RecipientLanguageCode#</LanguageCode>
			<LocaleCode>#attributes.RecipientLocaleCode#</LocaleCode>
		</Recipient>
		<Broker>
			<ShipAlert>#attributes.BrokerShipAlert#</ShipAlert>
			<DeliveryNotification>#attributes.BrokerDeliveryNotification#</DeliveryNotification>
			<ExceptionNotification>#attributes.BrokerExceptionNotification#</ExceptionNotification>
			<Format>#attributes.BrokerEmailFormat#</Format>
			<LanguageCode>#attributes.BrokerLanguageCode#</LanguageCode>
			<LocaleCode>#attributes.BrokerLocaleCode#</LocaleCode>
		</Broker>
		<Other>
			<EMailAddress>#attributes.Other1Email#</EMailAddress>
			<ShipAlert>#attributes.Other1ShipAlert#</ShipAlert>
			<DeliveryNotification>#attributes.Other1DeliveryNotification#</DeliveryNotification>
			<ExceptionNotification></ExceptionNotification>
			<Format>#attributes.Other1EmailFormat#</Format>
			<LanguageCode>#attributes.Other1LanguageCode#</LanguageCode>
			<LocaleCode>#attributes.Other1LocaleCode#</LocaleCode>
		</Other>			
	</EMailNotification>
	*/
	
	EN_ShipAlertFaxNumber = '';
	if ( len(attributes.ShipAlertFaxNumber) gt 5 ) {
		EN_ShipAlertFaxNumber = '<ShipAlertFaxNumber>#attributes.ShipAlertFaxNumber#</ShipAlertFaxNumber>';
	}
	
	EN_ShipAlertOptionalMessage = '';
	if ( len(attributes.ShipAlertOptionalMessage) gte 2 ) {
		EN_ShipAlertOptionalMessage = '<ShipAlertOptionalMessage>#attributes.ShipAlertOptionalMessage#</ShipAlertOptionalMessage>';
	}
	
	EN_ShipperNotify = '';
	if ( attributes.ShipperNotify eq 1 ) {
		EN_ShipperNotify = '<Shipper>
			<ShipAlert>#attributes.ShipperShipAlert#</ShipAlert>
			<DeliveryNotification>#attributes.ShipperDeliveryNotification#</DeliveryNotification>
			<ExceptionNotification>#attributes.ShipperExceptionNotification#</ExceptionNotification>
			<Format>#attributes.ShipperEmailFormat#</Format>
			<LanguageCode>#attributes.ShipperLanguageCode#</LanguageCode>
			<LocaleCode>#attributes.ShipperLocaleCode#</LocaleCode>
		</Shipper>';
	}
	
	EN_RecipientNotify = '';
	if ( attributes.RecipientNotify eq 1 ) {
		EN_RecipientNotify = '<Recipient>
			<ShipAlert>#attributes.RecipientShipAlert#</ShipAlert>
			<DeliveryNotification>#attributes.RecipientDeliveryNotification#</DeliveryNotification>
			<ExceptionNotification>#attributes.RecipientExceptionNotification#</ExceptionNotification>
			<Format>#attributes.RecipientEmailFormat#</Format>
			<LanguageCode>#attributes.RecipientLanguageCode#</LanguageCode>
			<LocaleCode>#attributes.RecipientLocaleCode#</LocaleCode>
		</Recipient>';
	}
	
	EN_Other1Notify = '';
	if ( attributes.Other1Notify eq 1 ) {
		EN_Other1Notify = '<Other>
			<EMailAddress>#attributes.Other1Email#</EMailAddress>
			<ShipAlert>#attributes.Other1ShipAlert#</ShipAlert>
			<DeliveryNotification>#attributes.Other1DeliveryNotification#</DeliveryNotification>
			<ExceptionNotification>#attributes.Other1ExceptionNotification#</ExceptionNotification>
			<Format>#attributes.Other1EmailFormat#</Format>
			<LanguageCode>#attributes.Other1LanguageCode#</LanguageCode>
			<LocaleCode>#attributes.Other1LocaleCode#</LocaleCode>
		</Other>';
	}

	EmailNotificationOpen = '<EMailNotification>';
	EmailNotificationClose = '</EMailNotification>';
	SSEmailNotificationIndicator = '';
	
	if ( Len(EN_ShipAlertFaxNumber) neq 0
		OR Len(EN_ShipperNotify) neq 0
		OR Len(EN_RecipientNotify) neq 0
		OR Len(EN_Other1Notify) neq 0 ){
	
		SSEmailNotificationIndicator = '#EmailNotificationOpen#
			#EN_ShipAlertFaxNumber#
			#EN_ShipAlertOptionalMessage#
			#EN_ShipperNotify#
			#EN_RecipientNotify#
			#EN_Other1Notify#
		#EmailNotificationClose#';
	}
	
	// SpecialServices/SignatureOption
	SSSignatureOptionIndicator = '';
	SSSignatureReleaseIndicator = '';
	if ( isDefined("attributes.SSSignatureOption") AND len(attributes.SSSignatureOption) gte 3 ) {
		SSSignatureOptionIndicator = '<SignatureOption>#attributes.SSSignatureOption#</SignatureOption>';
		
		// SpecialServices / SignatureRelease
		if ( isDefined("attributes.SignatureRelease") AND len(attributes.SignatureRelease) gte 1 ) {
			SSSignatureReleaseIndicator = '<SignatureRelease>#attributes.SignatureRelease#</SignatureRelease>';
		}
	
	}
	
	if ( Len(SSCODIndicator) neq 0
		OR Len(SSHoldAtLocIndicator) neq 0
		OR Len(SSDangGoodsIndicator) neq 0
		OR Len(SSDryIceIndicator) neq 0
		OR Len(SSResDelivIndicator) neq 0
		OR Len(SSInsidePickupIndicator) neq 0
		OR Len(SSInsideDeliveryIndicator) neq 0
		OR Len(SSSaturdayPickupIndicator) neq 0
		OR Len(SSSaturdayDeliveryIndicator) neq 0
		OR Len(SSAODIndicator) neq 0
		OR Len(SSAutoPODIndicator) neq 0
		OR Len(SSNonStandardContainerIndicator) neq 0 
		OR Len(SSFutureDayIndicator) neq 0 
		OR Len(SSEmailNotificationIndicator) neq 0
		OR Len(SSSignatureOptionIndicator) neq 0 ){
	
		SSIndicator = '#SSOpen#
			#SSCODIndicator#
			#SSHoldAtLocIndicator#
			#SSDangGoodsIndicator#
			#SSDryIceIndicator#
			#SSFutureDayIndicator#
			#SSResDelivIndicator#
			#SSInsidePickupIndicator#
			#SSInsideDeliveryIndicator#
			#SSSaturdayPickupIndicator#
			#SSSaturdayDeliveryIndicator#
			#SSAODIndicator#
			#SSAutoPODIndicator#
			#SSEmailNotificationIndicator#
			#SSNonStandardContainerIndicator#
			#SSSignatureOptionIndicator#
			#SSSignatureReleaseIndicator#
		#SSClose#';
	}
	else {
		SSIndicator = '';
	}
	
	// Home Delivery
	if ( Len(attributes.HomeDeliveryType) gt 0 ) {
		HomeDelivIndicator = '<HomeDelivery>
		<Date>#attributes.HomeDeliveryDate#</Date>
		<Instructions>#Left(attributes.HomeDeliveryInstructions, 74)#</Instructions>
		<Type>#attributes.HomeDeliveryType#</Type>
		<PhoneNumber>#attributes.HomeDeliveryPhoneNumber#</PhoneNumber>
		<SignatureRequired>#attributes.HomeDeliverySigRequired#</SignatureRequired>
	</HomeDelivery>';
	}
	else {
		HomeDelivIndicator = '';
	}
	
	//Thermal labels only

	if ( attributes.LabelImageType eq "ELTRON" OR attributes.LabelImageType eq "ZEBRA") {
		if (attributes.ThermalLabelType eq 'ZONE001' AND len(attributes.ThermalLabelZoneNumber) gte 1) {
			ThermalLabelIndicator = '
				<LabelStockOrientation>#attributes.LabelStockOrientation#</LabelStockOrientation>
				<DocTabLocation>#attributes.ThermalLabelDocTabLocation#</DocTabLocation> 
				<DocTabContent>
					<Type>#attributes.ThermalLabelType#</Type>
					<Zone001>
						<HeaderValuePair>
							<ZoneNumber>#attributes.ThermalLabelZoneNumber#</ZoneNumber>
							<Header>#attributes.ThermalLabelHeader#</Header>
							<Value>#attributes.ThermalLabelValue#</Value>
						</HeaderValuePair>
					</Zone001>
				</DocTabContent>';
		}
		else {
			ThermalLabelIndicator = '
				<LabelStockOrientation>#attributes.LabelStockOrientation#</LabelStockOrientation>
				<DocTabLocation>#attributes.ThermalLabelDocTabLocation#</DocTabLocation> 
				<DocTabContent>
					<Type>#attributes.ThermalLabelType#</Type>
				</DocTabContent>';
		}
	}
	else {
		ThermalLabelIndicator = '';
	}
		
	// Payor Type
	if ( attributes.RateRequestType eq "FDXE" ) {
		if ( attributes.PayorType eq "RECIPIENT" OR attributes.PayorType eq "THIRDPARTY" ) {
			PayorIndicator = '<Payor>
				<AccountNumber>#attributes.PayorAccountNumber#</AccountNumber>
				<CountryCode>#attributes.PayorCountryCode#</CountryCode>
			</Payor>';
		}
		else {
			PayorIndicator = '';
		}
	}
	else {
		if ( attributes.PayorType eq "THIRDPARTY" ) {
			PayorIndicator = '<Payor>
				<AccountNumber>#attributes.PayorAccountNumber#</AccountNumber>
				<CountryCode>#attributes.PayorCountryCode#</CountryCode>
			</Payor>';
		}
		else {
			PayorIndicator = '';
		}
	}
	
	// Payment via credit card
	if ( attributes.PayorType eq "CREDITCARD" ) {
		CreditCardIndicator = '<CreditCard>
			<Number>#attributes.CreditCardNumber#</Number>
			<Type>#attributes.CreditCardType#</Type>
			<ExpirationDate>#attributes.CreditCardExpiration#</ExpirationDate>
		</CreditCard>';
	}
	else {
		CreditCardIndicator = '';
	}
	
	// Return Shipment
	/*
	if ( attributes.RateRequestType eq "FDXG" AND (attributes.ReturnShipment eq "NETRETURNORONLINELABEL" OR attributes.ReturnShipment eq "RETURNMANAGER") ) {
		ReturnShipmentIndicator = '<ReturnShipmentIndicator>#attributes.ReturnShipment#</ReturnShipmentIndicator>';
	}
	else {
		ReturnShipmentIndicator = '';
	}
	*/
	ReturnShipmentIndicator = '';
	if ( attributes.ReturnShipment eq "PRINTRETURNLABEL" ) {
		ReturnShipmentIndicator = '<ReturnShipmentIndicator>#attributes.ReturnShipment#</ReturnShipmentIndicator>';
	}
	
	//Dimensions
	if ( Len(attributes.PackageLength) neq 0 AND Len(attributes.PackageWidth) neq 0 AND Len(attributes.PackageHeight) neq 0 ) {
		DimensionsIndicator = '<Dimensions>
		<Length>#attributes.PackageLength#</Length>
		<Width>#attributes.PackageWidth#</Width>
		<Height>#attributes.PackageHeight#</Height>
		<Units>#attributes.PackageUnitOfMeasurement#</Units>
	</Dimensions>';
	}
	else {
		DimensionsIndicator = '';
	}
	
	// Origin Address elements
	if ( Len(attributes.ShipperDept) neq 0 ) { ShipperDeptIndicator = '<Department>#attributes.ShipperDept#</Department>'; }
	else { ShipperDeptIndicator = ''; }
	if ( Len(attributes.ShipperPager) neq 0 ) { ShipperPagerIndicator = '<PagerNumber>#attributes.ShipperPager#</PagerNumber>'; }
	else { ShipperPagerIndicator = ''; }
	if ( Len(attributes.ShipperFax) neq 0 ) { ShipperFaxIndicator = '<FaxNumber>#attributes.ShipperFax#</FaxNumber>'; }
	else { ShipperFaxIndicator = ''; }
	if ( Len(attributes.ShipperEmail) neq 0 ) { ShipperEmailIndicator = '<E-MailAddress>#attributes.ShipperEmail#</E-MailAddress>'; }
	else { ShipperEmailIndicator = ''; }
	if ( Len(attributes.ShipperStreet2) neq 0 ) { ShipperStreet2Indicator = '<Line2>#attributes.ShipperStreet2#</Line2>'; }
	else { ShipperStreet2Indicator = ''; }
	
	// Destination Address elements
	if ( Len(attributes.ShipToDept) neq 0 ) { ShipToDeptIndicator = '<Department>#Left(attributes.ShipToDept, 10)#</Department>'; }
	else { ShipToDeptIndicator = ''; }
	if ( Len(attributes.ShipToPager) neq 0 ) { ShipToPagerIndicator = '<PagerNumber>#attributes.ShipToPager#</PagerNumber>'; }
	else { ShipToPagerIndicator = ''; }
	if ( Len(attributes.ShipToFax) neq 0 ) { ShipToFaxIndicator = '<FaxNumber>#attributes.ShipToFax#</FaxNumber>'; }
	else { ShipToFaxIndicator = ''; }
	if ( Len(attributes.ShipToEmail) neq 0 ) { ShipToEmailIndicator = '<E-MailAddress>#attributes.ShipToEmail#</E-MailAddress>'; }
	else { ShipToEmailIndicator = ''; }
	if ( Len(attributes.ShipToStreet2) neq 0 ) { ShipToStreet2Indicator = '<Line2>#attributes.ShipToStreet2#</Line2>'; }
	else { ShipToStreet2Indicator = ''; }
	
	// Declared value element
	if ( Len(attributes.DeclaredValue) gte 2 AND  Len(attributes.DeclaredValue) eq 3 ) 
	{ 
		DeclaredValueIndicator = '<DeclaredValue>#trim(NumberFormat(attributes.DeclaredValue,"99999.99"))#</DeclaredValue>';
	}
	else { DeclaredValueIndicator = ''; }
	
	//Ground request elements that must not be present if empty
	// referencecustomernote="Ground Test Label"
	// referenceponumber="PO12345"
	// referenceinvoicenumber="INV12345"
	
	// Customer Reference Element
	if ( IsDefined("attributes.ReferenceCustomerNote") AND Len(attributes.ReferenceCustomerNote) gte 1 ) {
		ReferenceCustomerNoteIndicator = '<CustomerReference>#attributes.ReferenceCustomerNote#</CustomerReference>';
	}
	else {
		ReferenceCustomerNoteIndicator = '';
	}
	
	// PO Number Element
	if ( IsDefined("attributes.ReferencePONumber") AND Len(attributes.ReferencePONumber) gte 1 ) {
		ReferencePONumberIndicator = '<PONumber>#attributes.ReferencePONumber#</PONumber>';
	}
	else {
		ReferencePONumberIndicator = '';
	}
	
	// Invoice Number Element
	if ( IsDefined("attributes.ReferenceInvoiceNumber") AND Len(attributes.ReferenceInvoiceNumber) gte 1 ) {
		ReferenceInvoiceNumberIndicator = '<InvoiceNumber>#attributes.ReferenceInvoiceNumber#</InvoiceNumber>';
	}
	else {
		ReferenceInvoiceNumberIndicator = '';
	}
	
	// Assemble ReferenceInfo element and children
	if ( Len(ReferenceCustomerNoteIndicator) gt 0 OR Len(ReferencePONumberIndicator) gt 0 OR Len(ReferenceInvoiceNumberIndicator) gt 0 ) {
		ReferenceElementIdcicator = '<ReferenceInfo>
		#ReferenceCustomerNoteIndicator#
		#ReferencePONumberIndicator#
		#ReferenceInvoiceNumberIndicator#
	</ReferenceInfo>';
	}
	else {
		ReferenceElementIdcicator = '';
	}
	
	/* Multi-piece element --- Positioned below Label element ---
	<MultiPiece>
		<PackageCount></PackageCount>
		<PackageSequenceNumber></PackageSequenceNumber>
		<ShipmentWeight></ShipmentWeight>
		<MasterTrackingNumber></MasterTrackingNumber>
		<MasterFormID></MasterFormID>
	</MultiPiece>
	
	attributes.MultiPiece
	attributes.PackageCount
	attributes.PackageSequenceNumber
	attributes.ShipmentWeight
	attributes.MasterTrackingNumber
	attributes.MasterFormID
	
	*/
	
	multipieceIndicator = '';
	
	// Master package of multi-piece shipment
	if ( attributes.MultiPiece eq 1 AND attributes.PackageCount gt 1
			AND attributes.PackageSequenceNumber eq 1)
	{
		multipieceIndicator = '<MultiPiece>
			<PackageCount>#attributes.PackageCount#</PackageCount>
			<PackageSequenceNumber>1</PackageSequenceNumber>
			<ShipmentWeight>#trim(NumberFormat(attributes.ShipmentWeight,"99999.9"))#</ShipmentWeight>
		</MultiPiece>';
	}
	
	// additional package of multi-piece shipment - FDXE
	else if ( attributes.MultiPiece eq 1 AND attributes.RateRequestType eq "FDXE" AND attributes.PackageCount gt 1
			AND attributes.PackageSequenceNumber gt 1)
	{
		multipieceIndicator = '<MultiPiece>
			<PackageCount>#attributes.PackageCount#</PackageCount>
			<PackageSequenceNumber>#attributes.PackageSequenceNumber#</PackageSequenceNumber>
			<MasterTrackingNumber>#attributes.MasterTrackingNumber#</MasterTrackingNumber>
			<MasterFormID>#attributes.MasterFormID#</MasterFormID>
		</MultiPiece>';
	}
	
	// additional package of multi-piece shipment - FDXG
	else if ( attributes.MultiPiece eq 1 AND attributes.RateRequestType eq "FDXG" AND attributes.PackageCount gt 1
			AND attributes.PackageSequenceNumber gt 1)
	{
		multipieceIndicator = '<MultiPiece>
			<PackageCount>#attributes.PackageCount#</PackageCount>
			<PackageSequenceNumber>#attributes.PackageSequenceNumber#</PackageSequenceNumber>
			<MasterTrackingNumber>#attributes.MasterTrackingNumber#</MasterTrackingNumber>
		</MultiPiece>';
	}
	
	attributes.XMLRequestInput = '<?xml version="1.0" encoding="UTF-8"?>
	<FDXShipRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXShipRequest.xsd">
	<RequestHeader>
		<CustomerTransactionIdentifier>US Ship</CustomerTransactionIdentifier>
		<MeterNumber>#attributes.FedexIndentifier#</MeterNumber>
		<AccountNumber>#attributes.AccountNumber#</AccountNumber>
		<CarrierCode>#attributes.RateRequestType#</CarrierCode>
	</RequestHeader>		
	<RequestType>SHIP</RequestType>
	<ShipDate>#attributes.DateShipped#</ShipDate>
	<ShipTime>#attributes.TimeShipped#</ShipTime>
	<DropoffType>#attributes.DropOffType#</DropoffType>
	<Service>#attributes.ServiceLevel#</Service>
	<Packaging>#attributes.PackageType#</Packaging>
	<WeightUnits>#attributes.PackageWeightUnit#</WeightUnits>
	<Weight>#trim(NumberFormat(attributes.PackageWeight,"99999.9"))#</Weight>
	<CurrencyCode>#attributes.CurrencyCode#</CurrencyCode>
	<ListRate>#attributes.RequestListRates#</ListRate>
	#ReturnShipmentIndicator#
	<Origin>
		<Contact>
			<PersonName>#attributes.ShipperContactName#</PersonName>
			<CompanyName>#attributes.ShipperCompany#</CompanyName>
			#ShipperDeptIndicator#
			<PhoneNumber>#attributes.ShipperPhone#</PhoneNumber>
			#ShipperPagerIndicator#
			#ShipperFaxIndicator#
			#ShipperEmailIndicator#
		</Contact>
		<Address>
			<Line1>#attributes.ShipperStreet#</Line1>
			#ShipperStreet2Indicator#
			<City>#attributes.ShipperCity#</City>
			<StateOrProvinceCode>#attributes.ShipperState#</StateOrProvinceCode>
			<PostalCode>#attributes.ShipperZip#</PostalCode>
			<CountryCode>#attributes.ShipperCountry#</CountryCode>
		</Address>
	</Origin>
	<Destination>
		<Contact>
			<PersonName>#attributes.ShipToContactName#</PersonName>
			<CompanyName>#attributes.ShipToCompany#</CompanyName>
			#ShipToDeptIndicator#
			<PhoneNumber>#attributes.ShipToPhone#</PhoneNumber>
			#ShipToPagerIndicator#
			#ShipToFaxIndicator#
			#ShipToEmailIndicator#
		</Contact>
		<Address>
			<Line1>#attributes.ShipToStreet#</Line1>
			#ShipToStreet2Indicator#
			<City>#attributes.ShipToCity#</City>
			<StateOrProvinceCode>#attributes.ShipToState#</StateOrProvinceCode>
			<PostalCode>#attributes.ShipToZip#</PostalCode>
			<CountryCode>#attributes.ShipToCountry#</CountryCode>
		</Address>
	</Destination>
	<Payment>
		<PayorType>#attributes.PayorType#</PayorType>
		#PayorIndicator#
		#CreditCardIndicator#
	</Payment>
	#ReferenceElementIdcicator#
	#DimensionsIndicator#
	#DeclaredValueIndicator#
	#SSIndicator#
	#HomeDelivIndicator#
	<Label>
		<Type>#attributes.LabelType#</Type>
		<ImageType>#attributes.LabelImageType#</ImageType>
		#ThermalLabelIndicator#
	</Label>
	#multipieceIndicator#
	#IntlIndicator#
	</FDXShipRequest>';
	</cfscript>
  <cfhttp method="post" url="#attributes.FedexServer#" resolveurl="yes" port="443" timeout="#attributes.TimeOut#">
    <cfhttpparam name="XML" type="xml" value="#attributes.XMLRequestInput#">
  </cfhttp>
  <cfif IsDefined("cfhttp.FileContent") AND Len(cfhttp.FileContent) gt 0>
    <!--- Error check open to see if a valid content was received by cfhttp --->
    <!--- [IF-Debug Mode] --->
    <cfif attributes.Debug eq "True">
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#shiprequest.xml" output="#attributes.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#shipresponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
      <cftry>
        <cfset caller.stFedexShipResponse = xmlParse(Trim(cfhttp.FileContent))>
        <cfdump var="#caller.stFedexShipResponse#">
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Hard Error: Custom Tag did not receive a valid response from Fedex, attempting to parse it threw an exception [Debug Stage]">
        </cfcatch>
      </cftry>
      <cfelse>
      <!--- Process live response --->
      <cftry>
        <cfset caller.stFedexShipResponse = xmlParse(Trim(cfhttp.FileContent))>
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Hard Error: Custom Tag did not receive a valid response from Fedex, attempting to parse it threw an exception [Debug Stage]">
        </cfcatch>
      </cftry>
      <cfif isDefined("caller.stFedexShipResponse") AND StructKeyExists(caller.stFedexShipResponse, "FDXShipReply")>
        <!--- Label Creation open --->
        <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply, "Labels")>
          <!--- Create label image --->
          <cfset caller.TrackingNumber = #caller.stFedexShipResponse.FDXShipReply.Tracking.TrackingNumber.XmlText#>
          <cfset base64Label = toBinary("#caller.stFedexShipResponse.FDXShipReply.Labels.OutboundLabel.XmlText#")>
          <cfset imageTypesBrowser = 'PDF,PNG4X6,PNG'>
		  <cfset imageTypesThermal = 'ELTRON,ZEBRA,UNIMARK'>
		  <cfif listFind(imageTypesBrowser, attributes.LabelImageType) gte 1>
            <cfswitch expression="#attributes.LabelImageType#">
				<cfcase value="PDF"><cfset fileExtension = 'pdf'></cfcase>
				<cfcase value="PNG4X6;PNG" delimiters=";"><cfset fileExtension = 'png'></cfcase>
				<cfdefaultcase><cfset fileExtension = 'pdf'></cfdefaultcase>
			</cfswitch>
			<cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Labels#trailingSlash##caller.TrackingNumber#.#fileExtension#" output="#base64Label#" addnewline="No" nameconflict="overwrite">
            <!--- Create html page to display label image for printing --->
            <cfset caller.LabelPageName = caller.TrackingNumber & ".html">
          <cfelseif listFind(imageTypesThermal, attributes.LabelImageType) gte 1>
            <cfswitch expression="#attributes.LabelImageType#">
				<cfcase value="ELTRON"><cfset fileExtension = 'epl'></cfcase>
				<cfcase value="ZEBRA"><cfset fileExtension = 'zpl'></cfcase>
				<cfcase value="UNIMARK"><cfset fileExtension = 'uni'></cfcase>
				<cfdefaultcase><cfset fileExtension = 'epl'></cfdefaultcase>
			</cfswitch>
			<cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Labels#trailingSlash##caller.TrackingNumber#.#fileExtension#" output="#base64Label#" addnewline="No" nameconflict="overwrite">
          </cfif>
        </cfif>
        <!--- Label Creation close --->
        <!--- Create rate query to store all rate related data for this shipment --->
        <cfif IsDefined("caller.stFedexShipResponse.FDXShipReply.Error.Code.XmlText")>
          <!--- There was an error get default shipping rate for this service level --->
          <cfset caller.FedexError = "1">
          <cfset caller.FedexErrorDesc = "#caller.stFedexShipResponse.FDXShipReply.Error.Message.XmlText#">
          <cfelse>
          <!--- 
					** Need to account for different elements returned based on Express, Ground request **
					FDXE
					FDXG
					ALL
					 --->
          <cfset caller.FedexError = "0">
          <cfset caller.FedexErrorDesc = "Success">
          <cfset caller.qFedexRateQuery = QueryNew("DimWeightUsed, Oversize, RateScale, RateZone, CurrencyCode, BilledWeight, DimWeight, 
					DiscBaseFreightCharges, DiscDiscountAmt, DiscNetTotalCharge, DiscBaseTotalCharges, DiscTotalRebate, DiscSurchargeCOD, DiscSurchargeSatPickup, DiscSurchargeDV, DiscSurchargeAOD, DiscSurchargeAD, DiscSurchargeAutoPOD,
						DiscSurchargeHomeDelivery, DiscSurchargeHomeDeliveryDC, DiscSurchargeHomeDeliveryEvening, DiscSurchargeHomeDeliverySig,
						DiscSurchargeNonStd, DiscSurchargeHazMat, DiscSurchargeRes, DiscSurchargeVAT, DiscSurchargeHST, DiscSurchargeGST, DiscSurchargePST,
						DiscSurchargeSatDeliv, DiscSurchargeDG, DiscSurchargeOutOfPickupArea, DiscSurchargeOutOfDeliveryArea, DiscSurchargeInsidePickup, DiscSurchargeInsideDeliv,
						DiscSurchargePryAlert, DiscSurchargeDelivArea, DiscSurchargeFuel, DiscSurchargeFICE, DiscSurchargeOffshore, DiscSurchargeOther, DiscSurchargeTotal, 
					ListBaseFreightCharges, ListDiscountAmt, ListNetTotalCharge, ListTotalRebate, ListSurchargeCOD, ListSurchargeSatPickup, ListSurchargeDV, ListSurchargeAOD, ListSurchargeAD, ListSurchargeAutoPOD,
						ListSurchargeHomeDelivery, ListSurchargeHomeDeliveryDC, ListSurchargeHomeDeliveryEvening, ListSurchargeHomeDeliverySig,
						ListSurchargeNonStd, ListSurchargeHazMat, ListSurchargeRes, ListSurchargeVAT, ListSurchargeHST, ListSurchargeGST, ListSurchargePST,
						ListSurchargeSatDeliv, ListSurchargeDG, ListSurchargeOutOfPickupArea, ListSurchargeOutOfDeliveryArea, ListSurchargeInsidePickup, ListSurchargeInsideDeliv,
						ListSurchargePryAlert, ListSurchargeDelivArea, ListSurchargeFuel, ListSurchargeFICE, ListSurchargeOffshore, ListSurchargeOther, ListSurchargeTotal,
						VariableHandling, ListVariableHandlingCharge, TotalCustomerCharge, ListTotalCustomerCharge, MultiweightVariableHandlingCharge, MultiweightTotalCustomerCharge")>
          <cfset newRow  = QueryAddRow(caller.qFedexRateQuery, 1)>
          <!--- ** Inner CP1 ** Check for existence of estimated charges element --->
          <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply, "EstimatedCharges")>
            <!--- FDXE Only --->
            <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges, "DimWeightUsed")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DimWeightUsed", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DimWeightUsed.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DimWeightUsed", "", 1)>
            </cfif>
            <!--- FDXG Only --->
            <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges, "Oversize")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "Oversize", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.Oversize.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "Oversize", "", 1)>
            </cfif>
            <!--- FDXE Only --->
            <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges, "RateScale")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "RateScale", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.RateScale.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "RateScale", "", 1)>
            </cfif>
            <!--- FDXE Only --->
            <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges, "RateZone")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "RateZone", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.RateZone.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "RateZone", "", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges, "CurrencyCode")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "CurrencyCode", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.CurrencyCode.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "CurrencyCode", "", 1)>
            </cfif>
            <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges, "BilledWeight")>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "BilledWeight", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.BilledWeight.XmlText, 1)>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "BilledWeight", "", 1)>
            </cfif>
            <!--- Discount Charges element - present in both FDXE and FDXG requests, for FDXG request this is only node returned --->
            <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges, "DiscountedCharges")>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "BaseCharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscBaseFreightCharges", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.BaseCharge.XmlText, 1)>
                <cfset nBaseCharge = caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.BaseCharge.XmlText>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscBaseFreightCharges", "0", 1)>
                <cfset nBaseCharge = 0>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "TotalDiscount")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscDiscountAmt", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.TotalDiscount.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscDiscountAmt", "0", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "NetCharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscNetTotalCharge", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.NetCharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscNetTotalCharge", "0", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "TotalRebate")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscTotalRebate", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.TotalRebate.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscTotalRebate", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "TotalSurcharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeTotal", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText, 1)>
                <cfset nBaseSurCharge = caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeTotal", "0", 1)>
                <cfset nBaseSurCharge = 0>
              </cfif>
              <cfset nTotalCharge = nBaseCharge + nBaseSurCharge>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscBaseTotalCharges", nTotalCharge, 1)>
              <!--- Anyone for a surcharge or 10 or 100!! --->
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "Surcharges")>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "COD")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeCOD", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.COD.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeCOD", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "SaturdayPickup")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeSatPickup", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.SaturdayPickup.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeSatPickup", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "DeclaredValue")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDV", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.DeclaredValue.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDV", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "AOD")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAOD", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.AOD.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAOD", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "AppointmentDelivery")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAD", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.AppointmentDelivery.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAD", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "AutoPOD")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAutoPOD", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.AutoPOD.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAutoPOD", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDelivery")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDelivery", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDelivery.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDelivery", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliveryDateCertain")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliveryDateCertain.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliveryEveningDelivery")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliveryEveningDelivery.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliverySignature")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliverySignature.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "NonStandardContainer")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeNonStd", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.NonStandardContainer.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeNonStd", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HazardousMaterials")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHazMat", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HazardousMaterials.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHazMat", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "Residential")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeRes", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.Residential.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeRes", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "VAT")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeVAT", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.VAT.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeVAT", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HSTSurcharge")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHST", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HSTSurcharge.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHST", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "GSTSurcharge")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeGST", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.GSTSurcharge.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeGST", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "PSTSurcharge")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargePST", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.PSTSurcharge.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargePST", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "SaturdayDelivery")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeSatDeliv", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.SaturdayDelivery.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeSatDeliv", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "DangerousGoods")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDG", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.DangerousGoods.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDG", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "OutOfPickupOrh2Area")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.OutOfPickupOrh2Area.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "OutOfDeliveryOrh2Area")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.OutOfDeliveryOrh2Area.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "InsidePickup")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsidePickup", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.InsidePickup.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsidePickup", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "InsideDelivery")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsideDeliv", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.InsideDelivery.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsideDeliv", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "PriorityAlert")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargePryAlert", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.PriorityAlert.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargePryAlert", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "DeliveryArea")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDelivArea", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.DeliveryArea.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDelivArea", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "Fuel")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFuel", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.Fuel.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFuel", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "FICE")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFICE", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.FICE.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFICE", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "Offshore")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOffshore", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.Offshore.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOffshore", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "Other")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOther", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.Other.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOther", "", 1)>
                </cfif>
              </cfif>
              <!--- Anyone for a surcharge or 10 or 100!! CLOSE --->
              <cfelse>
              <!--- Discount charges element unavailable - this should not be possible as this is primary charges node --->
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscBaseFreightCharges", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscDiscountAmt", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscNetTotalCharge", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscTotalRebate", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeCOD", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeSatPickup", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDV", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAOD", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAD", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeAutoPOD", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDelivery", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeNonStd", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHazMat", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeRes", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeVAT", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeHST", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeGST", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargePST", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDG", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsidePickup", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeInsideDeliv", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeDelivArea", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFuel", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeFICE", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeOffshore", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "DiscSurchargeTotal", "", 1)>
            </cfif>
            <!--- Discount Charges element - CLOSE --->
            <!--- List Charges element --->
            <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges, "ListCharges")>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "BaseCharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListBaseFreightCharges", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.BaseCharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListBaseFreightCharges", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "TotalDiscount")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListDiscountAmt", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.TotalDiscount.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListDiscountAmt", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "NetCharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListNetTotalCharge", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.NetCharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListNetTotalCharge", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "TotalRebate")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalRebate", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.TotalRebate.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalRebate", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "TotalSurcharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeTotal", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.TotalSurcharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeTotal", "", 1)>
              </cfif>
              <!--- Anyone for a surcharge or 10 or 100!! --->
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "Surcharges")>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "COD")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeCOD", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.COD.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeCOD", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "SaturdayPickup")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeSatPickup", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.SaturdayPickup.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeSatPickup", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "DeclaredValue")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDV", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.DeclaredValue.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDV", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "AOD")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAOD", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.AOD.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAOD", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "AppointmentDelivery")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAD", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.AppointmentDelivery.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAD", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "AutoPOD")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAutoPOD", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.AutoPOD.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAutoPOD", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HomeDelivery")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDelivery", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HomeDelivery.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDelivery", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliveryDateCertain")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliveryDateCertain.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliveryEveningDelivery")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliveryEveningDelivery.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliverySignature")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliverySig", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliverySignature.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliverySig", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "NonStandardContainer")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeNonStd", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.NonStandardContainer.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeNonStd", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HazardousMaterials")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHazMat", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HazardousMaterials.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHazMat", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "Residential")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeRes", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.Residential.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeRes", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "VAT")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeVAT", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.VAT.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeVAT", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HSTSurcharge")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHST", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HSTSurcharge.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHST", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "GSTSurcharge")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeGST", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.GSTSurcharge.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeGST", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "PSTSurcharge")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargePST", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.PSTSurcharge.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargePST", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "SaturdayDelivery")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeSatDeliv", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.SaturdayDelivery.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeSatDeliv", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "DangerousGoods")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDG", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.DangerousGoods.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDG", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "OutOfPickupOrh2Area")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfPickupArea", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.OutOfPickupOrh2Area.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfPickupArea", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "OutOfDeliveryOrh2Area")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.OutOfDeliveryOrh2Area.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "InsidePickup")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsidePickup", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.InsidePickup.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsidePickup", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "InsideDelivery")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsideDeliv", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.InsideDelivery.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsideDeliv", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "PriorityAlert")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargePryAlert", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.PriorityAlert.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargePryAlert", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "DeliveryArea")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDelivArea", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.DeliveryArea.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDelivArea", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "Fuel")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFuel", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.Fuel.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFuel", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "FICE")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFICE", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.FICE.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFICE", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "Offshore")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOffshore", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.Offshore.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOffshore", "", 1)>
                </cfif>
                <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "Other")>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOther", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.Other.XmlText, 1)>
                  <cfelse>
                  <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOther", "", 1)>
                </cfif>
              </cfif>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListBaseFreightCharges", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListDiscountAmt", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListNetTotalCharge", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalRebate", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeCOD", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeSatPickup", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDV", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAOD", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAD", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeAutoPOD", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDelivery", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHomeDeliverySig", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeNonStd", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHazMat", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeRes", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeVAT", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeHST", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeGST", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargePST", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDG", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfPickupArea", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsidePickup", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeInsideDeliv", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeDelivArea", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFuel", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeFICE", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeOffshore", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListSurchargeTotal", "", 1)>
            </cfif>
            <!--- List Charges element - CLOSE --->
            <!--- Variable Handling Elements --->
            <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges, "VariableHandling")>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "VariableHandlingCharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "VariableHandling", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.VariableHandlingCharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "VariableHandling", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "ListVariableHandlingCharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListVariableHandlingCharge", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.ListVariableHandlingCharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListVariableHandlingCharge", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "TotalCustomerCharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "TotalCustomerCharge", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.TotalCustomerCharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "TotalCustomerCharge", "", 1)>
              </cfif>
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "ListTotalCustomerCharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalCustomerCharge", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.ListTotalCustomerCharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalCustomerCharge", "", 1)>
              </cfif>
              <!--- FDXG Only --->
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "MultiweightVariableHandlingCharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightVariableHandlingCharge", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.MultiweightVariableHandlingCharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightVariableHandlingCharge", "", 1)>
              </cfif>
              <!--- FDXG Only --->
              <cfif StructKeyExists(caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "MultiweightTotalCustomerCharge")>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightTotalCustomerCharge", caller.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.MultiweightTotalCustomerCharge.XmlText, 1)>
                <cfelse>
                <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightTotalCustomerCharge", "", 1)>
              </cfif>
              <cfelse>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "VariableHandling", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListVariableHandlingCharge", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "TotalCustomerCharge", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "ListTotalCustomerCharge", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightVariableHandlingCharge", "", 1)>
              <cfset temp = QuerySetCell(caller.qFedexRateQuery, "MultiweightTotalCustomerCharge", "", 1)>
            </cfif>
            <!--- Variable Handling Elements CLOSE --->
            <cfelse>
            <!--- ** Inner CP1 ** Check for existence of estimated charges element not successful --->
            <!--- Charge not retrieved for some reason set empty columns --->
            <cfset caller.FedexError = "2">
            <cfset caller.FedexErrorDesc = "Fedex returned a valid response without a base rate">
          </cfif>
          <!--- ** Inner CP1 ** Check for existence of estimated charges element close --->
        </cfif>
        <!--- Create rate query to store all rate related data for this shipment close --->
        <cfelse>
        <!--- Hard error, FDXSHIPREPLY not present --->
        <cfset caller.FedexError = "2">
        <cfset caller.FedexErrorDesc = "HARD ERROR: non valid XML response received from Fedex, check your request is valid">
      </cfif>
    </cfif>
    <!--- [END-IF-Debug Mode] --->
    <cfelse>
    <!--- Error check to see if a valid content was received by cfhttp --->
    <cfset caller.FedexError = "2">
    <cfset caller.FedexErrorDesc = "Hard Error: Custom Tag did not receive a valid response from Fedex, please check your network connections">
  </cfif>
  <!--- Error check close to see if a valid content was received by cfhttp --->
  </cfcase>
  <!--- Ship Request close  --->
  <!--- ***** 2.0 ****** --->
  <!--- Ship Delete Request  --->
  <cfcase value="ShipDeleteRequest">
  <cfscript>
		attributes.XMLRequestInput = '<?xml version="1.0" encoding="UTF-8"?>
		<FDXShipDeleteRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXShipDeleteRequest.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>#attributes.DeleteShipmentTransactionString#</CustomerTransactionIdentifier>
			<AccountNumber>#attributes.AccountNumber#</AccountNumber>
			<MeterNumber>#attributes.FedexIndentifier#</MeterNumber>
			<CarrierCode>#attributes.RateRequestType#</CarrierCode>
		</RequestHeader>
		<TrackingNumber>#attributes.TrackingNumber#</TrackingNumber>
		</FDXShipDeleteRequest>';
	</cfscript>
  <cfhttp method="post" url="#attributes.FedexServer#" resolveurl="yes" port="443" timeout="#attributes.TimeOut#">
    <cfhttpparam name="XML" type="xml" value="#attributes.XMLRequestInput#">
  </cfhttp>
  <cfif IsDefined("cfhttp.FileContent") AND Len(cfhttp.FileContent) gt 0>
    <!--- Error check open to see if a valid content was received by cfhttp --->
    <!--- Debug Mode --->
    <cfif attributes.Debug eq "True">
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#ShipDeleteRequest.xml" output="#attributes.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#ShipDeleteResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
      <cfset caller.stFdxShipDeleteResponse = XmlParse(Trim(cfhttp.FileContent))>
      <cfoutput>
        <cfdump var="#caller.stFdxShipDeleteResponse#">
      </cfoutput>
      <cfabort>
    </cfif>
    <!--- Debug Mode --->
    <!--- Process live response --->
    <cfset caller.stFdxShipDeleteResponse = XmlParse(Trim(cfhttp.FileContent))>
    <cfif StructKeyExists(caller.stFdxShipDeleteResponse.FDXShipDeleteReply, "Error")>
      <cfif StructKeyExists(caller.stFdxShipDeleteResponse.FDXShipDeleteReply.Error, "Code")>
        <cfset caller.FedexError = caller.stFdxShipDeleteResponse.FDXShipDeleteReply.Error.Code.XmlText>
        <cfset caller.FedexErrorDesc = caller.stFdxShipDeleteResponse.FDXShipDeleteReply.Error.Message.XmlText>
        <cfelse>
        <cfset caller.FedexError = "2">
        <cfset caller.FedexErrorDesc = "Hard Error: Fedex Servers returned a Malformed XML document/Invalid response">
        <!--- Error: no customer transaction identifier present in replyHeader - Malformed XML document received from Fedex --->
      </cfif>
      <cfelseif StructKeyExists(caller.stFdxShipDeleteResponse.FDXShipDeleteReply, "ReplyHeader")>
      <cfif StructKeyExists(caller.stFdxShipDeleteResponse.FDXShipDeleteReply.ReplyHeader, "CustomerTransactionIdentifier")>
        <cfset caller.DeleteIdentifier = caller.stFdxShipDeleteResponse.FDXShipDeleteReply.ReplyHeader.CustomerTransactionIdentifier.XmlText>
        <cfif caller.DeleteIdentifier eq attributes.DeleteShipmentTransactionString>
          <cfset caller.FedexError = "0">
          <cfset caller.FedexErrorDesc = "Shipment was successfully deleted from Fedex Servers">
        </cfif>
        <cfelse>
        <cfset caller.FedexError = "2">
        <cfset caller.FedexErrorDesc = "Hard Error: Fedex Servers returned a Malformed XML document/Invalid response">
        <!--- Error: no customer transaction identifier present in replyHeader - Malformed XML document received from Fedex --->
      </cfif>
      <cfelse>
      <!--- Error - no valid element received --->
      <cfset caller.FedexError = "2">
      <cfset caller.FedexErrorDesc = "Hard Error: Fedex Servers returned a Malformed XML document/Invalid response">
    </cfif>
    <cfelse>
    <!--- Error check to see if a valid content was received by cfhttp --->
    <cfset caller.FedexError = "2">
    <cfset caller.FedexErrorDesc = "Hard Error: Custom Tag did not receive a valid response from Fedex, please check your network connections">
  </cfif>
  <!--- Error check close to see if a valid content was received by cfhttp --->
  </cfcase>
  <!--- Ship Delete Request Close  ---><!--- Ground Close Request Start  --->
  <cfcase value="GroundCloseRequest">
  <cfscript>
	if ( IsDefined("Report") ) {
	 strReportIndicator = '<ReportOnly>#attributes.Report#</ReportOnly>
	 <ReportIndicator>#UCase(attributes.ReportType)#</ReportIndicator>';
	}
	else { strReportIndicator = ''; }
	attributes.XMLRequestInput = '<?xml version="1.0" encoding="UTF-8" ?>
	<FDXCloseRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXCloseRequest.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>APT_GroundCloseRequest</CustomerTransactionIdentifier>
			<AccountNumber>#attributes.AccountNumber#</AccountNumber>
			<MeterNumber>#attributes.FedexIndentifier#</MeterNumber>
			<CarrierCode>#attributes.RateRequestType#</CarrierCode>
		</RequestHeader>
		<Date>#attributes.CloseDate#</Date>
		<Time>#attributes.CloseTime#</Time>
		#strReportIndicator#
	</FDXCloseRequest>';
	</cfscript>
  <cfhttp method="post" url="#attributes.FedexServer#" resolveurl="yes" port="443" timeout="#attributes.TimeOut#">
    <cfhttpparam name="XML" type="xml" value="#attributes.XMLRequestInput#">
  </cfhttp>
  <cfif IsDefined("cfhttp.FileContent") AND Len(cfhttp.FileContent) gt 0>
    <!--- Check to see if a valid content was received by cfhttp --->
    <cfset caller.stFedexGCResponse = XmlParse(Trim(cfhttp.FileContent))>
    <!--- Debug Mode --->
    <cfif attributes.Debug eq "True">
      <cfoutput>
        <cfdump var="#caller.stFedexGCResponse#">
      </cfoutput>
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#GCRequest.xml" output="#attributes.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#Debug#trailingSlash#GCResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
      <cfabort>
    </cfif>
    <!--- Debug Mode --->
    <cfif StructKeyExists(caller.stFedexGCResponse.FDXCloseReply, "Error")>
      <cfset caller.FedexError = 1>
      <cfif StructKeyExists(caller.stFedexGCResponse.FDXCloseReply.Error, "Message")>
        <cfset caller.FedexErrorDesc = caller.stFedexGCResponse.FDXCloseReply.Error.Message.XmlText>
        <cfelse>
        <cfset caller.FedexErrorDesc = "An error was received from Fedex Servers, no description was supplied">
      </cfif>
      <cfelseif StructKeyExists(caller.stFedexGCResponse.FDXCloseReply, "Manifest")>
      <cfif StructKeyExists(caller.stFedexGCResponse.FDXCloseReply.Manifest, "FileName")>
        <cfset caller.ReportName = caller.stFedexGCResponse.FDXCloseReply.Manifest.FileName.XmlText>
        <cfset caller.FedexError = 0>
        <cfset caller.FedexErrorDesc = "">
        <cfelse>
        <cfset caller.FedexError = 1>
        <cfset caller.FedexErrorDesc = "APT: Manifest File Name was not received as expected">
        <cfset caller.ReportName = "Undefined">
      </cfif>
      <cfif StructKeyExists(caller.stFedexGCResponse.FDXCloseReply.Manifest, "File")>
        <cfset binary = toBinary("#caller.stFedexGCResponse.FDXCloseReply.Manifest.File.XmlText#")>
        <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#GCReports#trailingSlash##attributes.strDateIdentifier#_Manifest.png" output="#binary#" addnewline="No" nameconflict="overwrite">
        <cfset caller.ReportImageName = #attributes.Manifest# & ".png">
        <cfset caller.FedexError = 0>
        <cfset caller.FedexErrorDesc = "">
        <cfelse>
        <cfset caller.FedexError = 1>
        <cfset caller.FedexErrorDesc = "Report image unavailable">
      </cfif>
      <cfelseif StructKeyExists(caller.stFedexGCResponse.FDXCloseReply, "MultiweightReport")>
      <cfset binary = toBinary("#caller.stFedexGCResponse.FDXCloseReply.MultiweightReport.XmlText#")>
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#GCReports#trailingSlash##attributes.strDateIdentifier#_MultiweightReport.png" output="#binary#" addnewline="No" nameconflict="overwrite">
      <cfset caller.ReportImageName = #attributes.MultiweightReport# & ".png">
      <cfset caller.FedexError = 0>
      <cfset caller.FedexErrorDesc = "">
      <cfelseif StructKeyExists(caller.stFedexGCResponse.FDXCloseReply, "HazMatCertificate")>
      <cfset binary = toBinary("#caller.stFedexGCResponse.FDXCloseReply.HazMatCertificate.XmlText#")>
      <cffile action="WRITE" file="#attributes.ServerFilePath##trailingSlash#GCReports#trailingSlash##attributes.strDateIdentifier#_HazMatCertificate.png" output="#binary#" addnewline="No" nameconflict="overwrite">
      <cfset caller.ReportImageName = #attributes.HazMatCertificate# & ".png">
      <cfset caller.FedexError = 0>
      <cfset caller.FedexErrorDesc = "">
      <cfelse>
      <cfset caller.FedexError = 1>
      <cfset caller.FedexErrorDesc = "Report image unavailable">
    </cfif>
    <cfelse>
    <!--- Error check to see if a valid content was received by cfhttp --->
    <cfset caller.FedexError = "2">
    <cfset caller.FedexErrorDesc = "Hard Error: Custom Tag did not receive a valid response from Fedex, please check your network connections">
  </cfif>
  <!--- Error check close to see if a valid content was received by cfhttp --->
  </cfcase>
  <!--- End Ground Close Request Online --->
  <!---  //////////////////////// Fedex Address Validation request open //////////////////////// --->
  <cfcase value="addressValidation">
  <cfscript>
	caller.nTickStage1 = GetTickCount();
	if ( attributes.AddressMatches gt 10 ) {
	 attributes.AddressMatches = 10;
	}
	else if ( attributes.AddressMatches lt 1 ) {
	 attributes.AddressMatches = 3;
	}
	attributes.XMLRequestInput = '<?xml version="#attributes.XMLVersion#" encoding="UTF-8"?>
	<FDXAddressVerificationRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXAddressVerificationRequest.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>Address Verification</CustomerTransactionIdentifier>
			<MeterNumber>#attributes.FedexIndentifier#</MeterNumber>
			<AccountNumber>#attributes.AccountNumber#</AccountNumber>
		</RequestHeader>
		<CompanyName>#left(attributes.ShipToCompany, 35)#</CompanyName>
		<Line1>#left(attributes.ShipToStreet, 35)#</Line1>
		<Line2>#left(attributes.ShipToStreet2, 35)#</Line2>
		<City>#left(attributes.ShipToCity, 35)#</City>
		<StateOrProvinceCode>#left(attributes.ShipToState, 2)#</StateOrProvinceCode>
		<PostalCode>#left(attributes.ShipToZip, 9)#</PostalCode>
		<Urbanization>#left(attributes.ShipToUrbanization, 35)#</Urbanization>
		<MaximumMatchCount>#attributes.AddressMatches#</MaximumMatchCount>
	</FDXAddressVerificationRequest>';
	</cfscript>
  <cfset caller.nTickStage2 = GetTickCount()>
  <cfhttp method="post" url="#attributes.FedexServer#" resolveurl="yes" port="443" timeout="#attributes.TimeOut#">
    <cfhttpparam name="XML" type="xml" value="#attributes.XMLRequestInput#">
  </cfhttp>
  <cfset caller.nTickStage3 = GetTickCount()>
  <cfif IsDefined("cfhttp.FileContent") AND Len(cfhttp.FileContent) gt 10>
    <!--- check if valid response returned --->
    <cfset caller.nTickStage4 = GetTickCount()>
    <cfif attributes.Debug eq "True">
      <cftry>
        <cfset caller.stFedexAddressValidation = XmlParse(Trim(cfhttp.FileContent))>
        <cfset caller.FedexError = "0">
        <cfset caller.FedexErrorDesc = "DEBUG: Debug request completed successfully">
        <cfdump var="#caller.stFedexAddressValidation#">
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex, XML could not be parsed (Address Validation Request)">
        </cfcatch>
      </cftry>
      <cffile action="WRITE" file="#attributes.ServerFilePath##request.bslash#Debug#request.bslash#AddressValidationRequest.xml" output="#attributes.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
      <cffile action="WRITE" file="#attributes.ServerFilePath##request.bslash#Debug#request.bslash#AddressValidationResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
      <cfelse>
      <!--- // [IF-Debug Mode] // --->
      <cftry>
        <cfset caller.stFedexAddressValidation = XmlParse(Trim(cfhttp.FileContent))>
        <cfcatch type="any">
          <cfset caller.FedexError = "2">
          <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex, XML could not be parsed (Address Validation Request)">
        </cfcatch>
      </cftry>
      <cfif isDefined("caller.stFedexAddressValidation")>
        <!--- // [IF-2 Check if XML Response could be parsed successfully] // --->
        <cfif IsDefined("caller.stFedexAddressValidation.FDXAddressVerificationReply.Error.Code.XmlText")>
          <cfset caller.FedexError = "1">
          <cfif isDefined("caller.stFedexAddressValidation.FDXAddressVerificationReply.Error.Message.XmlText")>
            <cfset caller.FedexErrorDesc = caller.stFedexAddressValidation.FDXAddressVerificationReply.Error.Message.XmlText>
            <cfelse>
            <cfset caller.FedexErrorDesc = "Soft Error: There was an error validating this address, no valid message was returned from Fedex Server in relation to the specific error.">
          </cfif>
          <cfelse>
          <cfset caller.nTickStage5 = GetTickCount()>
          <cfset caller.FedexError = "0">
          <cfset caller.FedexErrorDesc = "Success">
          <cfset variables.matchArray = XmlSearch(caller.stFedexAddressValidation, "/FDXAddressVerificationReply/Match")>
          <!--- <cfdump var="#variables.matchArray#" label="Package"> --->
          <!--- Successful response start processing all elements  --->
          <cfset caller.qAddressValidation = queryNew("Score, Rank, Company, Street1, Street2, City, State, Zipcode, Residential, Urbanization, SingleHouseNumber, SoftErrorType, SoftErrorCode, SoftErrorMessage")>
          <cfif IsDefined("variables.matchArray") AND IsArray(variables.matchArray) AND arrayLen(variables.matchArray) gte 1>
            <!--- /// Response is an array /// --->
            <cfset loopCount = ArrayLen(variables.matchArray)>
            <cfloop from="1" to="#loopCount#" index="i">
              <cfset newRow  = QueryAddRow(caller.qAddressValidation, 1)>
              <cfif StructKeyExists(variables.matchArray[i], "Score")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "Score", variables.matchArray[i].Score.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "Rank")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "Rank", variables.matchArray[i].Rank.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "CompanyName")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "Company", variables.matchArray[i].CompanyName.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "Line1")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "Street1", variables.matchArray[i].Line1.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "Line2")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "Street2", variables.matchArray[i].Line2.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "City")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "City", variables.matchArray[i].City.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "StateOrProvinceCode")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "State", variables.matchArray[i].StateOrProvinceCode.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "PostalCode")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "Zipcode", variables.matchArray[i].PostalCode.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "ResidentialDelivery")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "Residential", variables.matchArray[i].ResidentialDelivery.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "Urbanization")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "Urbanization", variables.matchArray[i].Urbanization.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "SingleHouseNumber")>
                <cfset temp = QuerySetCell(caller.qAddressValidation, "SingleHouseNumber", variables.matchArray[i].SingleHouseNumber.XmlText)>
              </cfif>
              <cfif StructKeyExists(variables.matchArray[i], "SoftError")>
                <cfif StructKeyExists(variables.matchArray[i].SoftError, "Type")>
                  <cfset temp = QuerySetCell(caller.qAddressValidation, "SoftErrorType", variables.matchArray[i].SoftError.Type.XmlText)>
                </cfif>
                <cfif StructKeyExists(variables.matchArray[i].SoftError, "Code")>
                  <cfset temp = QuerySetCell(caller.qAddressValidation, "SoftErrorCode", variables.matchArray[i].SoftError.Code.XmlText)>
                </cfif>
                <cfif StructKeyExists(variables.matchArray[i].SoftError, "Message")>
                  <cfset temp = QuerySetCell(caller.qAddressValidation, "SoftErrorMessage", variables.matchArray[i].SoftError.Message.XmlText)>
                </cfif>
              </cfif>
            </cfloop>
            <!--- <cfdump var="#caller.qAddressValidation#"> --->
            <cfelse>
            <cfset caller.FedexError = 2>
            <cfset caller.FedexErrorDesc = "HARD ERROR: Unexpected Response received from Fedex">
            <!--- expected package array was not received in the response --->
          </cfif>
          <cfset caller.nTickStage6 = GetTickCount()>
        </cfif>
        <cfelse>
        <!--- // [IF-2 Check if XML Response could be parsed successfully] // --->
      </cfif>
      <!--- // [END-IF-2 Check if XML Response could be parsed successfully] // --->
    </cfif>
    <!--- // [END-IF-Debug Mode] // --->
    <cfelse>
    <!--- Valid response not received --->
    <cfset caller.FedexError = "2">
    <cfset caller.FedexErrorDesc = "Hard Error: No valid response was received from Fedex (Address Validation Request)">
  </cfif>
  <!--- Valid response received check end --->
  <cfset caller.nTickStageEnd = GetTickCount()>
  </cfcase>
  <!---  //////////////////////// Fedex Address Validation request close //////////////////////// --->
</cfswitch>



















