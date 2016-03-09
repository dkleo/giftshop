<!---Assigns or removes members to and from a group--->

<!---First, remove from groups--->
<cfif isdefined('form.removeditems')>
	<cfloop from = "1" to="#listlen(form.removeditems)#" index="itemcount">
		<cfset thisitem = #listgetat(form.removeditems, itemcount)#>

        <cfquery name = "deletefromgroup" datasource="#request.dsn#">
        DELETE FROM nl_membersingroup
        WHERE memberid = #thisitem#
        AND groupid = #form.assignto#
        </cfquery>
    </cfloop>
</cfif>

<!---If the selecteditems form field exists, then loop over the values and update their group list--->
<cfif isdefined('form.selecteditems')>
	<cfloop from = "1" to="#listlen(form.selecteditems)#" index="itemcount">
		<cfset thisitem = listgetat(form.selecteditems, itemcount)>

		<cfquery name = "qInsertIntoGroup" datasource="#request.dsn#">
        INSERT INTO nl_membersingroup
        (groupid, memberid)
        VALUES
        (#form.assignto#, #thisitem#)
        </cfquery>
		
	</cfloop>
</cfif>
<center><b>Group Assignments were saved.</b></center>
<p>
<cfoutput><center><a href = "index.cfm?action=newsletter.manage.assigntogroups&mytoken=#mytoken#">Go Back</a></cfoutput>



















