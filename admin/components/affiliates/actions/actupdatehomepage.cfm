<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<h2>Home Page</h2>
<cffile action = "write" file = "#request.CatalogPath#affiliates#request.bslash#pages#request.bslash#homepage.cfm" output="#form.EditPage#">
Your affiliate homepage has been saved.