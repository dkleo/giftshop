<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif len(timr(form.linkurl)) LT 1>
	Error: You must enter a url<cfabort>
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

	<cfquery name = "qryInsertLink" datasource="#request.dsn#">
	UPDATE nav_links
	SET LinkTitle='#NewLinkName#', 
	linkurl='#form.linkurl#', 
	linktarget='#form.linktarget#',
	SubLinkOf='#form.SubLinkOf#',
	LinkImage='#form.LinkImage#',
	LinkRollOverImage='#form.LinkRollOverImage#',
    bgcolor = '#form.bgColor#'
	WHERE ID = #form.ID#
	</cfquery>

	<cflocation url = "index.cfm?mView=#url.mView#&level=#level#&nview=#nview#">