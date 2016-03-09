<cftry>
<link rel="stylesheet" type="text/css" href="../../controlpanel.css">
<Page href="../../ControlPanel.css" rel="stylesheet" type="text/css">
<cfparam name="action" default="">

<cfswitch expression="#action#">
    <cfcase value = 'NewPage'>
      <cfinclude template='forms/frmadd.cfm'>
    </cfcase>
    <cfcase value = 'AddPage'>
      <cfinclude template='actions/actadd.cfm'>
    </cfcase>
     <cfcase value = 'DeletePage'>
      <cfinclude template = 'actions/actdelete.cfm'>
    </cfcase>
     <cfcase value = 'EditPage'>
      <cfinclude template = 'forms/frmedit.cfm'>
    </cfcase>
    <cfcase value = 'UpdatePermissions'>
      <cfinclude template = 'actions/actupdatepermissions.cfm'>
    </cfcase>         
	<cfcase value = 'UpdatePage'>
      <cfinclude template = 'actions/actupdate.cfm'>
    </cfcase>
	<cfcase value = 'setpassword'>
      <cfinclude template = 'forms/frmpassword.cfm'>
    </cfcase>
	<cfcase value = 'findreplace'>
      <cfinclude template = 'forms/frmfindreplace.cfm'>
    </cfcase>
	<cfdefaultcase>
    	<cfinclude template = "forms/frmpagemanager.cfm">
	</cfdefaultcase>
</cfswitch>    

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>
</cftry>







