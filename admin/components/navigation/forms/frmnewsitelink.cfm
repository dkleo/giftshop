<script>
function OpenFileBrowser( url )
{
	var winwidth = ( screen.width * .95);
	var winheight = ( screen.height * .7);
	var iLeft = 1 ;
	var iTop  = 1;

	var sOptions = "toolbar=no,status=yes,resizable=yes,dependent=yes" ;
	sOptions += ",width=" + winwidth ;
	sOptions += ",height=" + winheight ;
	sOptions += ",left=" + iLeft ;
	sOptions += ",top=" + iTop ;

	window.open( url, 'FileBrowserWindow', sOptions ) ;
}

function SetUrl(fileurl,thePath,theFileName,layout,formname,formfield) 
{
 var dspdiv = 'dspLinkURL_'+formfield;
 var file_name = 'FILENAME_'+formfield;
 var file_path = 'PATH_'+formfield;
 document.getElementById(dspdiv).innerHTML = fileurl;
 document.forms[formname].elements[formfield].value = fileurl ;
 if(document.forms[formname].elements[file_path]){
	document.forms[formname].elements[file_path].value = thePath ;
  }
 if(document.forms[formname].elements[file_name]){
	 document.forms[formname].elements[file_name].value = theFileName ;
 }

}
</script>

<cfparam name = "linkimage" default="None">
<cfparam name = "linkrolloverimage" default="None">

<cfinclude template = "../queries/qrynavstyle.cfm">
<cfdirectory action="list" directory="#request.catalogpath#docs#request.bslash#" name="qryPages">
<cfdirectory action="list" directory="#request.catalogpath#" name="qryTemplates">

<h2>Add Site Link</h2>
<form method="post" enctype="multipart/form-data" name="linkform" id="linkform" <cfoutput>action="index.cfm?action=addLink&nView=#url.nView#&mView=#url.mView#&level=#level#"</cfoutput>>
<input name="FILENAME_LinkFile" type="hidden" value="" />
<input name="PATH_LinkFile" type="hidden" value="" />
<input name="LinkFile" type="hidden" value="" />
<cfset startdir = urlencodedformat('#request.bslash#docs#request.bslash#')>
<p>Page: <select name = "page">
		<option value = "None" selected="selected">-------Select a Page----------</option>
	<cfoutput query = "qryPages">
	<cfif type IS 'file'>
    	<option value="#name#">#name#</option>
    </cfif>
	</cfoutput>
    </select>
<p>Link Title:
<input name="LinkTitle" type="text" id="LinkTitle" size="25" />
</p>
<p>Load in Frame?
  <select name="loadinframe">
    <option value = "no" SELECTED="selected">No</option>
    <option value = "Yes">Yes</option>
  </select>
</p>
<p> Use SSL?
<select name="UseSSL" id="UseSSL">
  <option value = "No" selected="selected">No</option>
  <option value = "Yes">Yes</option>
</select>
</p>
<p>Widgets: 
  <select name="widgetsright">
      <option value = "show" selected="selected">Show Left Column Widgets</option>
      <option value="hide">Hide Left Column Widgets</option>
    </select> 
    <select name="widgetsleft">
      <option value = "show" selected="selected">Show Right Column Widgets</option>
      <option value="hide">Hide Right Column Widgets</option>
    </select>
</p>
<p>Page Template:
  <select name="pagetemplate">
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
Link Target:
<select name="LinkTarget" id="LinkTarget">
<option value="_blank">Open in a New Window/Tab</option>
<option value="_self" SELECTED>Open in the Same Window/Tab</option>
</select>
	<p>
    Color:  <input name="bgColor" type="text" id="bgColor" size="10" value="" />
        <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=linkform&amp;field=bgColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a> (For multicolor flash menu)
	</p>  
<!---<p>
Page Title: <input name="pagetitle" type="text" id="pagetitle" size="45" />
<p>
Meta Description:<br />
<textarea name="metadescription" cols="35" rows="5" id="metadescription"></textarea>                    
<p>
Meta Keywords: <br />
<textarea name="metakeywords" cols="35" rows="5" id="metakeywords"></textarea>
</p>--->
<input type = "hidden" value = "none" name="linkimage" id="linkimage">
<input type = "hidden" value = "none" name="linkrolloverimage" id="linkrolloverimage">
<input type = "hidden" value = "" name="PageTitle">
<input type = "hidden" value = "" name="metadescription">		
<input type = "hidden" value = "" name="metakeywords">	
<cfoutput>
<cfif isdefined('url.pLinkID')>
	<input type = "hidden" name = "pLinkID" value = "#url.pLinkID#" />
</cfif>
<input type = "hidden" value = "#url.ov#" name="OrderValue" />
</cfoutput>
<input type = "hidden" name = "LinkType" value = "PageLink">
<p>
  <input type="submit" value="Add Site Link"  />
  </blockquote>
</form>



















