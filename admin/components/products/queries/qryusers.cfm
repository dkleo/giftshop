<cfquery name = "qryUsers" datasource="#request.dsn#">
SELECT * FROM Logins
<cfif ISDEFINED('form.SearchBox')>WHERE lastname LIKE '%#form.SearchBox#%' OR firstname LIKE '%#form.SearchBox#%'
OR address LIKE '%#form.SearchBox#%' OR username LIKE '%#form.SearchBox#%'</cfif>
</cfquery>
















