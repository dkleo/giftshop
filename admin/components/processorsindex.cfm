<cftry>
<link href="../../controlpanel.css" rel="stylesheet" type="text/css" />

<style>
.normal {background-color: #FFFFFF; cursor: default;}
.onhover {background-color: #FFFFCC; cursor: default;}
</style>

<cfparam name = "action" default="default">

<cfswitch expression="#action#">
    <cfcase value="selectgateway">
        <cfinclude template = "forms/frmselectgateway.cfm">
    </cfcase>
    <cfcase value="select3rdparty">
        <cfinclude template = "forms/frmselectthirdparty.cfm">
    </cfcase>
    <cfcase value="setgateway">
        <cfinclude template = "actions/actselectgateway.cfm">
    </cfcase>
    <cfcase value="set3rdparty">
        <cfinclude template = "actions/actsetthirdparty.cfm">
    </cfcase>
    <cfcase value="new">
        <cfinclude template = "forms/frmedit.cfm">
    </cfcase>
    <cfcase value="edit">
        <cfinclude template = "forms/frmedit.cfm">
    </cfcase>
    <cfcase value="add">
        <cfinclude template = "actions/actadd.cfm">
    </cfcase>
    <cfcase value="update">
        <cfinclude template = "actions/actupdate.cfm">
    </cfcase>    
    <cfcase value="settings">
        <cfinclude template = "forms/frmsettings.cfm">
    </cfcase>
    <cfcase value="savesettings">
        <cfinclude template = "actions/actsavesettings.cfm">
    </cfcase>
    <cfcase value="clearsetting">
        <cfinclude template = "actions/actclearsetting.cfm">
    </cfcase>
    <cfcase value="clear_gateway">
        <cfinclude template = "actions/actcleargateway.cfm">
    </cfcase>
    
    <cfdefaultcase>
    	<cfinclude template = "forms/frmprocessors.cfm">
    </cfdefaultcase>
</cfswitch>
<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>
</cftry>










