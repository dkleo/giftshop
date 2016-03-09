<!---Move the image ordervalue up one and the one above it down one to move the image to the left--->

<!---Get this items images--->
<cfinclude template = '../../queries/qryitemimages.cfm'>

<!---Get the ordervalue of the current image--->
<cfquery name = "qryOrderVal" dbtype="query">
SELECT * FROM qry_Images WHERE ID = #url.id#
</cfquery>

<!---Get the value of the one just before this one--->
<cfquery name = "qryValsUnder" dbtype="query">
SELECT * FROM qry_Images WHERE ordervalue < #qryOrderVal.OrderValue#
ORDER BY OrderValue DESC
</cfquery>

<cfset CurrentOrderVal = qryOrderVal.OrderValue>
<cfset CurrentPic = url.id>

<cfoutput query = "qryValsUnder" maxrows="1">
	<cfset OValBefore = #OrderValue#>
	<cfset BeforePic = #id#>
</cfoutput>

<!---Update the ordervalue for the current one--->
<cfquery name = "qryUpdateOrderValThis" datasource="#request.dsn#">
UPDATE products_images
SET ordervalue = #OValBefore#
WHERE id = #CurrentPic#
</cfquery>

<!---Update the ordervalue for the one just above this one--->
<cfquery name = "qryUpdateOrderValBeforeThis" datasource="#request.dsn#">
UPDATE products_images
SET ordervalue = #CurrentOrderVal#
WHERE id = #BeforePic#
</cfquery>

<cflocation url = "dophotomanager.cfm?action=search&itemid=#url.itemid#">































