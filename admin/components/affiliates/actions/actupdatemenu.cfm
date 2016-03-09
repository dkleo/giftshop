<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---updates the order values of the menu items--->
<cfloop from = "1" to="#listlen(form.ids)#" index="fcount">
	<cfset this_id = listgetat(form.ids, fcount)>
	<cfset this_orderval = listgetat(form.ordervalue, fcount)>
	
    <cfquery name="qUpdateOrder" datasource="#request.dsn#">
    UPDATE afl_menu SET ordervalue = #this_orderval#
    WHERE id = #this_id#
    </cfquery>

</cfloop>

<cflocation url = "index.cfm?action=menu">