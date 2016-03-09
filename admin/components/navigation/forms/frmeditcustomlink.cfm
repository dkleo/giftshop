<cfinclude template="../queries/qrynavigation.cfm">
<cfinclude template = "../queries/qrytopnav.cfm">
<p>
<h2>Editing a Custom Link</h2>
<cfoutput query = "qryNavigation">
<form name = "linkform" id="linkform" method="post" action="index.cfm?action=UpdateCustomLink&nView=#url.nView#&mView=#url.mView#&level=#level#">
<table width="516" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td>Link Title:</td>
    <td><input name="LinkTitle" type="text" id="LinkTitle3" size="25" value = "#LinkTitle#" /></td>
  </tr>
  <tr>
    <td>Link URL:</td>
    <td><input name="LinkURL" type="text" id="LinkURL2" size="65" value = "#LinkURL#" /></td>
  </tr><tr>
    <td>Link Target:</td>
    <td><select name="LinkTarget" id="LinkTarget">
      <option value="_blank" <cfif linktarget IS '_blank'>SELECTED</cfif>>Open in a New Window/Tab</option>
      <option value="_self" <cfif linktarget IS '_self'>SELECTED</cfif>>Open in the Same Window/Tab</option>
      </select></td>
  </tr>
  <tr>
    <td>Sublink Of:</td>
    <td colspan="2"><select name = "sublinkof">
      <option value = "0" <cfif sublinkof IS '0'>SELECTED</cfif>>None</option>
      <cfloop query = "qryTopNav">
        <cfinclude template = "../queries/qrysubnav.cfm">
        <option value = "#qryTopNav.ID#" <cfif qryNavigation.sublinkof IS '#qryTopNav.ID#'>SELECTED</cfif>>#qryTopNav.LinkTitle#</option>
        <cfloop query = "qrySubNav">
          <option value = "#qrySubNav.ID#" <cfif qryNavigation.sublinkof IS '#qrySubNav.ID#'>SELECTED</cfif>>---#qrySubNav.LinkTitle#</option>
        </cfloop>
      </cfloop>
    </select></td>
  </tr>
  <tr>
    <td>Color:</td>
	<td colspan="2"><input name="bgColor" type="text" id="bgColor" size="10" value="#bgColor#" />
        <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=linkform&amp;field=bgColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a> (For multicolor flash menu)</td>
  </tr>
   <tr>
    <td colspan="2">    
  	<input type = "hidden" value = "None" name = "linkimage" />
	<input type = "hidden" value = "None" name = "linkrolloverimage" />
    <input type = "hidden" name = "LinkImage" value = "#LinkImage#">
  	<input type = "hidden" name = "LinkRolloverImage" value = "#LinkRolloverImage#">
	<input type="hidden" name="id" value="#id#">
    <input type="submit" name="Submit" value="Update Link" /></td>
  </tr>
</table>
</form>
</cfoutput>
<p>



















