<form method="post" action="index.cfm?action=applyborder" name="applyborder" target="_top">
<table width="100%" cellpadding="3" cellspacing="0">
  <tr>
    <td width="40%"> Border Color:</td>
    <td><input name="borderColor" type="text" id="borderColor" size="10" value="#000000" />
      <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=applyborder&amp;field=borderColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false;"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
  </tr>
  <tr>
    <td>Border Thickness: </td>
    <td><input name="borderWidth" type="text" size="7" maxlength="3" value="3" />
      number only (in Pixels)</td>
  </tr>
  <tr>
    <td>Border Type:</td>
    <td><select name="borderType">
    <option value="constant" selected="selected">Selected Color</option>
    <option value="wrap">Tiled Image</option>
    <option value="reflect">Reflection</option>
    <option value="copy">Copy Outter Edge</option> 
    </select>   
    </td>
  </tr>
  <tr>
    <td align="center" colspan="2"><input type="submit" name="SubmitButton" value="Apply"></td>
  </tr>
</table>
</form>
















