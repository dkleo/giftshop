<link href="../../controlpanel.css" rel="stylesheet" type="text/css">
<cfparam name = "action" default="default">

<cfswitch expression="#action#">
    <cfcase value = "approve">
        <cfinclude template = "actions/act_approvecomments.cfm">
    </cfcase>
    <cfcase value = "delete">
        <cfinclude template = "forms/frm_deletecomments.cfm">
    </cfcase>
    <cfcase value = "moderate_approved">
        <cfinclude template = "forms/frm_deleteapprovedcomments.cfm">
    </cfcase>
    <cfcase value = "deleteA">
        <cfinclude template = "actions/act_deletecomments.cfm">
    </cfcase>
    <cfcase value = "deleteU">
        <cfinclude template = "actions/act_DeleteComments.cfm">
    </cfcase>    
	<cfdefaultcase>
		<cfinclude template = "forms/frm_approvecomments.cfm">	
	</cfdefaultcase> 
</cfswitch>









