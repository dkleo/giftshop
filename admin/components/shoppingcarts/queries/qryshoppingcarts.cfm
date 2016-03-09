<cfquery name = "qryShoppingCarts" datasource="#request.dsn#">
SELECT * FROM shoppingcarts
<cfif isdefined('url.carttoken')>WHERE carttoken = '#url.carttoken#'</cfif>
</cfquery>















