<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>
<cfparam name = "action" default="import">
<cfsetting requesttimeout="1200">

<cfswitch expression="#action#">
    <cfcase value='Import'>
        <cfinclude template = 'forms/frm_import.cfm'>
    </cfcase>
    <cfcase value='Import_Step_2'>
        <cfinclude template = 'forms/frm_import_2.cfm'>
    </cfcase>
    <cfcase value='Prep_Import'>
        <cfinclude template = 'actions/act_prepimport.cfm'>
    </cfcase>
    <cfcase value='importwindow'>
        <cfinclude template = 'displays/dsp_importwindow.cfm'>
    </cfcase>
    <cfcase value='importwindow2'>
        <cfinclude template = 'displays/dsp_importwindow.cfm'>
    </cfcase>
    <cfcase value='Import_Step_3'>
        <cfinclude template = 'forms/frm_import_3.cfm'>
    </cfcase>
    <cfcase value='Import_Step_4'>
        <cfinclude template = 'forms/frm_import_4.cfm'>
    </cfcase>
</cfswitch>







