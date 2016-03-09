<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>
<CFQUERY Name = "UpdateUserInfo" Datasource = "#request.dsn#">
UPDATE companyinfo
SET CompanyName = '#form.CompanyName#',
FirstName = '#form.FirstName#',
LastName = '#form.LastName#',
Address = '#form.Address#',
Apt = '#form.Apt#',
City = '#form.City#',
State = '#form.State#',
Zip = '#form.Zip#',
Country = '#form.Country#',
PhoneNumber1 = '#form.Phone1#',
PhoneNumber2 = '#form.Phone2#',
emailaddress = '#form.emailaddress#'
</CFQUERY>

<cfset funcpath = replace(request.absolutepath, "/", "", "ALL")>
<cfif NOT len(funcpath) IS 0>
	<cfset funcpath = "#funcpath#.">
</cfif>

<cfinvoke component="#funcpath#admin.functions.dumpsettings" method="WriteSettings" returnvariable="outputmsg">
	<cfinvokeargument name="cfdsn" value="#request.dsn#">
	<cfinvokeargument name="path" value="#request.catalogpath#">
</cfinvoke>

<cflocation url="dosetup.cfm?updated=true">







