<cfparam name = "linkimage" default="None">
<cfparam name = "linkrolloverimage" default="None">

<cfinclude template="../queries/qrycomponents.cfm">
<cfinclude template = "../queries/qrynavstyle.cfm">

<cfdirectory action="list" directory="#request.catalogpath#" name="qryTemplates">

<h2>Component Link</h2>
<form method="post" enctype="multipart/form-data" name="linkform" id="linkform" <cfoutput>action="index.cfm?action=addLink&nView=#url.nView#&mView=#url.mView#&level=#level#"</cfoutput>>
  <blockquote>
	Name of Component:
	  <select name="PluginID" id="PluginID">
		<cfoutput query = "qryComponents">
		  <option value = "#id#">#name#</option>
		</cfoutput>
	  </select>
	<p>Target:
	  <select name="LinkTarget" id="LinkTarget">
		<option value="_blank">Open in a New Window/Tab</option>
		<option value="_self" selected="selected">Open in the Same Window/Tab</option>
	  </select>
	</p>
	<p>Title To Display:
	  <input name="LinkTitle" type="text" id="LinkTitle" size="25" />
	</p>
    When Page Loads Set<br />
    Right Widgets Column: 
    <select name="widgetsright">
    <option value = "show" selected="selected">Show Right Column Widgets</option>
    <option value="hide">Hide Right Column Widgets</option>
    </select><br />
    Left Widgets Column: 
    <select name="widgetsleft">
    <option value = "show" selected="selected">Show Right Column Widgets</option>
    <option value="hide">Hide Right Column Widgets</option>
    </select>
    <p>Load in Frame?
      <select name="loadinframe">
        <option value = "no" SELECTED="selected">No</option>
        <option value = "Yes">Yes</option>
      </select>
    
    <p>Use SSL?
	  <select name="UseSSL" id="UseSSL">
		<option value = "No" selected="selected">No</option>
		<option value = "Yes">Yes</option>
	  </select>
	</p>
    <p>Page Template: 
    <select name="PageTemplate">
    <option value = "index.cfm" selected="selected">Main Template (index.cfm)</option>
   <cfloop query = "qryTemplates">
        <cfif qryTemplates.type IS 'file'>
            <cfif qryTemplates.name CONTAINS 'index_' AND NOT qryTemplates.name IS 'index.cfm'>
                <option value = "#name#">#name#</option>
            </cfif>
        </cfif>
    </cfloop>
  </select>
    </p>
	<p>
    Color:  <input name="bgColor" type="text" id="bgColor" size="10" value="" />
        <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=linkform&amp;field=bgColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a> (For multicolor flash menu)
	</p>      
<input name="pagetitle" type="hidden" id="pagetitle" size="45" />
	  <input type="hidden" name="metadescription" cols="35" rows="5" id="metadescription">                    
	  <input type = "hidden" name="metakeywords" cols="35" rows="5" id="metakeywords">
	<input type = "hidden" value = "none" name="linkimage" id="linkimage">
	<input type = "hidden" value = "none" name="linkrolloverimage" id="linkrolloverimage">		
	  <cfoutput>
		<input type = "hidden" value = "#url.ov#" name="OrderValue" />
		</cfoutput>
	<input type = "hidden" name = "LinkType" value = "PluginLink">
	  <input type="submit" value="Add Component Link"  />
	</p>
</blockquote></form>  



















