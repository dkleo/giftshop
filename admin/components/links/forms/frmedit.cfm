<cfinclude template="../queries/qrylinks.cfm">

<form method="POST" action="dolinks.cfm" enctype="multipart/form-data">
  <hr>
  <h4><strong>Edit Link</strong></h4>
<cfoutput query = "qrylinks">
  <div align="left">
    <table width="75%" border="0" cellpadding="4" cellspacing="0" id="AutoNumber1">
      <tr>
        <td width="21%">Order Value</td>
        <td width="79%" colspan="2">
        <input type="text" name="LinkOrder" size="4" value="#LinkOrder#">
        (Determines what order links are displayed 
        in)</td>
      </tr>
      <tr>
        <td width="21%">
        <p align="left">Link Title:</td>
        <td width="79%" colspan="2">
        <input type="text" name="LinkTitle" size="49" value="#LinkTitle#"></td>
      </tr>
      <tr>
        <td width="21%">URL:</td>
        <td width="79%" colspan="2">
        <input type="text" name="LinkRef" size="49" value="#LinkRef#"></td>
      </tr>
      <tr>
        <td width="21%">Target:</td>
          <td width="79%" colspan="2"> 
            <select name="LinkTarget" id="LinkTarget">
              <option value="_Blank" <cfif LinkTarget IS '_Blank'>selected</cfif>>New Window</option>
              <option value="None" <cfif LinkTarget IS ''>SELECTED</cfif>>None</option>
              <option value="None" <cfif LinkTarget IS 'iFrame'>SELECTED></cfif>>iFrame</option>
            </select>          </td>
      </tr>
      <tr>
        <td width="21%">Description:</td>
        <td width="79%" colspan="2"><textarea rows="5" name="LinkDescription" cols="41">#LinkDescription#</textarea></td>
      </tr>
      <tr>
        <td>Replace Image:</td>
        <td><input name="FileContents" type="file" id="filefield" size="40" /></td>
        <td width="200" rowspan="2"><cfif NOT linkimage IS 'None'><img name="linkimage#linkid#" id="linkimage#linkid#" src = "#request.HomeURL#photos/#LinkImage#" border="0" <cfif NOT #LinkRImage# IS 'none'>onmouseover="this.src='#request.HomeURL#photos/#LinkRImage#';" onmouseout="this.src='#request.HomeURL#photos/#LinkImage#';"</cfif>></cfif></td>
      </tr>
      <tr>
        <td>Replace Rollover Image: </td>
        <td><input name="FileContents2" type="file" id="FileContents" size="40" /></td>
        </tr>
      <tr>
        <td>Remove Image? </td>
        <td colspan="2"><label>
          <select name="removeimage" id="removeimage">
            <option selected="selected">No</option>
            <option>Yes</option>
          </select>
        </label></td>
      </tr>
    </table>
  </div>
<input type="Hidden" value="#LinkID#" Name="LinkID">
<input type="Hidden" value="#LinkImage#" Name="LinkImage">
<input type="Hidden" value="#LinkRImage#" Name="LinkRImage">
<input type="hidden" value="Update" Name="Action">
<p><input type="submit" value="Update Link" name="B1"></p>
</cfoutput>
</form>





















