<cfimage action="info" source="#request.catalogpath#temp#request.bslash##cookie.imagefile#" structname="imginfo">

<form method="post" action="index.cfm?action=resize" name="resizeform" target="_top">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>Current Size:</td>
    <td><cfoutput>Width: #imginfo.width#  Height: #imginfo.height# pixels</cfoutput></td>
  </tr>
  <tr>
    <td width="40%">New Width:</td>
    <td><cfoutput><input name="newwidth" type="text" id="newwidth" size="10" value="#imginfo.width#" /></cfoutput></td>
  </tr>
  <tr>
    <td>New Height:</td>
    <td><cfoutput><input name="newheight" type="text" id="newwidth" size="10" value="#imginfo.height#" /></cfoutput></td>
  </tr>
  <tr>
    <td>Resize by:</td>
    <td><select name="resizeby" id="resizeby">
      <option selected="selected">pixels</option>
      <option>percentage</option>
    </select></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">
      <input type="submit" name="SubmitButton" value="Apply">
    </div></td>
  </tr>
</table>
</form>
















