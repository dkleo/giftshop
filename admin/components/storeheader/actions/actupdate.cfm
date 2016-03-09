<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset theheader = form.storeheader>

<cffile action = "Write" file = "#request.CatalogPath##request.bslash#docs#request.bslash#header.cfm" Output = "#theheader#">

<h2 align="center">The Store Header was Updated!<br></h2>
<p align="center">
<a href = "doheadermanager.cfm">Back to editing the Store Header</a><br>
</p>
















