<cftry>
<link rel="stylesheet" type="text/css" href="../../controlpanel.css">
<cfparam name = "action" default="default">
<cfparam name = "mytoken" default="null">
<cfparam name = "request.dsnun" default="">
<cfparam name = "request.dsnpw" default="">

<cfif listlen(action, ".") GT 1>
	<cfset action = listgetat(action, 3, ".")>
</cfif>

<cfswitch expression="#action#">
	 	<cfcase value = "default">
			<cfinclude template = "forms/frm_createnewsletter.cfm">	
		</cfcase>
	 	<cfcase value = "save">
			<cfinclude template = "actions/act_savenewsletter.cfm">	
		</cfcase>
	 	<cfcase value = "send">
			<cfinclude template = "forms/frm_newsletters.cfm">	
		</cfcase>
	 	<cfcase value = "sendnewsletter">
			<cfinclude template = "actions/act_send.cfm">	
		</cfcase>
	 	<cfcase value = "preparetosend">
			<cfinclude template = "forms/frm_send.cfm">	
		</cfcase>
	 	<cfcase value = "edit">
			<cfinclude template = "forms/frm_editnewsletter.cfm">	
		</cfcase>
	 	<cfcase value = "delete">
			<cfinclude template = "actions/act_deletenewsletter.cfm">	
		</cfcase>
	 	<cfcase value = "members">
			<cfinclude template = "forms/frm_members.cfm">	
		</cfcase>
	 	<cfcase value = "deletemembers">
			<cfinclude template = "actions/act_deletemembers.cfm">	
		</cfcase>
	 	<cfcase value = "editsettings">
			<cfinclude template = "forms/frm_settings.cfm">	
		</cfcase>
	 	<cfcase value = "savesettings">
			<cfinclude template = "actions/act_savesettings.cfm">	
		</cfcase>
	 	<cfcase value = "groups">
			<cfinclude template = "forms/frm_groups.cfm">	
		</cfcase>
	 	<cfcase value = "updategroup">
			<cfinclude template = "actions/act_savesettings.cfm">	
		</cfcase>
	 	<cfcase value = "addgroup">
			<cfinclude template = "actions/act_addgroup.cfm">	
		</cfcase>
	 	<cfcase value = "deletegroup">
			<cfinclude template = "actions/act_deletegroup.cfm">	
		</cfcase>
	 	<cfcase value = "setstatus">
			<cfinclude template = "actions/act_setstatus.cfm">	
		</cfcase>
	 	<cfcase value = "editmember">
			<cfinclude template = "forms/frm_editmember.cfm">	
		</cfcase>
	 	<cfcase value = "updatemember">
			<cfinclude template = "actions/act_updatemember.cfm">	
		</cfcase>
	 	<cfcase value = "addmember">
			<cfinclude template = "actions/act_addmember.cfm">	
		</cfcase>
	 	<cfcase value = "AssignToGroups">
			<cfinclude template = "forms/frm_assigntogroups.cfm">	
		</cfcase>
	 	<cfcase value = "SaveGroupMembers">
			<cfinclude template = "actions/act_assigntogroups.cfm">	
		</cfcase>
		<cfdefaultcase>
			Error!  Missing action call.
		</cfdefaultcase>
</cfswitch>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>









