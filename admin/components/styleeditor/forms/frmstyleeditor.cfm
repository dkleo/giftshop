<script language="javascript">
function OpenFileBrowser( url )
{
	var winwidth = ( screen.width * .8);
	var winheight = ( screen.height * .8);
	var iLeft = ( screen.width  - winwidth ) / 2 ;
	var iTop  = ( screen.height - winheight ) / 2 ;

	var sOptions = "toolbar=no,status=yes,resizable=yes,dependent=yes,scrollbars=1" ;
	sOptions += ",width=" + winwidth ;
	sOptions += ",height=" + winheight ;
	sOptions += ",left=" + iLeft ;
	sOptions += ",top=" + iTop ;

	window.open( url, 'FileBrowserWindow', sOptions ) ;
}

function SetUrl(fileurl,formname,formfield) 
{
 document.forms[formname].elements[formfield].value = fileurl ;
}
</script>

<h2>Editing styles for <b><cfoutput>#form.editstyle#</cfoutput></b> tag:</h2>
<p><cfoutput><a href="index.cfm">Cancel and Go Back</a></cfoutput></p>
<p>Tip: You can leave fields blank or select Not Specified  to leave the style declaration out. </p>
<form name="stylesform" method="post" <cfoutput>action="index.cfm?action=settings.customcss.write&isplugin=no"</cfoutput>>
<font color="#000099"><b>Text: </b></font><br>
<div style="border-top: #000000 solid thin;">
  <p><b>Font Family: 
    </b>
    <select name="fontfamily" id="fontfamily">
      <option value = "None" <cfif fontfamily IS ''>SELECTED</cfif>>Not Specified</option>
      <option <cfif fontfamily IS 'Arial, Helvetica, sans-serif'>selected="selected"</cfif>>Arial, Helvetica, sans-serif</option>
      <option <cfif fontfamily IS 'Times New Roman, Times, serif'>selected="selected"</cfif>>Times New Roman, Times, serif</option>
      <option <cfif fontfamily IS 'Courier New, Courier, monospace'>selected="selected"</cfif>>Courier New, Courier, monospace</option>
      <option <cfif fontfamily IS 'Georgia, Times New Roman, Times, serif'>selected="selected"</cfif>>Georgia, Times New Roman, Times, serif</option>
      <option <cfif fontfamily IS 'Verdana, Arial, Helvetica, sans-serif'>selected="selected"</cfif>>Verdana, Arial, Helvetica, sans-serif</option>
      <option <cfif fontfamily IS 'Geneva, Arial, Helvetica, sans-serif'>selected="selected"</cfif>>Geneva, Arial, Helvetica, sans-serif</option>
    </select>
</p>
  <p><b>Font Size:</b> 
    <select name="fontsize" id="fontsize">
			<option value = "None" <cfif fontsize IS ''>selected="selected"</cfif>>Not Specified </option>
      <option <cfif fontsize IS '8px'>selected="selected"</cfif>>8px</option>
      <option <cfif fontsize IS '9px'>selected="selected"</cfif>>9px</option>
      <option <cfif fontsize IS '10px'>selected="selected"</cfif>>10px</option>
      <option <cfif fontsize IS '11px'>selected="selected"</cfif>>11px</option>
      <option <cfif fontsize IS '12px'>selected="selected"</cfif>>12px</option>
      <option <cfif fontsize IS '14px'>selected="selected"</cfif>>14px</option>
      <option <cfif fontsize IS '18px'>selected="selected"</cfif>>18px</option>
      <option <cfif fontsize IS '24px'>selected="selected"</cfif>>24px</option>
			<option <cfif fontsize IS '36px'>selected="selected"</cfif>>36px</option>
      <option <cfif fontsize IS '8pt'>selected="selected"</cfif>>8pt</option>
      <option <cfif fontsize IS '9pt'>selected="selected"</cfif>>9pt</option>
      <option <cfif fontsize IS '10pt'>selected="selected"</cfif>>10pt</option>
      <option <cfif fontsize IS '11pt'>selected="selected"</cfif>>11pt</option>
      <option <cfif fontsize IS '12pt'>selected="selected"</cfif>>12pt</option>
      <option <cfif fontsize IS '14pt'>selected="selected"</cfif>>14pt</option>
      <option <cfif fontsize IS '18pt'>selected="selected"</cfif>>18pt</option>
      <option <cfif fontsize IS '24px'>selected="selected"</cfif>>24pt</option>
			<option <cfif fontsize IS '36px'>selected="selected"</cfif>>26pt</option>
    </select>
