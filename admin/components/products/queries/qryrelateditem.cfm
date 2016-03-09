<!---Gets info on a related items to display it in the details section--->
<cfquery name = "qryRelatedItem" datasource="#request.dsn#">
SELECT * FROM products
WHERE itemid = #relatedid#
</cfquery>

<!---Get the image file for this one--->
<cfquery name = "qryRelatedImage" datasource="#request.dsn#">
SELECT * FROM products_images
WHERE itemid = #relatedid#
</cfquery>















