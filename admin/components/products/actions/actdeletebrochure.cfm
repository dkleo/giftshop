<!---deletes a brochure--->
<cfquery name = "qryDeleteBrochure" datasource="#request.dsn#">
DELETE FROM brochures
WHERE id = #url.id#
</cfquery>
















