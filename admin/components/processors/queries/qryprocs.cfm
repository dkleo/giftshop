<cfquery name = "qProcs" datasource="#request.dsn#">
SELECT * FROM cfsk_processors
ORDER BY p_adminname ASC
</cfquery>