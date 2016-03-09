<cftry>
<h2>Shipping Settings</h2>

<cfif NOT qryLoginCheck.userlevel IS 'admin' AND NOT qryLoginCheck.userlevel IS 'masteradmin'>
    Shipping settings can not be changed by users.  Please login as an admin to edit these settings.
    <cfabort>
</cfif>

<cfparam name="action" default="">
<cfswitch expression="#action#">

<cfcase value = "SetupUPS">
   <cfinclude template = "forms/frmupssettings.cfm">
</cfcase>
<cfcase value = "SetupFEDEX">
   <cfinclude template = "forms/frmfedexsettings.cfm">
</cfcase>
<cfcase value = "EditOne">
  <cfinclude template = "forms/frmconfigureone.cfm">
</cfcase>
<cfcase value = "EditTwo">
  <cfinclude template = "forms/frmconfiguretwo.cfm">
</cfcase>
<cfcase value = "EditFive">
  <cfinclude template = "forms/frmconfigurefive.cfm">
</cfcase>
<cfcase value = "EditFlat">
  <cfinclude template = "forms/frmeditflat.cfm">
</cfcase>
<cfcase value = "EditCustom">
  <cfinclude template = "forms/frmconfigurecustom.cfm">
</cfcase>
<cfcase value = "EditACustom">
  <cfinclude template = "forms/frmeditcustom.cfm">
</cfcase>
<cfcase value = "EditAOne">
  <cfinclude template = "forms/frmeditone.cfm">
</cfcase>
<cfcase value = "EditAFive">
  <cfinclude template = "forms/frmeditfive.cfm">
</cfcase>
<cfcase value = "EditATwo">
  <cfinclude template = "forms/frmedittwo.cfm">
</cfcase>
<cfcase value = "DeleteCustom">
  <cfinclude template = "actions/actdeletecustom.cfm">
</cfcase>
<cfcase value = "DeleteOne">
  <cfinclude template = "actions/actdeleteone.cfm">
</cfcase>
<cfcase value = "DeleteTwo">
  <cfinclude template = "actions/actdeletetwo.cfm">
</cfcase>
<cfcase value = "DeleteFive">
  <cfinclude template = "actions/actdeletefive.cfm">
</cfcase>
<cfcase value = "ShippingAreas">
	<cfinclude template = "forms/frmshippingareas.cfm">
</cfcase>
<cfcase value = "EditCountries">
	<cfinclude template = "forms/frmeditcountries.cfm">
</cfcase>
<cfcase value = "EditStates">
	<cfinclude template = "forms/frmeditstates.cfm">
</cfcase>
<cfcase value = "EditQuantityTable">
	<cfinclude template = "forms/frmconfigureqtyshipping.cfm">
</cfcase>
<cfcase value = "EditAQty">
	<cfinclude template = "forms/frmeditqtyshipping.cfm">
</cfcase>
<cfcase value = "DeleteQty">
	<cfinclude template = "actions/actdeleteqty.cfm">
</cfcase>
<cfcase value = "Surcharge">
	<cfinclude template = "forms/frmeditsurcharges.cfm">
</cfcase>
<cfcase value = "FreeZones">
	<cfinclude template = "forms/frmfreezones.cfm">
</cfcase>
<cfcase value = "DeleteSurcharge">
	<cfinclude template = "actions/actdeletesurcharge.cfm">
</cfcase>
<cfcase value = "DeleteFreeZone">
	<cfinclude template = "actions/actdeletefreezone.cfm">
</cfcase>
<cfcase value = "EditShippingTypes">
   <cfinclude template = "forms/frmshippingtypes.cfm">
</cfcase>
<cfcase value = "DeleteShippingType">
	<cfinclude template = "actions/actdeleteshippingtype.cfm">
</cfcase>		
<cfcase value = "SetShippingPoints">
	<cfinclude template = "forms/frmshippingpoints.cfm">
</cfcase>
<cfcase value = "DeleteShippingPoint">
   <cfinclude template = "actions/actdeleteshippingpoint.cfm">
