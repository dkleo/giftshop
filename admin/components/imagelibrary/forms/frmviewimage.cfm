<cfparam name = "name" default="none.jpg">
<cfparam name = "dir" default="/">
<cfparam name = "searchtxt" default="">
<cfparam name = "start" default="1">
<cfparam name = "disp" default="40">

<cfif NOT isdefined("form.newwidth")>
	<cfinclude template = "../actions/actreadimage.cfm">
<cfelse>
	<cfinclude template = "../actions/actresize.cfm">    
</cfif>

<cfparam name = "request.homeURL" default="#request.HomeURL#images/">
<cfoutput>
<table width="100%" cellpadding="4" cellspacing="0">
<tr>
	<td colspan="3"><h2>#url.name#</h2></td>
</tr>
<tr>
	<td width="15%"><a href = "doimagelibrary.cfm?dir=#url.dir#&start=#start#&disp=#disp#&searchtxt=#searchtxt#">Go Back</a></td>
  <td width="71%" valign="top">
  <!---if they have a supported custom tag for resizing images installed show the resize form--->
  <cfif NOT request.ImageProcessor IS 'None'>
  <cfform name = "resizeimageform" action="doimagelibrary.cfm?action=viewimage&dir=#dir#&filename=#name#&name=#name#" method="post">
    <p>QUICK RESIZE: 
      Current Size: <cfoutput>#iwidth#x#iheight# pixels</cfoutput> &nbsp;&nbsp;&nbsp;New Size:
      <cfinput name="newwidth" type="text" id="textfield5" size="10" required="no" /> 
      X 
      <cfinput name="newheight" type="text" id="textfield6" size="10" required="no" /> 
      (Width x Height in pixels) 
      <input type = "submit" name="resizeimagebutton" value="Resize" />
</p>
    <p>Note: Because your browser will probably cache images, the image will appear as though it was not resized even though it has it been.</p>
  </cfform>
</cfif></td>
  <td width="14%" valign="bottom"><div align="right"><a href="##" onclick="getElementById('msg_div').style.display = 'block';">Advanced Image Editor</a></div></td>
</tr>
<tr>
  <td colspan="3"><div id="msg_div" style="display: none;">Want to use the Advanced Image editor? You will need to purchase the cfimageeffect.cfc from   <a href="http://foundeo.com/image-effects/" target="_blank">http://foundeo.com/image-effects/</a>  It is not open source and cannot be distributed with this application.<br />
    Upload it to your /admin/components/photoeditor/actions/ folder, and you will be able to use the more advanced image editing utility. Here is what you will be able to do:</p>
    <ul>
      <li>Crop</li>
      <li>Resize</li>
      <li>Increase/Decrease brightness</li>
      <li>Add a drop shadow</li>
      <li>Add a reflection</li>
      <li>Create a plastic effect</li>
      <li>Create rounded corners</li>
      <li>Add borders</li>
      <li>Apply a Sepia Tone</li>
      <li>Convert to Gray Scale</li>
      <li>Save your edited image to a new file name</li>
      </ul>
    <p><a href = "##" onclick="getElementById('msg_div').style.display = 'none';">Close this message</a></p></td>
</tr>
<tr>
	<td colspan="3">
      <a href = "doimagelibrary.cfm?dir=#url.dir#"><img src = "#request.homeURL#images/#name#" border="0"></a>	</td>
</tr>
</table>
</cfoutput>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">





















