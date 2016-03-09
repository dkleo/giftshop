<form method="post" action="index.cfm?action=plastic" name="applyplastic" target="_top">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td width="40%">Background Color:</td>
    <td><input name="backgroundColor" type="text" id="backgroundColor4" size="10" value="#FFFFFF"/>
      <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=applyplastic&amp;field=backgroundColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
  </tr>
  <tr>
    <td>Start Opacity:</td>
    <td><input name="textfield3" type="text" id="textfield3" value="60" size="10" maxlength="2" />
      number only</td>
  </tr>
  <tr>
    <td>End Opactiy:</td>
    <td><input name="textfield4" type="text" id="textfield4" value="20" size="10" maxlength="2" />
      number only</td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">
      <input type="submit" name="SubmitButton" value="Apply">
    </div></td>
  </tr>
</table>
</form>

















