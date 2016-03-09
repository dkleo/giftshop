<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfinclude template = "../queries/qrystyles.cfm">

<!---replace all spaces in the name with the underscore character--->
<cfset newthemename = replace(form.newtheme, " ", "_", "ALL")>
<cfset newthemename = trim(newthemename)>

<cfif directoryexists('#request.catalogpath#themes#request.bslash##newthemename#')>
	The theme name you chose is already taken.  You must manually delete the theme from your server before you can save another theme
    by that name.
    <cfabort>
</cfif>

<!---generate the css based on the settings in the database--->
<cfprocessingdirective suppresswhitespace="yes">

<cfsavecontent variable="storestyles">
<cfoutput query = "qryStyles">

<cfif qryStyles.Width_Container GT 0>
.container {width: #qryStyles.Width_Container#;}
</cfif>
.selecttr { background-color: #bgColor_SelectRow#; cursor: pointer; color: #TextColor_SelectRow#; }
.initial { background-color: #bgColor_body#; color: #TextColor_Normal#; cursor: pointer; }
.normal { background-color: #bgColor_body#; color: #TextColor_Normal#; cursor: pointer; }
.highlight { background-color: #bgColor_SelectRow#; cursor: pointer; color: #TextColor_SelectRow#; }
.delcheckbox {cursor: None;} 

a {font-family: #Font_Links#;
font: #Font_Links#;	
font-weight: #FontWeight_Links#;
font-size: #TextSize_Links#; 
color: #TextColor_Links#;
text-decoration: #TextDecor_Links# }

a:hover {font-family: #Font_LinksHover#;
font: #Font_LinksHover#;	
font-weight: #FontWeight_LinksHover#;
font-size: #TextSize_LinksHover#; 
color: #TextColor_LinksHover#;
text-decoration: #TextDecor_LinksHover# }

.navbar{font-weight: #fontweight_navbar#;
font-size: #TextSize_NavBar#; 
color: #TextColor_NavBar#;
background: #bgColor_navbar#;
background-color: #bgColor_navbar#;
background-image: url(themes/#newthemename#/#bgImage_NavBar#);
<cfif #Display_navbar# IS 'none'>display: #Display_navbar#;</cfif>}

.navbar td{font-weight: #fontweight_navbar#; 
font-size: #TextSize_NavBar#; 
color: #TextColor_NavBar#;}

.navbar a{text-decoration: #TextDecor_NavBarLinks#;
font-weight: #FontWeight_NavBarLinks#; 
font-size: #TextSize_NavBarLinks#; 
color: #TextColor_NavBarLinks#;}

.navbar a:hover{text-decoration: #TextDecor_NavBarLinksHover#;
font-weight: #FontWeight_NavBarLinksHover#; 
font-size: #TextSize_NavBarLinksHover#; 
color: #TextColor_NavBarLinksHover#;}

.TableTitles {color: #TextColor_ColumnHeaders#; 
background-color: #bgColor_ColumnHeaders#;
background: #bgColor_ColumnHeaders#;
background-image: url(themes/#newthemename#/#bgImage_ColumnHeaders#);
font-family: #Font_ColumnHeaders#;
font: #Font_ColumnHeaders#;
font-weight: #FontWeight_ColumnHeaders#;
font-style: #FontStyle_ColumnHeaders#;
font-size: #TextSize_ColumnHeaders#;
height: #height_columnheaders#;}

.spacer {height: #height_navbar#;}

.widget_title{color: #textcolor_widgettitles#;
font-size: #textsize_widgettitles#;
background-color: #bgcolor_widgettitles#;
background: #bgcolor_widgettitles#;
text-align: #align_widgettitles#;
font-weight: #fontweight_widgettitles#;
background-image: url(themes/#newthemename#/#bgimage_widgettitles#);}

.widget_box{border: #border_widgetboxcolor# #border_widgetboxsize# solid; 
background: #bgcolor_widget#;
background-color: #bgcolor_widget#;}

.widget_column{width: #width_widgetcolumn#;
background: #bgcolor_widgetcolumn#;
background-color: #bgcolor_widgetcolumn#;}

.widget_box a{color: #textcolor_widgetlinks#;
font-size: #textsize_widgetlinks#;
background-color: #bgcolor_widgetlinks#;
background: #bgcolor_widgetlinks#;
font-weight: #fontweight_widgetlinks#;
}

.widget_box a:hover{color: #textcolor_widgetlinksHover#;
font-size: #textsize_widgetlinksHover#;
background-color: #bgcolor_widgetlinksHover#;
background: #bgcolor_widgetlinksHover#;
font-weight: #fontweight_widgetlinksHover#;
}

.widget_content{background: #bgcolor_widget#;
background: url(#bgimage_widget#);
background-image: url(#bgimage_widget#);}

.bodytable {background: #bgColor_body#;
background-color: #bgColor_body#;
color: #TextColor_Normal#;
font-family: #Font_Normal#;
font: #Font_Normal#;
font-size: #TextSize_Normal#;}

input { font-family: #font_formfields#; 
font-size: #textsize_formfields#; 
color: #textcolor_formfields#; 
background-color: #bgcolor_formfields#;}

select { font-family: #font_formfields#; 
font-size: #textsize_formfields#; 
color: #textcolor_formfields#; 
background-color: #bgcolor_formfields#;}

textarea { font-family: #font_formfields#; 
font-size: #textsize_formfields#; 
color: #textcolor_formfields#; 
background-color: #bgcolor_formfields#;}

.footersection {
font-family: #font_footer#;
font: #font_footer#;
font-size: #textsize_footer#;
color: #textcolor_footer#;
background: #bgcolor_footer#;
background-image: url(themes/#newthemename#/#bgImage_footer#);
height: #height_footer#;
}

.headersection {
font-family: #font_header#;
font: #font_header#;
font-size: #textsize_header#;
color: #textcolor_header#;
background: #bgcolor_header#;
background-image: url(themes/#newthemename#/#bgImage_header#);
background-position: #header_bgposition#;
background-repeat: #header_bgrepeat#;
height: #height_header#;}

body {font-family: #font_normal#; 
font:#font_normal#; 
font-size: #textsize_normal#; 
color: #textcolor_normal#; 
background-image: url(themes/#newthemename#/#bgimage_website#);
background-color: #bgcolor_website#;
background-repeat: #site_bgrepeat#;
background-position: #site_bgposition#;
background-position: #site_bgvposition#;
}

<cfset shadeper = replace(shadowstrength, "%", "", "ALL")>
<cfset shadedec = shadeper / 100>
    
.shadowcell_right {width: #shadowwidth#px;}
.shadowcell_left {width: #shadowwidth#px;}    
    
.shadowcell_spacerimg {width: #shadowwidth#px}

.innercontainer {background: #bgColor_body#;
background-color: #bgColor_body#;
border: #border_contentsize# #border_contentcolor# solid;}

.CouponCodeTable{border-bottom: ##D4D4D4 0px solid;}
.ShoppingCartTable{border: ##D4D4D4 1px solid;}
.cartcontents{border-bottom: ##D4D4D4 1px solid;}
.CouponRow{border: ##D4D4D4 1px solid;}
.CartTotals{border-bottom: ##D4D4D4 1px solid; border-left: ##D4D4D4 1px solid;}

.OptionsTitles{font-family: #font_OptionsTitles#; 
font:#font_OptionsTitles#; 
font-size: #textsize_OptionsTitles#; 
color: #textcolor_OptionsTitles#; 
background-color: #bgcolor_OptionsTitles#; 
font-style: #FontStyle_OptionsTitles#;
font-weight: #FontWeight_OptionsTitles#;
}

.Options{font-family: #font_Options#; 
font:#font_Options#; 
font-size: #textsize_Options#; 
color: #textcolor_Options#; 
background-color: #bgcolor_Options#;}

.Price{font-family: #font_Price#; 
font:#font_Price#; 
font-size: #TextSize_Price#; 
color: #textcolor_Price#;
font-weight: #FontWeight_Price#;
font-style: #FontStyle_Price#;
}

.WholesalePrice{font-family: #font_WholesalePrice#; 
font:#font_WholesalePrice#; 
font-size: #TextSize_WholesalePrice#; 
color: #textcolor_Wholesale#;
font-weight: #FontWeight_WholesalePrice#;
font-style: #FontStyle_WholesalePrice#;
}

.ListPrice{font-family: #font_ListPrice#; 
font:#font_ListPrice#; 
font-size: #TextSize_ListPrice#; 
color: #textcolor_ListPrice#;
font-weight: #FontWeight_ListPrice#;
font-style: #FontStyle_ListPrice#;
}

</cfoutput>
</cfsavecontent>

<cfsavecontent variable="newthemecontent">

<cfif qryStyles.Width_Container LT 1>
<script LANGUAGE="JavaScript" type="text/javascript">
    if(screen.width < 801) {
      document.write('<style>.container {width: 100%;}</style>');
	  }

    if(screen.width > 800) {
      document.write('<style>.container {width: 85%;}</style>');
	  }
</script>
</cfif>

<cfoutput>
<style>
#qryStyles.customstyles#

#storestyles#

</style>
</cfoutput>
</cfsavecontent>
</cfprocessingdirective>

<!---create new folders under the themes folder--->
<cfdirectory action="create" directory="#request.catalogpath#themes#request.bslash##newthemename#">
<cfdirectory action="create" directory="#request.catalogpath#themes#request.bslash##newthemename##request.bslash#images">
<!---These are images that will be copied over to their image folder--->
<cfdirectory action="create" directory="#request.catalogpath#themes#request.bslash##newthemename##request.bslash#thumb">
<cfdirectory action="create" directory="#request.catalogpath#themes#request.bslash##newthemename##request.bslash#preview">
<cfdirectory action="create" directory="#request.catalogpath#themes#request.bslash##newthemename##request.bslash#images#request.bslash#buttons">

<!---copy images--->
<cfset bgimage = replace(qryStyles.bgimage_website, "/", "#request.bslash#", "ALL")>
<cfset headerbgimage = replace(qryStyles.bgimage_header, "/", "#request.bslash#", "ALL")>
<cfset footerbgimage = replace(qryStyles.bgimage_footer, "/", "#request.bslash#", "ALL")>
<cfset colheadersbgimage = replace(qryStyles.bgimage_columnheaders, "/", "#request.bslash#", "ALL")>
<cfset navbarbgimage = replace(qryStyles.bgimage_navbar, "/", "#request.bslash#", "ALL")>
<cfset widgetbgimage = replace(qryStyles.bgimage_widgettitles, "/", "#request.bslash#", "ALL")>

<cfif fileexists('#request.CatalogPath##bgimage#')>
<cffile action = "copy" source="#request.CatalogPath##bgimage#" destination="#request.CatalogPath#themes#request.bslash##newthemename##request.bslash##bgimage#">
</cfif>

<cfif fileexists('#request.CatalogPath##headerbgimage#')>
<cffile action = "copy" source="#request.CatalogPath##headerbgimage#" destination="#request.CatalogPath#themes#request.bslash##newthemename##request.bslash##headerbgimage#">
</cfif>

<cfif fileexists('#request.CatalogPath##footerbgimage#')>
<cffile action = "copy" source="#request.CatalogPath##footerbgimage#" destination="#request.CatalogPath#themes#request.bslash##newthemename##request.bslash##footerbgimage#">
</cfif>

<cfif fileexists('#request.CatalogPath##colheadersbgimage#')>
<cffile action = "copy" source="#request.CatalogPath##colheadersbgimage#" destination="#request.CatalogPath#themes#request.bslash##newthemename##request.bslash##colheadersbgimage#">
</cfif>

<cfif fileexists('#request.CatalogPath##navbarbgimage#')>
<cffile action = "copy" source="#request.CatalogPath##navbarbgimage#" destination="#request.CatalogPath#themes#request.bslash##newthemename##request.bslash##navbarbgimage#">
</cfif>

<cfif fileexists('#request.CatalogPath##widgetbgimage#')>
<cffile action = "copy" source="#request.CatalogPath##widgetbgimage#" destination="#request.CatalogPath#themes#request.bslash##newthemename##request.bslash##widgetbgimage#">
</cfif>

<!---copy current button set--->
<cfdirectory action="list" directory="#request.catalogpath#images#request.bslash#buttons#request.bslash#" name="qryButtons">

<cfloop query = "qryButtons">
<cffile action = "copy" source="#request.CatalogPath##request.bslash#images#request.bslash#buttons#request.bslash##name#" destination="#request.CatalogPath#themes#request.bslash##newthemename##request.bslash#images#request.bslash#buttons#request.bslash#">
</cfloop>

<!---write the buttons include--->
<cfquery name = "qryButtons" datasource="#request.dsn#">
SELECT * FROM custom_buttons
</cfquery>

<cfset outputstring = "">
<cfloop query = "qryButtons">
<cfset outputstring = outputstring & "<cfset request.#qryButtons.button_name# = 'themes/#newthemename#/images/buttons/#image_file#'>">
</cfloop>

<cfset newthemecontent = newthemecontent & outputstring>

<!---Write the new theme to the themes folder.--->
<cfoutput>
<cffile action = "write" file="#request.catalogpath#themes#request.bslash##newthemename##request.bslash##newthemename#.cfm" output="#newthemecontent#">
</cfoutput>

<cfoutput>
<center><b>You have created a new theme called #newthemename#</b></center>
<p>
<center><a href = "dosetup.cfm?action=storecolors">Return to Editing Store Colors</a></center>
</p></cfoutput>