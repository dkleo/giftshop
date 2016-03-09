<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>
<cfset thefooter = form.storefooter>

<cffile action = "Write" file = "#request.CatalogPath##request.bslash#docs#request.bslash#footer.cfm" Output = "#thefooter#">

<h2 align="center">The Store footer was Updated!<br></h2>
<p align="center">
<a href = "dofootermanager.cfm">Back to editing the Store footer</a><br>
</p>
















