<cftry>

<cfif NOT qryLoginCheck.userlevel IS 'admin' AND NOT qryLoginCheck.userlevel IS 'masteradmin'>
	<h2>Users</h2>
    You do not have permissions to edit users.
    <cfabort>
</cfif>
<cfparam name="action" default="">

<cfswitch expression="#action#">
	<cfcase value="add">
		<cfinclude template = "forms/frmadd.cfm">
    </cfcase>
	<cfcase value="edit">
		<cfinclude template = "forms/frmedit.cfm">
    </cfcase>
	<cfcase value="deleteuser">
    	<cfinclude template = "actions/actdelete.cfm">
    </cfcase>
	<cfcase value="updateuser">
	    <cfinclude template = "actions/actupdate.cfm">
    </cfcase>
	<cfcase value="adduser">
	    <cfinclude template = "actions/actadd.cfm">
    </cfcase>
    <cfdefaultcase>
    	<cfinclude template = "forms/frmusers.cfm">
    </cfdefaultcase>
    
</cfswitch>    
 
<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>







