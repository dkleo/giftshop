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
<h2>Colors and Fonts <cfoutput><a href = "#request.AdminPath#helpdocs/store_colors.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></h2>
<cfinclude template = "../queries/qrystyles.cfm">

<!---You can modify the lists below to change the values of the listboxes--->

<!---Fonts--->
<cfset qryFonts = QueryNew("")>
<cfset FontList = "Arial, Helvetica, sans-serif^Times New Roman, Times, serif^Courier New, Courier, monospace^Georgia, Times New Roman, Times, serif^Verdana, Arial, Helvetica, sans-serif^Geneva, Arial, Helvetica, sans-serif">
<cfset fontarray = listtoarray(FontList, "^")>
<cfset nColumnNumber1 = QueryAddColumn(qryFonts, "fontname", fontarray)>

<!---Font Sizes--->
<cfset qryTextSizes = QueryNew("")>
<cfset TextSizeList ="8pt^8px^10pt^10px^11pt^11px^12pt^12px^14pt^14px^16pt^16px^21pt^21px">
<cfset textsizearray = listtoarray(TextSizeList, "^")>
<cfset nColumnNumber1 = QueryAddColumn(qryTextSizes, "textsize", textsizearray)>

<!---Font Weights--->
<cfset qryFontWeights = QueryNew("")>
<cfset FontWeightsList ="normal^bold^bolder">
<cfset FontWeightsArray = listtoarray(FontWeightsList, "^")>
<cfset nColumnNumber1 = QueryAddColumn(qryFontWeights, "FontWeight", FontWeightsArray)>

<!---Text Decorations--->
<cfset qryDecor = QueryNew("")>
<cfset dList ="none^underline^overline^underline overline">
<cfset dArray = listtoarray(dList, "^")>
<cfset nColumnNumber1 = QueryAddColumn(qryDecor, "decor", dArray)>

<!---Font Styles--->
<cfset qryFontStyles = QueryNew("")>
<cfset FontStylesList ="normal^italics">
<cfset FontStylesArray = listtoarray(FontStylesList, "^")>
<cfset nColumnNumber1 = QueryAddColumn(qryFontStyles, "FontStyle", FontStylesArray)>

<!---Alignments--->
<cfset qryAlign = QueryNew("")>
<cfset AlignList ="left^center^right">
<cfset AlignArray = listtoarray(AlignList, "^")>
<cfset nColumnNumber1 = QueryAddColumn(qryAlign, "Alignment", AlignArray)>

<!---Vertical Alignments--->
<cfset qryvAlign = QueryNew("")>
<cfset vAlignList ="top^middle^bottom">
<cfset vAlignArray = listtoarray(vAlignList, "^")>
<cfset nColumnNumber1 = QueryAddColumn(qryvAlign, "vAlignment", vAlignArray)>

<!---border widths--->
<cfset qryBorderWidths = QueryNew("")>
<cfset BorderWidthsList ="0px^1px^2px^3px^4px^5px">
<cfset BorderWidthsArray = listtoarray(BorderWidthsList, "^")>
<cfset nColumnNumber1 = QueryAddColumn(qryBorderWidths, "BorderWidth", BorderWidthsArray)>

<!---background repeating--->
<cfset qryBGRepeat = QueryNew("")>
<cfset BGRepeatList ="repeat^repeat-x^repeat-y^no-repeat">
<cfset BGRepeatArray = listtoarray(BGRepeatList, "^")>
<cfset nColumnNumber1 = QueryAddColumn(qryBGRepeat, "bgrepeat", BGRepeatArray)>

<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
<script language="JavaScript">
<!--
	function openWin( windowURL, windowName, windowFeatures ) { 
		return window.open( windowURL, windowName, windowFeatures ) ; 
	} 
	
	function previewImg( windowURL, windowName, windowFeatures, textfield ) { 
		var image =  eval("document.forms[0]." + textfield + ".value");
		var openURL = windowURL + "?Image=" + image;
		return window.open( openURL, windowName, windowFeatures ) ; 
	} 
	
		function CancelForm () {
	location.href = "frmcolorprefs.cfm";
	}

// -->
</script>

<!---get the available themes--->
<cfdirectory action="list" directory="#request.catalogpath#themes#request.bslash#" name="themefiles">

<!---get the directories only--->
<cfquery name = "qryFolders" dbtype="query">
SELECT * FROM themefiles
</cfquery>

<cfform Action="dosetup.cfm?action=savetheme" method="POST" name="savethemeform">
  <table width="100%" border="0" align="center" cellpadding="4" cellspacing="0" style="border: 2px #000000 solid;">        
    <!---CREATE A NEW THEME--->
      <tr>
        <td width="35%" bgcolor="#000000"><font color="#FFFFFF"><strong>New Theme <cfoutput><a href = "#request.AdminPath#helpdocs/new_theme.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></strong></font></td>
        <td bgcolor="#000000"><font>&nbsp;</font></td>
      </tr>
      <tr>         
        <td colspan="2"> You can create a new theme from your custom settings below. Enter a name for the theme and click save.</td>
    </tr>
      
      <tr>
        <td bgcolor="#FFFFFF">Name of New Theme :<cfoutput></cfoutput></td>
        <td bgcolor="#FFFFFF"><input type="text" name="newtheme" id="newtheme" /> <cfoutput></cfoutput></td>
      </tr>
      <tr>
        <td bgcolor="#FFFFFF">&nbsp;</td>
        <td bgcolor="#FFFFFF"><span style="color: #FFFFFF">
          <input type="submit" name="SubmitButton2" value="Create New Theme" />
        </span></td>
      </tr>
    </table>
