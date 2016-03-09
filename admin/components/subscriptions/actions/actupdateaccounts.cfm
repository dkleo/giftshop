<cfparam name="subscription" default="0">
<cfparam name="searchstring" default="null">

<cfloop from = "1" to = "#listlen(form.ids)#" index="i">
	<cfset thisid = listgetat(form.ids, i)>
    <cfset thisstatus = listgetat(form.status, i)>
    
    <cfquery name = "qryUpdateAccounts" datasource="#request.dsn#">
    UPDATE customers_subscriptions
    SET status = '#thisstatus#'
    WHERE id = #thisid#
    </cfquery>
</cfloop>

<cflocation url = "index.cfm?subscription=#url.subscription#&searchstring=#url.searchstring#&wasupdate=true">















