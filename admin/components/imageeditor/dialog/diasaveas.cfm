<form method="post" action="index.cfm?action=saveas" name="myfuckingform" target="_top">
<cfset cur_step = '#cookie.current_step#_'>
<cfset orig_imagename = replace(cookie.imagefile, cur_step, '')>
<table width="100%" border="0" cellpadding="3" cellspacing="0">
  <tr>
    <td width="20%">File Name:</td>
    <td><cfoutput><input name="imageFilename" type="text" id="imageFilename" value="#orig_imagename#" size="40" maxlength="100"/></cfoutput></td>
  </tr>
  <tr>
    <td align="center" colspan="2">
    <input type="submit" name="SubmitButton" value="Save Image"></td>
  </tr>
</table>
</form>















