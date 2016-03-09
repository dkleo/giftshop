<cfif fileexists("#request.downloadspath##url.filename#")>
	<cffile action="delete" file = "#request.downloadspath##url.filename#">
</cfif>

<cfquery name = "qry_DelAttachment" datasource="#request.dsn#">
DELETE FROM product_files
WHERE id = #url.id#
</cfquery>

<cflocation url = "doproducts.cfm?action=downloads&itemid=#url.itemid#">















