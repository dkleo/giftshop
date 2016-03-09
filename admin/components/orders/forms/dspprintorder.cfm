<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
<div <cfoutput>id="print_#ordernumber#"</cfoutput>>

<cfif NOT isdefined('customerid')>
	<cfquery name = "qryCustomerid" datasource="#request.dsn#">
	SELECT CustomerID FROM orders WHERE ordernumber = '#ordernumber#'
	</cfquery>
	
	<cfoutput query = "qryCustomerid">
		<cfset customerid = #customerid#>
	</cfoutput>
	
	<cfif qryCustomerid.recordcount IS 0>
		<cfset customerid = 0>
	</cfif>
</cfif>


<cfset ThePaymentMethod = #PaymentMethod#>
<cfset PayMethod= ''>

<cfquery name = "qMethod" datasource="#request.dsn#">
SELECT * FROM cfsk_processors WHERE p_name = '#ThePaymentMethod#'
</cfquery>

<cfoutput query = "qMethod">
	<cfset PayMethod = qMethod.p_adminname>
</cfoutput>

<cfoutput>
<table width="90%" border="0" align="center" cellpadding="4" cellspacing="0">
<tr>
<td><span style="font-size: 18px; font-weight: bold">Order Number </span><span style="font-size: 18px">#OrderNumber#</span><br />#dateformat(qryOrders.DateOfOrder, "mmm dd, yyyy")#</td>
<!---Payment Method--->
<td>
  <div align="right" style="font-weight: bold; font-size: 16px">Payment Method:
      <br>
      #PayMethod#  </div></td>
