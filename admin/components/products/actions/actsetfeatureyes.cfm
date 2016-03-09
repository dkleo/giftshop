<cfquery name = "SetFeature" datasource = "#request.dsn#">
UPDATE products
SET IsFeatured = 'Yes'
WHERE ItemID = #url.itemid#
</cfquery>

<cfif NOT ISDEFINED('url.WasSearch')>
<cflocation url = "doproducts.cfm">
</cfif>

<cfif ISDEFINED('url.WasSearch')>
<cflocation url = "Doproducts.cfm?action=search">
</cfif>















