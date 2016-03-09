<cfquery name = "qrydiscounts" Datasource = "#request.dsn#">
SELECT *
FROM discounts
WHERE ItemID = '#TempVar.EditID#'
<cfif ISDEFINED('url.Discountid')>AND DiscountID = #url.Discountid#</cfif>
<cfif ISDEFINED('form.Discountid')>AND DiscountID = #form.Discountid#</cfif>
ORDER by MinQ ASC
</cfquery>















