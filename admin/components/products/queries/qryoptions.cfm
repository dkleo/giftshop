<!---Gets the options for this product--->
<cfquery name = "qryoptions" datasource="#request.dsn#">
SELECT * FROM options 
<cfif ISDEFINED('ThisOptionField')>WHERE OptionID = #ThisOptionField#</cfif>
ORDER BY OrderID ASC
</cfquery>
















