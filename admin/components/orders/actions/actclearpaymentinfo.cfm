<!---removes the payment info from the db--->
<cfquery name = "qryRemovePaymentDetails" datasource="#request.dsn#">
UPDATE orders SET CreditCardNumber = '',
CCConfirmationNumber = ''
WHERE OrderNumber = '#url.ordernumber#' AND CustomerID = '#url.CustomerID#'
</cfquery>

<cflocation url = "doorders.cfm?action=vieworder&CustomerID=#url.CustomerID#&OrderNumber=#url.OrderNumber#">



















