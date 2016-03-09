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

<cfif form.UseSSL IS 'No'>
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
<cfquery name = "qryUpdateLink" datasource="#request.dsn#">
UPDATE nav_links
SET LinkTitle = '#NewLinkName#',
UseSSL = '#form.UseSSL#',
linktarget = '#form.linktarget#',
SubLinkOf='#form.SubLinkOf#',
widgetsleft = '#form.widgetsleft#',
widgetsright = '#form.widgetsright#',
loadinframe = '#form.loadinframe#',
pagetemplate = '#form.pagetemplate#',
linkurl = '#linkurl#',
bgcolor = '#form.bgColor#'
WHERE id = #form.id#
</cfquery>

<cflocation url = "index.cfm?mView=#mView#&nview=#nview#&level=#level#">
