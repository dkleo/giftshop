<cfparam name = "linkimage" default="None">
<cfparam name = "linkrolloverimage" default="None">

<cfinclude template="../queries/qrynavigation.cfm">
<cfinclude template="../queries/qrytopnav.cfm">

<cfdirectory action="list" directory="#request.catalogpath#docs#request.bslash#" name="qryPages">
<cfdirectory action="list" directory="#request.catalogpath#" name="qryTemplates">

<h2>Site Link</h2>
<form method="post" enctype="multipart/form-data" name="linkform" id="linkform" <cfoutput>action="index.cfm?action=updateSiteLink&nView=#url.nView#&mView=#url.mView#&level=#level#"</cfoutput>>
<input name="FILENAME_LinkFile" type="hidden" value="" />
<input name="PATH_LinkFile" type="hidden" value="" />
<input name="LinkFile" type="hidden" value="" />
<cfset startdir = urlencodedformat('#request.bslash#docs#request.bslash#')>
<cfloop query = "qryNavigation">
<table width="100%" cellpadding="4" cellspacing="0" border="0">
<tr>
<td width="20%">Page:</td>
<td>
<select name = "page">
	<cfoutput query = "qryPages">
	<cfif type IS 'file'>
    	<option value="#name#" <cfif qryNavigation.filename IS '#name#'>selected="selected"</cfif>>#name#</option>
    </cfif>
	</cfoutput>
    </select></td>
</tr>
<tr>
<td>Link Title:</td>
<td><cfoutput><input name="LinkTitle" type="text" id="LinkTitle" size="25" value="#linktitle#" /></cfoutput></td>
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
<td>Use SSL?</td>
<td>
<select name="UseSSL" id="UseSSL">
  <option value = "No" <cfif qryNavigation.UseSSL IS 'no'>selected="selected"</cfif>>No</option>
  <option value = "Yes" <cfif qryNavigation.UseSSL IS 'yes'>selected="selected"</cfif>>Yes</option>
</select></td>
<tr>
<td>Link Target:</td>
<td><select name="LinkTarget" id="LinkTarget">
<option <cfif qryNavigation.LinkTarget IS '_blank'>SELECTED="selected"</cfif> value="_blank">Open in a New Window/Tab</option>
<option <cfif qryNavigation.LinkTarget IS '_self'>SELECTED="selected"</cfif> value="_self" SELECTED>Open in the Same Window/Tab</option>
</select></td>
</tr>
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
				<cfoutput><option value = "#qryTopNav.ID#" <cfif qryNavigation.sublinkof IS '#qryTopNav.ID#'>SELECTED</cfif>>#qryTopNav.LinkTitle#</option></cfoutput>
                <cfloop query = "qrySubNav">
                <cfoutput><option value = "#qrySubNav.ID#" <cfif qryNavigation.sublinkof IS '#qrySubNav.ID#'>SELECTED</cfif>>---#qrySubNav.LinkTitle#</option></cfoutput>
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
<td colspan="2">
<input type = "hidden" value = "none" name="linkimage" id="linkimage">
<input type = "hidden" value = "none" name="linkrolloverimage" id="linkrolloverimage">
<input type = "hidden" value = "" name="PageTitle">
<input type = "hidden" value = "" name="metadescription">		
<input type = "hidden" value = "" name="metakeywords">	
<cfif isdefined('url.pLinkID')>
	<input type = "hidden" name = "pLinkID" value = "#url.pLinkID#" />
</cfif>
<input type = "hidden" name = "LinkType" value = "PageLink">
<cfoutput><input type = "hidden" name = "id" value = "#url.id#" /></cfoutput>
<input type="submit" value="Update Site Link"  /></td>
</tr>
</table>
</cfloop>
</form>




















