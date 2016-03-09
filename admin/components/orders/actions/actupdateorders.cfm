<!---updated for version 5.4 in which ordered items are now stored in a separate table--->
<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfparam name = "paid" default="yes">
<cfparam name = "sortorder" default="DESC">
<cfparam name = "sortby" default="dateoforder">

<cfif isdefined('form.OrderID')>
<cfloop index="LoopIndex" FROM="1" TO="#ListLen(form.OrderID)#">
	<cfset UpdateThisItem = ListGetAt(#form.OrderID#, LoopIndex)>
	<cfset thistrname = ListGetAt(#form.trnames#, LoopIndex)>
	<cfset Thisorderstatus = ListGetAt(#form.orderstatus#, LoopIndex)>
	<cfset ThisOldorderstatus = ListGetat(#form.Oldorderstatus#, LoopIndex)>
	<cfset ThisIsPaidStatus = ListGetAt(#form.ispaid#, LoopIndex)>
    <cfset ThisPaymentStatus = ListGetAt(#form.paymentstatus#, LoopIndex)>
	<cfset ThisOrderNumber = ListGetat(#form.OrderNumber#, LoopIndex)>
	<cfset ThisCustEmail = ListGetat(#form.CustEmail#, LoopIndex)>
	<cfset ThisCustEmail = replace(ThisCustEmail, "'", "", "ALL")>
	<cfset ThisTransType = ListGetat(#form.TransType#, LoopIndex)>
	<cfif listlen(form.pnref) GT LoopIndex OR listlen(form.pnref) IS LoopIndex>
		<cfset ThisPNREF = ListGetat(#form.pnref#, LoopIndex)>
    <cfelse>
    	<cfset ThisPNREF = '00000'>
    </cfif>

	<!--- Get Order Number to Update Affiliates --->
	<cfquery name = "getOrderno" datasource = "#request.dsn#">
	SELECT Ordernumber,notes,OrderTotal,QuotedShipping,FiguredTax FROM orders
	WHERE OrderID = #UpdateThisItem#
	</cfquery>
	
	<!---Set the subtotal for the order (used below)--->
	<cfset OrderSubTotal = getOrderNo.OrderTotal - (getOrderNo.QuotedShipping + getOrderNo.FiguredTax)>

	<!---****Setup lists to loop over to restock items****--->
	<!---Set status--->
	<cfset shipped_form = 'form.shipped_#thistrname#'>
	<cfif isdefined(shipped_form)>
		<cfset shippedlist = evaluate(shipped_form)>
		<cfset shippedlist = replace(shippedlist, ",", "^", "ALL")>
	</cfif>

	<!---Get old status--->
	<cfset oldshipped_form = 'form.oldshipped_#thistrname#'>
	<cfif isdefined(oldshipped_form)>
		<cfset oldshippedlist = evaluate(oldshipped_form)>
		<cfset oldshippedlist = replace(oldshippedlist, ",", "^", "ALL")>
	</cfif>

	<!---Set Tracking Numbers--->
	<cfset tracking_form = 'form.trackingnumber_#thistrname#'>
	<cfif isdefined(tracking_form)>
		<cfset trackingnumbers = evaluate(tracking_form)>
		<cfset trackingnumbers = replace(trackingnumbers, ",", "^", "ALL")>
	</cfif>

	<!---Set Package Numbers--->
	<cfset package_form = 'form.package_#thistrname#'>
	<cfif isdefined(package_form)>
		<cfset packagenumbers = evaluate(package_form)>
		<cfset packagenumbers = replace(packagenumbers, ",", "^", "ALL")>
	</cfif>

	<!---Get ItemIDs--->
	<cfset items_form = 'form.itemid_#thistrname#'>
	<cfif isdefined(items_form)>
		<cfset itemids = evaluate(items_form)>
		<cfset itemids = replace(itemids, ",", "^", "ALL")>
	</cfif>	

	<!---Get Quantities--->
	<cfset quantity_form = 'form.quantity_#thistrname#'>
	<cfif isdefined(quantity_form)>
		<cfset quantities = evaluate(quantity_form)>
		<cfset quantities = replace(quantities, ",", "^", "ALL")>
	</cfif>
    
   	<!---If inventory is enabled then update the stock if items were cancelled on this order--->
	<cfif request.EnableInventory IS 'Yes'>
		<cfinclude template = "actrestock.cfm">
	</cfif>
    	
	<!---****END RESTOCK ROUTINE***--->
    
	<!---update each item on this order--->
    <cfloop from = "1" to="#listlen(itemids, '^')#" index="L">
    
    <cfset itemid = listgetat(itemids, L, "^")>
    <cfif NOT listlen(trackingnumbers, "^") IS listlen(itemids, "^")>
    	You left a tracking number field blank.  Please enter a zero in the field instead of leaving it blank.
        <cfabort>
    </cfif>
	<cfset trackingnumber = listgetat(trackingnumbers, L, "^")>
    <cfif NOT listlen(packagenumbers, "^") IS listlen(itemids, "^")>
    	You left a tracking number field blank.  Please enter a zero in the field instead of leaving it blank.
        <cfabort>
    </cfif>
	<cfset packagenumber = listgetat(packagenumbers, L, "^")>
    <cfset itemstatus = listgetat(shippedlist, L, "^")>
    
	<cfquery name = "qryUpdateItem" datasource="#request.dsn#">
    UPDATE orders_items
    SET item_tracking = '#trackingnumber#',
    item_package = '#packagenumber#',
    item_status ='#itemstatus#'
    WHERE itemid = '#itemid#' AND ordernumber = '#thisordernumber#'
    </cfquery>
    
    </cfloop>
	
	<!---Set Notes--->
	<cfset thesenotes = #getOrderno.notes#>
	<cfset notes_form = 'form.notes_#thistrname#'>
	<cfif isdefined(notes_form)>
		<cfset thesenotes = evaluate(notes_form)>
	</cfif>

	<cfquery name = "UpdateOrder" datasource = "#request.dsn#">
		UPDATE orders
		SET orderstatus = '#Thisorderstatus#',
		paid = '#ThisIsPaidStatus#',
        paymentstatus = '#ThisPaymentStatus#',
		notes = '#thesenotes#'
		<cfif isdefined(tracking_form)>,
			crtTrackingNumbers = '#trackingnumbers#'
		</cfif>
		<cfif isdefined(package_form)>,
			crtPackageNumber = '#packagenumbers#'
		</cfif>
		<cfif isdefined(shipped_form)>,
			crtShipped = '#shippedlist#'
		</cfif>
		WHERE OrderID = #UpdateThisItem#

	</cfquery>
	
	<!---If the order was cancelled then set the commission to 0 and the saleamount to zero--->
	<cfif OrderStatus IS 'Cancelled'>
		<cfset ud_SaleAmount = 0>
		<cfset ud_Commission = 0>
	<cfelse>
	<!---Otherwise set it to whatever it is supposed to be--->

		<!---Get commission rate for affiliates--->
		<cfquery name="getcomm" datasource="#Request.DSN#">
		SELECT * FROM settings_main
		</cfquery>
	
		<!---Calculate the affiliates commission--->
		<cfoutput>
			<cfset commish = evaluate(#OrderSubTotal# * evaluate(#getcomm.commrate# / 100))>
		</cfoutput>

		<cfset ud_SaleAmount = OrderSubTotal>
		<cfset ud_Commission = commish>
	
	</cfif>

	<!---Update Affiliate--->
		<cfquery name = "UpdateOrder3" datasource = "#request.dsn#">
		UPDATE afl_transactions
		SET orderstatus = '#Thisorderstatus#',
		SaleAmount = #ud_SaleAmount#, 
		Commission = #ud_Commission#
		WHERE OrderNumber = '#getOrderno.Ordernumber#'
	</cfquery>

<!---If the order status changed, email the customer to let them know the order status has changed--->
<cfif NOT Thisorderstatus IS ThisOldorderstatus>
<cfif ThisCustEmail CONTAINS '@'>
	<cfinclude template = "actemailorderstatus.cfm">
</cfif>
</cfif>
</cfloop>

</cfif>

<cflocation URL="doorders.cfm?paid=#paid#&sortorder=#sortorder#&sortby=#sortby#&ordersupdated=true">





















