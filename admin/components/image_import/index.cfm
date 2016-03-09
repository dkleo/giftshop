<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>
<cfparam name = "action" default="import">
<cfsetting requesttimeout="1200">

<cfswitch expression="#action#">
    <cfcase value='Import'>
        <cfinclude template = 'forms/frmimport.cfm'>
    </cfcase>
    <cfcase value='Import_Step_2'>
        <cfinclude template = 'forms/frmimport2.cfm'>
    </cfcase>
</cfswitch>









