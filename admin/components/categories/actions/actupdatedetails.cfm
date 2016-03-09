<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cffile action = "write" file = "#request.CatalogPath#docs#request.bslash#categories#request.bslash#category_#form.categoryid#.cfm" output="#form.details#" mode="666">
<center><b>Category Description Saved.</b></center><br>
<center><a href = "index.cfm">Back to Categories</a></center>





















