<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>
<cfif len(form.widgetname) LT 1>You must give your widget a name!<cfabort></cfif>

<cfquery name = "qryUpdateWidget" datasource="#request.dsn#">
UPDATE widgets SET widgetname='#form.widgetname#', 
widgettitle='#form.widgettitle#', 
widgetdesc='#form.widgetdesc#', 
isvisible='#form.isvisible#', 
widgetposition='#form.widgetposition#',
title_image = '#form.title_image#',
widgetcode='#form.widgetcode#', 
showtitle='#form.showtitle#',
custom_styles='#form.custom_styles#'
WHERE id = #form.id#
</cfquery>
<center>Widget settings saved.</center>
<p>
<center><a href = "dosetup.cfm?action=widgetsetup">Go back</a></center>

<cfset funcpath = replace(request.absolutepath, "/", "", "ALL")>
<cfif NOT len(funcpath) IS 0>
	<cfset funcpath = "#funcpath#.">
</cfif>

<cfinvoke component="#funcpath#admin.functions.dumpsettings" method="WriteSettings" returnvariable="outputmsg">
	<cfinvokeargument name="cfdsn" value="#request.dsn#">
	<cfinvokeargument name="path" value="#request.catalogpath#">
</cfinvoke>








