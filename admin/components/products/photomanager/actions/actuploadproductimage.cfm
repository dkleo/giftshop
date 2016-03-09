<!---Upload an image for the specific product--->
<cfinclude template = "../../queries/qrycompanyinfo.cfm">
<cfinclude template = "../../queries/qryitemimages.cfm">

<!---Get the next ordervalue for this image--->
<cfset LastOrderValue = 0>
<cfoutput query = "qry_Images">
	<cfset LastOrderValue = #OrderValue#>
</cfoutput>

<cfset NextOrderValue = LastOrderValue + 1>

<!---Upload the image--->

<!---if they selected a file from their computer, upload it.--->
<cfif len(form.productimage) GT 0>

    <CFFILE	Action="upload"
    FileField = "form.productimage"
    Destination = "#request.CatalogPath#photos#request.bslash#large#request.bslash#"
    nameconflict="overwrite"
    Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg, image/png"
    mode="777">
                
    <cfset photo = "#cffile.ServerFile#">
    <cfset thumb = "#cffile.ServerFile#">
    <cfset processimage = 'true'>
<cfelse>
	<!---otherwise use the file specified in the selector box--->
	<cfif len(form.prod_image) GT 0>
		<cfset photo = "#form.prod_image#">
        <cfset thumb = "#form.prod_image#">
	    <cfset processimage = 'false'>
	<cfelse>
    	nothing found!
        <cfabort>
    	<cflocation url = "dophotomanager.cfm?action=productimages&ItemID=#ItemID#&wasdoing=#wasdoing#">
    </cfif>
</cfif>

<!---process the image if this was one that was uploaded.  If it's selected, we don't need to process the image.--->
<cfif processimage IS 'true'>
	<cfinclude template = "actprocessimage.cfm">
</cfif>

<!---since it was only selected, just read the image--->
<cfif processimage IS 'false'>
	<cfinclude template = "actreadimage.cfm">
</cfif>

<!---Insert the information into the database--->
<cfquery name = "qry_InsertImageInfo" datasource = "#request.dsn#">
INSERT INTO products_images
(iFileName, Itemid, iHeight, iWidth, thumbHeight, thumbWidth, tinyHeight, tinyWidth, Ordervalue, mediumheight, mediumwidth)
VALUES
('#photo#', '#url.itemid#', '#iHeight#', '#iWidth#', '#ithumbHeight#', '#ithumbWidth#', '#itinyHeight#', '#itinyWidth#', #NextOrderValue#, '#imediumheight#', '#imediumwidth#')
</cfquery>

<!---If the imageurl in the db is set to nopic.jpg then update it to this one (products table) to keep a record of the primary image--->
<cfquery name = "qryPrimary" datasource="#request.dsn#">
SELECT * FROM products
WHERE itemid = #url.itemid#
</cfquery>

<cfset theimageurl = 'Nothing'>

<cfoutput query = "QryPrimary">
	<cfset theimageurl = #imageURL#>
</cfoutput>

<cfif theimageurl IS 'nopic.jpg'>
	<cfquery name = "UpdatePrimary" datasource="#request.dsn#">
	UPDATE products SET imageURL = '#photo#',
    Thumbnail = '#photo#'
	WHERE itemid = #url.itemid#
	</cfquery>
</cfif>

<cflocation url = "dophotomanager.cfm?action=search&itemid=#url.itemid#&wasdoing=#url.wasdoing#">