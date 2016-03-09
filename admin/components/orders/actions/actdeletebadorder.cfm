<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif NOT ISDEFINED('url.Confirm') AND NOT isdefined('url.DeleteCustomer')>
  <cfoutput>
    <div align="Center"> 
      <p><strong>This will ONLY delete the order this customer placed.</strong></p>
      <p><strong>Would you like to remove this customer's address information and account too?</strong></p>
      <p><strong>Note</strong>: You can only remove the account if there are no other orders in the system <br />
        placed by 
        this customer
      .</p>
      <p><strong><a href = "doorders.cfm?action=BadOrder&DeleteCustomer=Yes&CustomerID=#Url.CustomerID#&OrderNumber=#url.ordernumber#">Yes</a> 
        &nbsp;&nbsp;|&nbsp;&nbsp; <a href = "doorders.cfm?action=BadOrder&DeleteCustomer=No&CustomerID=#Url.CustomerID#&OrderNumber=#url.ordernumber#">No</a></strong></p>
    </div>
  </cfoutput>
</cfif>


<cfif NOT ISDEFINED('url.Confirm') AND isdefined('url.DeleteCustomer')>
  <cfoutput>
    <div align="Center">
      <p><strong><font color="##FF0000">**WARNING**</font></strong></p>
      <p><strong>You are about to permanently delete an order that was placed <br>
	  <cfif url.DeleteCustomer IS 'Yes'>
	    AND possibly the customer
	  </cfif> from the database.</strong></p>
      <p><strong>        If you have inventory enabled, inventory<br>
        for the item(s) placed will be recalculated as well<br>
      as the statistics for the item(s)</strong><strong>.</strong></p>
      <p><strong> Are you absolutely sure you want to do this?</strong></p>
      <p><strong> <a href = "doorders.cfm?action=BadOrder&Confirm=Yes&CustomerID=#Url.CustomerID#&DeleteCustomer=#url.DeleteCustomer#&OrderNumber=#url.ordernumber#">Yes</a> 
        &nbsp;&nbsp;|&nbsp;&nbsp; <a href = "doorders.cfm">No</a></strong></p>
    </div>
  </cfoutput>
</cfif>
<cfif ISDEFINED('url.confirm')>

<!---If inventory is enabled then restock the item(s)--->
<cfif request.EnableInventory IS 'Yes'>

<!---query all the new orders this person placed and select just the ones that are in 
received status.  This way any legitimate orders will not be removed--->
<cfquery name="qryOrders" datasource="#request.dsn#">
SELECT * FROM orders
WHERE CustomerID = #url.customerID#
AND OrderNumber = '#url.OrderNumber#'
</cfquery>

<!---Remove the order--->
<cfloop query = "qryOrders">
<cfloop index="IndexCount" from="1" To="#ListLen(qryOrders.CrtProductID, "^")#">
<cfoutput>
<cfset ProdID = #ListGetAt(qryOrders.CrtItemID, IndexCount, "^")#>
<cfset ProdName = #ListGetAt(qryOrders.CrtProductName, IndexCount, "^")#>
<cfset ProdQty = #ListGetAt(qryOrders.CrtQuantity, IndexCount, "^")#>
</cfoutput>

<cfquery name = "FindProduct" datasource="#request.dsn#">
SELECT *
FROM products
WHERE ItemID = #ProdID#
</cfquery>

<cfoutput query = "FindProduct">
<cfset NewUnitsInStock = #UnitsInStock# + #ProdQty#>
<cfset NewUnitsSold = #UnitsSold# - #ProdQty#>
</cfoutput>

<cfif NOT #FindProduct.RecordCount# IS 0>
<cfif isdefined('NewUnitsInStock')>
<cfquery name = "UpdateStock" datasource="#request.dsn#">
UPDATE products
SET UnitsInStock = '#NewUnitsInStock#',
UnitsSold = '#NewUnitsSold#'
WHERE ItemID = #ProdID#
</cfquery>
</cfif>
</cfif>
</cfloop>
</cfloop>
</cfif>

<!---If they want to remove the customer information too, then delete it--->
<cfif url.DeleteCustomer IS 'Yes'>

<!---Check to make sure they don't have other orders in the system--->
<cfquery name = "qryCheckOrders" Datasource="#Request.dsn#">
SELECT * FROM orders
WHERE CustomerID = #url.CustomerID#
</cfquery>

<!---If there aren't any other orders then remove the customer--->
	<cfif qryCheckOrders.recordcount IS 0>
		<cfquery name = "DeleteCustomer" Datasource="#Request.dsn#">
		DELETE FROM customerhistory
		WHERE CustomerID = #url.CustomerID#
		</cfquery>
	</cfif>
</cfif>

<cfquery name = "qryOrders" Datasource="#Request.dsn#">
DELETE FROM orders
WHERE CustomerID = #url.CustomerID# AND ordernumber = '#url.ordernumber#'
</cfquery>

<!--- Update Affiliates --->
<cfquery name = "UpdateAff" datasource="#request.dsn#">
UPDATE afl_transactions
SET OrderStatus = 'Deleted - Bad Order',
SaleAmount = 0.00,
Commission = 0.00
WHERE OrderNumber = '#url.OrderNumber#'
</cfquery>

<cflocation url="doorders.cfm">
</cfif>



















