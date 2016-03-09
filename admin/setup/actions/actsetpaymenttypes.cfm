<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Credit Cards--->
<cfoutput>
<cfif NOT isdefined("form.Visa") AND NOT isdefined("form.MasterCard") AND NOT isdefined("form.Discover") AND NOT isdefined("form.Amex") AND NOT isdefined("form.JCB") AND NOT isdefined("form.ACH")>
 <font face="Verdana" size="2">ERROR:  You have to have at least one credit card checked that you accept.
 <a href="javascript:history.go(-1);">Click here to go back</a>.</font>
<cfabort>
</cfif>
</cfoutput>

<cfif isdefined("form.mastercard")>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET MasterCard = 'Yes'
</CFQUERY>
<cfelse>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET MasterCard = 'No'
</CFQUERY>
</cfif>

<cfif isdefined("form.visa")>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET Visa = 'Yes'
</CFQUERY>
<cfelse>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET Visa = 'No'
</CFQUERY>
</cfif>

<cfif isdefined("form.Discover")>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET Discover = 'Yes'
</CFQUERY>
<cfelse>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET Discover = 'No'
</CFQUERY>
</cfif>

<cfif isdefined("form.AmEx")>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET AmEx = 'Yes'
</CFQUERY>
<cfelse>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET AmEx = 'No'
</CFQUERY>
</cfif>

<cfif isdefined("form.JCB")>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET JCB = 'Yes'
</CFQUERY>
<cfelse>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET JCB = 'No'
</CFQUERY>
</cfif>

<cfif isdefined("form.ACH")>
<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET ACH = 'Yes'
</CFQUERY>
<cfelse>

<CFQUERY Name = "UpdateUnits" Datasource = "#request.dsn#">
UPDATE settings_processor
SET ACH = 'No'
</CFQUERY>
</cfif>


<p align = "center">Your settings were saved!</p>

<cfinvoke component="#funcpath#admin.functions.dumpsettings" method="WriteSettings" returnvariable="outputmsg">
	<cfinvokeargument name="cfdsn" value="#request.dsn#">
	<cfinvokeargument name="path" value="#request.catalogpath#">
</cfinvoke>