</p>
  <p><b>Line Height: 
    </b>
    <cfoutput>
      <input name="lineheight" type="text" size="5" maxlength="2" value="#replacenocase(lineheight, 'px', '', 'ALL')#">
    </cfoutput>
  px</p>
  <p><b>Font Color:</b> <cfoutput>
    <input name="color" type="text" id="color" size="10" maxlength="7" value="#color#" />
  </cfoutput><cfoutput><img src="choosecoloricon.gif" width="24" height="20" style="cursor:pointer;" onclick="JavaScript:window.open('colorchooser.cfm?&form=stylesform&field=color','cal','noresize,width=265,height=225');return false" /></cfoutput></p>
  <p><b>Font Weight:</b> 
    <select name="fontweight" id="fontweight">
      <option value="none" <cfif fontweight IS ''>SELECTED</cfif>>Not Specified</option>
      <option value="normal" <cfif fontweight IS 'normal'>SELECTED</cfif>>Normal</option>
      <option value="bold" <cfif fontweight IS 'bold'>SELECTED</cfif>>Bold</option>
    </select>
  </p>
  <p>
  <b>Decoration:  </b>
  <select name="textdecoration">
    <option value = "none" <cfif textdecoration IS 'none'>SELECTED</cfif>>None</option>
    <option value = "underline" <cfif textdecoration IS 'underline'>SELECTED</cfif>>Underline</option>
    <option value = "overline" <cfif textdecoration IS 'overline'>SELECTED</cfif>>Overline</option>
    <option value = "underline overline" <cfif textdecoration IS 'underline overline'>SELECTED</cfif>>Underline and Overline</option>
  </select>
    <p><b>Text Vertical Alignment: 
              <select name="verticalalign">
                <option <cfif verticalalign IS ''>SELECTED</cfif>>Not Specified (Default)</option>
                <option value="top" <cfif verticalalign IS 'top'>SELECTED</cfif>>Top</option>
                <option value="middle" <cfif verticalalign IS 'middle'>SELECTED</cfif>>Middle</option>
                <option value="bottom" <cfif verticalalign IS 'bottom'>SELECTED</cfif>>Bottom</option>
      </select>
          </b></p>
          <p><b>Text Horizontal Alignment: 
              <select name="textalign" id="textalign">
                <option <cfif textalign IS ''>SELECTED</cfif>>Not Specified (Default)</option>
                <option value="left" <cfif textalign IS 'left'>SELECTED</cfif>>Left</option>
                <option value="center" <cfif textalign IS 'center'>SELECTED</cfif>>Center</option>
                <option value="right" <cfif textalign IS 'right'>SELECTED</cfif>>Right</option>
          </select>
          </b></p>
</div>
<font color="#000099"><b>Background:</b></font>
<div style="border-top: #000000 solid thin;">
<b>Background Color:</b> 
  <cfoutput>
    <input name="backgroundcolor" type="text" id="backgroundcolor" size="10" value="#backgroundcolor#" maxlength="7" />
  </cfoutput><cfoutput><img src="choosecoloricon.gif" width="24" height="20" style="cursor:pointer;" onclick="JavaScript:window.open('colorchooser.cfm?form=stylesform&field=backgroundcolor','cal','noresize,width=265,height=225');return false" /></cfoutput>
<p>
<input type="checkbox" name="useimage" value="useimage" <cfif NOT backgroundimage IS ''>checked</cfif>>Check here to use a background Image</p>
					<p><b>Image:</b>            
					<cfoutput>  <input type = "text" size="20" value = "#backgroundimage#" name="backgroundimage" id="bgImage"> <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&fname=stylesform&ffield=backgroundimage')"></cfoutput>
					<cfoutput>
					  </cfoutput></p>
					<p><b>Background Image Repeat: 
					    <select name="backgroundrepeat">
					      <option <cfif backgroundrepeat IS ''>SELECTED</cfif>>Not Specified</option>
					      <option value="no-repeat" <cfif backgroundrepeat IS 'no-repeat'>SELECTED</cfif>>Do Not Repeat</option>
					      <option value="repeat" <cfif backgroundrepeat IS 'repeat'>SELECTED</cfif>>Repeat</option>
					      <option value="repeat-x" <cfif backgroundrepeat IS 'repeat-x'>SELECTED</cfif>>Horizontal Repeat Only</option>
					      <option value="repeat-y" <cfif backgroundrepeat IS 'repeat-y'>SELECTED</cfif>>Vertical Repeat Only</option>
		        </select>
          </b></p>
          <p><b>Background Image Horizontal Position: 
              <select name="backgroundpositionH">
                <option <cfif NOT backgroundposition CONTAINS 'left' AND NOT backgroundposition CONTAINS 'right' AND NOT backgroundposition CONTAINS 'center'>SELECTED</cfif>>Not Specified (Default)</option>
                <option value="left" <cfif backgroundposition CONTAINS 'left'>selected</cfif>>Left</option>
                <option value="right" <cfif backgroundposition CONTAINS 'right'>selected</cfif>>Right</option>
                <option value="center" <cfif backgroundposition CONTAINS 'center'>selected</cfif>>Center</option>
          </select>
          </b></p>
          <p><b>Background Image Vertical Position: 
              <select name="backgroundpositionV">
                <option <cfif NOT backgroundposition CONTAINS 'top' AND NOT backgroundposition CONTAINS 'middle' AND NOT backgroundposition CONTAINS 'bottom'>SELECTED</cfif>>Not Specified (Default)</option>
                <option value="top" <cfif backgroundposition CONTAINS 'top'>selected</cfif>>Top</option>
                <option value="middle" <cfif backgroundposition CONTAINS 'middle'>selected</cfif>>Middle</option>
                <option value="bottom" <cfif backgroundposition CONTAINS 'bottom'>selected</cfif>>Bottom</option>
              </select>
          </b></p>
