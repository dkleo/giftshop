<cfquery name = "qrySubAffiliate" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateid = '#Subaffiliateid#'
</cfquery>











