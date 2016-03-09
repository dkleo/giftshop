<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset theEditPage = form.EditPage>
<cffile action = "Write" file = "#request.CatalogPath##request.bslash#docs#request.bslash##form.PageRef#" Output = "#theEditPage#" mode="777">

<cflocation url = 'dopages.cfm'>















