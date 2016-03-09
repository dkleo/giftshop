<!---Queries the list of types of support they can choose from a list of what the problem is--->
<cfquery name = "qryTypes" datasource="#request.dsn#">
SELECT * FROM support_types
</cfquery>
















