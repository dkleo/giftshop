<!---Move the image ordervalue down one and the one below it up one to move the image to the right--->

<!---Get this items images--->
<cfinclude template = '../../queries/qryitemimages.cfm'>

<!---Get the ordervalue of the current image--->
<cfquery name = "qryOrderVal" dbtype="query">
SELECT * FROM qry_Images WHERE ID = #url.id#
</cfquery>

<!---Get the value of the one just below this one--->
<cfquery name = "qryValsAbove" dbtype="query">
SELECT * FROM qry_Images WHERE ordervalue > #qryOrderVal.OrderValue#
ORDER BY OrderValue ASC
</cfquery>

<cfset CurrentOrderVal = qryOrderVal.OrderValue>
<cfset CurrentPic = url.id>

<cfoutput query = "qryValsAbove" maxrows="1">
	<cfset OValAfter = #OrderValue#>
	<cfset AfterPic = #id#>
</cfoutput>

<!---Update the ordervalue for the current one--->
<cfquery name = "qryUpdateOrderValThis" datasource="#request.dsn#">
UPDATE products_images
SET ordervalue = #OValAfter#
WHERE id = #CurrentPic#
</cfquery>

<!---Update the ordervalue for the one just above this one--->
<cfquery name = "qryUpdateOrderValBeforeThis" datasource="#request.dsn#">
UPDATE products_images
SET ordervalue = #CurrentOrderVal#
WHERE id = #AfterPic#
</cfquery>

<cflocation url = "dophotomanager.cfm?action=search&itemid=#url.itemid#">































