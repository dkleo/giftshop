<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>
<cfif len(form.widgetname) LT 1>You must give your widget a name!<cfabort></cfif>

<cfquery name = "qryOrder" datasource="#request.dsn#">
SELECT * FROM widgets ORDER BY ordervalue DESC
</cfquery>

<cfoutput query = "qryOrder" maxrows="1"><cfset nextordervalue = ordervalue + 1></cfoutput>

<cfset thewidgetname = replace(widgettitle, " ", "", "ALL")>

<!---check for illegal code (that could be a security risk)--->
<cfif form.widgetcode contains '<cffile' OR form.widgetcode CONTAINS '<cffile'>
	You cannot use the cffile command in a widgetbox.  Please remove that bit of code and try again.
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<cfdirectory' OR form.widgettitle CONTAINS '<cffile'>
	You cannot use the cfdirectory command in a widgetbox.  Please remove that bit of code and try again.
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<cfcontent' OR form.widgettitle CONTAINS '<cfcontent'>
	You cannot use the cfcontent command in a widgetbox.  Please remove that bit of code and try again.
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<cfregistry' OR form.widgettitle CONTAINS '<cfregistry'>
	You cannot use the cfregistry command in a widgetbox.  Please remove that bit of code and try again.
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<cfftp' OR form.widgettitle CONTAINS '<cfftp'>
	You cannot use the cfftp command in a widgetbox.  Please remove that bit of code and try again.
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<cfmail' OR form.widgettitle CONTAINS '<cfmail'>
	For security reasons we do not allow you the ability to use a cfmail tag within a widgetbox.  If you need to setup some sort of emailing application, please contact us for a customized solution.
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<cfmail' OR form.widgettitle CONTAINS '<cfmail'>
	For security reasons we do not give you the ability to use a cfmail tag within a widgetbox.  If you need to setup some sort of emailing application, please contact us for a customized solution.
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<cfmail' OR form.widgettitle CONTAINS '<cfmail'>
	For security reasons we do not give you the ability to use a cfmail tag within a widgetbox.  If you need to setup some sort of emailing application, please contact us for a customized solution.
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<cfexecute' OR form.widgettitle CONTAINS '<cfexecute'>
	You cannot use the cfexecute tag in a widgetbox.  Please remove it from you code.
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<CFLOG' OR form.widgettitle CONTAINS '<CFLOG'>
	You cannot use the cflog tag in a widgetbox.  Please remove it from you code.    
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<cfschedule' OR form.widgettitle CONTAINS '<cfschedule'>
	You cannot use the cfschedule tag in a widgetbox.  Please remove it from you code.
    <cfabort>
</cfif>

<cfif form.widgetcode contains '<?php' OR form.widgettitle CONTAINS '<?php'>
	For security reasons, you cannot use php script in a custom widgetbox.  You should only be copying and pasting javascript or html code into the code box, as anything else it too big of a security risk for your website.
    <cfabort>
</cfif>

<cfquery name = "qryAddCustomWidget" datasource="#request.dsn#">
INSERT INTO widgets
(widgetname, widgettitle, widgetdesc, widgetfile, ordervalue, isvisible, widgetposition, widgetcode, showtitle, candelete, enabled, custom_styles, title_image)
VALUES
('#form.widgetname#', '#form.widgettitle#', '#form.widgetdesc#', 'Custom', #nextordervalue#, 'Yes', '#form.widgetposition#', '#form.widgetcode#', '#form.showtitle#', 'Yes', 'Yes', '#form.custom_styles#', '#form.title_image#')
</cfquery>

You custom widget has been added. <a href = "dosetup.cfm?action=widgetsetup">Go Back</a>

<cfset funcpath = replace(request.absolutepath, "/", "", "ALL")>
<cfif NOT len(funcpath) IS 0>
	<cfset funcpath = "#funcpath#.">
</cfif>

<cfinvoke component="#funcpath#admin.functions.dumpsettings" method="WriteSettings" returnvariable="outputmsg">
	<cfinvokeargument name="cfdsn" value="#request.dsn#">
	<cfinvokeargument name="acfdsn" value="#request.dsn#">
	<cfinvokeargument name="path" value="#request.catalogpath#">
</cfinvoke>