</cfcase>
<cfcase value = "SetShippingLocation">
   <cfinclude template = "forms/frmsetshippinglocation.cfm">
</cfcase>				
<cfcase value = "fedexregister">
   <cfinclude template = "forms/frmfedexregister.cfm">
</cfcase>		
<cfcase value = "testfedex">
   <cfinclude template = "forms/frmtestfedex.cfm">
</cfcase>
<cfcase value = "testups">
   <cfinclude template = "forms/frmtestups.cfm">
</cfcase>						
<cfcase value = "countries_setshow">
   <cfinclude template = "actions/actchangecountryshow.cfm">
</cfcase>
<cfcase value = "states_setshow">
   <cfinclude template = "actions/actchangestateshow.cfm">
</cfcase>	
<cfcase value = "addcountry">
   <cfinclude template = "actions/actaddcountry.cfm">
</cfcase>	
<cfcase value = "addstate">
   <cfinclude template = "actions/actaddstate.cfm">
</cfcase>	
<cfcase value = "deletecountry">
   <cfinclude template = "actions/actdeletecountry.cfm">
</cfcase>	
<cfcase value = "deletestate">
   <cfinclude template = "actions/actdeletestate.cfm">
</cfcase>	

<cfcase value = "UpdateOne">
  <cfinclude template = "actions/actupdateone.cfm">
</cfcase>
<cfcase value = "UpdateTwo">
  <cfinclude template = "actions/actupdatetwo.cfm">
</cfcase>
<cfcase value = "UpdateFive">
  <cfinclude template = "actions/actupdatefive.cfm">
</cfcase>
<cfcase value = "UpdateFlat">
  <cfinclude template = "actions/actupdateflat.cfm">
</cfcase>
<cfcase value = "AddCustom">
  <cfinclude template = "actions/actaddcustom.cfm">
</cfcase>
<cfcase value = "AddOne">
  <cfinclude template = "actions/actaddone.cfm">
</cfcase>
<cfcase value = "AddTwo">
  <cfinclude template = "actions/actaddtwo.cfm">
</cfcase>
<cfcase value = "AddFive">
  <cfinclude template = "actions/actaddfive.cfm">
</cfcase>
<cfcase value = "UpdateCustom">
  <cfinclude template = "actions/actupdatecustom.cfm">
</cfcase>
<cfcase value = "SetMethod">
  <cfinclude template = "actions/actupdatesettings.cfm">
</cfcase>
<cfcase value = "UpdateCountries">
  <cfinclude template = "actions/actsetcountries.cfm">
</cfcase>
<cfcase value = "UpdateStates">
  <cfinclude template = "actions/actsetstates.cfm">
</cfcase>
<cfcase value = "AddSurcharge">
  <cfinclude template = "actions/actaddsurcharge.cfm">
</cfcase>
<cfcase value = "AddFreeZone">
  <cfinclude template = "actions/actaddfreezone.cfm">
</cfcase>
<cfcase value = "AddQty">
	<cfinclude template = "actions/actaddqty.cfm">
</cfcase>
<cfcase value = "UpdateQty">
	<cfinclude template = "actions/actupdateqty.cfm">
</cfcase>
<cfcase value = "AddShippingType">
	<cfinclude template = "actions/actaddshippingtype.cfm">
</cfcase>
<cfcase value = "FinishUPSSetup">
	<cfinclude template = "forms/frmSelectMethod.cfm">
</cfcase>
<cfcase value = "UpdateShippingLocation">
	<cfinclude template = "actions/actsetshippinglocation.cfm">
</cfcase>
<cfcase value = "AddShippingPoint">
	<cfinclude template = "actions/actaddshippingpoint.cfm">
</cfcase>
<cfcase value = "UpdateUPSSettings">
	<cfinclude template = "actions/actupdateupssettings.cfm">
</cfcase>
<cfcase value = "UpdateFedexSettings">
	<cfinclude template = "actions/actupdatefedexsettings.cfm">
</cfcase>
<cfdefaultcase>
	<cfinclude template = "forms/frmselectmethod.cfm">
</cfdefaultcase>
</cfswitch>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>