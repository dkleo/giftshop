<cfquery name = "qrypromos" Datasource = "#request.dsn#">
SELECT *
FROM promos
<cfif ISDEFINED('url.promoid')>WHERE PromoID = #url.promoid# </cfif>
<cfif ISDEFINED('form.promoid')>WHERE PromoID = #form.promoid# </cfif>
</cfquery>







