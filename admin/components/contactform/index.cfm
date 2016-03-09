<cfparam name = "action" default="settings">
<cfsetting requesttimeout="1200">

<cfswitch expression="#action#">
    <cfcase value='settings'>
        <cfinclude template = 'forms/frmsettings.cfm'>
    </cfcase>
    <cfcase value='view_data'>
        <cfinclude template = 'forms/frmData.cfm'>
    </cfcase>
    <cfcase value='save_settings'>
        <cfinclude template = 'actions/actsavesettings.cfm'>
    </cfcase>
    <cfdefaultcase>
    	<cfinclude template = 'forms/frmsettings.cfm'>
    </cfdefaultcase>
</cfswitch>









