<form method="post" action="index.cfm?action=shadow" name="applyshadow" target="_top">
<table width="100%" cellpadding="3" cellspacing="0">
  <tr>
    <td width="40%"> Background Color:</td>
    <td><input name="backgroundColor" type="text" id="backgroundColor" size="10" value="#FFFFFF" />
      <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=applyshadow&amp;field=backgroundColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false;"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
  </tr>
  <tr>
    <td>Shadow Color: </td>
    <td><input name="shadowcolor" type="text" id="shadowcolor" size="10" value="#666666" />
      <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=applyshadow&amp;field=shadowcolor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false;"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
  </tr>
  <tr>
    <td>Shadow Width: </td>
    <td><input name="shadowwidth" type="text" size="15" maxlength="2" value="3" />
      number only</td>
  </tr>
  <tr>
    <td>Shadow Distance: </td>
    <td><input name="shadowwdistance" type="text" size="15" maxlength="2" value="4" />
      number only</td>
  </tr>
  <tr>
    <td align="center" colspan="2"><input type="submit" name="SubmitButton" value="Apply"></td>
  </tr>
</table>
</form>
















