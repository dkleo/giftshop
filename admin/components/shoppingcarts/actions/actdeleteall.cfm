<cfset TodaysDate = now()>
<cfset TodaysDate = #dateformat(TodaysDate, "yyyy-dd-mm")#>

<cfquery name = "DeleteAllCarts" datasource="#request.dsn#">
DELETE from shoppingcarts
WHERE dateentered <> '#TodaysDate#'
</cfquery>

<cflocation url = "doshoppingcarts.cfm">

















