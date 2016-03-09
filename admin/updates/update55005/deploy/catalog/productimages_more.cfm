<cfsavecontent variable="imagetable2">
<cfif qry_AProductImages.recordcount GT 1>
<div class="moreimages_wrapper">
<!---If there is more than one image for this item, display a row of the tiny thumbnails they can click on to get a better view--->
<cfset piccount = 0>
<cfoutput query = "qry_AProductImages">
<cfset piccount = piccount + 1>
	<span class="moreimages_span">
	<img src="#request.secureURL#photos/tiny/#iFileName#" border="0" style="cursor:pointer;" onclick="document.getElementById('ImageFilePic').src='#request.secureURL#photos/medium/#iFileName#'; document.getElementById('LargeImage').value = '#request.secureURL#photos/large/#iFileName#'"></span>
</cfoutput>
</div>
</cfif>
</cfsavecontent>





