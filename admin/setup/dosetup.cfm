<cftry>
<link href="../controlpanel.css" rel="stylesheet" type="text/css">

<cfif NOT qryLoginCheck.userlevel IS "admin" AND NOT qryLoginCheck.userlevel IS 'masteradmin'>
	<h3>Settings</h3>
    User accounts cannot change some settings.  Please login as an admin to change settings.
    <cfabort>
</cfif>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function showColor(val) {
document.colorform.hexval.value = val;
}
//  End -->
</script>

<cfparam name = "action" default="">

<cfswitch expression="#action#">
	<cfcase value="taxes">
      <cfinclude template = "forms/frmtaxes.cfm">
    </cfcase>
    <cfcase value="PaymentMethods">
      <cfinclude template = "forms/frmpaymentmethods.cfm">
    </cfcase>
    <cfcase value="CCProcessing">
      <cfinclude template = "forms/frmccsetup.cfm">
    </cfcase>
    <cfcase value="CustomButtons">
      <cfinclude template = "forms/frmcustombuttons.cfm">
    </cfcase>
    <cfcase value="DeleteTax">
      <cfinclude template = "actions/actdeletetax.cfm">
    </cfcase>
	<cfcase value="urlrewrite">
      <cfinclude template = "forms/frmgeneraterewrite.cfm">
    </cfcase>
    <cfcase value="promos">
      <cfinclude template = "forms/frmPomotionalCodes.cfm">
    </cfcase>
    <cfcase value="EditPromo">
      <cfinclude template = "forms/frmEditPromo.cfm">
    </cfcase>
    <cfcase value="DeletePromo">
      <cfinclude template = "actions/actDeletePromo.cfm">
    </cfcase>
    <cfcase value="StoreColors">
      <cfinclude template = "forms/frmcolorprefs.cfm">
    </cfcase>
    <cfcase value="SetTableText">
      <cfinclude template = "forms/frmTableText.cfm">
    </cfcase>
    <cfcase value="SetTableBG">
      <cfinclude template = "forms/frmTableBG.cfm">
    </cfcase>
    <cfcase value="SetLinkText">
      <cfinclude template = "forms/frmLinkText.cfm">
    </cfcase>
    <cfcase value="SetLinkHover">
      <cfinclude template = "forms/frmLinkHover.cfm">
    </cfcase>
    <cfcase value="SetLinkHoverColor">
      <cfinclude template = "forms/frmLinkHoverText.cfm">
    </cfcase>
    <cfcase value="Variables">
      <cfinclude template = "forms/frmvariables.cfm">
    </cfcase>
    <cfcase value="EditPaymentTypes">
      <cfinclude template = "forms/frmEditPaymentTypes.cfm">
    </cfcase>
    <cfcase value="DeletePaymentType">
      <cfinclude template = "actions/actDeletePaymentType.cfm">
    </cfcase>
    <cfcase value="SetAuthorizenet">
      <cfinclude template = "forms/frmsetupauthorizenet.cfm">
    </cfcase>
    <cfcase value="SetLinkPoint">
      <cfinclude template = "forms/frmsetuplinkpointbasic.cfm">
    </cfcase>
    <cfcase value="SetPayPal">
      <cfinclude template = "forms/frmsetuppaypal.cfm">
    </cfcase>
    <cfcase value="Set2checkout">
      <cfinclude template = "forms/frmsetup2checkout.cfm">
    </cfcase>
    <cfcase value="SetSkipJack">
      <cfinclude template = "forms/frmsetupskipjack.cfm">
    </cfcase>
    <cfcase value="SetPayflowLink">
      <cfinclude template = "forms/frmsetuppayflowlink.cfm">
    </cfcase>
    <cfcase value="SetPayflowPro">
      <cfinclude template = "forms/frmsetuppayflowpro.cfm">
    </cfcase>
    <cfcase value="SetYourPay">
      <cfinclude template = "forms/frmsetupyourpay.cfm">
    </cfcase>
    <cfcase value="SetPsiGate">
      <cfinclude template = "forms/frmsetuppsigate.cfm">
    </cfcase>
    <cfcase value="SetOptimal">
      <cfinclude template = "forms/frmSetupOptimal.cfm">
    </cfcase>
    <cfcase value="SetMoneris">
      <cfinclude template = "forms/frmSetupMoneris.cfm">
    </cfcase>
    <cfcase value="SetPayPalPro">
      <cfinclude template = "forms/frmsetuppaypalpro.cfm">
    </cfcase>
    <cfcase value="WidgetSetup">
      <cfinclude template = "forms/frmwidgets.cfm">
    </cfcase>
    <cfcase value="resizeimages">
      <cfinclude template = "actions/actresizeimages.cfm">
    </cfcase>		
    <cfcase value="NewCustomWidget">
      <cfinclude template = "forms/frmcustomwidget.cfm">
    </cfcase>
    <cfcase value="EditWidget">
      <cfinclude template = "forms/frmeditwidget.cfm">
    </cfcase>		
    <cfcase value="DeleteWidget">
      <cfinclude template = "actions/actdeletewidget.cfm">
    </cfcase>	
    <cfcase value="viewerrors">
      <cfinclude template = "forms/frmerrorlog.cfm">
    </cfcase>	
    <cfcase value="viewerrordetail">
      <cfinclude template = "forms/frmviewerror.cfm">
    </cfcase>	
    <cfcase value="DeleteError">
      <cfinclude template = "actions/actdeleteerror.cfm">
    </cfcase>	
    <cfcase value="MarkErrorResolved">
      <cfinclude template = "forms/frmmarkerrorresolved.cfm">
    </cfcase>	
    <cfcase value="MarkErrorUnresolved">
      <cfinclude template = "forms/frmmarkerrorresolved.cfm">
    </cfcase>	
    <cfcase value="reporterror">
      <cfinclude template = "actions/actnotifysupport.cfm">
    </cfcase>	
    <cfcase value="viewsolutions">
      <cfinclude template = "forms/frmerrorfixes.cfm">
    </cfcase>	
    <cfcase value="clearerrorlog">
      <cfinclude template = "actions/actclearerrorlog.cfm">
    </cfcase>	
    <cfcase value="choosetheme">
      <cfinclude template = "forms/frmchoosetheme.cfm">
    </cfcase>
    <cfcase value="SaveTheme">
        <cfinclude template = "actions/actsaveastheme.cfm">
    </cfcase>
    <cfcase value="selecttheme">
        <cfinclude template = "actions/actselecttheme.cfm">
    </cfcase>                     	
    <cfcase value = "updatecc">
      <cfinclude template = "actions/actupdatecc.cfm">
    </cfcase>
    <cfcase value = "UpdateButtons">
      <cfinclude template = "actions/actupdatebuttons.cfm">
    </cfcase>
    <cfcase value = "UploadLogo">
      <cfinclude template = "actions/actUploadLogo.cfm">
    </cfcase>
    <cfcase value = "UpdateCompanyInfo">
      <cfinclude template = "actions/actupdateinfo.cfm">
    </cfcase>
