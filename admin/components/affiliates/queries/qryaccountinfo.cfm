<cfquery name = "qryAccount" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateid = '#affiliateid#'
</cfquery>











