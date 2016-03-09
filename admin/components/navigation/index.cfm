<cfparam name = "selecteditem" default="1">
<cfparam name = "mview" default="1">
<cfparam name = "nview" default="0">
<cfparam name = "level" default="1">
<cfparam name = "pLinkID" default="0">
<cfparam name = "action" default="">

<link href="../../controlpanel.css" rel="stylesheet" type="text/css">

<cfswitch expression="#action#">
	<cfcase value="NewCategoryLink">
    	<cfinclude template = "forms/frmnewcategorylink.cfm">
    </cfcase>
    <cfcase value="Reorder">
        <cfinclude template = "forms/frmchangeorder.cfm">
    </cfcase>
    <cfcase value="SaveReorder">
        <cfinclude template = "actions/actsavereorder.cfm">
    </cfcase>
    <cfcase value="AddLink">
        <cfinclude template = "actions/actaddlink.cfm">
    </cfcase>
    <cfcase value="NewLink">
        <cfinclude template = "forms/frmnewlink.cfm">
    </cfcase>
    <cfcase value="NewSiteLink">
        <cfinclude template = "forms/frmnewsitelink.cfm">
    </cfcase>
    <cfcase value="NewPluginLink">
        <cfinclude template = "forms/frmnewpluginlink.cfm">
    </cfcase>
    <cfcase value="NewCustomLink">
        <cfinclude template = "forms/frmnewcustomlink.cfm">
    </cfcase>						
    <cfcase value="DeleteLink">
        <cfinclude template = "actions/actdelete.cfm">
    </cfcase>
    <cfcase value="EditPluginLink">
        <cfinclude template = "forms/frmeditpluginlink.cfm">
    </cfcase>
    <cfcase value="UpdatePluginLink">
        <cfinclude template = "actions/actupdatepluginlink.cfm">
    </cfcase>
    <cfcase value="EditPageLink">
        <cfinclude template = "forms/frmeditsitelink.cfm">
    </cfcase>
    <cfcase value="UpdateSiteLink">
        <cfinclude template = "actions/actupdatesitelink.cfm">
    </cfcase>
    <cfcase value="EditCustomLink">
        <cfinclude template = "forms/frmeditcustomlink.cfm">
    </cfcase>
    <cfcase value="UpdateCustomLink">
        <cfinclude template = "actions/actupdatecustomlink.cfm">
    </cfcase>
    <cfcase value="ChangeRelationship">
        <cfinclude template = "forms/frmSetRelationship.cfm">
    </cfcase>
    <cfcase value="SetRelationship">
        <cfinclude template = "actions/actSetRelationship.cfm">
    </cfcase>
    <cfcase value="EditSubMenu">
        <cfinclude template = "forms/frmEditSubmenu.cfm">
    </cfcase>
    <cfcase value="EditStyles">
        <cfinclude template = "forms/frmstyles.cfm">
    </cfcase>
    <cfcase value="updatestyles">
        <cfinclude template = "actions/actupdatestyles.cfm">
    </cfcase>
    <cfcase value="updatehtml">
        <cfinclude template = "actions/actupdatehtml.cfm">
    </cfcase>
    <cfcase value="EditCategoryLink">
        <cfinclude template = "forms/frmeditcategorylink.cfm">
    </cfcase>
    <cfcase value="UpdateCategoryLink">
        <cfinclude template = "actions/actupdatecategorylink.cfm">
    </cfcase>
    <cfdefaultcase>
        <cfinclude template = "forms/frmnavigation.cfm">
    </cfdefaultcase>
</cfswitch>









