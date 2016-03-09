<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">
<cfparam name = "subscription" default = "0">
<cfparam name = "searchstring" default = "null">
<cfparam name = "customerid" default = "0">

<cfset TodaysDate = now()>
<!---If this is a subscription item, then find the info in the subscriptions product table (which should be there)--->
<cfquery name="qrySubscriptionItems" datasource="#request.dsn#">
	SELECT * FROM products_subscriptions
	WHERE r_id = '#url.subscription#'
</cfquery>

<!---determine what date it will expire on--->
<cfset expiremonth = #dateformat(DateAdd("m", 1, TodaysDate), "mm/dd/yyyy")#>
<!---check to see when subscription will expire--->
<cfif form.r_expiresin IS '1 Week'>
	<cfset expiredate = #dateformat(DateAdd("d", 7, TodaysDate), "mm/dd/yyyy")#>
</cfif>
<cfif form.r_expiresin IS '1 Month'>
	<cfset expiredate = #dateformat(DateAdd("m", 1, TodaysDate), "mm/dd/yyyy")#>
</cfif>
<cfif form.r_expiresin IS '3 Day'>
	<cfset expiredate = #dateformat(DateAdd("m", 3, TodaysDate), "mm/dd/yyyy")#>
</cfif>
<cfif form.r_expiresin IS '6 Months'>
	<cfset expiredate = #dateformat(DateAdd("m", 6, TodaysDate), "mm/dd/yyyy")#>
</cfif>
<cfif form.r_expiresin IS '1 Year'>
	<cfset expiredate = #dateformat(DateAdd("y", 1, TodaysDate), "mm/dd/yyyy")#>
</cfif>                
<cfif form.r_expiresin IS '2 Years'>
	<cfset expiredate = #dateformat(DateAdd("y", 2, TodaysDate), "mm/dd/yyyy")#>
</cfif>                                                      
<cfif form.r_expiresin IS 'Never'>
	<cfset expiredate = #dateformat(DateAdd("y", 100, TodaysDate), "mm/dd/yyyy")#>
</cfif>

<cfquery name = "qryDelete" datasource="#request.dsn#">
DELETE FROM customers_subscriptions
WHERE r_id = '#qrySubscriptionItems.r_id#' AND customerid = '#url.customerid#' AND status = 'Expired'
</cfquery>

<cfquery name = "InsertSubscriber" datasource="#request.dsn#">
INSERT INTO customers_subscriptions
(r_id, customerid, startdate, status, ordernumber, expiredate, subscription_length)
VALUES
('#qrySubscriptionItems.r_id#', '#url.CustomerID#', #createodbcdate(TodaysDate)#, 'Active', 'None', #createodbcdate(expiredate)#, '#qrySubscriptionItems.r_expiresin#')
</cfquery>

<cflocation url = "index.cfm?action=addaccounts&subscription=#subscription#&start=#start#&disp=#disp#&customerid=#customerid#&searchstring=#searchstring#">
















