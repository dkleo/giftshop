<!---Write file--->
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>
<cfset thehomepage = form.homepage>

<cffile action = "Write"
file = "#request.CatalogPath#docs#request.bslash#homepage.cfm"
Output = "#thehomepage#">

<p align="center"><a href="dohomepageeditor.cfm">Click here to go back to the Home page Editor</a></p>



















