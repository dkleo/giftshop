<form method="post" action="index.cfm?action=roundedcorners" name="applyroundedcorners" target="_top">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td width="40%">Background Color: </td>
    <td><input name="backgroundColor" type="text" id="backgroundColor" size="10" value="#FFFFFF"/>
      <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=applyroundedcorners&amp;field=backgroundColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
  </tr>
  <tr>
    <td>Corner Size:</td>
    <td><input name="cornersize" type="text" size="15" maxlength="3" value="20" required="yes" message="Please enter a corner size!"/>
      number only</td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">
      <input type="submit" name="SubmitButton" value="Apply">
    </div></td>
  </tr>
</table>
</form>
















