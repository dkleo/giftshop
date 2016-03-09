<cfquery name = "qryoptions2" datasource="#request.dsn#">
SELECT * FROM options
<cfif ISDEFINED('form.fieldname')>WHERE FieldName = '#form.FieldName#'</cfif>
ORDER BY OrderID ASC
</cfquery>




















