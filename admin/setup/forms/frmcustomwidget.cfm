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

<h2><strong>Custom Widget</strong></h2>

<p>You can create your own custom widget. Enter HTML code or copy and paste the code for a widget into the HTML Code box. <br />
You can get widgets at <a href="http://www.widgetbox.com" target="_blank">http://www.widgetbox.com</a></p>
<form name = "customwidget" action="dosetup.cfm" method="post">
<table width="750" border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td>Widget Name: </td>
    <td><input name="widgetname" type="text" id="widgetname" /></td>
    <td width="200" rowspan="6" valign="top"><p>Custom CSS
      <cfoutput><a href = "#request.AdminPath#helpdocs/widgetbox_custom_css.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></p>
      <p>
        <textarea name="custom_styles" id="custom_styles" cols="25" rows="10"></textarea>
        </p></td>
  </tr>
  <tr>
    <td width="30%">Title:</td>
    <td><input name="widgettitle" type="text" id="widgettitle"></td>
    </tr>
  <tr>
    <td>Title Image:</td>
    <td><cfoutput>
      <input name="title_image" type="text" id="title_image" value="" />
    <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&fname=customwidget&ffield=title_image')"></cfoutput></td>
  </tr>
  <tr>
    <td>Show Title? </td>
    <td><select name="showtitle" id="showtitle">
      <option>Yes</option>
      <option>No</option>
    </select>    </td>
    </tr>
  <tr>
    <td>Position:</td>
    <td><select name="widgetposition" id="widgetposition">
      <option>Left</option>
      <option>Right</option>
        </select></td>
    </tr>
  
  <tr>
    <td>Description:</td>
    <td><textarea name="widgetdesc" cols="45" rows="3" id="widgetdesc"></textarea></td>
    </tr>
  <tr>
    <td colspan="3">HTML Code:</td>
  </tr>
  <tr>
    <td colspan="3"><textarea name="widgetcode" id="widgetcode" style="width: 100%; height: 450px;"></textarea></td>
  </tr>
</table>
<input name = "action" type="hidden" value="AddCustomWidget">
<input type="submit" name="submitbutton" value="Create Custom Widget">
</form>


<script type="text/javascript">
	CKEDITOR.replace( 'widgetcode',
	{
		height:"400", width:"100%",
		filebrowserBrowseUrl : '/admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '/admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '/admin/filebrowser/browseflash.cfm'		
	});
</script>