</cfform>

<cfform Action="dosetup.cfm" method="POST" name="colorform">

<cfoutput query = "qryStyles">  

        <table width="100%" border="0" align="center" cellpadding="4" cellspacing="0" style="border: 2px ##000000 solid;">        
		<!---THEME SETTING--->
          <tr>
            <td width="35%" bgcolor="##000000"><font color="##FFFFFF"><strong>Change Theme <a href = "#request.AdminPath#helpdocs/select_or_remove_theme.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></strong></font></td>
            <td bgcolor="##000000"><font>&nbsp;</font></td>
          </tr>
          <tr>         
            <td> Choosing a theme may override some of your settings below:</td>
        <td><cfif themetouse is 'A_Custom_Theme'>Currently Using Custom Settings<cfelse>
            <strong>Currently set to:</strong> #themetoUse#</cfif>
          - <a href="dosetup.cfm?action=choosetheme">Choose</a> <cfif not themetouse is 'A_Custom_Theme'>| <a href = "dosetup.cfm?action=selecttheme&themename=A_Custom_Theme">Remove</a></cfif></td>
          </tr>
          
          <tr>
            <td bgcolor="##FFFFFF">&nbsp;</td>
            <td bgcolor="##FFFFFF">&nbsp;</td>
          </tr>
		 <!---GENERAL SETTINGS--->
		 <!---Website--->
          <tr>
            <td bgcolor="##000000"><span style="color: ##FFFFFF; font-weight: bold">Website </span></td>
            <td bgcolor="##000000"><span style="color: ##FFFFFF">
              <input type="submit" name="SubmitButton" value="Update Style Settings" />
            </span></td>
          </tr>
          <tr>
            <td>Website Background Image (full url):<a href = "#request.AdminPath#helpdocs/website_background_image.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><cfinput name="bgImage_website" type="text" id="bgImage_website" size="50" value="#bgImage_website#" /> 
            <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&fname=colorform&ffield=bgImage_website')"></td>
          </tr>
          <tr>
            <td>Website Background Image Repeat: <a href = "#request.AdminPath#helpdocs/website_background_repeat.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><select name="site_bgrepeat">
              <cfloop query = "qryBGRepeat">
                <option <cfif qryBGRepeat.BGRepeat IS qryStyles.site_bgrepeat>SELECTED</cfif>>#qryBGRepeat.BGRepeat#</option>
              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Background image Horizontal Positioning: <a href = "#request.AdminPath#helpdocs/background_image_horizontal_vertical_position.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><select name="site_bgposition" id="site_bgposition">
              <cfloop query = "qryAlign">
                <option <cfif qryAlign.alignment IS qryStyles.site_bgposition>SELECTED</cfif>>#qryAlign.alignment#</option>
              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Background image Vertical Positioning: 
            <a href = "#request.AdminPath#helpdocs/background_image_horizontal_vertical_position.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><select name="site_bgvposition" id="site_bgvposition">
              <cfloop query = "qryvAlign">
                <option <cfif qryvAlign.valignment IS qryStyles.site_bgvposition>SELECTED</cfif>>#qryvAlign.valignment#</option>
              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Website Background Color: <a href = "#request.AdminPath#helpdocs/website_background_color.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><cfinput name="bgColor_website" type="text" id="bgColor_website" size="10" maxlength="7" value="#bgColor_website#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgColor_website','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /> </a></td>
          </tr>
          <tr>
            <td>Outer Table Position: <a href = "#request.AdminPath#helpdocs/outer_table.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><select name="Align_Container">
			<cfloop query = "qryAlign">
            	<option <cfif qryAlign.alignment IS qryStyles.Align_Container>SELECTED</cfif>>#qryAlign.alignment#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Outer Table Width: <a href = "#request.AdminPath#helpdocs/outer_table.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><cfinput name="Width_Container" type="text" size="10" maxlength="7" value="#Width_Container#" /> 
              (px or %)</td>
          </tr>
          <tr>
            <td>Outer Table Border Width (0 for none): <a href = "#request.AdminPath#helpdocs/outer_table.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><select name="border_contentsize">
			<cfloop query = "qryBorderWidths">
            	<option <cfif qryBorderWidths.BorderWidth IS qryStyles.border_contentsize>SELECTED</cfif>>#qryBorderWidths.BorderWidth#</option>
            </cfloop>
              </select></td>
          </tr>
          <tr>
            <td>Outer Table Border Color: <a href = "#request.AdminPath#helpdocs/outer_table.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><cfinput name="border_contentcolor" type="text" id="border_contentcolor" size="10" maxlength="7" value="#border_contentcolor#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=border_contentcolor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>         
          <tr>
            <td>Body Background Color: <a href = "#request.AdminPath#helpdocs/body_background_color.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><img src = "#request.AdminPath#images/help.gif" border="0" /></a></td>
            <td><cfinput name="bgcolor_body" type="text" id="bgcolor_body" size="10" maxlength="7" value="#bgcolor_body#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_body','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Body Shadow On/Off?: <a href = "#request.AdminPath#helpdocs/body_shadow.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><select name="bodyshadow" id="bodyshadow">
              <option value="On" <cfif bodyshadow IS 'On'>selected="selected"</cfif>>On</option>
              <option value="Off" <cfif NOT bodyshadow IS 'On'>selected="selected"</cfif>>Off</option>
            </select></td>
          </tr>
          <tr>
            <td>Body Shadow Column Width:<a href = "#request.AdminPath#helpdocs/body_shadow.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b> <img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><input name="shadowwidth" type="text" id="shadowwidth" size="7" maxlength="2" value="#shadowwidth#" /> 
            px</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>	  		  
		  <!---Column Headers--->
          <tr>
            <td bgcolor="##000000"><font color="##FFFFFF"><strong>Column 
              Headers <a href = "#request.AdminPath#helpdocs/column_headers.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></strong></font></td>
            <td bgcolor="##000000"><font>
              <input name="SubmitButton" type="submit" id="SubmitButton" value="Update Style Settings" />
            </font></td>
          </tr>
          <tr>
            <td> Colum Headers Text Color </td>
            <td><cfinput name="Textcolor_ColumnHeaders" type="text" id="Textcolor_ColumnHeaders" size="10" maxlength="7" value="#TextColor_ColumnHeaders#" />
            <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=colorform&field=Textcolor_ColumnHeaders','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td> Column Headers Background Color: </td>
            <td><cfinput name="bgColor_ColumnHeaders" type="text" id="bgColor_ColumnHeaders" size="10" maxlength="7" value="#bgColor_ColumnHeaders#"/> <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=colorform&field=bgColor_ColumnHeaders','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20"></a> </td>
          </tr>
          <tr>
            <td>Column Headers Font: <font size="1">&nbsp;</font></td>
            <td><select name="Font_ColumnHeaders">
            <cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.Font_ColumnHeaders#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select>            </td>
          </tr>
          <tr>
            <td>Column Headers Font Size: </td>
            <td><select name="TextSize_ColumnHeaders">
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.TextSize_ColumnHeaders>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select>            </td>
          </tr>
          <tr>
            <td>Column Headers Background Image (url): </td>
            <td><cfinput name="bgImage_ColumnHeaders" type="text" id="bgImage_ColumnHeaders" size="35" value="#bgImage_ColumnHeaders#" />
            <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&fname=colorform&ffield=bgImage_ColumnHeaders')" /></td>
          </tr>
          <tr>
            <td>Column Headers Height [must be in px (pixels]:</td>
            <td><input name="height_columnheaders" type="text" id="height_columnheaders" size="7" value="#height_columnheaders#" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>	  		  
          <tr bgcolor="##000000">
            <td><font color="##FFFFFF"><strong>Default Fonts <a href = "#request.AdminPath#helpdocs/default_fonts.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></strong></font></td>
            <td><font color="##FFFFFF">
              <input name="SubmitButton" type="submit" id="SubmitButton" value="Update Style Settings" />
            </font></td>
          </tr>
          <tr>
            <td>Default Color:</td>
            <td><cfinput name="Textcolor_normal" type="text" id="Textcolor_normal" size="10" maxlength="7" value="#Textcolor_normal#" /><a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=colorform&field=Textcolor_normal','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a> </td>
          </tr>
          <tr>
            <td> Default Size:</td>
            <td><select name="TextSize_Normal" selected="#TextSize_Normal#">
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.TextSize_Normal>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Default Font: </td>
            <td><select name="Font_normal" selected="#font_normal#">
			<cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.Font_normal#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Default Link Color: </td>
            <td><label>
              <cfinput name="Textcolor_Links" type="text" id="Textcolor_Links" size="10" maxlength="7" value="#Textcolor_Links#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=Textcolor_Links','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></label></td>
          </tr>
          <tr>
            <td>Default Link Weight: </td>
            <td><select name="FontWeight_Links">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.FontWeight_Links>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Default Link Size: </td>
            <td><select name="TextSize_Links" selected="#TextSize_Links#">
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.TextSize_Links>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Default Link Font: </td>
            <td><select name="Font_Links" selected="#font_links#">
            <cfloop query = "qryFonts">
                <option <cfif qryFonts.fontname IS #qryStyles.Font_Links#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select>			</td>
          </tr>
          <tr>
            <td>Default Link Background Color: </td>
            <td><cfinput name="bgcolor_links" type="text" id="bgcolor_links" size="10" maxlength="7" value="#bgcolor_links#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_links','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Default Link Hover Color: </td>
            <td><cfinput name="Textcolor_LinksHover" type="text" id="Textcolor_LinksHover" size="10" maxlength="7" value="#Textcolor_LinksHover#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=Textcolor_LinksHover','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Default Link Hover Background Color:</td>
            <td><cfinput name="bgcolor_LinksHover" type="text" id="bgcolor_LinksHover" size="10" maxlength="7" value="#bgcolor_LinksHover#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_LinksHover','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Default Link Decoration: </td>
            <td><select name="TextDecor_Links">
            <cfloop query = "qryDecor">	
                <option <cfif qryDecor.Decor IS qryStyles.TextDecor_Links>SELECTED</cfif>>#qryDecor.Decor#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Default Link Hover Decoration: </td>
            <td><select name="TextDecor_LinksHover">
            <cfloop query = "qryDecor">	
                <option <cfif qryDecor.Decor IS qryStyles.TextDecor_LinksHover>SELECTED</cfif>>#qryDecor.Decor#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
</table>

<!---NAVBAR--->
        <table width="100%" border="0" align="center" cellpadding="4" cellspacing="0" style="border: 2px ##000000 solid;">   
		<!---navbar starts here--->
          <tr bgcolor="##000000">
            <td width="30%"><font color="##FFFFFF"><strong>Navigation Bar <a href = "#request.AdminPath#helpdocs/navigation_bar.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></strong></font></td>
            <td><font color="##FFFFFF">
              <input name="SubmitButton" type="submit" id="SubmitButton" value="Update Style Settings" />
            </font></td>
          </tr>
          <tr>
            <td>Navbar On/Off: </td>
            <td><select name="Display_NavBar" selected="#Display_NavBar#">
              <option value="block" <cfif Display_NavBar IS 'block'>SELECTED</cfif>>Visible</option>
              <option value="none" <cfif Display_NavBar IS 'none'>SELECTED</cfif>>Hide</option>
			</select></td>
          </tr>
          <tr>
            <td> Navbar Text Color: </td>
            <td width="475"><cfinput name="TextColor_Navbar" type="text" id="TextColor_Navbar" size="10" maxlength="7" value="#TextColor_Navbar#" />
              <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=colorform&field=TextColor_Navbar','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Navbar Text Font: </td>
            <td><select name="Font_Navbar" Selected="#Font_Navbar#">
			<cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.Font_Navbar#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Navbar Text Font Size: </td>
            <td><select name="TextSize_NavBar" selected="#TextSize_NavBar#">
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.TextSize_NavBar>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Navbar Text Weight: </td>
            <td><select name="FontWeight_NavBar" selected="#FontWeight_NavBar#">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.FontWeight_NavBar>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Navbar Link Text Color: </td>
            <td><cfinput name="TextColor_NavBarLinks" type="text" id="TextColor_NavBarLinks" size="10" maxlength="7" value="#TextColor_NavBarLinks#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=TextColor_NavBarLinks','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Navbar Link Text Hover Color </td>
            <td width="475"><cfinput name="TextColor_NavBarLinksHover" type="text" id="TextColor_NavBarLinksHover" size="10" maxlength="7" value="#TextColor_NavBarLinksHover#"/>
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=TextColor_NavBarLinksHover','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Navbar Link Text Font: </td>
            <td><select name="Font_NavbarLinks" Selected="#Font_NavbarLinks#">
			<cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.Font_NavbarLinks#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select>            </td>
          </tr>
          <tr>
            <td>Navbar Link Text Size: </td>
            <td><select name="TextSize_NavBarLinks" selected="#TextSize_NavBarLinks#">
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.TextSize_NavBarLinks>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Navbar Link Decoration: </td>
            <td><select name="TextDecor_NavBarLinks">
            <cfloop query = "qryDecor">	
                <option <cfif qryDecor.Decor IS qryStyles.TextDecor_NavBarLinks>SELECTED</cfif>>#qryDecor.Decor#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Navbar Link Background Color: </td>
            <td><cfinput name="bgcolor_navbarlinks" type="text" id="bgcolor_navbarlinks" size="10" maxlength="7" value="#bgcolor_navbarlinks#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_navbarlinks','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Navbar Link Background Hover Color: </td>
            <td><cfinput name="bgcolor_navbarlinkshover" type="text" id="bgcolor_navbarlinkshover" size="10" maxlength="7" value="#bgcolor_navbarlinkshover#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_navbarlinkshover','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Navbar Link Hover Decoration: </td>
            <td><select name="TextDecor_NavbarLinksHover">
            <cfloop query = "qryDecor">	
                <option <cfif qryDecor.Decor IS qryStyles.TextDecor_NavbarLinksHover>SELECTED</cfif>>#qryDecor.Decor#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Navbar Background Color:</td>
            <td><cfinput name="bgcolor_navbar" type="text" id="bgcolor_navbar" size="10" maxlength="7" value="#bgcolor_navbar#" />
              <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=colorform&field=bgcolor_navbar','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a> </td>
          </tr>
          <tr>
            <td>Navbar Background Image (Overrides color): </td>
            <td><cfinput name="bgimage_navbar" type="text" id="bgimage_navbar" size="50" value="#bgimage_navbar#" /> <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&amp;fname=colorform&amp;ffield=bgimage_navbar')" /></td>
          </tr>
          <tr>
            <td>Navbar Link Weight: </td>
            <td><select name="fontweight_navbarlinks">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.fontweight_navbarlinks>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Navbar Height: [must be in px (pixels]</td>
            <td><input name="height_navbar" type="text" id="height_navbar" size="7" value="#height_navbar#" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td width="475">&nbsp;</td>
          </tr>
</table>		

<!---WIDGETS--->
        <table width="100%" border="0" align="center" cellpadding="4" cellspacing="0" style="border: 2px ##000000 solid;"> 		
          <tr>
            <td width="30%" bgcolor="##000000"><span style="color: ##FFFFFF; font-weight: bold">Widget Column <a href = "#request.AdminPath#helpdocs/widget_column.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></span></td>
            <td bgcolor="##000000"><span style="color: ##FFFFFF">
              <input name="SubmitButton" type="submit" id="SubmitButton" value="Update Style Settings" />
            </span></td>
          </tr>
          <tr>
            <td>Widget Column Width (when visible): </td>
            <td><cfinput name="Width_WidgetColumn" type="text" size="10" maxlength="7" value="#Width_WidgetColumn#" />
(px or % - 20% recommended) </td>
          </tr>  		  
          <tr>
            <td>Widget Column Background Color:</td>
            <td><cfinput name="bgcolor_WidgetColumn" type="text" id="bgcolor_WidgetColumn" size="10" maxlength="7" value="#bgcolor_WidgetColumn#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_WidgetColumn','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td> </td>
          </tr>	  
          <tr>
            <td bgcolor="##000000"><span style="color: ##FFFFFF; font-weight: bold">Widget Box Styles </span><a href = "#request.AdminPath#helpdocs/widget_styles.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
  <td bgcolor="##000000"><span style="color: ##FFFFFF">
              <input name="SubmitButton" type="submit" id="SubmitButton" value="Update Style Settings" />
            </span></td>
          </tr>
          <tr>
            <td>Widget Box Titles Text Color:</td>
            <td><cfinput name="Textcolor_WidgetTitles" type="text" id="Textcolor_WidgetTitles" size="10" maxlength="7" value="#TextColor_WidgetTitles#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=Textcolor_WidgetTitles','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Widget Box Titles Background Color:</td>
            <td><cfinput name="bgcolor_widgettitles" type="text" id="bgcolor_widgettitles" size="10" maxlength="7" value="#bgcolor_widgettitles#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_widgettitles','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Widget Box Titles Height (in Pixels):</td>
            <td><input name="Height_WidgetTitle" type="text" id="Height_WidgetTitle" value="#Height_WidgetTitle#" size="10" /> 
              (must be in pixels -- specify with 'px')</td>
          </tr>
          <tr>
            <td>Widget Box Title Padding:</td>
            <td><input name="widget_title_pad" type="text" id="widget_title_pad" value="#widget_title_pad#" size="10" />
(must be in pixels -- specify with 'px')</td>
          </tr>
          <tr>
            <td>Widget Box Background Color:</td>
            <td><cfinput name="bgcolor_widget" type="text" id="bgcolor_widget" size="10" maxlength="7" value="#bgcolor_widget#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_widget','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Widget Box Footer Background Color:</td>
            <td><cfinput name="bgcolor_widgetfooters" type="text" id="bgcolor_widgetfooters" size="10" maxlength="7" value="#bgcolor_widgetfooters#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_widgetfooters','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Widget Box Titles Font Type:</td>
            <td><select name="Font_WidgetTitles" selected="#font_widgettitles#">
   <cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.Font_WidgetTitles#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select>            </td>
          </tr>
          <tr>
            <td>Widget Box Titles Font Size:</td>
            <td><select name="TextSize_WidgetTitles" selected="#TextSize_WidgetTitles#">
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.TextSize_WidgetTitles>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Widget Box Titles Background Image:</td>
            <td><cfinput name="bgimage_widgettitles" type="text" id="bgimage_widgettitles" size="35" value="#bgimage_widgettitles#" />
            <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&amp;fname=colorform&amp;ffield=bgimage_widgettitles')" /></td>
          </tr>
          <tr>
            <td>Widget Box Background Image:</td>
            <td><cfinput name="bgimage_widget" type="text" id="bgimage_widget" size="35" value="#bgimage_widget#" />
            <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&amp;fname=colorform&amp;ffield=bgimage_widget')" /></td>
          </tr>
          <tr>
            <td>Widget Footer Background Image:</td>
            <td><cfinput name="bgimage_widgetfooters" type="text" id="bgimage_widgetfooters" size="35" value="#bgimage_widgetfooters#" />
            <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&amp;fname=colorform&amp;ffield=bgimage_widgetfooters')" /></td>
          </tr>
          <tr>
            <td>Widget Titles Text Alignment:</td>
            <td><select name = "align_widgettitles" selected="#align_widgettitles#">
			<cfloop query = "qryAlign">
            	<option <cfif qryAlign.alignment IS qryStyles.align_widgettitles>SELECTED</cfif>>#qryAlign.alignment#</option>
            </cfloop>
            </select>            </td>
          </tr>
          <tr>
            <td>Widget Font Type: </td>
            <td><select name="Font_Widget" selected="#font_widget#">
              <cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.Font_Widget#>SELECTED</cfif>>#qryFonts.fontname#</option>
           	 </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Widget Font Size: </td>
            <td><select name="textsize_widget" selected="#textsize_widget#" bind>
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.textsize_widget>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Widget Font Color: </td>
            <td><cfinput name="textcolor_widget" type="text" id="textcolor_widget" size="10" maxlength="7" value="#textcolor_widget#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=textcolor_widget','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Widget Font Title Weight: </td>
            <td><select name="fontweight_widgettitles">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.fontweight_widgettitles>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>
            </select></td>
          </tr>
          
          <tr>
            <td>Widget Title Style </td>
            <td><select name="fontstyle_widgettitles">
			<cfloop query = "qryFontStyles">
            	<option <cfif qryFontStyles.FontStyle IS qryStyles.fontstyle_widgettitles>SELECTED</cfif>>#qryFontStyles.FontStyle#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Widget Links Size:</td>
            <td><select name="textsize_widgetlinks" selected="#textsize_widgetlinks#" bind>
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.textsize_widgetlinks>SELECTED</cfif>>#qryTextSizes.TextSize#</option></cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Widget Links Color : </td>
            <td><cfinput name="textcolor_widgetlinks" type="text" id="textcolor_widgetlinks" size="10" maxlength="7" value="#textcolor_widgetlinks#"/>
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=textcolor_widgetlinks','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Widget Links Hover Color: </td>
            <td><cfinput name="Textcolor_widgetlinkshover" type="text" id="Textcolor_widgetlinkshover" size="10" maxlength="7" value="#Textcolor_widgetlinkshover#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=Textcolor_widgetlinkshover','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Widget Links Decoration: </td>
            <td><select name="TextDecor_WidgetLinks">
            <cfloop query = "qryDecor">	
                <option <cfif qryDecor.Decor IS qryStyles.TextDecor_WidgetLinks>SELECTED</cfif>>#qryDecor.Decor#</option>
            </cfloop>
           </select></td>
          </tr>
          <tr>
            <td>Widget Links Hover Decoration: </td>
            <td><select name="TextDecor_WidgetLinksHover">
            <cfloop query = "qryDecor">	
                <option <cfif qryDecor.Decor IS qryStyles.TextDecor_WidgetLinksHover>SELECTED</cfif>>#qryDecor.Decor#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Widget Links Font: </td>
            <td><select name="font_widgetlink">
            <cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.font_widgetlink#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Widget Links Weight: </td>
            <td><select name="fontweight_widgetlinks">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.fontweight_widgetlinks>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Widget Links Hover Weight: </td>
            <td><select name="fontweight_widgetlinkshover">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.fontweight_widgetlinkshover>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Widget Links Background Color: </td>
            <td><cfinput name="bgcolor_widgetlinks" type="text" id="bgcolor_widgetlinks" size="10" maxlength="7" value="#bgcolor_widgetlinks#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_widgetlinks','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Widget Links Hover Background Color: </td>
            <td><cfinput name="bgcolor_widgetlinksHover" type="text" id="bgcolor_widgetlinksHover" size="10" maxlength="7" value="#bgcolor_widgetlinksHover#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_widgetlinksHover','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Widget Box Border Width (0 for none): </td>
            <td><select name="border_widgetboxsize">
			<cfloop query = "qryBorderWidths">
            	<option <cfif qryBorderWidths.BorderWidth IS qryStyles.border_widgetboxsize>SELECTED</cfif>>#qryBorderWidths.BorderWidth#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Widget Box Border Color: </td>
            <td><cfinput name="border_widgetboxcolor" type="text" id="border_widgetboxcolor" size="10" maxlength="7" value="#border_widgetboxcolor#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=border_widgetboxcolor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
 </table>

<!---SHOPPING CART--->
        <table width="100%" border="0" align="center" cellpadding="4" cellspacing="0" style="border: 2px ##000000 solid;"> 		         
          <tr>
            <td width="30%" bgcolor="##000000"><span style="color: ##FFFFFF; font-weight: bold">Price Format (When viewing Details) <a href = "#request.AdminPath#helpdocs/price_format.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></span></td>
            <td bgcolor="##000000"><span style="color: ##FFFFFF">
              <input name="SubmitButton" type="submit" id="SubmitButton" value="Update Style Settings" />
            </span></td>
          </tr>
          <tr>
            <td>Price Font Color:</td>
            <td><cfinput name="textcolor_price" type="text" id="textcolor_price" size="10" maxlength="7" value="#textcolor_price#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=textcolor_price','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Price Font Size: </td>
            <td><select name="textsize_price">
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.textsize_price>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Price Font: </td>
            <td><select name="Font_Price">
  <cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.Font_Price#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Price Font Style: </td>
            <td><select name="fontstyle_price">
			<cfloop query = "qryFontStyles">
            	<option <cfif qryFontStyles.FontStyle IS qryStyles.fontstyle_price>SELECTED</cfif>>#qryFontStyles.FontStyle#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Price Font Weight: </td>
            <td><select name="FontWeight_Price">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.FontWeight_Price>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Wholesale Price Font:</td>
            <td> <select name="Font_Wholesaleprice">
  <cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.Font_Wholesaleprice#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Wholesale Price Font Size: </td>
            <td><select name="TextSize_WholesalePrice">
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.TextSize_WholesalePrice>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          
          <tr>
            <td>Wholesale Price Font Style: </td>
            <td><select name="FontStyle_WholesalePrice">
			<cfloop query = "qryFontStyles">
            	<option <cfif qryFontStyles.FontStyle IS qryStyles.FontStyle_WholesalePrice>SELECTED</cfif>>#qryFontStyles.FontStyle#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Wholesale Price Weight: </td>
            <td><select name="FontWeight_WholesalePrice">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.FontWeight_WholesalePrice>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>
           </select></td>
          </tr>
          <tr>
            <td>List Price Font Color:</td>
            <td><cfinput name="TextColor_ListPrice" type="text" id="Textcolor_listprice" size="10" maxlength="7" value="#TextColor_ListPrice#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=TextColor_ListPrice','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>List Price Font Size: </td>
            <td><select name="TextSize_ListPrice" selected="#TextSize_ListPrice#">
              <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.TextSize_ListPrice>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>List Price Font Type: </td>
            <td><select name="Font_ListPrice" selected="#font_listprice#">
            <cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.Font_ListPrice#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select></td></tr>
          <tr>
            <td>List Price Font Style:</td>
            <td><select name="FontStyle_ListPrice">
            <cfloop query = "qryFontStyles">	
                <option <cfif qryFontStyles.FontStyle IS qryStyles.FontStyle_ListPrice>SELECTED</cfif>>#qryFontStyles.FontStyle#</option>
            </cfloop>
            </select></td>
          </tr>        
          <tr>
            <td>List Price Weight: </td>
            <td><select name="FontWeight_ListPrice">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.FontWeight_ListPrice>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
		<!---form fields--->
          <tr bgcolor="##000000">
            <td><font color="##FFFFFF"><strong>Form Fields <a href = "#request.AdminPath#helpdocs/form_field_styles.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></strong></font></td>
            <td width="475"><font color="##FFFFFF">&nbsp;</font> <input name="SubmitButton" type="submit" id="SubmitButton" value="Update Style Settings" /></td>
          </tr>
          <tr>
            <td nowrap="nowrap">Form Fields Text Color (Buttons, Input Boxes, Drop 
              Down, etc.): </td>
            <td width="475"><cfinput name="TextColor_FormFields" type="text" id="TextColor_FormFields" size="10" maxlength="7" value="#TextColor_FormFields#" />
              <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=colorform&field=TextColor_FormFields','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a> </td>
          </tr>
          <tr>
            <td>Form Fields Background Color:</td>
            <td width="475"><cfinput name="bgColor_FormFields" type="text" id="bgColor_FormFields" size="10" maxlength="7" value="#bgColor_FormFields#" />
              <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=colorform&field=bgColor_FormFields','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a> </td>
          </tr>
          <tr>
            <td>Form Fields Font:</td>
            <td><select name="font_FormFields" selected="#font_FormFields#">
			<cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.font_FormFields#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select>            </td>
          </tr>
          <tr>
            <td>Form Fields Text Size: </td>
            <td><select name="textsize_formfields" selected="#textsize_formfields#">
            <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.TextSize_formfields>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Form Fields Text Style: </td>
            <td><select name="fontstyle_formfields">
            <cfloop query = "qryFontStyles">	
                <option <cfif qryFontStyles.FontStyle IS qryStyles.fontstyle_formfields>SELECTED</cfif>>#qryFontStyles.FontStyle#</option>
            </cfloop>
            </select></td>
          </tr>    
          <tr>
            <td>Form Fields Font Weight: </td>
            <td><select name="fontweight_formfields">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.fontweight_formfields>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td width="475">&nbsp;</td>
          </tr>
          <tr bgcolor="##000000">
            <td bgcolor="##000000"><span style="font-weight: bold"><font color="##FFFFFF">Options Section </font></span> <a href = "#request.AdminPath#helpdocs/options_section.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><input name="SubmitButton" type="submit" id="SubmitButton" value="Update Style Settings" /></td>
          </tr>
          <tr>
            <td>Options Section Background Color: </td>
            <td><cfinput name="bgcolor_options" type="text" id="bgcolor_options" size="10" maxlength="7" value="#bgcolor_options#" />
            <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_options','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false">
              <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Options Section Text Color:</td>
            <td><cfinput name="textcolor_options" type="text" id="textcolor_options" size="10" maxlength="7" value="#textcolor_options#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=textcolor_options','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"> <img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Options Section Title Background Color:</td>
            <td><cfinput name="bgcolor_optionstitles" type="text" id="bgcolor_optionstitles" size="10" maxlength="7" value="#bgcolor_optionstitles#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=bgcolor_optionstitles','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a><a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=colorform&field=Navbarlinkcolor','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"></a>	  </td>
          </tr>
          <tr>
            <td>Options Section Title Text Color: </td>
            <td><cfinput name="Textcolor_OptionsTitles" type="text" id="Textcolor_OptionsTitles" size="10" maxlength="7" value="#Textcolor_OptionsTitles#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=Textcolor_OptionsTitles','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Options Section Title Text Style: </td>
            <td><select name="FontStyle_OptionsTitles">
            <cfloop query = "qryFontStyles">	
                <option <cfif qryFontStyles.FontStyle IS qryStyles.FontStyle_OptionsTitles>SELECTED</cfif>>#qryFontStyles.FontStyle#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Options Section Title Font: </td>
            <td><select name="Font_OptionsTitles" selected="#Font_OptionsTitles#">
			<cfloop query = "qryFonts">
            	<option <cfif qryFonts.fontname IS #qryStyles.Font_OptionsTitles#>SELECTED</cfif>>#qryFonts.fontname#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Options Section Title Font Size: </td>
            <td><select name="TextSize_OptionsTitles" selected="#TextSize_OptionsTitles#">
            <cfloop query = "qryTextSizes">
              <option <cfif qryTextSizes.TextSize IS qryStyles.TextSize_OptionsTitles>SELECTED</cfif>>#qryTextSizes.TextSize#</option>              </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Options Section Title Font Weight: </td>
            <td><select name="FontWeight_OptionsTitles">
			<cfloop query = "qryFontWeights">
            <option <cfif qryFontWeights.FontWeight IS qryStyles.FontWeight_OptionsTitles>SELECTED</cfif>>#qryFontWeights.FontWeight#</option>
            </cfloop>            
            </select></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td></td>
          </tr>
</table>
<!---HEADER/FOOTER--->
    <table width="100%" border="0" align="center" cellpadding="4" cellspacing="0" style="border: 2px ##000000 solid;"> 		
          <tr bgcolor="##000000">
            <td width="30%"><span style="color: ##FFFFFF; font-weight: bold">Header</span> <a href = "#request.AdminPath#helpdocs/header_styles.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            <td><input name="SubmitButton" type="submit" id="SubmitButton" value="Update Style Settings" /></td>
          </tr>
          <tr>
            <td>Header Background Color: </td>
            <td><cfinput name="bgcolor_header" type="text" id="bgcolor_header" size="10" maxlength="7" value="#bgcolor_header#" />
             <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=colorform&field=bgcolor_header','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Header Background Image (url): </td>
            <td><cfinput name="bgimage_header" type="text" id="bgimage_header" size="50" value="#bgimage_header#" /> <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&amp;fname=colorform&amp;ffield=bgimage_header')" /></td>
          </tr>
          <tr>
            <td>Header Background Image Position: </td>
            <td><select name="header_bgposition">
			<cfloop query = "qryAlign">
            	<option <cfif qryAlign.alignment IS qryStyles.header_bgposition>SELECTED</cfif>>#qryAlign.alignment#</option>
            </cfloop>
              </select></td>
          </tr>
          <tr>
            <td>Header Background Image Repeat: </td>
            <td><select name="header_bgrepeat">
			<cfloop query = "qryBGRepeat">
            	<option <cfif qryBGRepeat.BGRepeat IS qryStyles.header_bgrepeat>SELECTED</cfif>>#qryBGRepeat.BGRepeat#</option>
            </cfloop>
            </select></td>
          </tr>
          <tr>
            <td>Header Text Color: </td>
            <td><cfinput name="TextColor_Header" type="text" id="TextColor_Header" size="10" maxlength="7" value="#TextColor_Header#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=TextColor_Header','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Header Height:</td>
            <td><input name="height_header" type="text" id="height_header" size="7" value="#height_header#" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td bgcolor="##000000"><span style="color: ##FFFFFF; font-weight: bold">Footer <a href = "#request.AdminPath#helpdocs/footer_styles.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></span></td>
            <td bgcolor="##000000"><span style="color: ##FFFFFF">
              <input name="SubmitButton" type="submit" id="SubmitButton" value="Update Style Settings" />
            </span></td>
      </tr>
          <tr>
            <td>Footer Background Color: </td>
            <td><cfinput name="bgcolor_Footer" type="text" id="bgcolor_Footer" size="10" maxlength="7" value="#bgcolor_Footer#" />
              <a href = "Color%20Selector" onClick="JavaScript:window.open('colorchooser.cfm?form=colorform&field=bgcolor_Footer','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Footer Background Image (url): </td>
            <td><cfinput name="bgimage_Footer" type="text" id="bgimage_Footer" size="50" value="#bgimage_Footer#" /> <input type = "button" value="Select Image" onclick="javascript: OpenFileBrowser('#request.adminpath#components/imagelibrary/doimagelibrary.cfm?action=browse&amp;fname=colorform&amp;ffield=bgimage_Footer')" /></td>
          </tr>
          <tr>
            <td>Header Background Image Position: </td>
            <td><select name="Footer_bgposition">
			<cfloop query = "qryAlign">
            	<option <cfif qryAlign.alignment IS qryStyles.Footer_bgposition>SELECTED</cfif>>#qryAlign.alignment#</option>
            </cfloop>
              </select></td>
          </tr>
          <tr>
            <td>Header Background Image Repeat: </td>
            <td><select name="Footer_bgrepeat">
    			<cfloop query = "qryBGRepeat">
            	<option <cfif qryBGRepeat.BGRepeat IS qryStyles.Footer_bgrepeat>SELECTED</cfif>>#qryBGRepeat.BGRepeat#</option>
            </cfloop>
             </select></td>
          </tr>
          <tr>
            <td>Footer  Text Color: </td>
            <td><cfinput name="TextColor_Footer" type="text" id="TextColor_Footer" size="10" maxlength="7" value="#TextColor_Footer#" />
              <a href = "Color%20Selector" onclick="JavaScript:window.open('colorchooser.cfm?form=colorform&amp;field=TextColor_Footer','cal','noresize,width=275,height=220,outerwidth=475,outerheight=275');return false"><img alt="Click to open the color chooser" border="0" src="choosecoloricon.gif" width="24" height="20" /></a></td>
          </tr>
          <tr>
            <td>Footer Height:</td>
            <td><input name="height_footer" type="text" id="height_footer" size="7" value="#height_footer#" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
</table>
<!---CUSTOM STYLES--->
    <table width="100%" border="0" align="center" cellpadding="4" cellspacing="0" style="border: 2px ##000000 solid;"> 	
          <tr>
          <td bgcolor="##000000"><span style="color: ##FFFFFF; font-weight: bold">Custom Styles <a href = "#request.AdminPath#helpdocs/custom_styles.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></span></td>
          </tr>
          <tr>
            <td colspan="2"><p align="left">
              <cftextarea name="CustomStyles" id="CustomStyles" style="width: 100%; height: 420;">#CustomStyles#</cftextarea>
            </td>
          </tr>
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
        </table>
</cfoutput>
<input type="submit" name="SubmitButton" value="Update Style Settings">
<input type="hidden" name="Action" value="UpdateColors">
</cfform>








