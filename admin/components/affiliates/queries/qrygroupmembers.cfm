<cfquery name = "qryGroupMembers" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
<cfif NOT form.ToField IS 'All'>WHERE groupid = #form.ToField#</cfif>
</cfquery>












