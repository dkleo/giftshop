<cfquery name = "qryDeleteCart" datasource="#request.dsn#">
DELETE FROM shoppingcarts
WHERE CartToken = '#url.CartToken#'
</cfquery>

<cflocation url = 'doshoppingcarts.cfm'>















