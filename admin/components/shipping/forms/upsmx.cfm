 <!--- 
	date:			August 22, 2003
	purpose: 		
						Query UPS Shipping Rates & Services
						Using the new CFMX XML functionality.
						
						All UPS generated errors are returned in a structure called ERROR.
						Do not distribute this code. 
						
	required variables:
						AccessLicenseNumber
						UserId
						Password
						RequestAction
						PickupTypeCode
						ShipmentShipperAddressPostalCode
						ShipmentShipToAddressPostalCode
						ShipmentShipToAddressCountryCode
						PackagePackagingTypeCode
						PackageDescription
						PackageWeight
						Mode
						
	code example:
				<cf_upsmx
					AccessLicenseNumber="TEST"
					UserId="TEST"
					Password="TEST"
					RequestAction="Rate"
					RequestOption="Shop"
					PickupTypeCode="03"
					ShipmentShipperAddressPostalCode="97201"
					ShipmentShipToAddressPostalCode="10010"
					ShipmentShipToAddressCountryCode="US"
					PackagePackagingTypeCode="02"
					PackageDescription="My own packaging"
					PackageWeight="23"
					AdditionalHandling="2.55"					
					Mode="test"
					Variable="response">
--->

  	<cfparam name="attributes.AccessRequestLanguage" default="en-US">
	<cfparam name="attributes.AccessLicenseNumber" default="">
	<cfparam name="attributes.UserId" default="">
	<cfparam name="attributes.Password" default="">
	<cfparam name="attributes.RatingServiceSelectionRequestLanguage" default="en-US">
	<cfparam name="attributes.CustomerContext" default="Rates">
	<cfparam name="attributes.RequestAction" default="Rate">
	<cfparam name="attributes.RequestOption" default="shop">
	<cfparam name="attributes.XpciVersion" default="1.0001">
	<cfparam name="attributes.PickupTypeCode" default="03">	
	<cfparam name="attributes.ShipmentShipperAddressPostalCode" default="97292">
	<cfparam name="attributes.ShipmentShipToAddressPostalCode" default="10010">
	<cfparam name="attributes.ShipmentShipToAddressCountryCode" default="">
	<cfparam name="attributes.ShipmentServiceCode" default="03">	
	<cfparam name="attributes.PackagePackagingTypeCode" default="02">
	<cfparam name="attributes.PackagePackagingTypeDescription" default="">
	<cfparam name="attributes.PackageDescription" default="">
	<cfparam name="attributes.PackageWeight" default="10">	
	<cfparam name="attributes.NumberOfPackages" default="1">	
	<cfparam name="attributes.AdditionalHandling" default="0">	
	
	<cfparam name="attributes.Mode" default="Live">
	<cfparam name="attributes.variable" default="response">

	<cfoutput>
	<cfsavecontent variable="xml">
	<?xml version="1.0"?>
		<AccessRequest xml:lang="#attributes.AccessRequestLanguage#"> 
			<AccessLicenseNumber>#attributes.AccessLicenseNumber#</AccessLicenseNumber> 
			<UserId>#attributes.UserId#</UserId> 
			<Password>#attributes.Password#</Password> 
		</AccessRequest>
		<?xml version="1.0"?>
		<RatingServiceSelectionRequest xml:lang="#attributes.RatingServiceSelectionRequestLanguage#"> 
			<Request> 
				<TransactionReference> 
					<CustomerContext>#attributes.CustomerContext#</CustomerContext> 
					<XpciVersion>#attributes.XpciVersion#</XpciVersion> 
				</TransactionReference> 
				<RequestAction>#attributes.RequestAction#</RequestAction> 
				<RequestOption>#attributes.RequestOption#</RequestOption> 
			</Request> 
			<PickupType> 
				<Code>#attributes.PickupTypeCode#</Code> 
			</PickupType> 
			<Shipment> 
				<Shipper> 
					<Address> 
						<PostalCode>#attributes.ShipmentShipperAddressPostalCode#</PostalCode> 
					</Address> 
				</Shipper> 
				<ShipTo> 
					<Address> 
						<PostalCode>#attributes.ShipmentShipToAddressPostalCode#</PostalCode> 
						<CountryCode>#attributes.ShipmentShipToAddressCountryCode#</CountryCode> 
					</Address> 
				</ShipTo> 
				<Service> 
					<Code>#attributes.ShipmentServiceCode#</Code> 
				</Service> 
				<cfloop from="1" to="#attributes.NumberOfPackages#" index="i">
				<Package> 
					<PackagingType> 
						<Code>#attributes.PackagePackagingTypeCode#</Code> 
						<Description>Package (#i#) #attributes.PackagePackagingTypeDescription#</Description> 
					</PackagingType>
					<Description>#attributes.PackageDescription#</Description> 
					<PackageWeight> 
						<Weight>#attributes.PackageWeight#</Weight> 
					</PackageWeight> 
				</Package>
				</cfloop>
			</Shipment> 
		</RatingServiceSelectionRequest>
	 </cfsavecontent> 
 	</cfoutput>
    
	<cfscript>
		if(attributes.mode eq 'live') {
			// live server
			upsAppServer='https://onlinetools.ups.com/ups.app/xml/Rate';
		} else {
			// testing server
			upsAppServer='https://wwwcie.ups.com/ups.app/xml/Rate';
		}
	</cfscript>

	<!--- post XML to UPS listener, wait for response --->
	<cfhttp url="#upsAppServer#" method="post" port="443">
		<cfhttpparam type="xml" value="#xml#">
	</cfhttp>

	<cfscript>
		// parse servers response into an XML doc
		response=xmlParse(cfhttp.fileContent);
	
		// check for errors returned from UPS
		if(structKeyExists(response.RatingServiceSelectionResponse.Response, 'Error')) {
			// create error container
			error=structNew();
			
			// parse error from xml response
			error.ErrorDescription=response.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText;
			error.ErrorSeverity=response.RatingServiceSelectionResponse.Response.Error.ErrorSeverity.XmlText;
			error.ErrorCode=response.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText;
			error.ResponseStatusCode=response.RatingServiceSelectionResponse.Response.ResponseStatusCode.XmlText;
			error.ResponseStatusDescription=response.RatingServiceSelectionResponse.Response.ResponseStatusDescription.XmlText;
			
			'caller.#attributes.variable#.error'= error;
		} else {
			// get the number of services returned
			servicesCount=arrayLen(response.RatingServiceSelectionResponse.RatedShipment);
			// copy the services response into a new array
			// the reason I do this is for readability
			// having huge dot notation structures gets hard on the eyes
			service=duplicate(response.RatingServiceSelectionResponse);
		
			// create response query
			returnQuery=queryNew("id,ResponsePacket,ResponseStatusCode,ResponseStatusDescription,Service,ServiceCode,ServiceDescription,ServiceRatedShipmentWarning,BillingWeight,BillingWeightUnitOfMeasurement,BillingWeightUnitOfMeasurementCode,UnitOfMeasurementDescription,BillingWeightWeight,TransportationChargeCurrencyCode,TransportationChargeMonetaryValue,ServiceOptionsCurrencyCode,ServiceOptionsMonetaryValue,HandlingChargeCurrencyCode,HandlingChargeMonetaryValue,TotalChargeCurrencyCode,TotalChargeMonetaryValue,GuaranteedDaysToDelivery,ScheduledDeliveryTime,RatedPackageTransportationCharges,RatedPackageServiceOptionsCharges,RatedPackageTotalCharges,RatedPackageWeight,RatedPackageBillingWeightUnitOfMeasurement,RatedPackageBillingWeightWeight,RatedPackageBillingWeightUnitOfMeasurementCode,RatedPackageBillingWeightUnitOfMeasurementDescription,Rate");
			
			service=duplicate(response.RatingServiceSelectionResponse);
	
			/* fields from spec
				id,ResponseStatusCode,ResponseStatusDescription,Service,ServiceCode,ServiceDescription,ServiceRatedShipmentWarning,BillingWeight,UnitOfMeasurement,UnitOfMeasurementCode,UnitOfMeasurementDescription,TransportationChargeCurrencyCode,TransportationChargeMonetaryValue,ServiceOptionsCurrencyCode,ServiceOptionsMonetaryValue,HandlingChargeCurrencyCode,HandlingChargeMonetaryValue,TotalHandlingChargeCurrencyCode,TotalHandlingChargeMonetaryValue,GuaranteedDaysToDelivery,ScheduledDeliveryTime,RatedPackage,TransportationChargeCurrencyCode,TransportationChargeMonetaryValue,PackageServiceOptionsChargeCurrencyCode,PackageServiceOptionsChargeMonetaryValue,PackageTotalChargeCurrencyCode,PackageTotalChargeMonetaryValue,PackageRatedWeight,PackageBillingWeight,PackageBillingWeightUnitOfMeasurement,PackageBillingWeightUnitOfMeasurementCode,PackageBillingWeightUnitOfMeasurement,PackageBillingWeightUnitOfMeasurementDescription,Rate
			*/
			
			// create response query
			for(i=1; i lte servicesCount; i=i+1) {
				queryAddRow(returnQuery);
				querySetCell(returnQuery, "id", createUUID());
				
				querySetCell(returnQuery, "GuaranteedDaysToDelivery", service.RatedShipment[i].GuaranteedDaysToDelivery.XmlText);
				querySetCell(returnQuery, "ScheduledDeliveryTime", service.RatedShipment[i].ScheduledDeliveryTime.XmlText);
				
				if(structKeyExists(service, 'Response')) {
					querySetCell(returnQuery, "ResponsePacket", response);
					querySetCell(returnQuery, "ResponseStatusCode", service.Response.ResponseStatusCode.XmlText);
					querySetCell(returnQuery, "ResponseStatusDescription", service.Response.ResponseStatusDescription.XmlText);
				}
				if(structKeyExists(service.RatedShipment[i].Service, 'Code')) {
					querySetCell(returnQuery, "Service", getServiceName(service.RatedShipment[i].Service.Code.XmlText));			
					querySetCell(returnQuery, "ServiceCode", service.RatedShipment[i].Service.Code.XmlText);
				}			
				if(structKeyExists(service.RatedShipment[i].Service, 'Description')) {
					querySetCell(returnQuery, "ServiceDescription",service.RatedShipment[i].Service.Description.XmlText);			
				}
				if(structKeyExists(service.RatedShipment[i], 'ServiceRatedShipmentWarning')) {
					querySetCell(returnQuery, "ServiceRatedShipmentWarning",service.RatedShipment[i].ServiceRatedShipmentWarning.XmlText);
				} else {
					querySetCell(returnQuery, "ServiceRatedShipmentWarning", '');
				}
				
				if(structKeyExists(service.RatedShipment[i], 'BillingWeight')) {
					querySetCell(returnQuery, "BillingWeight", service.RatedShipment[i].BillingWeight.XmlText);	
		
					querySetCell(returnQuery, "BillingWeightUnitOfMeasurement", service.RatedShipment[i].BillingWeight.UnitOfMeasurement.XmlText);
					querySetCell(returnQuery, "BillingWeightUnitOfMeasurementCode", service.RatedShipment[i].BillingWeight.UnitOfMeasurement.Code.XmlText);
						
					if(structKeyExists(service.RatedShipment[i].BillingWeight.UnitOfMeasurement, 'Description')) {
						querySetCell(returnQuery, "UnitOfMeasurementDescription", service.RatedShipment[i].BillingWeight.UnitOfMeasurement.Description.XmlText);
					} else {
						querySetCell(returnQuery, "UnitOfMeasurementDescription", '');
					}
		
					if(structKeyExists(service.RatedShipment[i].BillingWeight, 'Weight')) {
						querySetCell(returnQuery, "BillingWeightWeight", service.RatedShipment[i].BillingWeight.Weight.XmlText);
					} else {
						querySetCell(returnQuery, "BillingWeightWeight", '');
					}
				}
				if(structKeyExists(service.RatedShipment[i], 'TransportationCharges')) {
					querySetCell(returnQuery, "TransportationChargeCurrencyCode", service.RatedShipment[i].TransportationCharges.CurrencyCode.XmlText);
					querySetCell(returnQuery, "TransportationChargeMonetaryValue", service.RatedShipment[i].TransportationCharges.MonetaryValue.XmlText);
				}
				if(structKeyExists(service.RatedShipment[i], 'ServiceOptionsCharges')) {
					querySetCell(returnQuery, "ServiceOptionsCurrencyCode", service.RatedShipment[i].ServiceOptionsCharges.CurrencyCode.XmlText);
					querySetCell(returnQuery, "ServiceOptionsMonetaryValue", service.RatedShipment[i].ServiceOptionsCharges.MonetaryValue.XmlText);
				}
				if(structKeyExists(service.RatedShipment[i], 'HandlingCharge')) {
					if(structKeyExists(service.RatedShipment[i].HandlingCharge, 'CurrencyCode')) {
						querySetCell(returnQuery, "HandlingChargeCurrencyCode",service.RatedShipment[i].CurrencyCode.XmlText);
					} else {
						querySetCell(returnQuery, "HandlingChargeCurrencyCode", '');
					}
					if(structKeyExists(service.RatedShipment[i].HandlingCharge, 'MonetaryValue')) {
						querySetCell(returnQuery, "HandlingChargeMonetaryValue",service.RatedShipment[i].HandlingCharge.MonetaryValue.XmlText);
					} else {
						querySetCell(returnQuery, "HandlingChargeMonetaryValue", '');
					}
				}
				if(structKeyExists(service.RatedShipment[i], 'TotalCharges')) {
					querySetCell(returnQuery, "TotalChargeCurrencyCode", service.RatedShipment[i].TotalCharges.CurrencyCode.XmlText);
					querySetCell(returnQuery, "TotalChargeMonetaryValue", service.RatedShipment[i].TotalCharges.MonetaryValue.XmlText);
				}	
				if(structKeyExists(service.RatedShipment[i], 'RatedPackage')) {
					if(structKeyExists(service.RatedShipment[i].RatedPackage, 'TransportationCharges')) {
						querySetCell(returnQuery, "RatedPackageTransportationCharges", service.RatedShipment[i].RatedPackage.TransportationCharges.XmlText);
					}
					if(structKeyExists(service.RatedShipment[i].RatedPackage, 'ServiceOptionsCharges')) {
						querySetCell(returnQuery, "RatedPackageServiceOptionsCharges", service.RatedShipment[i].RatedPackage.ServiceOptionsCharges.XmlText);
					}
					if(structKeyExists(service.RatedShipment[i].RatedPackage, 'TotalCharges')) {
						querySetCell(returnQuery, "RatedPackageServiceOptionsCharges", service.RatedShipment[i].RatedPackage.TotalCharges.XmlText);
					}
					if(structKeyExists(service.RatedShipment[i].RatedPackage, 'Weight')) {
						querySetCell(returnQuery, "RatedPackageServiceOptionsCharges", service.RatedShipment[i].RatedPackage.Weight.XmlText);
					}
					if(structKeyExists(service.RatedShipment[i].RatedPackage, 'BillingWeight')) {					
						if(structKeyExists(service.RatedShipment[i].RatedPackage.BillingWeight, 'Weight')) {
							querySetCell(returnQuery, "RatedPackageBillingWeightWeight", service.RatedShipment[i].RatedPackage.Weight.XmlText);
						}
						if(structKeyExists(service.RatedShipment[i].RatedPackage.BillingWeight, 'UnitOfMeasurement')) {
							if(structKeyExists(service.RatedShipment[i].RatedPackage.BillingWeight.UnitOfMeasurement, 'Code')) {					
								querySetCell(returnQuery, "RatedPackageBillingWeightUnitOfMeasurementCode", service.RatedShipment[i].RatedPackage.BillingWeight.UnitOfMeasurement.Code.XmlText);
							}
							if(structKeyExists(service.RatedShipment[i].RatedPackage.BillingWeight.UnitOfMeasurement, 'Description')) {					
								querySetCell(returnQuery, "RatedPackageBillingWeightUnitOfMeasurementDescription", service.RatedShipment[i].RatedPackage.ServiceOptionsCharges.XmlText);
							}
						}					
					}
				}
				querySetCell(returnQuery, "Rate", service.RatedShipment[i].TotalCharges.MonetaryValue.XmlText+attributes.AdditionalHandling);
			}
			
			'caller.#attributes.variable#'=returnQuery;
		}
	
		// returns the name of the UPS service for a given service type id
		// for example: pass '03' to this function and it returns 'UPS Ground'
		function getServiceName(type_id) {
			var serviceName='';
			
			switch(type_id) {
				case "01": 
					serviceName='UPS Next Day Air';
				break;
				case "02": 
					serviceName='UPS 2nd Day Air';
				break;
				case "03": 
					serviceName='UPS Ground';
				break;
				case "07": 
					serviceName='UPS Worldwide Express SM';
				break;
				case "08": 
					serviceName='UPS Worldwide Expedited SM';
				break;
				case "11": 
					serviceName='UPS Standard';
				break;
				case "12": 
					serviceName='UPS 3 Day Select';
				break;
				case "13": 
					serviceName='UPS Next Day Air Saver';
				break;
				case "14": 
					serviceName='UPS Next Day Air  Early A.M.';
				break;
				case "54": 
					serviceName='UPS Worldwide Express Plus SM';
				break;
				case "59": 
					serviceName='UPS 2nd Day Air A.M.';
				break;
				case "64": 
					serviceName='No Services Available';
				break;
				case "65": 
					serviceName='UPS Express Saver';
				break;
				
				default:
					serviceName='No Services Available';								
			}
			// return UPS service name
			return serviceName;
		}
	</cfscript>















