<!---queries all file attachments for this product--->
<cfquery name = "qryAttachments" datasource="#request.dsn#">
SELECT * FROM product_files
WHERE itemid = '#url.itemid#'
</cfquery>

<cfif isdefined('filename')>
	<cfquery name = "qryDuplicates" datasource="#request.dsn#">
	SELECT * FROM product_files
	WHERE filename = '#filename#'
	</cfquery>
</cfif>
















