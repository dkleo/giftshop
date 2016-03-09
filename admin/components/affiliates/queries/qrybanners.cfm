<cfquery name="qryImages" datasource="#request.dsn#">
SELECT * FROM afl_banners
<cfif ISDEFINED('url.bannerid')>WHERE banner_id = #url.bannerid#</cfif>
</cfquery>













