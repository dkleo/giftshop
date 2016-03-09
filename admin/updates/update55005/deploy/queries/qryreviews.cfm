<cfquery name = "qryReviews" datasource="#request.dsn#">
SELECT * FROM product_reviews
WHERE itemid = <cfqueryparam value="#itemid#" cfsqltype="cf_sql_integer"> AND approved = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
<cfif isdefined('start') AND isdefined('disp')>LIMIT #start#,#disp#</cfif>
</cfquery>

<!---get a count--->
<cfquery name = "qTotalReviews" datasource="#request.dsn#">
SELECT count(*) AS totalrecords FROM product_reviews
WHERE itemid = <cfqueryparam value="#itemid#" cfsqltype="cf_sql_integer"> AND approved = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
</cfquery>