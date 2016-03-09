<cfinclude template="../queries/qrynavigation.cfm">
<cfinclude template="../queries/qrycomponents.cfm">
<cfinclude template = "../queries/qrynavstyle.cfm">
<cfinclude template = "../queries/qrytopnav.cfm">

<cfdirectory action="list" directory="#request.catalogpath#" name="qryTemplates">

<h2>Component Link</h2>
<cfoutput query = "qryNavigation">
<form name = "linkform" id="linkform" method="post" action="index.cfm?action=UpdatePluginLink&nView=#url.nView#&mView=#url.mView#&level=#level#">
<table width="500" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="157">Name of Component:</td>
    <td width="327"><cfoutput>
      <select name="PluginID" id="PluginID">
        <cfloop query = "qryComponents">
          <option value = "#id#" <cfif id IS #qryNavigation.pluginid#>SELECTED</cfif>>#name#</option>
        </cfloop>
      </select>
    </cfoutput></td>
  </tr>
  <tr>
    <td>Link Target:</td>
    <td><select name="LinkTarget" id="LinkTarget">
      <option value="_blank" <cfif linktarget IS '_blank'>SELECTED</cfif>>Open in a New Window/Tab</option>
      <option value="_self" <cfif linktarget IS '_self'>SELECTED</cfif>>Open in the Same Window/Tab</option>
    </select></td>
  </tr>
  <tr>
    <td>Link Title: </td>
    <td><cfoutput>
      <input name="LinkTitle" type="text" id="LinkTitle" size="25" value="#LinkTitle#" />
    </cfoutput></td>
  </tr>
    <tr>
      <td>Left Column Widgets:</td>
      <td><select name="widgetsleft">
    <option value = "show" <cfif NOT widgetsleft IS 'hide'>selected="selected"</cfif>>Show Left Column Widgets</option>
    <option value="hide" <cfif widgetsleft IS 'hide'>selected="selected"</cfif>>Hide Left Column Widgets</option>
    </select></td>
    <tr>
      <td>Right Column Widgets:</td>
      <td><select name="widgetsright">
    <option value = "show" <cfif NOT widgetsright IS 'hide'>selected="selected"</cfif>>Show Right Column Widgets</option>
    <option value="hide" <cfif widgetsright IS 'hide'>selected="selected"</cfif>>Hide Right Column Widgets</option>
    </select></td>
    <tr>  
  <tr>
    <td>Use SSL?</td>
    <td><select name="UseSSL" id="UseSSL">
      <option value = "No" <cfif UseSSL IS 'No'>SELECTED</cfif>>No</option>
      <option value = "Yes" <cfif UseSSL IS 'Yes'>SELECTED</cfif>>Yes</option>
    </select></td>
  </tr>
  	<input type = "hidden" value = "None" name = "linkimage" />
	<input type = "hidden" value = "None" name = "linkrolloverimage" />
  <tr>
    <td>Page Template:</td>
    <td colspan="2"><select name="pagetemplate">
      <option value = "index.cfm" <cfif pagetemplate IS 'index.cfm'>selected="selected"</cfif>>Main Template (index.cfm)</option>
      <cfloop query = "qryTemplates">
        <cfif qryTemplates.type IS 'file'>
          <cfif qryTemplates.name CONTAINS 'index_' AND NOT qryTemplates.name IS 'index.cfm'>
            <option value = "#name#" <cfif pagetemplate IS '#name#'>selected="selected"</cfif>>#name#</option>
          </cfif>
        </cfif>
      </cfloop>
    </select></td>
  </tr>
  <tr>
    <td>Load in Frame?</td>
    <td colspan="2">
    <select name="loadinframe">
      <option value = "no" <cfif NOT loadinframe IS 'Yes'>selected="selected"</cfif>>No</option>
      <option value = "Yes" <cfif loadinframe IS 'Yes'>selected="selected"</cfif>>Yes</option>
    </select></td>
  </tr>
    <tr>
    <td>Sublink Of:</td>
	<td colspan="2">
		<select name = "sublinkof">
			<option value = "0" <cfif sublinkof IS '0'>SELECTED</cfif>>None</option>
			<cfloop query = "qryTopNav">
                <cfinclude template = "../queries/qrysubnav.cfm">
				<option value = "#qryTopNav.ID#" <cfif qryNavigation.sublinkof IS '#qryTopNav.ID#'>SELECTED</cfif>>#qryTopNav.LinkTitle#</option>
                <cfloop query = "qrySubNav">
                <option value = "#qrySubNav.ID#" <cfif qryNavigation.sublinkof IS '#qrySubNav.ID#'>SELECTED</cfif>>---#qrySubNav.LinkTitle#</option>
	             </cfloop>
			</cfloop>
			</option>
		</select>	</td>
  </tr>
  <cfoutput>
  <tr>
    <td>Color:</td>
	<td colspan="2"><input name="bgColor" type="text" id="bgColor" size="10" value="#bgColor#" />
        <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=linkform&amp;field=bgColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a> (For multicolor flash menu)</td>
  </tr>  
  </cfoutput>
  <tr>
    <td colspan="2"><cfoutput>
      <div align="center">
        <input type = "hidden" name = "LinkImage" value = "#LinkImage#" />
        <input type = "hidden" name = "id" value = "#id#" />
        <input type = "submit" name="submit" value = "Update Link" />
        </div>
    </cfoutput></td>
  </tr>
</table>
</form>
</cfoutput>



















