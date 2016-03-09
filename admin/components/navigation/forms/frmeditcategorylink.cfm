<cfparam name = "linkimage" default="None">
<cfparam name = "linkrolloverimage" default="None">

<cfinclude template="../queries/qrynavigation.cfm">
<cfinclude template = "../queries/qrynavstyle.cfm">
<cfinclude template = "../queries/qrycategories.cfm">
<cfinclude template = "../queries/qrytopnav.cfm">

<cfif qryCategories.recordcount IS 0>
<h2>There's a Problem</h2>
You need to add categories to your product catalog before you can create category links.

<cfelse>

<cfdirectory action="list" directory="#request.catalogpath#" name="qryTemplates">

<h2>Category Link</h2>
<cfoutput query = "qryNavigation">
<form method="post" enctype="multipart/form-data" name="linkform" id="linkform" <cfoutput>action="index.cfm?action=UpdateCategoryLink&nView=#url.nView#&mView=#url.mView#&level=#level#"</cfoutput>>
  <blockquote>
	Category:
    <select name="Category" size="0" id="Category" style="width: 200px;">
    <option value="0">Top Level (Main Categories)</option>
    <cf_CategoryTree Directory="/"
    Datasource="#request.dsn#"
    FirstIndent="#request.CategoryIndent#"
	SelectedItem="#categoryid#">
    </select>
	<p>Target:
<select name="LinkTarget" id="LinkTarget">
      <option value="_blank" <cfif linktarget IS '_blank'>SELECTED</cfif>>Open in a New Window/Tab</option>
      <option value="_self" <cfif linktarget IS '_self'>SELECTED</cfif>>Open in the Same Window/Tab</option>
    </select
	</p>
	<p>Title To Display (If different from category name):
	  <input name="LinkTitle" type="text" id="LinkTitle" size="25" value="#LinkTitle#" />
	</p>
    When Page Loads Set<br />
    Left Widgets Column: 
    <select name="widgetsleft">
    <option value = "show" <cfif NOT widgetsleft IS 'hide'>selected="selected"</cfif>>Show Left Column Widgets</option>
    <option value="hide" <cfif widgetsleft IS 'hide'>selected="selected"</cfif>>Hide Left Column Widgets</option>
    </select><br />
    Right Widgets Column: 
    <select name="widgetsright">
    <option value = "show" <cfif NOT widgetsright IS 'hide'>selected="selected"</cfif>>Show Right Column Widgets</option>
    <option value="hide" <cfif widgetsright IS 'hide'>selected="selected"</cfif>>Hide Right Column Widgets</option>
    </select>
    <p>Load in Frame?
    <select name="loadinframe">
      <option value = "no" <cfif NOT loadinframe IS 'Yes'>selected="selected"</cfif>>No</option>
      <option value = "Yes" <cfif loadinframe IS 'Yes'>selected="selected"</cfif>>Yes</option>
    </select>  
    <p>Use SSL?
<select name="UseSSL" id="UseSSL">
      <option value = "No" <cfif UseSSL IS 'No'>SELECTED</cfif>>No</option>
      <option value = "Yes" <cfif UseSSL IS 'Yes'>SELECTED</cfif>>Yes</option>
    </select>
	</p>
    <p>Page Template: 
<select name="pagetemplate">
      <option value = "index.cfm" <cfif pagetemplate IS 'index.cfm'>selected="selected"</cfif>>Main Template (index.cfm)</option>
      <cfloop query = "qryTemplates">
        <cfif qryTemplates.type IS 'file'>
          <cfif qryTemplates.name CONTAINS 'index_' AND NOT qryTemplates.name IS 'index.cfm'>
            <option value = "#name#" <cfif pagetemplate IS '#name#'>selected="selected"</cfif>>#name#</option>
          </cfif>
        </cfif>
      </cfloop>
    </select>
    </p>
<p>Sub Link of: <select name = "sublinkof">
			<option value = "0" <cfif sublinkof IS '0'>SELECTED</cfif>>None</option>
			<cfloop query = "qryTopNav">
                <cfinclude template = "../queries/qrysubnav.cfm">
				<option value = "#qryTopNav.ID#" <cfif qryNavigation.sublinkof IS '#qryTopNav.ID#'>SELECTED</cfif>>#qryTopNav.LinkTitle#</option>
                <cfloop query = "qrySubNav">
                <option value = "#qrySubNav.ID#" <cfif qryNavigation.sublinkof IS '#qrySubNav.ID#'>SELECTED</cfif>>---#qrySubNav.LinkTitle#</option>
	             </cfloop>
			</cfloop>
			</option>
		</select>    
	<p>
    Color:  <input name="bgColor" type="text" id="bgColor" size="10" value="#bgColor#" />
        <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=linkform&amp;field=bgColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a> (For multicolor flash menu)
	</p>      
<input type = "hidden" value = "None" name = "linkimage" />
<input type = "hidden" value = "None" name = "linkrolloverimage" />
<input type = "hidden" name = "id" value = "#id#" />
<input type = "hidden" name = "LinkType" value = "CategoryLink">
<input type="submit" value="Save Category Link"  />
	</p>
</blockquote></form>  
</cfoutput>
</cfif>



















