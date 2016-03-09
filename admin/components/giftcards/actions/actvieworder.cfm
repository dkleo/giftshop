<cfinclude template = "../queries/qrycompanyinfo.cfm">

<style type="text/css">
<!--
.giftcode {
	font-size: 18px;
	font-weight: bold;
}
-->
</style>

<cfoutput>
  <div align = "center"> <b>
    <h2 align="left">Order Number #url.OrderNumber#</h2>
    </b> </div>
</cfoutput>

<cfquery name = "qryCustomers" datasource = "#Request.DSN#">
SELECT * FROM customerhistory
WHERE CustomerID = #URL.CustomerID#
</cfquery>

<cfquery name = "QryOrders" datasource = "#Request.DSN#">
SELECT * FROM orders
WHERE OrderNumber = '#url.OrderNumber#'
</cfquery>

<cfoutput query="QryOrders">
<cfif paid IS 'No'>
<div>
  <blockquote> <b><span style="color: ##FF0000"><span style="font-size: 14px">WARNING! </span><br />
        <span style="font-size: 10px">It appears that payment was not received for this order! Please check with your customer and/or payment processor. If you have received payment update this orders payment status.</span></span> <br />
</b></cfif>
<!---    Order Summary:</b> - Fraud Risk Level: 
    <cfif NOT FraudFlag IS ''><img src = "icons/#FraudFlag#Flag.gif"><cfelse>Not Available</cfif></div>
    <br>--->
  </blockquote>
    <div align="center">
      <center>
        <table width="90%" border="1" cellspacing="0" cellpadding="4" style="border-collapse: collapse" bordercolor="##111111">
          <tr class="TableTitles">
            <td class="TableTitles" width="50%" height="19" style="border-color:##000000; border-width:1; " >
              <b>Name</b></td>
            <td class="TableTitles" width="15%" height="19" style="border-color:##000000; border-width:1; " ><p align="center">
                <b>Price</b></p></td>
            <td class="TableTitles" width="10%" height="19" style="border-color:##000000; border-width:1; " ><p align="center">
                <b>Quantity</b></p></td>
            <td class="TableTitles" width="25%" height="19" align="center" style="border-color:##000000; border-width:1; " >
              <b>Total</b></td>
          </tr>
          <cfloop index="IndexCount" from="1" To="#ListLen(CrtProductID, "^")#">
             <tr>
                <td width="50%" style="border-color:##000000; border-width:1; " valign="middle">
					#ListGetAt(CrtProductID, IndexCount, "^")# - #ListGetAt(CrtProductName, IndexCount, "^")#</td>
                <td width="15%" style="border-color:##000000; border-width:1; " valign="middle">
                  <cfset EachPrice = ListGetAt(CrtPrice, IndexCount, "^") / ListGetAt(CrtQuantity, IndexCount, " ^")>
                  <p align="center">
              	  <cfif request.EnableEuro IS 'Yes'>
                	  #lseurocurrencyformat(EachPrice, "Local")#
              	  <cfelse>
                      #lscurrencyformat(EachPrice, "Local")#
                  </cfif>
                  </p>
                </td>
                <td width="10%" style="border-color:##000000; border-width:1; " valign="middle">
                  <p align="center"> #ListGetAt(CrtQuantity, IndexCount, "^")#</p></td>
                <td width="25%" align="right" style="border-color:##000000; border-width:1; ">
					<cfset TotalOfItems = #ListGetAt(CrtPrice, IndexCount, "^")#>
					<cfif request.EnableEuro IS 'Yes'>
                    <div align="right">#lseurocurrencyformat(TotalOfItems, "Local")#
                      <cfelse>
                      #lscurrencyformat(TotalOfItems, "Local")#</div>
                  </cfif></td>
            </tr>
          </cfloop>
          </tr>
          <tr>
            <td height="15" colspan="3" style="border-style: none"><div align="right">Discount
                (If any):</div></td>
            <td height="15" align="right" style="border-color:##000000; border-width:1; ">
        	<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(DiscountAmount, "Local")#<cfelse>#LSCurrencyFormat(DiscountAmount, "Local")#</cfif>
			</td>
          </tr>
          <tr>
            <td height="15" colspan="3" align="right">Gift Card Amount Applied <cfif len(giftcode) GT 0>(#giftcode#)</cfif>:</td>
            <td height="15" align="right">
        	<cfif len(giftamountused) GT 0>
			<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(giftamountused, "Local")#<cfelse>#LSCurrencyFormat(giftamountused, "Local")#</cfif>
			<cfelse>
			N/A
			</cfif>
			</td>
          </tr>	  	  
          <tr>
            <td height="15" colspan="3" style="border-style: none"><div align="right">Taxes:</div></td>
            <td height="15" align="right" style="border-color:##000000; border-width:1; "><strong>
				<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(FiguredTax, "Local")#
				<cfelse>#LSCurrencyformat(FiguredTax, "Local")#</cfif>
			</td>
          </tr>
          <tr>
            <td width="88%" height="15" colspan="3" style="border-style: none">
              <p align="right"><cfif NOT ShippingMethod IS 'N/A'>(#ShippingMethod#) - </cfif>Shipping &amp; Handling: </td>
            <td width="20%" height="15" align="right" style="border-color:##000000; border-width:1; ">
				<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(QuotedShipping, "Local")#
				<cfelse>#LSCurrencyformat(QuotedShipping, "Local")#</cfif>
			</td>
          </tr>
          <tr>
            <td width="88%" height="15" colspan="3" style="border-style: none">
              <p align="right"><b>Total:</b></p></td>
            <td width="20%" height="15" align="right" style="border-color:##000000; border-width:1; "><b>
                <cfif request.EnableEuro IS 'Yes'>
                  #lseurocurrencyformat(OrderTotal, "Local")#
                  <cfelse>
                  #lscurrencyformat(OrderTotal, "Local")#
                </cfif>
                </b></td>
          </tr>
        </table>
      </center>
    </div>
<cfset ThePaymentMethod = #PaymentMethod#>
</cfoutput>
<p>
<table width="90%" border="1" align="center" cellpadding="4" cellspacing="0">
      <tr>
        <td height="15" Class="TableTitles"><strong>Billing Information</strong></td>
        <td height="15" valign="top" Class="TableTitles"><strong>Ship Order To:</strong></td>
      </tr>
      <tr>
        <td height="15">
		<cfoutput query = "qryCustomers">
		#FirstName# #LastName#<br> #BusinessName# #address#<br> #city#, #State# &nbsp;&nbsp; #ZipCode#<br> #Country#<br> <p> <b>Email Address:</b> #EmailAddress#<br>
            <b> Phone Number:</b> #PhoneNumber# <br>
          </p>
          <p>&nbsp; </p>
		  </td>
        <td width="48%" height="15" valign="top"> 
		#qryOrders.ShippedTo#
		<p> <b>Coupon Code Used: </b> #qryOrders.PromoCode#
        <p><strong>Customer IP Address: #qryOrders.VisitorIP#</strong></td>
      </tr>
      <tr>
        <td height="15" colspan="2" Class="TableTitles">Customer Notes</td>
      </tr>
      <tr>
        <td height="15" colspan="2">#qryOrders.memo#</td>
      </tr>
	</cfoutput>
</table>

</div>

<cfif ISDEFINED('ThePaymentMethod')>
<blockquote>
<cfoutput>
<h4>Payment Method:
<cfif ThePaymentMethod IS 'CheckOrMoneyOrder'>

<cfset PayMethod = "Sending Check or Money order">
</cfif>
<cfif ThePaymentMethod IS 'CreditCard'>

<cfset PayMethod = "Credit Card">
</cfif>
    <cfif ThePaymentMethod IS 'PayPalcheckout'>

<cfset PayMethod = "Paid with PayPal">
</cfif>
    <cfif ThePaymentMethod IS 'DeptAcctCode'>

<cfset PayMethod = "Department and Account Code">
</cfif>
    <cfif ThePaymentMethod IS 'POAccount'>

<cfset PayMethod = "PO Account">
</cfif>
#PayMethod#</h4>
</cfoutput>
<p>
</p>
</cfif>
<p>
<cfoutput query = "qryOrders">
    <p>
    Order Status: #OrderStatus#

	<p>
</p>
</cfoutput>
</p>
<!---Check for gift certificates on this order--->

<cfquery name = "qryCheck" datasource="#request.dsn#">
SELECT * FROM giftcards
WHERE OrderID = '#OrderNumber#'
</cfquery>	

<cfif qryCheck.RecordCount GT 0>
  <h4>Gift Codes:</h4>
  <cfloop query = "qryCheck">
<!---Display this gift certificate number--->
<table width = "350" cellpadding="4" cellspacing="0" style="border: dashed 2px #CCCCCC;" align="center">
<tr>
	<td height="100" align="center" valign="middle">
	<span class="giftcode"><cfoutput>#gNumber#</cfoutput></span>
	</td>
</tr>
</table>
<p>
</cfloop>

</cfif>	
<!---End check for gift certificates--->
<p>
<a href = "dogiftcards.cfm?action=default">Go Back</a>



















