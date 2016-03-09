<cfinclude template = "../queries/qrylinks.cfm">
<cfinclude template = "../queries/qrypages.cfm">

<cfset NewLinkOrder = 0>
<!---Find the last link order number and add one to it--->
<hr>
<strong><font size="4">Site Links</font></strong> 
<p>Use the form below to add pages you have created using the Content Manager 
    into the &quot;Additional Information&quot; section of you website.</p>

<cfoutput query = "qryLinks"> 
  <cfset NewLinkOrder = #LinkOrder#>
</cfoutput>
<cfset NewLinkOrder = NewLinkOrder + 1>
<form method="POST" action="dolinks.cfm" enctype="multipart/form-data">
  <div align="left">
    <table width="100%" border="0" cellpadding="4" cellspacing="0" id="AutoNumber1">
      <tr> 
        <td width="20%" height="43">Order Value</td>
        <td width="48%"> <cfoutput> 
            <input type="text" name="LinkOrder" size="4" value="#NewLinkOrder#">
          </cfoutput> <br>
          (Determines what order links are displayed in)</td>
        <td width="32%" rowspan="10" valign="top"><p>&nbsp;</p>          </td>
      </tr>
      <tr>
        <td>Link Title: </td>
        <td><input name="LinkTitle" type="text" id="LinkTitle" size="25" /></td>
      </tr>
      <tr> 
        <td width="20%"><p>Page:</p>
          <p>&nbsp;</p></td>
        <td width="48%"><p>
            <p> 
              <select name="FileLink" size="8" style="width: 250px;">
              <option value="NONE" selected="selected">---Choose a page or component---</option>
              <cfoutput query = "qryPages"> 
                <option value = "index.cfm?Page=docs/#name#">#name#</option>
              </cfoutput> 
			  <option value = "index.cfm?action=sitemap">Your site map</option>
			  <option value = "index.cfm?action=showblog">Your blog</option>
              <option value = "index.cfm?action=view">View Cart Link</option>
              <option value = "index.cfm?action=myaccount">My Account Link</option>
              <option value = "index.cfm?action=contactform_show">Contact Form</option>
            </select>
            </p>		</td>
      </tr>
      <tr> 
        <td width="20%" height="82">Target:</td>
        <td width="48%"><select name="LinkTarget" id="LinkTarget">
            <option value="InTemplate" selected>Put page In Template</option>
            <option value="New">Open in New Window</option>
          </select>        </td>
      </tr>
      <tr>
        <td>Right Widgets Column: </td>
        <td><select name="widgetsright">
            <option value = "show" selected="selected">Show Right Column Widgets</option>
            <option value="hide">Hide Right Column Widgets</option>
          </select></td>
      </tr>
      <tr>
        <td>Left Widgets Column:</td>
        <td><select name="widgetsleft">
          <option value = "show" selected="selected">Show Left Column Widgets</option>
          <option value="hide">Hide Left Column Widgets</option>
        </select></td>
      </tr>
      <tr> 
        <td width="20%">Description <br>
          (For your info only):</td>
        <td width="48%"><textarea rows="4" name="LinkDescription" cols="41"></textarea></td>
      </tr>
      <tr>
        <td>Image:</td>
        <td><input name="FileContents" type="file" id="filefield" size="40" /></td>
      </tr>
      <tr>
        <td>Rollover Image: </td>
        <td><input name="FileContents2" type="file" id="FileContents" size="40" /></td>
      </tr>
    </table>
  </div>
<input type = "hidden" name = "action" value="AddSiteLink">
<p><input type="submit" value="Add Link" name="B1"></p>
</form>
<p><b>Current Links (Click on one to edit it)</b></p>
<div align="center">
  <center>
    <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="101%" id="AutoNumber2" cellpadding="6">
      <tr> 
        <td width="10%" bgcolor="#000080"> <p align="center"><font color="#FFFFFF"><b>Order 
            Value</b></font></td>
        <td width="19%" bgcolor="#000080"> <p align="left"><font color="#FFFFFF"><b> 
            Link Name</b></font></td>
        <td width="46%" bgcolor="#000080"><font color="#FFFFFF"><b> URL</b></font></td>
        <td width="11%" bgcolor="#000080"><font color="#FFFFFF"><b> Target</b></font></td>
      </tr>
      <cfoutput query = "qryLinks"> 
        <tr> 
          <td width="10%"> 
            <p align="center">#LinkOrder#</td>
          <td width="19%"> 
            <p align="left"> <a href="doLinkManager.cfm?action=Edit&LinkID=#LinkID#">#LinkTitle#</a></td>
          <td width="46%">#LinkRef#</td>
          <td width="11%">#LinkTarget#</td>
        </tr>
      </cfoutput> 
    </table>
  </center>
</div>




















