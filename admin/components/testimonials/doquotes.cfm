<!---Mall News and Updates--->
<link href="../../controlpanel.css" rel="stylesheet" type="text/css">
<cfparam name = "action" default="default">

<cfswitch expression="#action#">
	<cfcase value = "default">
		<cfinclude template = "forms/frmQuotes.cfm">	
	</cfcase>
    <cfcase value = "new">
        <cfinclude template = "forms/frmadd.cfm">
    </cfcase>
    <cfcase value = "edit">
	        <cfinclude template = "forms/frmedit.cfm">	
    </cfcase>
    <cfcase value = "publish">
        	<cfinclude template = "actions/actPublish.cfm">	
    </cfcase>
    <cfcase value = "delete">
        	<cfinclude template = "actions/actdelete.cfm">	
    </cfcase>
    <cfcase value = "update">
        	<cfinclude template = "actions/actupdate.cfm">	
    </cfcase>
	<cfdefaultcase>
		<cfinclude template = "forms/frmQuotes.cfm">
	</cfdefaultcase>
    
</cfswitch>







