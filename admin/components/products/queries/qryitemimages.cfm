<cfquery name = "qry_Images" datasource="#request.dsn#">
SELECT * FROM products_images
<cfif isdefined('url.itemid') AND NOT isdefined('thisitemid')>WHERE itemid = '#url.itemid#'</cfif>
<cfif isdefined('thisitemid')>WHERE itemid = '#thisitemid#'</cfif>
ORDER BY OrderValue ASC
</cfquery>
















