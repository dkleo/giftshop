<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<h2>Selling Tools Page</h2>
<cffile action = "write" file = "#request.CatalogPath#affiliates#request.bslash#pages#request.bslash#sellingtools.cfm" output="#form.EditPage#">
Your Selling Tools Page Has Been Saved.