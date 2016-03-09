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

<cfinclude template = "../queries/qrynavstyle.cfm">

<form name="colorform" method="post" action="index.cfm?action=updatestyles">
<h2>Menu Styles</h2>
<p>Note: Some styles will only apply to certain menu types. You can also use the style editor to change these styles. <br />
  Also, some styles may get replaced if you are using a theme.</p>
<table width="75%" border="0" align="left" cellpadding="4" cellspacing="0">
	<cfoutput query = "qryNavStyle">	
    <cfdirectory action="list" directory="#request.catalogpath#flashmenus" name="qMenus">
    <tr>
      <td>Select Flash Menu: </td>
      <td><select name="FlashMenuStyle">
        <cfloop query = "qMenus">
        <cfif type IS 'file'>
        	<cfif name CONTAINS '.swf'>
		        <option value="#name#" <cfif qryNavStyle.FlashMenuStyle IS '#name#'>selected="selected"</cfif>>#name#</option>
            </cfif>
        </cfif>
        </cfloop>
      </select> 
        (if using Flash menu)</td>
    </tr>
    
    <tr>
      <td>Background color:        </td>
      <td><input name="mBackgroundColor" type="text" id="mBackgroundColor" size="10" value="#mBackgroundColor#" />
        <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=mBackgroundColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a> For multi-color flash, this is default background color.</td>
    </tr>
    <tr>
      <td>Hover Background color: </td>
      <td><input name="mHoverBackgroundColor" type="text" id="mBackgroundColor2" size="10" value="#mHoverBackgroundColor#" /><a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=mHoverBackgroundColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
    </tr>
    <tr>
      <td>Submenu Background:</td>
      <td><input name="sBackgroundColor" type="text" id="sBackgroundColor" size="10" value="#sBackgroundColor#" /> <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=sBackgroundColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
    </tr>
    <tr>
      <td>Submenu Hover Background:</td>
      <td><input name="sHoverBackgroundColor" type="text" id="sBackgroundColor2" size="10" value="#sHoverBackgroundColor#" /><a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=sHoverBackgroundColor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
    </tr>
    <tr>
      <td>Font Size: </td>
      <td><label>
        <select name="mfontsize" id="mfontsize">
          <option <cfif mfontsize IS '6'>selected="selected"</cfif>>6</option>
          <option <cfif mfontsize IS '7'>selected="selected"</cfif>>7</option>
          <option <cfif mfontsize IS '8'>selected="selected"</cfif>>8</option>
          <option <cfif mfontsize IS '10'>selected="selected"</cfif>>10</option>
          <option <cfif mfontsize IS '11'>selected="selected"</cfif>>11</option>
		  <option <cfif mfontsize IS '12'>selected="selected"</cfif>>12</option>
          <option <cfif mfontsize IS '14'>selected="selected"</cfif>>14</option>
        </select>
      </label></td>
    </tr>
    <tr>
      <td>Font Hover Size: </td>
      <td><select name="mfonthoversize" id="mfonthoversize">
        <option <cfif mfonthoversize IS '8'>selected="selected"</cfif>>6</option>
        <option <cfif mfonthoversize IS '8'>selected="selected"</cfif>>7</option>
        <option <cfif mfonthoversize IS '8'>selected="selected"</cfif>>8</option>
        <option <cfif mfonthoversize IS '10'>selected="selected"</cfif>>10</option>
        <option <cfif mfonthoversize IS '11'>selected="selected"</cfif>>11</option>        
		<option <cfif mfonthoversize IS '12'>selected="selected"</cfif>>12</option>
        <option <cfif mfonthoversize IS '14'>selected="selected"</cfif>>14</option>
      </select></td>
    </tr>
    <tr>
      <td>Font Size: </td>
      <td><label>
        <select name="sfontsize" id="sfontsize">
          <option <cfif sfontsize IS '6'>selected="selected"</cfif>>6</option>
          <option <cfif sfontsize IS '7'>selected="selected"</cfif>>7</option>
          <option <cfif sfontsize IS '8'>selected="selected"</cfif>>8</option>
          <option <cfif sfontsize IS '10'>selected="selected"</cfif>>10</option>
          <option <cfif sfontsize IS '11'>selected="selected"</cfif>>11</option>
		  <option <cfif sfontsize IS '12'>selected="selected"</cfif>>12</option>
          <option <cfif sfontsize IS '14'>selected="selected"</cfif>>14</option>
        </select>
      </label></td>
    </tr>
    <tr>
      <td>Font Hover Size: </td>
      <td><select name="sfonthoversize" id="sfonthoversize">
        <option <cfif sfonthoversize IS '8'>selected="selected"</cfif>>6</option>
        <option <cfif sfonthoversize IS '8'>selected="selected"</cfif>>7</option>
        <option <cfif sfonthoversize IS '8'>selected="selected"</cfif>>8</option>
        <option <cfif sfonthoversize IS '10'>selected="selected"</cfif>>10</option>
        <option <cfif sfonthoversize IS '11'>selected="selected"</cfif>>11</option>        
		<option <cfif sfonthoversize IS '12'>selected="selected"</cfif>>12</option>
        <option <cfif sfonthoversize IS '14'>selected="selected"</cfif>>14</option>
      </select></td>
    </tr>    
    <tr>
      <td>Font Color: </td>
      <td><input name="mfontcolor" type="text" id="mfontcolor" size="10" value="#mfontcolor#" />
        <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=mfontcolor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
    </tr>
    <tr>
      <td>Hover Font Color </td>
      <td><input name="mfonthovercolor" type="text" id="mfonthovercolor" size="10" value="#mfonthovercolor#" />
        <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=mfonthovercolor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
    </tr>
    <tr>
      <td>Font Family: </td>
      <td><label>
        <select name="mfontfamily" id="mfontfamily">
          <option <cfif mfontfamily IS 'Arial, Helvetica, sans-serif'>selected="selected"</cfif>>Arial, Helvetica, sans-serif</option>
          <option <cfif mfontfamily IS 'Times New Roman, Times, serif'>selected="selected"</cfif>>Times New Roman, Times, serif</option>
          <option <cfif mfontfamily IS 'Courier New, Courier, monospace'>selected="selected"</cfif>>Courier New, Courier, monospace</option>
          <option <cfif mfontfamily IS 'Georgia, Times New Roman, Times, serif'>selected="selected"</cfif>>Georgia, Times New Roman, Times, serif</option>
          <option <cfif mfontfamily IS 'Verdana, Arial, Helvetica, sans-serif'>selected="selected"</cfif>>Verdana, Arial, Helvetica, sans-serif</option>
          <option <cfif mfontfamily IS 'Geneva, Arial, Helvetica, sans-serif'>selected="selected"</cfif>>Geneva, Arial, Helvetica, sans-serif</option>
        </select>
      </label></td>
    </tr>
    <tr>
      <td>Font Weight </td>
      <td><select name="mfontweight" id="mfontweight">
        <option <cfif mfontweight IS 'Normal'>selected="selected"</cfif>>Normal</option>
        <option <cfif mfontweight IS 'Bold'>selected="selected"</cfif>>Bold</option>
        <option <cfif mfontweight IS 'Bolder'>selected="selected"</cfif>>Bolder</option>
      </select>      </td>
    </tr>
    
    <tr>
      <td>Menu Items Border Size: </td>
      <td><select name="mbordersize" id="select">
        <option value="0" <cfif mbordersize IS '0'>SELECTED</cfif>>None</option>
				<option value="1" <cfif mbordersize IS '1'>SELECTED</cfif>>1px</option>
        <option value="2" <cfif mbordersize IS '2'>SELECTED</cfif>>2px</option>
        <option value="3" <cfif mbordersize IS '3'>SELECTED</cfif>>3px</option>
        <option value="4" <cfif mbordersize IS '4'>SELECTED</cfif>>4px</option>
        <option value="5" <cfif mbordersize IS '5'>SELECTED</cfif>>5px</option>
            </select></td>
    </tr>
    <tr>
      <td>Menu Items Border Style: </td>
      <td><select name="mborderstyle" id="select2">
        <option value="solid" <cfif mborderstyle IS 'solid'>SELECTED</cfif>>Solid</option>
        <option value="dotted" <cfif mborderstyle IS 'dotted'>SELECTED</cfif>>Dotted</option>
        <option value="dashed" <cfif mborderstyle IS 'dashed'>SELECTED</cfif>>Dashed</option>
        <option value="double" <cfif mborderstyle IS 'double'>SELECTED</cfif>>Double</option>
                  </select></td>
    </tr>
    <tr>
      <td>Menu Items Border Color: </td>
      <td><input name="mbordercolor" type="text" id="bmordercolor" size="10" value="#mbordercolor#" />
        <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=mbordercolor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
    </tr>
    <tr>
      <td>Link Border Size: </td>
      <td><select name="itembordersize" id="itembordersize">
        <option value="0" <cfif itembordersize IS '0'>SELECTED</cfif>>None</option>
				<option value="1" <cfif itembordersize IS '1'>SELECTED</cfif>>1px</option>
        <option value="2" <cfif itembordersize IS '2'>SELECTED</cfif>>2px</option>
        <option value="3" <cfif itembordersize IS '3'>SELECTED</cfif>>3px</option>
        <option value="4" <cfif itembordersize IS '4'>SELECTED</cfif>>4px</option>
        <option value="5" <cfif itembordersize IS '5'>SELECTED</cfif>>5px</option>
      </select></td>
    </tr>
    <tr>
      <td>Link Border Style: </td>
      <td><select name="itemborderstyle" id="itemborderstyle">
        <option value="solid" <cfif itemborderstyle IS 'solid'>SELECTED</CFIF>>Solid</option>
        <option value="dotted" <cfif itemborderstyle IS 'dotted'>SELECTED</CFIF>>Dotted</option>
        <option value="dashed" <cfif itemborderstyle IS 'dashed'>SELECTED</CFIF>>Dashed</option>
        <option value="double" <cfif itemborderstyle IS 'double'>SELECTED</CFIF>>Double</option>
      </select></td>
    </tr>
    <tr>
      <td>Link Border Color: </td>
      <td><input name="itembordercolor" type="text" id="itembordercolor" size="10" value="#mfonthovercolor#" />
        <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=itembordercolor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
    </tr>
    <tr>
      <td>Cell Padding: </td>
      <td><input name="cellpadding" type="text" id="cellpadding" size="5" value="#cellpadding#" />
        px</td>
    </tr>
    <tr>
      <td>Cell Spacing: </td>
      <td><input name="cellspacing" type="text" id="cellspacing" size="5" value="#cellspacing#" />
        px</td>
    </tr>
    <tr>
      <td>Text Alignment: </td>
      <td><select name="TextAlignment" id="TextAlignment">
        <option value="left" <cfif TextAlignment IS 'left'>SELECTED</cfif>>Left</option>
        <option value="right" <cfif TextAlignment IS 'right'>SELECTED</cfif>>Right</option>
        <option value="center" <cfif TextAlignment IS 'center'>SELECTED</cfif>>Center</option>
        <option value="justified" <cfif TextAlignment IS 'justified'>SELECTED</cfif>>Justified</option>
            </select></td>
    </tr>
    <tr>
      <td>Overall Menu Width: </td>
      <td><input name="menuwidth" type="text" id="menuwidth" size="5" value="#menuwidth#" />
      End with % to specify percentage value (default is in px) </td>
    </tr>
    <tr>
      <td>Width of each menu item cell: </td>
      <td><input name="cellwidth" type="text" id="cellwidth" size="5" value="#cellwidth#" />
        px</td>
    </tr>
    <tr>
      <td>Height of each menu item cell: </td>
      <td><input name="cellheight" type="text" id="cellheight" size="5" value="#cellheight#" />
        px</td>
    </tr>
    <tr>
      <td valign="top">Tile Image </td>
      <td>
      <input name="tileImage" type="text" id="tileImage" size="50" value="#tileIMage#" /> <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&fname=colorform&ffield=tileImage')" />	</td>
    </tr>
    <tr>
      <td valign="top">Tile Image Hover </td>
      <td>
         <input name="tileImageHover" type="text" id="tileImageHover" size="50" value="#tileImageHover#" /> <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&fname=colorform&ffield=tileImageHover')" />	  </td>
    </tr>
    
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
		</td>
      <td><input type = "submit" value = "Update Menu" name="submit" /></td>
    </tr>
	</cfoutput>
  </table>   
</form>




















