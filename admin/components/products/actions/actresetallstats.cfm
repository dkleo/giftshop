<cfquery name="ResetStats" datasource="#request.dsn#">
UPDATE products
SET TimesViewed=0
</cfquery>

<cflocation url = "doproducts.cfm?action=ViewStats">















