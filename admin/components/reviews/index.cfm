
<cfparam name="action" default="default">
<cfparam name="itemid" default="0">

<cfswitch expression="#action#">
    <cfcase value="read">
    	<cfinclude template = "displays/dspreview.cfm">
    </cfcase>
    <cfcase value="delete">
    	<cfinclude template = "actions/actdeletereview.cfm">
    </cfcase>
    <cfcase value="approvals">
    	<cfinclude template = "forms/frmapprove.cfm">
    </cfcase>  
    <cfcase value="approve">
    	<cfinclude template = "actions/actapprove.cfm">
    </cfcase>  
	<cfdefaultcase>
    	<cfinclude template = "forms/frmApprove.cfm">
    </cfdefaultcase>
</cfswitch>







