<link href="../../controlpanel.css" rel="stylesheet" type="text/css">
<cftry>
<cfparam name = "action" default = "">

<cfswitch expression="#action#">
	<cfcase value="update">
		<cfinclude template = "actions/actupdate.cfm">
	</cfcase>
	<cfcase value="edit">
		<cfinclude template = "forms/frmedit.cfm">
	</cfcase>
	<cfcase value="ViewSubAffiliates">
		<cfinclude template = "displays/dspsubaffiliates.cfm">
	</cfcase>
	<cfcase value="delete">
		<cfinclude template = "actions/actdelete.cfm">
	</cfcase>
	<cfcase value="search">
		<cfinclude template = "forms/frmsearch.cfm">
	</cfcase>
	<cfcase value="add">
		<cfinclude template = "forms/frmadd.cfm">
	</cfcase>
	<cfcase value="insert">
		<cfinclude template = "actions/actadd.cfm">
	</cfcase>
	<cfcase value="top">
		<cfinclude template = "forms/frmtopaffiliates.cfm">
	</cfcase>
	<cfcase value="pay">
		<cfinclude template = "forms/frmpayaffiliates.cfm">
	</cfcase>
	<cfcase value="gopay">
		<cfinclude template = "actions/actpay.cfm">
	</cfcase>
	<cfcase value="banners">
		<cfinclude template = "forms/frmbanners.cfm">
	</cfcase>
	<cfcase value="transactions">
		<cfinclude template = "displays/dsptransactions.cfm">
	</cfcase>	
	<cfcase value="uploadbanner">
		<cfinclude template = "actions/actupload.cfm">
	</cfcase>
	<cfcase value="deletebanner">
		<cfinclude template = "actions/actdeletebanner.cfm">
	</cfcase>
	<cfcase value="payouts">
		<cfinclude template = "forms/frmpayouts.cfm">
	</cfcase>
	<cfcase value="viewpayouts">
		<cfinclude template = "displays/dsppayouts.cfm">
	</cfcase>
	<cfcase value="sellingtools">
		<cfinclude template = "forms/frmsellingtools.cfm">
	</cfcase>
	<cfcase value="updatesellingtools">
		<cfinclude template = "actions/actupdatepage.cfm">
	</cfcase>
	<cfcase value="homepage">
		<cfinclude template = "forms/frmhomepage.cfm">
	</cfcase>
	<cfcase value="updatehomepage">
		<cfinclude template = "actions/actupdatehomepage.cfm">
	</cfcase>
	<cfcase value="select">
		<cfinclude template = "forms/frmselect.cfm">
	</cfcase>

	<cfcase value="menu">
		<cfinclude template = "forms/frmmenu.cfm">
	</cfcase>
	<cfcase value="menu_add">
		<cfinclude template = "forms/frmmenu_add.cfm">
	</cfcase>
	<cfcase value="menu_update">
		<cfinclude template = "actions/actupdatemenu.cfm">
	</cfcase>
	<cfcase value="menu_delete">
		<cfinclude template = "actions/actmenu_delete.cfm">
	</cfcase>
	<cfcase value="menu_edit">
		<cfinclude template = "forms/frmmenu_edit.cfm">
	</cfcase>

	<cfcase value="transactions_insert">
		<cfinclude template = "forms/frminserttrans.cfm">
	</cfcase>
	<cfcase value="transactions_edit">
		<cfinclude template = "forms/frmedittrans.cfm">
	</cfcase>
	<cfcase value="transactions_delete">
		<cfinclude template = "actions/actdeletetrans.cfm">
	</cfcase>

	
	<!---groups--->
	<cfcase value = "groups">
			<cfinclude template = "forms/frmgroups.cfm">	
	</cfcase>
	<cfcase value = "groups.groups">
			<cfinclude template = "forms/frmgroups.cfm">	
	</cfcase>	
	<cfcase value = "groups.update">
			<cfinclude template = "actions/actupdategroup.cfm">	
	</cfcase>
	<cfcase value = "groups.add">
			<cfinclude template = "actions/actaddgroup.cfm">	
	</cfcase>
	<cfcase value = "groups.delete">
			<cfinclude template = "actions/actdeletegroup.cfm">	
	</cfcase>
	<cfcase value = "groups.AssignToGroups">
			<cfinclude template = "forms/frmassigntogroups.cfm">	
	</cfcase>
	<cfcase value = "groups.SaveGroupMembers">
			<cfinclude template = "actions/actassigntogroups.cfm">	
	</cfcase>

	<!---Messages--->
	<cfcase value = "messages">
		<cfinclude template = "forms/frmmessages.cfm">
	</cfcase>
	<cfcase value = "messages.Send">
		<cfinclude template = "actions/actsend.cfm">
	</cfcase>
	<cfcase value = "messages.New">
		<cfinclude template = "forms/frmnew.cfm">
	</cfcase>
	<cfcase value = "messages.View">
		<cfinclude template = "forms/frmviewmessage.cfm">
	</cfcase>
	<cfcase value = "messages.Reply">
		<cfinclude template = "forms/frmreply.cfm">
	</cfcase>
	<cfcase value = "messages.SendReply">
		<cfinclude template = "actions/actsendreply.cfm">
	</cfcase>
	<cfcase value = "messages.delete">
		<cfinclude template = "actions/actdeletemsg.cfm">
	</cfcase>
	<cfcase value = "messages.viewsent">
		<cfinclude template = "forms/frmsentmessages.cfm">
	</cfcase>
	<cfcase value = "messages.viewsentmessage">
		<cfinclude template = "forms/frmviewsentmessage.cfm">
	</cfcase>
	
	<cfcase value = "exporttrans">
		<cfinclude template = "actions/actexportxls.cfm">
	</cfcase>
	<cfcase value = "exporttranscsv">
		<cfinclude template = "actions/actexportcsv.cfm">
	</cfcase>

   
	<cfdefaultcase>
		<cfinclude template = "forms/frmaffiliates.cfm">
	</cfdefaultcase>
</cfswitch>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>





