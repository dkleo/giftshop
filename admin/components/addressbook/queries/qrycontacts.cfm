<cfquery name = "qrycontacts" Datasource = #request.dsn#>
SELECT *
FROM contacts
<cfif ISDEFINED('url.ContactID')>WHERE ContactID = #url.contactID#</cfif>
<cfif ISDEFINED('form.CompanyName')>WHERE CompanyName = '#form.CompanyName#'</cfif>
ORDER BY CompanyName ASC
</cfquery>



















