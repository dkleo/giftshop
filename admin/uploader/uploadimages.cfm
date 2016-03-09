<!---Upload an image for the specific product--->
<cftry>

<cfset dir = 'photos#request.bslash#large#request.bslash#'>
<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfinclude template = "../components/products/queries/qryitemimages.cfm">

<!---Get the next ordervalue for this image--->
<cfset LastOrderValue = 0>
<cfoutput query = "qry_Images">
	<cfset LastOrderValue = #OrderValue#>
</cfoutput>

<cfset NextOrderValue = LastOrderValue + 1>

<!---Upload the image--->

<CFFILE	Action="Upload"
FileField = "FileData"
Destination = "#request.CatalogPath##dir#"
NameConflict = "overwrite"
mode="777">

<!---strip out any bad characters--->
<cfset thefile = cffile.serverfile>

<cfset thefile = replace(thefile, " ", "_", "ALL")>
<cfset thefile = replace(thefile, "&", "", "ALL")>
<cfset thefile = replace(thefile, "(", "", "ALL")>
<cfset thefile = replace(thefile, ")", "", "ALL")>
<cfset thefile = replace(thefile, "?", "", "ALL")>
<cfset thefile = replace(thefile, "<", "", "ALL")>
<cfset thefile = replace(thefile, ">", "", "ALL")>
<cfset thefile = replace(thefile, "@", "", "ALL")>
<cfset thefile = replace(thefile, "!", "", "ALL")>
<cfset thefile = replace(thefile, "*", "", "ALL")>
<cfset thefile = replace(thefile, "^", "", "ALL")>
<cfset thefile = replace(thefile, "%", "", "ALL")>
<cfset thefile = lcase(thefile)>

<cfset fullDespath = "#request.catalogpath##dir##request.bslash##thefile#">
<cfset fullDespath = replacenocase(FullDesPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfset fullFrompath = "#request.catalogpath##dir##request.bslash##cffile.serverfile#">
<cfset fullFrompath = replacenocase(FullFromPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfif NOT thefile IS cffile.serverfile>
    <cffile action = "rename" source = "#fullfrompath#" destination = "#fulldespath#" mode="777">
</cfif>
          
<cfset photo = "#thefile#">
<cfset thumb = "#thefile#">

<!---process the image--->
<cfinclude template = "../components/products/photomanager/actions/actProcessImage.cfm">

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
	UPDATE products SET imageURL = '#photo#'
	WHERE itemid = #url.itemid#
	</cfquery>
</cfif>

<cfcatch type = "any">
	<cfinclude template = "../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>



