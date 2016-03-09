<!---
*****************************************************************************************************
*Author: Jon Wallen                                                                                 *
*www.cfshopkart.com                                                                                 *
*                                                                                                   *
*                                                                                                   *
*Dumps settings to the users folder to keep database load low when browsing a store                 *
*                                                                                                   *
*Version:  1.0                                                                                      *
*License:  Part of CF Shopkart and may only be distributed with it.                                 *
*****************************************************************************************************

Revision History:

-Revised for substores...now dumps override settings at end

--->
<cfcomponent>
	
	<!---****WRITE SETTINGS*****---->
	<cffunction name="WriteSettings" returntype="string" description="Writes the settings file to the store home directory">
	<cfargument name = "path" type="string" required="yes" hint="Full path to the store home directory">
	<cfargument name = "cfdsn" type="string" required="yes" hint="Coldfusion dsn of the settings">
    
        <cfquery name = "qryCompanyInfo" datasource="#cfdsn#">
        SELECT * From companyinfo,settings_main,settings_mail,settings_processor
        </cfquery>

		<cfquery name = "qryButtons" datasource="#cfdsn#">
		SELECT * FROM custom_buttons
		</cfquery>

        <cfquery name = "qryStyles" datasource="#cfdsn#">
        SELECT * FROM customstyles
        </cfquery>

		<!---clear file--->
		<cffile action = "write" file="#path#config#request.bslash#settings.cfm" output="" mode="777">

		<!---write main settings--->
        <cfset col_list = qryCompanyInfo.columnlist>
            
        <cfloop from="1" to = "#listlen(col_list)#" index="c">
            <cfset thiscol = listgetat(col_list, c)>   
            <cfset requestvar = 'request.#thiscol#'>
            <cfset requestval = 'qryCompanyInfo.#thiscol#'>
            <cfset requestval = evaluate(requestval)>
        
           <cfif NOT requestval CONTAINS "'">
				<cfset thisline = "<cfset #requestvar# = '#requestval#'>">
            <cfelse>
	            <cfset thisline = '<cfset #requestvar# = "#requestval#">'>
            </cfif>
            
            <cffile action = "append" file="#path#config#request.bslash#settings.cfm" output="#thisline#" addnewline="yes">
        </cfloop>
		
        <!---write buttons--->
        <cfloop query = "qryButtons">
            <cfset thiscol = button_name>   
            <cfset requestvar = 'request.#thiscol#'>
            <cfset requestval = 'images/buttons/#image_file#'>	
        
            <cfset thisline = "<cfset #requestvar# = '#requestval#'>">
            
            <cffile action = "append" file="#path#config#request.bslash#settings.cfm" output="#thisline#" addnewline="yes">
        </cfloop>

		<!---append override settings from local database--->
		<!---<cfoutput query = "qryCompanyInfoLocal">
        	<cfset outstring = "<cfset CartThumbnails = '#CartThumbNails#'>
			<cfset request.ShowProductID = '#ShowProductID#'>
			<cfset request.LinksDisplay = '#LinksDisplay#'>
			<cfset request.CategoryDisplay = '#CategoryDisplay#'>
			<cfset request.sidebysidecols = '#sidebysidecols#'>
			<cfset request.WebsiteTitle = '#WebsiteTitle#'>
			<cfset request.MetaDescription = '#MetaDescription#'>
			<cfset request.MetaKeywords = '#MetaKeywords#'>
			<cfset request.defaultaction ='#defaultaction#'>
			<cfset request.NavMenuType = '#NavMenuType#'>
			<cfset request.EndOrderSubj = '#EndOrderSubj#'>
			<cfset request.EmailText = '#EmailText#'>
			<cfset request.EndOrderMessage = '#EndOrderMessage#'>">
        </cfoutput>--->
		
        <!---<cffile action = "append" file="#path#settings.cfm" output="#outstring#" addnewline="yes">--->

		<!---write ckeditor styles (these are styles that will be available in the editor)--->
		<cfsavecontent variable="ckeditor_styles">
        CKEDITOR.addStylesSet( 'site_styles',
		[
		<cfoutput query = "qryStyles">
        { name : 'Column Headers', 
        element : 'TableTitles', 
        styles : { 
        'font-family' : '#font_ColumnHeaders#',
        'background-color' : '#bgColor_ColumnHeaders#',
        'background' : '#bgColor_ColumnHeaders#',
        'background-image' : 'url(#bgImage_ColumnHeaders#)',
        'font-weight' : '#FontWeight_ColumnHeaders#',
        'font-style' : '#FontStyle_ColumnHeaders#',
        'font-size' : '#TextSize_ColumnHeaders#',
        'height' : '#height_columnheaders#'} 
        }
		</cfoutput>
        ]      
        );
        </cfsavecontent>

		<cffile action = "write" file="#path#config#request.bslash#ckstyles.js" output="#ckeditor_styles#" mode="777">
               
		<!---write styles--->
        <cfsavecontent variable="storestyles">
        <cfoutput query = "qryStyles">

        <style>

        td {font-family: #font_normal#; 
        font:#font_normal#; 
        font-size: #textsize_normal#; 
        color: #textcolor_normal#;
        }
        
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
        height: #height_navbar#;
        font-size: #TextSize_NavBar#; 
        color: #TextColor_NavBar#;
        background: #bgColor_navbar#;
        background-color: #bgColor_navbar#;
        background-image: url(#bgImage_NavBar#);
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
        background-image: url(#bgImage_ColumnHeaders#);
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
        background-image: url(#bgimage_widgettitles#);
        height: #Height_WidgetTitle#;
		padding: #widget_title_pad#;}
        
        .widget_box{border: #border_widgetboxcolor# #border_widgetboxsize# solid; 
        background: #bgcolor_widget#;
        background-color: #bgcolor_widget#;
        }
        
        .widget_footer{background: #bgcolor_widgetfooters#;
        background-color: #bgcolor_widgetfooters#;
        background-image: url(#bgimage_widgetfooters#);}
        
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
        font-size: #TextSize_Normal#; 
        height: 460px;}
        
        input {font-family: #font_formfields#; 
        font-size: #textsize_formfields#; 
        color: #textcolor_formfields#; 
        background-color: #bgcolor_formfields#;
        background: #bgcolor_formfields#;}
        
        select {font-family: #font_formfields#; 
        font-size: #textsize_formfields#; 
        color: #textcolor_formfields#; 
        background-color: #bgcolor_formfields#;
        background: #bgcolor_formfields#;}
        
        textarea { font-family: #font_formfields#; 
        font-size: #textsize_formfields#; 
        color: #textcolor_formfields#; 
        background-color: #bgcolor_formfields#;
        background: #bgcolor_formfields#;}
        
        .footersection {
        font-family: #font_footer#;
        font: #font_footer#;
        font-size: #textsize_footer#;
        color: #textcolor_footer#;
        background: #bgcolor_footer#;
        background-image: url(#bgImage_footer#);
        height: #height_footer#;
        }
        
        .headersection {
        font-family: #font_header#;
        font: #font_header#;
        font-size: #textsize_header#;
        color: #textcolor_header#;
        background: #bgcolor_header#;
        background-image: url(#bgImage_header#);
        background-position: #header_bgposition#;
        background-repeat: #header_bgrepeat#;
        height: #height_header#;}
        
        body {font-family: #font_normal#; 
        font:#font_normal#; 
        font-size: #textsize_normal#; 
        color: #textcolor_normal#; 
        background-image: url(#bgimage_website#);
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
        
        .Options {font-family: #font_Options#; 
        font:#font_Options#; 
        font-size: #textsize_Options#; 
        color: #textcolor_Options#; 
        background-color: #bgcolor_Options#;}
        
        .Price {font-family: #font_Price#; 
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
        
        #qryStyles.customstyles#
        
        </style>
        </cfoutput>
        </cfsavecontent>
		
       
       <cffile action = "write" file="#path#config#request.bslash#styles.cfm" output="#storestyles#" mode="777">
	
	   <cfset thisline = "<cfset request.themetouse = '#qryStyles.themetouse#'>">       
       <cffile action = "append" file="#path#config#request.bslash#styles.cfm" output="#thisline#" addnewline="yes">

	   <cfset thisline = "<cfset request.ALIGN_CONTAINER = '#qryStyles.ALIGN_CONTAINER#'>">
       <cffile action = "append" file="#path#config#request.bslash#styles.cfm" output="#thisline#" addnewline="yes">

	   <cfset thisline = "<cfset request.width_container = '#qryStyles.width_container#'>">
       <cffile action = "append" file="#path#config#request.bslash#styles.cfm" output="#thisline#" addnewline="yes">

	   <cfset thisline = "<cfset request.BodyShadow = '#qryStyles.BodyShadow#'>">
       <cffile action = "append" file="#path#config#request.bslash#styles.cfm" output="#thisline#" addnewline="yes">

		<cfset outputmsg = "#storestyles#">
   
	 <cfreturn outputmsg>

	</cffunction>
</cfcomponent>