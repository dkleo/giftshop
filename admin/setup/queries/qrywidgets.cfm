<cfquery name = "qryWidgets" datasource="#request.dsn#">
SELECT * FROM widgets
<cfif isdefined('url.id')>WHERE id = #url.id# AND enabled = 'Yes'
<cfelse>
WHERE enabled = 'Yes'
</cfif>
ORDER BY ordervalue ASC
</cfquery>







