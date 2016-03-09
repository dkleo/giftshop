<cfquery name = "qryAffiliates" datasource = "#request.dsn#">
SELECT * FROM afl_affiliates
<cfif NOT viewgroup IS 'All'>
   Where groupid = '#viewgroup#'
	<cfif NOT len(searchbox) IS 0>
		AND lastname LIKE '%#searchbox#%' OR 
		groupid = '#viewgroup#' AND firstname LIKE '%#searchbox#%' OR 
		groupid = '#viewgroup#' AND affiliateid LIKE '%#searchbox#%'
	</cfif>
</cfif>
<cfif viewgroup IS 'All'>
	<cfif NOT len(searchbox) IS 0>
		WHERE lastname LIKE '%#searchbox#%' OR firstname LIKE '%#searchbox#%' OR 
		affiliateid LIKE '%#searchbox#%'
	</cfif>
</cfif>
ORDER BY #sortby# #sortorder#
</cfquery>