</div>
<b><font color="#000099">Box:</font></b>
<div style="border-top: #000000 solid thin;">
  <p><br>
      <b>Padding-Top: 
    <cfoutput>
      <input name="paddingtop" type="text" size="5" maxlength="2" value="#replacenocase(paddingtop, 'px', '', 'ALL')#">
      px<br>
      Padding-Bottom: 
      <input name="paddingbottom" type="text" size="5" maxlength="2" value="#replacenocase(paddingbottom, 'px', '', 'ALL')#">
      px<br>
      Padding-Left: 
      <input name="paddingleft" type="text" size="5" maxlength="2" value="#replacenocase(paddingleft, 'px', '', 'ALL')#">
      px<br>
      Padding-Right: 
      <input name="paddingright" type="text" size="5" maxlength="2" value="#replacenocase(paddingright, 'px', '', 'ALL')#">
      px</b>
      </p>
    </cfoutput></p>
  <p>Height: <cfoutput>
    <input name="height" type="text" size="6" maxlength="4" value="#replacenocase(height, 'px', '', 'ALL')#">
    px<br>
    Width:
    <input name="width" type="text" size="6" maxlength="4" value="#replacenocase(width, 'px', '', 'ALL')#">
    px<br>
  </cfoutput></p>
</div>

					<!---check to see that all three elements of the border definition are present.  If not then ignore the settings--->
					<cfset bordersize = ''>
					<cfset borderstyle = ''>
					<cfset bordercolor = ''>
					<cfset borderstring = #border#>
	<cfif listlen(borderstring, " ") IS 3>
						<cfset bordersize = listgetat(borderstring, 1, " ")>
						<cfif bordersize IS 'thin'>
							<cfset bordersize = '1'>
						</cfif>
						<cfif bordersize IS 'thick'>
							<cfset bordersize = '2'>
						</cfif>
						<cfset borderstyle = listgetat(borderstring, 2, " ")>
						<cfset bordercolor = listgetat(borderstring, 3, " ")> 
	</cfif>
  <font color="#000099"><b>Border:</b></font><b></b>
<div style="border-top: #000000 solid thin;">
          <p><b>Size: </b><b>
            <cfoutput><input name="bordersize" type="text" size="5" maxlength="1" value="#replacenocase(bordersize, 'px', '', 'ALL')#"></cfoutput>
px</b><br>
          <cfoutput><b>Color:</b> 
            <input name="bordercolor" type="text" id="bordercolor" size="10" maxlength="7" value="#bordercolor#" />					</cfoutput>
          <cfoutput><img src="choosecoloricon.gif" width="24" height="20" style="cursor:pointer;" onclick="JavaScript:window.open('colorchooser.cfm?form=stylesform&field=bordercolor','cal','noresize,width=265,height=225');return false" /></cfoutput> <br>
          <b>Style: 
          <select name="borderstyle">
            <option <cfif borderstyle IS ''>SELECTED</cfif>>Not Specified (None)</option>
            <option value="solid" <cfif borderstyle IS 'solid'>SELECTED</cfif>>Solid</option>
            <option value="dotted" <cfif borderstyle IS 'dotted'>SELECTED</cfif>>Dotted</option>
            <option value="dashed" <cfif borderstyle IS 'dashed'>SELECTED</cfif>>Dashed</option>
            <option value="double" <cfif borderstyle IS 'double'>SELECTED</cfif>>Double</option>
          </select>
          </b></p>
</div>
          <p>
            <cfoutput><input type="hidden" name="editstyle" value="#form.editstyle#"></cfoutput>
						<cfoutput><input type="hidden" name="editing" value="#editing#"></cfoutput>
						<input type="submit" name="Submit" value="Update Style">
          </p>
</form>
<!---this form is called from frm_editstyletag.cfm and loads up any values into the fields that might
already be in the stylesheet.--->

















