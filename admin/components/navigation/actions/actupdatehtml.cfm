<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cffile action = "Write" file = "#request.CatalogPath##request.bslash#docs#request.bslash#navigation.cfm" Output = "#form.navhtml#">

<h2 align="center">Site Navigation HTML was saved.<br></h2>
<p align="center">
<a href = "index.cfm">Back to editing the Site Navigation HTML</a><br>
</p>
