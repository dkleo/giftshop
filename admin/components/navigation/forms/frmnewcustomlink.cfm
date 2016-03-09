<cfparam name = "linkimage" default="None">
<cfparam name = "linkrolloverimage" default="None">

<cfinclude template = "../queries/qrynavstyle.cfm">
<cfdirectory action="list" directory="#request.catalogpath#" name="qryTemplates">
 
<form method="post" enctype="multipart/form-data" name="linkform" id="linkform" <cfoutput>action="index.cfm?action=addLink&nView=#nView#&mView=#mView#&level=#level#"</cfoutput>>
<h2>Web Link</h2>
  <blockquote>
	<p>Link Title:
	  <input name="LinkTitle" type="text" id="LinkTitle" size="25" />
	</p>
	<p>Link URL:
	  <input name="LinkURL" type="text" id="LinkURL" size="45" />
	</p>
	<p>Link Target:
	  <select name="LinkTarget" id="LinkTarget">
		<option value="_blank" selected="selected">Open in a New Window/Tab</option>
		<option value="_Self">Open in the Same Window/Tab</option>
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
		<cfif isdefined('url.pLinkID')>
			<input type = "hidden" name = "pLinkID" value = "#url.pLinkID#" />
		</cfif>
		<input type = "hidden" value = "#url.ov#" name="OrderValue" />
		</cfoutput>
		<input type = "hidden" name = "LinkType" value = "CustomLink">
	  <input type="submit" name="Submit2" value="Add Custom Link" />
	</p>

</blockquote>
</form>



















