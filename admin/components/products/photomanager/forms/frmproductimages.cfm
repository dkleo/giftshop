<cfparam name = "wasdoing" default="products">
<cfparam name = "sortoption" default="Inactive">

<script language="javascript">
function OpenFileBrowser( url )
{
	var winwidth = ( screen.width * .8);
	var winheight = ( screen.height * .8);
	var iLeft = ( screen.width  - winwidth ) / 2 ;
	var iTop  = ( screen.height - winheight ) / 2 ;

	var sOptions = "toolbar=no,status=yes,resizable=yes,dependent=yes,scrollbars=1" ;
	sOptions += ",width=" + winwidth ;
	sOptions += ",height=" + winheight ;
	sOptions += ",left=" + iLeft ;
	sOptions += ",top=" + iTop ;

	window.open( url, 'FileBrowserWindow', sOptions ) ;
}

function SetUrl(fileurl,formname,formfield) 
{
 document.forms[formname].elements[formfield].value = fileurl ;
}
</script>

<cfinclude template = "../../queries/qryitemimages.cfm">
<cfinclude template = "../../queries/qrycompanyinfo.cfm">
<cfinclude template = "../../queries/qryproducts.cfm">

<cfset request.ImagesURL = '#request.HomeURL#photos/'>

<h4>Upload Images for <cfoutput>#qryProducts.ProductName# (#qryProducts.ProductID#)</cfoutput></h4>
<p>Use this form to upload images for a specific product. The first image is always the primary one.<br />
  <span style="font-weight: bold">Note: For subitems, only the first image is used.</span></p>
<form <cfoutput>action="dophotomanager.cfm?itemid=#url.itemid#&wasdoing=#wasdoing#"</cfoutput> method="post" enctype="multipart/form-data" name="form1" id="form1">
		<input name="productimage" type="file" id="productimage" size="45">
		<cfif request.ImageProcessor IS 'None'> Large Image <br />
		<input name="mediumfile" type="file" id="mediumfile" size="45"> Medium Image<br />
		<input name="smallfile" type="file" id="smallfile" size="45"> Small Image <br />
		<input name="tinyfile" type="file" id="tinyfile" size="45"> Tiny Image (Should be 75x75) <br />
		</cfif>
        <input type="hidden" name="action" value="Uploadproductpic" />
	    <input type="submit" name="Submit" value="Upload">
  </p> or select one: <input name="prod_image" type="text" id="prod_image" size="35" value="" /> 
      <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('dophotomanager.cfm?action=browse&fname=form1&ffield=prod_image')"> <input type="submit" name="Submit" value="Add"> 
      <p>
      <cfoutput><span style="font-weight: bold"><a href = "dophotomanager.cfm?action=multiProdupload&itemid=#url.itemid#&wasdoing=#wasdoing#">Or Click Here To Upload Multiple Images At Once</a></span></cfoutput>
<cfif qry_Images.recordcount IS 0>
		You do not have any images uploaded for this product yet
	<cfelse>
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr>
          <td align="center" valign="top"><cfoutput query = "qry_Images" maxrows="1"> 
					<a href = "#request.ImagesURL#large/#iFileName#" target="_blank" name="ImageLink" id="ImageLink"><img src = "#request.ImagesURL#small/#iFileName#" name="ImageFilePic" id="ImageFilePic" border="0"></a> </cfoutput></td>
        </tr>
        <tr>
          <td align="center" valign="middle">Image shown is the thumbnail<br>(click to view actual image in seperate window)</td>
        </tr>
      </table>
      </td>
      <td width="50%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr>
          <td><b>More Images</b> (click on one to view it) </td>
        </tr>
        <tr>
          <td><cfset piccount = 0>
              <table>
							<tr>
							<cfoutput query = "qry_Images">
							<cfset piccount = piccount + 1>
							<td align="center">
							<table width="100%">
							<tr>
							<td align="center" valign="middle" height="100">
              <img src="#request.ImagesURL#tiny/#iFileName#" <cfif ordervalue GT 1>border="0"</cfif> <cfif ordervalue IS 1>border="3"</cfif> style="cursor:pointer" onclick="ImageFilePic.src = '#request.ImagesURL#Small/#iFileName#'; document.getElementById('ImageLink').href='#request.ImagesURL#Large/#iFileName#';" />
							</td>
							</tr>
							<tr>
							<td align="center">
							<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
							<td width="34%">
							<cfif qry_Images.currentrow GT 1><a href = "dophotomanager.cfm?action=moveleft&id=#id#&itemid=#url.itemid#&iFilename=#iFileName#&sortoption=#sortoption#"><img src="icons/arrow_back_16.gif" border="0" alt="Move image left" title="Move image left"></a></cfif>
							</td>
							<td width="34%">
							<a href = "dophotomanager.cfm?action=delete&id=#id#&itemid=#url.itemid#&iFilename=#iFileName#&sortoption=#sortoption#"><img src="icons/del_16.gif" border="0" alt="Delete image" title="Delete image"></a>
							</td>
							<td width="34%">
							<cfif NOT qry_Images.CurrentRow IS qry_Images.RecordCount><a href = "dophotomanager.cfm?action=moveright&id=#id#&itemid=#url.itemid#&iFilename=#iFileName#&sortoption=#sortoption#"><img src="icons/arrow_next_16.gif" border="0" alt="Move image right" title="Move image right"></a></cfif>
							</td>
							</tr>
							</table>
							</td>
							</tr>
							</table>
							<cfif piccount IS 4></tr><tr><cfset piccount = 0></cfif>
							</td>
							</cfoutput>
							</tr>
		</table> 
					</td>
        </tr>
      </table></td>
    </tr>
  </table>
	</cfif>
</form>
	<p>
	<cfif wasdoing IS 'products'>
	<cfoutput><a href = "../doproducts.cfm">Back to Catalog</a></cfoutput></p>
</cfif>
	<cfif wasdoing IS 'images'>
	<cfoutput><a href = "dophotomanager.cfm?action=multipleupload">Back to Uploading Images</a></cfoutput></p>
</cfif>
