</tr>
<cfif paid IS 'No'>
<tr>
<td colspan="2">
<b><span style="color: ##FF0000"><span style="font-size: 14px">WARNING! </span><br />
<span style="font-size: 10px">It appears that payment was not received for this order! Please check with your customer and/or payment processor. If you have received payment update this orders payment status.</span></span> <br />
</b>
</td>
</tr>
</cfif>
</table>
      <center>
        <table width="90%" border="1" cellspacing="0" cellpadding="4" style="border-collapse: collapse" bordercolor="##111111">
          <tr class="TableTitles">
            <td width="50%" height="19" bgcolor="##000000" class="TableTitles" style="border-color:##000000; border-width:1; " >
              <span class="style1">Name</span></td>
            <td width="15%" height="19" bgcolor="##000000" class="TableTitles" style="border-color:##000000; border-width:1; " ><p align="center" class="style1">            Price</p></td>
            <td width="10%" height="19" bgcolor="##000000" class="TableTitles" style="border-color:##000000; border-width:1; " ><p align="center" class="style1">            Quantity</p></td>
            <td width="25%" height="19" align="center" bgcolor="##000000" class="TableTitles" style="border-color:##000000; border-width:1; " >
              <span class="style1">Total</span></td>
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
                  </p>                </td>
                <td width="10%" style="border-color:##000000; border-width:1; " valign="middle">
                  <p align="center"> #ListGetAt(CrtQuantity, IndexCount, "^")#</p></td>
                <td width="25%" align="right" style="border-color:##000000; border-width:1; ">
					<cfset TotalOfItems = #ListGetAt(CrtPrice, IndexCount, "^")#>
					<cfif request.EnableEuro IS 'Yes'>
                    #lseurocurrencyformat(TotalOfItems, "Local")#
                      <cfelse>
                      #lscurrencyformat(TotalOfItems, "Local")#
                  </cfif></td>
            </tr>
          </cfloop>
          </tr>
          <tr>
            <td height="15" colspan="3" style="border-style: none" align="right">Discount
                (If any):</td>
            <td height="15" align="right" style="border-color:##000000; border-width:1; ">
        	<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(DiscountAmount, "Local")#<cfelse>#LSCurrencyFormat(DiscountAmount, "Local")#</cfif>			</td>
          </tr>
          <tr>
            <td height="15" colspan="3" align="right">Gift Card Amount Applied <cfif len(giftcode) GT 0>(#giftcode#)</cfif>:</td>
            <td height="15" align="right">
        	<cfif len(giftamountused) GT 0>
			<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(giftamountused, "Local")#<cfelse>#LSCurrencyFormat(giftamountused, "Local")#</cfif>
			<cfelse>
			N/A
			</cfif>			</td>
          </tr>	  	  
          <tr>
            <td height="15" colspan="3" style="border-style: none" align="right">Taxes:</td>
            <td height="15" align="right" style="border-color:##000000; border-width:1; "><strong>
				<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(FiguredTax, "Local")#
				<cfelse>#LSCurrencyformat(FiguredTax, "Local")#</cfif>			</td>
          </tr>
          <tr>
            <td width="88%" height="15" colspan="3" style="border-style: none">
              <p align="right"><cfif NOT ShippingMethod IS 'N/A'>(#ShippingMethod#) - </cfif>Shipping &amp; Handling: </td>
            <td width="20%" height="15" align="right" style="border-color:##000000; border-width:1; ">
				<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(QuotedShipping, "Local")#
				<cfelse>#LSCurrencyformat(QuotedShipping, "Local")#</cfif>			</td>
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
</cfoutput>
<p>
<table width="90%" align="center" cellpadding="4" cellspacing="0" style="border:#000000 solid 1px;">
      <tr>
        <td height="15" bgcolor="#000000" Class="TableTitles"><span class="style1">Billing Information</span></td>
        <td height="15" valign="top" bgcolor="#000000" Class="TableTitles"><span class="style1">Ship Order To:</span></td>
      </tr>
      <tr>
        <td height="15">
		<cfoutput query = "qryCustomers">
		<cfif len(Businessname) GT 0>#BusinessName#<br /></cfif>
		#FirstName# #LastName#<br> 
		#address#<br> 
		<cfif len(address2) GT 0>
			#address2#<br />
		</cfif>
		#city#, #State# &nbsp;&nbsp; #ZipCode#
		<br> #Country#
		<p> 
		<b>Email Address:</b> #EmailAddress#<br>
        <b> Phone Number:</b> #PhoneNumber# <br>
 	    </td>
        <td width="48%" height="15" valign="top"> 
		<cfif len(qryOrders.ShipBusinessname) GT 0>#qryOrders.ShipBusinessName#<br /></cfif>
		#qryOrders.ShipFirstName# #qryOrders.ShipLastName#<br />
		#qryOrders.ShipAddress#<br />
		<cfif len(qryOrders.ShipAddress2) GT 0>#qryOrders.ShipAddress2#<br /></cfif>
		#qryOrders.ShipCity#, #qryOrders.ShipState#  #qryOrders.ShipZip#<br />
		#qryOrders.ShipCountry#
		<p> 
		<b>Coupon Code Used: </b> <cfif qryOrders.PromoCode IS ''>None<cfelse>#qryOrders.PromoCode#</cfif>
        <!---<p><strong>Customer IP Address: #qryOrders.VisitorIP#</strong>---></td>
      </tr>
      <tr>
        <td height="15" colspan="2" bgcolor="##000000" Class="TableTitles"><span class="style1">Customer Notes and Special Instructions</span></td>
      </tr>
      <tr>
        <td height="15" colspan="2"><cfif qryOrders.memo IS ''><p>&nbsp;<br />&nbsp;<cfelse>#qryOrders.memo#</cfif></td>
      </tr>
	</cfoutput>
</table>
<p>
<cfif ISDEFINED('ThePaymentMethod')>
<table width="90%" align="center" cellpadding="4" cellspacing="0" style="border:#000000 solid 1px;">
<tr>
<td bgcolor="#000000"><span style="font-weight: bold"><font color="#FFFFFF">Payment Information</font></span></td>
</tr>
<tr>
<td>
<cfif ThePaymentMethod IS 'CreditCard'>
    <cfif request.StoreCreditCardInfo IS 'Yes'>

	<cfset theCreditCardNumber = 'Data Removed'>
    <cfset theCardCode = 'Date Removed'>
    
    	<cfif len(CreditCardNumber) GT 0>
		<cfset theCreditCardNumber = #replace(CreditCardNumber, "//", "/", "ALL")#>
        <cfset theCreditCardNumber = #replace(theCreditCardNumber, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")#>
    	<cftry>
        	<cfset theCreditCardNumber = #decrypt(theCreditCardNumber, request.SeedString)#>
        <cfcatch>
        	<cfset theCreditCardNumber = 'Decryption Failed.'>
        </cfcatch>
        </cftry>
	</cfif>
    
    <cfif len(CCconfirmationNumber) GT 0>
		<cfset theCardCode = #replace(CCconfirmationNumber, "//", "/", "ALL")#>
        <cfset theCardCode = #replace(theCardCode, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")#>
        <cftry>
        <cfset theCardCode = #decrypt(theCardCode, request.SeedString)#>
        <cfcatch>
        	<cfset theCardCode = 'Decryption Failed.'>
        </cfcatch>
        </cftry>
    </cfif>
    
		<cfoutput>
            Type:  CreditCardType<br>
            Number:  #theCreditCardNumber#<br>
            Exp:  #CreditCardExpire#<br>
            CardCode:  #theCardCode#
        </cfoutput>

	<cfelse>
        <p>
        You have chosen not to store credit card information.
	</cfif>
</cfif>
	
<cfif ThePaymentMethod IS 'POnumber'>
	<cfoutput>
	PO Account Number:<br />
	#po_number#<br>
	</cfoutput>
</cfif>
</td>
</tr>
</table>
<p>
</cfif>
<table width = "90%" align="center" cellpadding="4" cellspacing="0" style="border:#000000 solid 1px;">
<tr>
<tr>
<td bgcolor="#000000"><span style="font-weight: bold"><font color="#FFFFFF">Order Notes</font></span></td>
</tr>
<td>
	<cfoutput>
	  <cfif notes IS ''><p>&nbsp;<br />&nbsp;<cfelse>
	  #notes#
	  </cfif>
	</cfoutput>
</td>
</tr>
</table>
<table width="90%" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td>
	<cfquery name="qryAffReferral" datasource="#request.dsn#">
	SELECT * FROM afl_transactions WHERE OrderNumber = '#qryOrders.OrderNumber#'
	</cfquery>

	<cfif qryAffReferral.recordcount GT 0>
		<cfquery name="qryAffInfo" datasource="#request.dsn#">
		SELECT * FROM afl_affiliates WHERE affiliateid = '#qryAffReferral.affiliateid#'
		</cfquery>

		<cfoutput query = "qryAffInfo">
		<table width="250" style="border:1px ##000000 solid">
		<tr>
		  <td bgcolor="##000000"><span style="color: ##FFFFFF; font-weight: bold">Affiliate who Referred Customer</span></td>
		</tr>
		<tr>
		<td>
		<b>#SiteName#</b><br />
		#FirstName# #LastName#
		#Address1#<br />
		<cfif len(address2) GT 0>#address2#<br /></cfif>
		#city#, #state#  #zip#<br />
		#country#</td>
		</tr>
		</table>
		</cfoutput>
	</cfif>
	</td>
  </tr>
</table>
</div>
</span>



















