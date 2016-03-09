<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfinclude template = "../queries/qrybanners.cfm">

<cfif fileexists('#request.CatalogPath#images#request.bslash#banners#request.bslash##qryImages.location#')>
	<cffile action = 'DELETE' file="#request.CatalogPath#images#request.bslash#banners#request.bslash##qryImages.location#">
</cfif>

<cfquery name="qryDeleteBanner" datasource="#request.dsn#">
DELETE FROM afl_banners
WHERE banner_id = #url.bannerid# 
</cfquery>

<cflocation url = "index.cfm?action=banners">














