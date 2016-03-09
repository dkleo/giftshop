<!---queries all file attachments for this product--->
<cfif isdefined('qryProducts.itemid')>
	<cfquery name = "qry_Attachments" datasource="#request.dsn#">
	SELECT * FROM products_files
	WHERE itemid = '#qryProducts.Itemid#'
	</cfquery>
</cfif>

<cfif isdefined('filename')>
	<cfquery name = "qry_Duplicates" datasource="#request.dsn#">
	SELECT * FROM products_files
	WHERE filename = '#filename#'
	</cfquery>
</cfif>
















