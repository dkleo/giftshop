<cfparam name = "action" default="">

<cfswitch expression="#action#">
    <cfcase value='editstyle'>
        <cfinclude template = 'forms/frmeditstyletag.cfm'>
    </cfcase>
    <cfcase value='Save'>
        <cfinclude template = 'forms/actsave.cfm'>
    </cfcase>
    <cfdefaultcase>
        <cfinclude template = 'forms/frmcustomstyles.cfm'>
    </cfdefaultcase>
</cfswitch>







