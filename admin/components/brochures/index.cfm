<cftry>
<link href="../../controlpanel.css" rel="stylesheet" type="text/css" />
<cfparam name = "action" default="">

<cfswitch expression="#action#">
	<cfcase value="new">
	 <cfinclude template = "forms/frmnew.cfm">   
    </cfcase>
	<cfcase value="add">
 		<cfinclude template = "actions/actadd.cfm">
    </cfcase>
	<cfcase value="delete">
    	<cfinclude template = "actions/actdelete.cfm">
    </cfcase>
	<cfcase value="update">
    	<cfinclude template = "actions/actupdate.cfm">
    </cfcase>
	<cfdefaultcase>
    	<cfinclude template = "forms/frmbrochures.cfm">
    </cfdefaultcase>
</cfswitch>


<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>









