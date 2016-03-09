<cftry>

<cfparam name="action" default="blog.edit.default">
<cfparam name="mytoken" default="0">
<cfset request.dsnun = ''>
<cfset request.dsnpw = ''>



<cfset request.action = listgetat(action, 2, ".")>
<cfset request.method = listgetat(action, 3, ".")>

<cfswitch expression="#request.action#">
	<cfcase value="edit">
		<cfswitch expression="#request.method#">
			<cfcase value="Edit">
				<cfinclude template = "forms/frm_editpost.cfm">
			</cfcase>
			<cfcase value="New">
				<cfinclude template = "forms/frm_newpost.cfm">
			</cfcase>
			<cfcase value="Add">
				<cfinclude template = "actions/act_addpost.cfm">
			</cfcase>
			<cfcase value="Update">
				<cfinclude template = "actions/act_updatepost.cfm">
			</cfcase>
			<cfcase value="Delete">
				<cfinclude template = "actions/act_deletepost.cfm">
			</cfcase>
			<cfcase value="EditReplies">
				<cfinclude template = "forms/frm_approvecomments.cfm">
			</cfcase>
			<cfcase value="ApproveReplies">
				<cfinclude template = "actions/act_approvecomments.cfm">
			</cfcase>
			<cfdefaultcase>
				<cfinclude template = "forms/frm_editposts.cfm">
			</cfdefaultcase>
		</cfswitch>
	</cfcase>
	<cfcase value="categories">
		<cfswitch expression="#request.method#">
			<cfcase value="Update">
				<cfinclude template = "actions/act_updatecategory.cfm">
			</cfcase>
			<cfcase value="Add">
				<cfinclude template = "actions/act_addcategory.cfm">
			</cfcase>
			<cfcase value="Delete">
				<cfinclude template = "actions/act_deletecategory.cfm">
			</cfcase>
			<cfdefaultcase>
				<cfinclude template = "forms/frm_categories.cfm">
			</cfdefaultcase>
		</cfswitch>
	</cfcase>
	<cfcase value="links">
		<cfswitch expression="#request.method#">
			<cfcase value="Add">
				<cfinclude template = "actions/act_addlink.cfm">
			</cfcase>
			<cfcase value="Delete">
				<cfinclude template = "actions/act_deletelink.cfm">
			</cfcase>
			<cfdefaultcase>
				<cfinclude template = "forms/frm_links.cfm">
			</cfdefaultcase>
		</cfswitch>
	</cfcase>
	<cfcase value="settings">
		<cfswitch expression="#request.method#">
			<cfcase value="update">
				<cfinclude template = "actions/act_updatesettings.cfm">
				<cfinclude template = "forms/frm_settings.cfm">
			</cfcase>
			<cfdefaultcase>
				<cfinclude template = "forms/frm_settings.cfm">
			</cfdefaultcase>
		</cfswitch>
	</cfcase>
	<cfdefaultcase>
	A valid action must be called for this component!
	</cfdefaultcase>
</cfswitch>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>










