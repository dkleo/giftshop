<cfquery name = "qrySubscribers" datasource="#request.dsn#">
SELECT * FROM customers_subscriptions
WHERE r_id = '#subscription#'
</cfquery>















