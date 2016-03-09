<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

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
	UPDATE nav_links
	SET LinkTitle='#NewLinkName#', 
	linkurl='#linkurl#', 
	linktarget='#form.linktarget#', 
	pluginname='#qryComponents.name#',
	useSSL='#form.UseSSL#',
	SubLinkOf='#form.SubLinkOf#',
    pluginid='#form.pluginid#',
    widgetsleft = '#form.widgetsleft#',
	widgetsright = '#form.widgetsright#',
    bgcolor = '#form.bgColor#'
	WHERE ID = #form.ID#
	</cfquery>

<cflocation url = "index.cfm?mView=#url.mView#&level=#level#&nview=#nview#">
