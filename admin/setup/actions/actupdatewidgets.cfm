<!---Updates the widgets and saves their settings--->
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfloop from = "1" to="#listlen(form.id)#" index="mycount">
	<cfset thisid = listgetat(form.id, mycount)>
    <cfset thisorderval = listgetat(form.ordervalue, mycount)>
    <cfset thisisvisible = listgetat(form.isvisible, mycount)>
    <cfset thistitle = listgetat(form.widgettitle, mycount)>
    <cfset thisposition = listgetat(form.widgetposition, mycount)>
    
    <cfquery name = "qryUpdateWidgets" datasource="#request.dsn#">
    UPDATE widgets SET isvisible = '#thisisvisible#',
    ordervalue = #thisorderval#,
    widgettitle = '#thistitle#',
    widgetposition = '#thisposition#'
    WHERE id = #thisid#
    </cfquery>
    
</cfloop>
Widget settings were saved!

<cfinvoke component="#funcpath#admin.functions.dumpsettings" method="WriteSettings" returnvariable="outputmsg">
	<cfinvokeargument name="cfdsn" value="#request.dsn#">
	<cfinvokeargument name="path" value="#request.catalogpath#">
</cfinvoke>







