<cfinclude template = "../queries/qrywidgets.cfm">
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

<h2><strong>Widget</strong> Settings </h2>
<cfoutput query = "qryWidgets">
<form name = "customwidget" action="dosetup.cfm" method="post">
  <table width="750" border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td>Widget Name </td>
    <td><cfif candelete NEQ 'Yes'>
	#widgetname# <input name="widgetname" type="hidden" id="widgetname" value="#widgetname#" />
	<cfelse>
	<input name="widgetname" type="text" id="widgetname" value="#widgetname#" />
	</cfif>	</td>
    <td width="200" rowspan="7" valign="top"><p>Custom CSS <cfoutput><a href = "#request.AdminPath#helpdocs/widgetbox_custom_css.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></p>
      <p>
        <textarea name="custom_styles" id="custom_styles" cols="25" rows="10">#custom_styles#</textarea>
      </p>
      <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td width="30%">Title:</td>
    <td><input name="widgettitle" type="text" id="widgettitle" value="#widgettitle#"></td>
    </tr>
  <tr>
    <td>Title Image:</td>
    <td><input name="title_image" type="text" id="title_image" value="#title_image#" /> <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&fname=customwidget&ffield=title_image')"></td>
  </tr>
  <tr>
    <td>Show Title? </td>
    <td><select name="showtitle" id="showtitle">
      <option <cfif showtitle NEQ 'No'>SELECTED</cfif>>Yes</option>
      <option <cfif showtitle EQ 'No'>SELECTED</cfif>>No</option>
    </select>    </td>
    </tr>
  <tr>
    <td>Visible?</td>
    <td><select name="isvisible" id="isvisible">
      <option <cfif isvisible NEQ 'No'>SELECTED</cfif>>Yes</option>
      <option <cfif isvisible EQ 'No'>SELECTED</cfif>>No</option>
    </select></td>
    </tr>
  <tr>
    <td>Position:</td>
    <td><select name="widgetposition" id="widgetposition">
      <option <cfif widgetposition NEQ 'Right'>SELECTED</cfif>>Left</option>
      <option <cfif widgetposition EQ 'Right'>SELECTED</cfif>>Right</option>
        </select></td>
    </tr>
  
  <tr>
    <td>Description:</td>
    <td>
	<cfif candelete NEQ 'Yes'>
		#widgetdesc# <input type = "hidden" name = "widgetdesc" value="#widgetdesc#" />
	<cfelse>
	<textarea name="widgetdesc" cols="45" rows="3" id="widgetdesc">#widgetdesc#</textarea>
	</cfif></td>
    </tr>
<cfif widgetfile IS 'Custom'>
  <tr>
    <td colspan="3">HTML Code:</td>
  </tr>
  <tr>
    <td colspan="3">
    
    <textarea name="widgetcode" style="width:100%; height: 400px;">#widgetcode#</textarea></td>
  </tr>
<cfelse>
	<input type = "hidden" name = "widgetcode" value = ""> 
</cfif>
</table>
<input name = "id" type="hidden" value="#id#">
<input name = "action" type="hidden" value="UpdateWidget">
<input type="submit" name="submitbutton" value="Update Widget">
</form>
</cfoutput>

<cfoutput>
<script type="text/javascript">
	CKEDITOR.replace( 'widgetcode',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'
	});
</script>
</cfoutput>