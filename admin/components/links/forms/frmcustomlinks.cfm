<cfinclude template = "../queries/qrylinks.cfm">
<cfinclude template = "../queries/qrypages.cfm">

<cfset NewLinkOrder = 0>
<!---Find the last link order number and add one to it--->
<hr>
<strong><font size="4">Custom Link</font></strong> 
<p>Create your link using the form below.</p>
<cfoutput query = "qryLinks"> 
  <cfset NewLinkOrder = #LinkOrder#>
</cfoutput>
<cfset NewLinkOrder = NewLinkOrder + 1>
<form method="POST" action="dolinks.cfm" enctype="multipart/form-data">
  <div align="left">
    <table width="100%" border="0" cellpadding="4" cellspacing="0" id="AutoNumber1">
      <tr> 
        <td width="20%" height="43"><strong>Order Value</strong></td>
        <td width="50%"> <cfoutput> 
            <input type="text" name="LinkOrder" size="4" value="#NewLinkOrder#">
          </cfoutput> <br>
          (Determines what order links are displayed in)</td>
        <td width="30%" rowspan="5" valign="top"><p>&nbsp;</p>          </td>
      </tr>
      <tr> 
        <td width="20%"> <p align="left"><strong>Link Title:</strong></td>
        <td width="50%"><input type="text" name="LinkTitle" size="49"></td>
      </tr>
      <tr> 
        <td width="20%"><p><strong>URL:</strong></p>
          <p>&nbsp;</p></td>
        <td width="50%"> <p>
            <input type="text" name="LinkRef" size="49" value="http://"><br>
		  	<input type="hidden" name="FileLink" Value="None">
		</td>
      </tr>
      <tr> 
        <td width="20%" height="82"><strong>Target:</strong></td>
        <td width="50%"><select name="LinkTarget" id="LinkTarget">
            <option value="Same">Same Window (Full Page)</option>
            <option value="New" selected>New Window</option>
            <option value="Frame">In an iFrame with the template</option>
          </select>        </td>
      </tr>
      <tr> 
        <td width="20%"><strong>Description <br>
          (For your info only)</strong>:</td>
        <td width="50%"><textarea rows="4" name="LinkDescription" cols="41"></textarea></td>
      </tr>
      <tr>
        <td><b>Image:</b></td>
        <td><input name="FileContents" type="file" id="filefield" size="40" /></td>
      </tr>
      <tr>
        <td><b>Rollover Image: </b></td>
        <td><input name="FileContents2" type="file" id="FileContents" size="40" /></td>
      </tr>
    </table>
  </div>
<input type = "hidden" name = "action" value="AddCustomLink">
<p><input type="submit" value="Add Link" name="B1"></p>
</form>
<p><b>Current Links (Click on one to edit it)</b></p>
<div align="center">
  <center>
    <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="101%" id="AutoNumber2" cellpadding="6">
      <tr> 
        <td width="10%" bgcolor="#000080"> <p align="center"><font color="#FFFFFF"><b>Order 
            Value</b></font></td>
        <td width="24%" bgcolor="#000080"> <p align="left"><font color="#FFFFFF"><b> 
            Link Name</b></font></td>
        <td width="42%" bgcolor="#000080"><font color="#FFFFFF"><b> URL</b></font></td>
        <td width="11%" bgcolor="#000080"><font color="#FFFFFF"><b> Target</b></font></td>
      </tr>
      <cfoutput query = "qryLinks"> 
        <tr> 
          <td width="10%"> 
            <p align="center">#LinkOrder#</td>
          <td width="24%"> 
            <p align="left"> <a href="doLinkManager.cfm?action=Edit&LinkID=#LinkID#">#LinkTitle#</a></td>
          <td width="42%">#LinkRef#</td>
          <td width="11%">#LinkTarget#</td>
        </tr>
      </cfoutput> 
    </table>
  </center>
</div>



