<!---    <cfcase value = "ChangePassword">
      <cfinclude template = "actions/actchangepassword.cfm">
    </cfcase>--->
    <cfcase value = "AddTax">
      <cfinclude template = "actions/actaddtax.cfm">
    </cfcase>
    <cfcase value = "UpdatePM">
      <cfinclude template = "actions/actsetpaymenttypes.cfm">
    </cfcase>
    <cfcase value = "AddPromo">
      <cfinclude template = "actions/actAddPromo.cfm">
    </cfcase>
    <cfcase value = "UpdatePromo">
      <cfinclude template = "actions/actupdatepromo.cfm">
    </cfcase>
    <cfcase value = "UpdateTableText">
      <cfinclude template = "actions/actUpdateTableText.cfm">
    </cfcase>
    <cfcase value = "UpdateTableBG">
      <cfinclude template = "actions/actUpdateTableBG.cfm">
    </cfcase>
    <cfcase value = "UpdateLinkText">
      <cfinclude template = "actions/actUpdateLinkText.cfm">
    </cfcase>
    <cfcase value = "UpdateLinkHover">
      <cfinclude template = "actions/actUpdateLinkHover.cfm">
    </cfcase>
    <cfcase value = "UpdateLinkHoverText">
      <cfinclude template = "actions/actUpdateLinkHoverText.cfm">
    </cfcase>
    <cfcase value = "UpdateColors">
      <cfinclude template = "actions/actupdatecolors.cfm">
    </cfcase>
    <cfcase value = "UpdateVariables">
      <cfinclude template = "actions/actupdatevariables.cfm">
    </cfcase>
    <cfcase value = "SetPaymentMethods">
      <cfinclude template = "actions/actSetPaymentTypes.cfm">
    </cfcase>
    <cfcase value = "AddPaymentType">
      <cfinclude template = "actions/actaddpaymenttype.cfm">
    </cfcase>
    <cfcase value = "UpdateProcessor">
      <cfinclude template = "actions/actsaveprocessorsettings.cfm">
    </cfcase>
    <cfcase value = "UpdateWidgets">
      <cfinclude template = "actions/actupdatewidgets.cfm">
    </cfcase>
    <cfcase value = "AddCustomWidget">
      <cfinclude template = "actions/actaddcustomwidget.cfm">
    </cfcase>
    <cfcase value = "UpdateWidget">
      <cfinclude template = "actions/actupdatewidget.cfm">
    </cfcase>
    <cfcase value = "bannedips">
      <cfinclude template = "forms/frmbannedips.cfm">
    </cfcase>
    <cfcase value = "customerror">
      <cfinclude template = "forms/frmcustomerror.cfm">
    </cfcase>
    <cfdefaultcase>
        <cfinclude template = "forms/frmmaininfo.cfm">
    </cfdefaultcase>
</cfswitch>

    <cfcatch type = "any">
    	<cfinclude template = "../errorprocess.cfm">
    	<cfabort>
    </cfcatch>

</cftry>


