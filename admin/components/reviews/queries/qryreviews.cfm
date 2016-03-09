<cfquery name = "qryReviews" datasource="#request.dsn#">
SELECT * FROM product_reviews
<cfif isdefined('url.id')>WHERE id = #url.ID#
<cfelse>
WHERE approved = '#viewtype#'
</cfif>
</cfquery>















