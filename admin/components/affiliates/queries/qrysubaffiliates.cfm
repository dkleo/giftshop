<cfquery name="qrySubAffiliates" datasource="#request.dsn#">
SELECT * FROM afl_affiliates 
WHERE subaffiliateof = '#AffiliateID#'
</cfquery>











