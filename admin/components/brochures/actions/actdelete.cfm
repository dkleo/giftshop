<!---deletes a brochure--->
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qryGetBrochureInfo" datasource="#request.dsn#">
SELECT * FROM brochures
WHERE id = #url.id#
</cfquery>

<cfdirectory action="delete" directory="#request.CatalogPath##request.bslash#brochures#request.bslash##qryGetBrochureInfo.name#" recurse="yes">

<cfquery name = "qryDeleteBrochure" datasource="#request.dsn#">
DELETE FROM brochures
WHERE id = #url.id#
</cfquery>

<cflocation url = "index.cfm">



















