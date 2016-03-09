<!---Deletes all the checked orders--->

<cfif NOT isdefined ('form.OrderDeleted')>
<b><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Error: You must 
at least check one order. Hit your browsers back button.</font></b> 
<cfabort>
</cfif>

<cfloop index="LoopIndex" FROM="1" TO="#ListLen(form.OrderDeleted)#">
<cfset DeleteThisOrder = ListGetAt(#form.OrderDeleted#, LoopIndex)>

<!--- Get Order Number to Update Central Affiliates --->
<cfquery name = "getOrderno" datasource = "#request.dsn#">
SELECT Ordernumber FROM orders
WHERE OrderID = #DeleteThisOrder#
</cfquery>

<CFQUERY Name = "DeleteOrder" DATASOURCE = "#request.dsn#">
DELETE FROM orders
WHERE OrderID = #DeleteThisOrder#
</CFQUERY>

<!---Now update the Local Affiliates info--->

<cfquery name = "UpdateOrder" datasource = "#request.dsn#">
UPDATE afl_transactions
SET OrderStatus = 'Deleted - Bad Order',
SaleAmount = 0.00,
Commission = 0.00
WHERE Ordernumber = '#getOrderno.Ordernumber#'
</cfquery>

</cfloop>

<cflocation url = "doorders.cfm?action=delete&disp=#form.disp#&paid=#form.paid#&start=#form.start#">




















