<form method="post" action="index.cfm?action=reflection" name="applyreflection" target="_top">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td width="40%">Background Color:</td>
    <td><input name="backgroundColor" type="text" id="backgroundColor" size="10" value="#FFFFFF"/>
      <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=applyreflection&amp;field=backgroundColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
  </tr>
  <tr>
    <td>Mirror Height:</td>
    <td><input name="mirrorheight" type="text" id="mirrorheight" size="10" value="120" maxlength="3" />
      number only</td>
  </tr>
  <tr>
    <td>Start Opacity:</td>
    <td><input name="startopacity" type="text" id="startopacity" size="10" value="30" maxlength="2" />
      number only</td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">
      <input type="submit" name="SubmitButton" value="Apply">
    </div></td>
  </tr>
</table>
















