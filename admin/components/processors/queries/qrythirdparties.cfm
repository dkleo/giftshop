<cfquery name = "qProcs" datasource="#request.dsn#">
SELECT * FROM cfsk_processors
WHERE p_type = '3rdparty'
</cfquery>