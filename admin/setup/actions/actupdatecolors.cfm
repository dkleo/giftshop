<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>
<cfset funcpath = replace(request.absolutepath, "/", "", "ALL")>

<cfif NOT len(funcpath) IS 0>   
	<cfset funcpath = "#funcpath#.">
</cfif>

<cfinvoke component="#funcpath#admin.functions.dbqueries" method="updatedata" returnvariable="outputmsg">
	<cfinvokeargument name="tablename" value="customstyles">
	<cfinvokeargument name="dbname" value="#request.dsn#">
	<cfinvokeargument name="dbuser" value="">
	<cfinvokeargument name="dbpass" value="">
	<cfinvokeargument name="wherestring" value = "">
</cfinvoke>

<center><h3>Styles were saved!</h3></center>
<p>
<center><a href = "dosetup.cfm?action=storecolors">Click here to go back</a></center>

<cfset funcpath = replace(request.absolutepath, "/", "", "ALL")>
<cfif NOT len(funcpath) IS 0>   
	<cfset funcpath = "#funcpath#.">
</cfif>

<cfinvoke component="#funcpath#admin.functions.dumpsettings" method="WriteSettings" returnvariable="outputmsg">
	<cfinvokeargument name="cfdsn" value="#request.dsn#">
	<cfinvokeargument name="path" value="#request.catalogpath#">
</cfinvoke>