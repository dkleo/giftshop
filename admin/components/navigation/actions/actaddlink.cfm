<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset thisSubLinkOf = "0">
<cfset thisLinkPath = "/">

<!---default sub link--->
<cfset thisSubLinkOf = 0>
<cfset thisLinkPath = "/">

<cfquery name = "qryGetParent" datasource="#request.dsn#">
SELECT * FROM nav_links
WHERE id = #nview#
</cfquery>

<cfoutput query="qryGetParent">
	<cfset thisSubLinkOf = nview>
    <cfset thisLinkPath = '#linkpath##nview#/'>
</cfoutput>

<cfif form.LinkType IS 'PageLink'>
	<cfif form.page is 'None'>
    	<center><h2>You didn't select a page to link to!</h2></center>/
    </cfif>
	<cfset NewFileName = form.page>

	<!---Replace all illgegal characters in the link title--->
	<cfset NewLinkName = replace(form.LinkTitle, "'", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, '"', '', 'ALL')>
	<cfset NewLinkName = replace(NewLinkName, "*", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, "&", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, "(", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, ")", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, ";", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, ":", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, "!", "", "ALL")>

	<cfset linkalias = form.LinkTitle>
    <cfset linkalias = replace(linkalias, " ", "-", "ALL")>
    <cfset linkalias = replace(linkalias, "'", "", "ALL")>
    <cfset linkalias = replace(linkalias, "!", "", "ALL")>
    <cfset linkalias = replace(linkalias, "@", "", "ALL")>
    <cfset linkalias = replace(linkalias, "$", "", "ALL")>
    <cfset linkalias = replace(linkalias, "%", "", "ALL")>
    <cfset linkalias = replace(linkalias, "^", "", "ALL")>
    <cfset linkalias = replace(linkalias, "*", "", "ALL")>
    <cfset linkalias = replace(linkalias, "(", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ")", "", "ALL")>
    <cfset linkalias = replace(linkalias, "/", "", "ALL")>	
    <cfset linkalias = replace(linkalias, "\", "", "ALL")>
    <cfset linkalias = replace(linkalias, "|", "", "ALL")>
    <cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
    <cfset linkalias = replace(linkalias, ">", "", "ALL")>    
    <cfset linkalias = replace(linkalias, ";", "", "ALL")>
    <cfset linkalias = replace(linkalias, ":", "", "ALL")>
    <cfset linkalias = replace(linkalias, '"', "", "ALL")>
    <cfset linkalias = replace(linkalias, ".", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ",", "", "ALL")> 


	<cfif UseSSL IS 'No'>
		<cfset linkurl = '#form.pagetemplate#?page=#form.page#'>
    <cfelse>
    	<cfset linkurl = '#request.secureurl##form.pagetemplate#?page=#form.page#'>
    </cfif>

    <cfif form.loadinframe IS 'Yes'>
		<cfset linkurl = '#linkurl#&lf=t'>
    </cfif>           	        	

    <cfif form.widgetsleft IS 'hide'>
		<cfset linkurl = '#linkurl#&hwl=t'>
    </cfif>           	
    <cfif form.widgetsright IS 'hide'>
		<cfset linkurl = '#linkurl#&hwr=t'>
    </cfif>

	<!---Insert the link information into the database--->
	<cfquery name = "qryInsertLink" datasource="#request.dsn#">
	INSERT INTO nav_links
	(LinkTitle, Ordervalue, filename, filelocation, linktarget, linktype, UseSSL, MenuID, SubLinkOf, LinkPath, PageTitle, MetaDescription, MetaKeywords, LinkImage, LinkRolloverImage, widgetsleft, widgetsright, linkurl, pagetemplate, loadinframe, bgColor, urlrw)
	VALUES
	('#NewLinkName#', #form.OrderValue#, '#NewFileName#', '/docs/', '#form.linktarget#', 'PageLink', '#form.UseSSL#', '#url.mView#', '#thisSubLinkOf#', '#thisLinkPath#', '#form.PageTitle#', 
'#form.MetaDescription#', '#form.MetaKeywords#', '#form.LinkImage#', '#form.LinkRolloverImage#', '#form.widgetsleft#', '#form.widgetsright#', '#linkurl#', '#form.pagetemplate#', '#form.loadinframe#', '#form.bgColor#', '#linkalias#')
	</cfquery>
	
</cfif>

<cfif form.LinkType IS 'CustomLink'>
	<!---Replace all illgegal characters in the link title--->
	<cfset NewLinkName = replace(form.LinkTitle, "'", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, '"', '', 'ALL')>
	<cfset NewLinkName = replace(NewLinkName, "*", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, "&", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, "(", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, ")", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, ";", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, ":", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, "!", "", "ALL")>

	<cfset linkalias = form.linktitle>
    <cfset linkalias = replace(linkalias, " ", "-", "ALL")>
    <cfset linkalias = replace(linkalias, "'", "", "ALL")>
    <cfset linkalias = replace(linkalias, "!", "", "ALL")>
    <cfset linkalias = replace(linkalias, "@", "", "ALL")>
    <cfset linkalias = replace(linkalias, "$", "", "ALL")>
    <cfset linkalias = replace(linkalias, "%", "", "ALL")>
    <cfset linkalias = replace(linkalias, "^", "", "ALL")>
    <cfset linkalias = replace(linkalias, "*", "", "ALL")>
    <cfset linkalias = replace(linkalias, "(", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ")", "", "ALL")>
    <cfset linkalias = replace(linkalias, "/", "", "ALL")>	
    <cfset linkalias = replace(linkalias, "\", "", "ALL")>
    <cfset linkalias = replace(linkalias, "|", "", "ALL")>
    <cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
    <cfset linkalias = replace(linkalias, ">", "", "ALL")>    
    <cfset linkalias = replace(linkalias, ";", "", "ALL")>
    <cfset linkalias = replace(linkalias, ":", "", "ALL")>
    <cfset linkalias = replace(linkalias, '"', "", "ALL")>
    <cfset linkalias = replace(linkalias, ".", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ",", "", "ALL")> 

	<cfset linkurl = form.linkurl>

	<cfquery name = "qryInsertLink" datasource="#request.dsn#">
	INSERT INTO nav_links
	(LinkTitle, Ordervalue, linkurl, linktarget, linktype, UseSSL, MenuID, SubLinkOf, LinkPath, PageTitle, MetaDescription, MetaKeywords, LinkImage, LinkRolloverImage, widgetsleft, widgetsright, pagetemplate, loadinframe, bgColor, urlrw)
	VALUES
	('#NewLinkName#', #form.OrderValue#, '#linkurl#', '#form.linktarget#', 'CustomLink', 'No', '#url.mView#', '#thisSubLinkOf#', '#thisLinkPath#' , '#form.PageTitle#', 
'#form.MetaDescription#', '#form.MetaKeywords#', '#form.LinkImage#', '#form.LinkRolloverImage#', 'show', 'show', 'index.cfm', 'No', '#form.bgColor#', '#linkalias#')
	</cfquery>
</cfif>

<cfif form.LinkType IS 'PluginLink'>
	<!---Replace all illgegal characters in the link title--->
	<cfset NewLinkName = replace(form.LinkTitle, "'", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, '"', '', 'ALL')>
	<cfset NewLinkName = replace(NewLinkName, "*", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, "&", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, "(", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, ")", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, ";", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, ":", "", "ALL")>
	<cfset NewLinkName = replace(NewLinkName, "!", "", "ALL")>
	
	<cfset linkalias = form.linktitle>
    <cfset linkalias = replace(linkalias, " ", "-", "ALL")>
    <cfset linkalias = replace(linkalias, "'", "", "ALL")>
    <cfset linkalias = replace(linkalias, "!", "", "ALL")>
    <cfset linkalias = replace(linkalias, "@", "", "ALL")>
    <cfset linkalias = replace(linkalias, "$", "", "ALL")>
    <cfset linkalias = replace(linkalias, "%", "", "ALL")>
    <cfset linkalias = replace(linkalias, "^", "", "ALL")>
    <cfset linkalias = replace(linkalias, "*", "", "ALL")>
    <cfset linkalias = replace(linkalias, "(", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ")", "", "ALL")>
    <cfset linkalias = replace(linkalias, "/", "", "ALL")>	
    <cfset linkalias = replace(linkalias, "\", "", "ALL")>
    <cfset linkalias = replace(linkalias, "|", "", "ALL")>
    <cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
    <cfset linkalias = replace(linkalias, ">", "", "ALL")>    
    <cfset linkalias = replace(linkalias, ";", "", "ALL")>
    <cfset linkalias = replace(linkalias, ":", "", "ALL")>
    <cfset linkalias = replace(linkalias, '"', "", "ALL")>
    <cfset linkalias = replace(linkalias, ".", "", "ALL")>	
    <cfset linkalias = replace(linkalias, ",", "", "ALL")> 


	<cfinclude template = "../queries/qrycomponents.cfm">

	<cfif UseSSL IS 'No'>
		<cfset linkurl = '#form.pagetemplate#?action=#qryComponents.action#'>
    <cfelse>
    	<cfset linkurl = '#request.secureurl##form.pagetemplate#?action=#qryComponents.action#'>
    </cfif>	

    <cfif form.loadinframe IS 'Yes'>
		<cfset linkurl = '#linkurl#&lf=t'>
    </cfif>           	

    <cfif form.widgetsleft IS 'hide'>
		<cfset linkurl = '#linkurl#&hwl=t'>
    </cfif>           	
    <cfif form.widgetsright IS 'hide'>
		<cfset linkurl = '#linkurl#&hwr=t'>
    </cfif>
    
	<cfquery name = "qryInsertLink" datasource="#request.dsn#">
	INSERT INTO nav_links
	(LinkTitle, Ordervalue, linkurl, linktarget, linktype, pluginname, UseSSL, MenuID, SubLinkOf, LinkPath, PageTitle, MetaDescription, MetaKeywords, pluginid, LinkImage, LinkRolloverImage, widgetsleft, widgetsright, pagetemplate, loadinframe, bgColor, urlrw)
	VALUES
	('#NewLinkName#', #form.OrderValue#, '#linkurl#', '#form.linktarget#', 'PluginLink', '#qrycomponents.Name#', 'No', '#url.mView#', '#thisSubLinkOf#', '#thisLinkPath#' , '#form.PageTitle#', 
'#form.MetaDescription#', '#form.MetaKeywords#', '#form.pluginid#', '#form.LinkImage#', '#form.LinkRolloverImage#', '#form.widgetsleft#', '#form.widgetsright#', '#form.pagetemplate#', '#form.loadinframe#', '#form.bgColor#', '#linkalias#')
	</cfquery>
</cfif>

<cfif form.LinkType IS 'CategoryLink'>
	<!---Replace all illgegal characters in the link title--->
	
	<cfif len(trim(form.LinkTitle)) GT 0>
		<cfset NewLinkName = replace(form.LinkTitle, "'", "", "ALL")>
        <cfset NewLinkName = replace(NewLinkName, '"', '', 'ALL')>
        <cfset NewLinkName = replace(NewLinkName, "*", "", "ALL")>
        <cfset NewLinkName = replace(NewLinkName, "&", "", "ALL")>
        <cfset NewLinkName = replace(NewLinkName, "(", "", "ALL")>
        <cfset NewLinkName = replace(NewLinkName, ")", "", "ALL")>
        <cfset NewLinkName = replace(NewLinkName, ";", "", "ALL")>
        <cfset NewLinkName = replace(NewLinkName, ":", "", "ALL")>
        <cfset NewLinkName = replace(NewLinkName, "!", "", "ALL")>

		<cfset linkalias = form.linktitle>
        <cfset linkalias = replace(linkalias, " ", "-", "ALL")>
        <cfset linkalias = replace(linkalias, "'", "", "ALL")>
        <cfset linkalias = replace(linkalias, "!", "", "ALL")>
        <cfset linkalias = replace(linkalias, "@", "", "ALL")>
        <cfset linkalias = replace(linkalias, "$", "", "ALL")>
        <cfset linkalias = replace(linkalias, "%", "", "ALL")>
        <cfset linkalias = replace(linkalias, "^", "", "ALL")>
        <cfset linkalias = replace(linkalias, "*", "", "ALL")>
        <cfset linkalias = replace(linkalias, "(", "", "ALL")>	
        <cfset linkalias = replace(linkalias, ")", "", "ALL")>
        <cfset linkalias = replace(linkalias, "/", "", "ALL")>	
        <cfset linkalias = replace(linkalias, "\", "", "ALL")>
        <cfset linkalias = replace(linkalias, "|", "", "ALL")>
        <cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
        <cfset linkalias = replace(linkalias, ">", "", "ALL")>    
        <cfset linkalias = replace(linkalias, ";", "", "ALL")>
        <cfset linkalias = replace(linkalias, ":", "", "ALL")>
        <cfset linkalias = replace(linkalias, '"', "", "ALL")>
        <cfset linkalias = replace(linkalias, ".", "", "ALL")>	
        <cfset linkalias = replace(linkalias, ",", "", "ALL")> 

	</cfif>

	<!---If no title given then assign categoryname as title--->
	<cfif len(trim(form.LinkTitle)) IS 0>
		<cfinclude template = "../queries/qrycategories.cfm">

		<cfoutput query = "qryCategories">
        	<cfset NewLinkName = categoryname>
            <cfset linkalias = urlrw>
        </cfoutput>
        
        <!---if not title is chosen then use default shop now title if top level is selected--->
        <cfif form.category IS 0>
        	<cfset NewLinkName = 'Shop Now'>
            <cfset linkalias = 'Shop-Now'>
        </cfif>
	</cfif>

	<cfif UseSSL IS 'No'>
		<cfset linkurl = '#form.pagetemplate#?action=viewcategory&category=#form.category#'>
    <cfelse>
    	<cfset linkurl = '#request.secureurl##form.pagetemplate#?action=viewcategory&category=#form.Category#'>
    </cfif>	

    <cfif form.loadinframe IS 'Yes'>
		<cfset linkurl = '#linkurl#&lf=t'>
    </cfif>           	

    <cfif form.widgetsleft IS 'hide'>
		<cfset linkurl = '#linkurl#&hwl=t'>
    </cfif>           	
    <cfif form.widgetsright IS 'hide'>
		<cfset linkurl = '#linkurl#&hwr=t'>
    </cfif>
    
	<cfquery name = "qryInsertLink" datasource="#request.dsn#">
	INSERT INTO nav_links
	(LinkTitle, Ordervalue, linkurl, linktarget, linktype, UseSSL, MenuID, SubLinkOf, LinkPath, PageTitle, MetaDescription, MetaKeywords, categoryid, LinkImage, LinkRolloverImage, widgetsleft, widgetsright, pagetemplate, loadinframe, bgColor, urlrw)
	VALUES
	('#NewLinkName#', #form.OrderValue#, '#linkurl#', '#form.linktarget#', 'CategoryLink', 'No', '#url.mView#', '#thisSubLinkOf#', '#thisLinkPath#' , '#form.PageTitle#', 
'#form.MetaDescription#', '#form.MetaKeywords#', '#form.category#', '#form.LinkImage#', '#form.LinkRolloverImage#', '#form.widgetsleft#', '#form.widgetsright#', '#form.pagetemplate#', '#form.loadinframe#', '#form.bgColor#', '#linkalias#')
	</cfquery>
</cfif>

<!---write to htaccess for url rewrites--->
<cffile action = "append" output="ReWriteRule ^#linkalias#$ #linkurl# " file="#request.catalogpath#.htaccess" addnewline="yes">

<cflocation url = "index.cfm?mView=#url.mView#&nview=#url.nView#&level=#level#">