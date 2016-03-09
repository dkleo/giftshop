<cfquery name = "qryCategories" datasource="#request.dsn#">
SELECT * FROM categories
<cfif isdefined('form.category')>WHERE categoryid = #form.category#</cfif>
</cfquery>





















