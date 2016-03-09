<script>
function printme()
{
	var a = window.open('','','width=640,height=480,scrollbars=1');
	a.document.open("text/html");
	a.document.write(document.getElementById('printpart').innerHTML);
	a.document.close();
	a.print();
}
</script>

<cfif isdefined('form.secretkey')>
	<cfset session.secretkey = form.secretkey>
</cfif>

<cfinclude template = "../queries/qrycompanyinfo.cfm">

<div id="printpart">

<cfif NOT isdefined('url.customerid')>
	<cfquery name = "qryCustomerid" datasource="#request.dsn#">
	SELECT CustomerID FROM orders WHERE ordernumber = '#url.ordernumber#'
	</cfquery>
	
	<cfoutput query = "qryCustomerid">
		<cfset url.customerid = #customerid#>
	</cfoutput>
	
	<cfif qryCustomerid.recordcount IS 0>
		<cfset url.customerid = 0>
	</cfif>
</cfif>

<cfquery name = "qryCustomers" datasource = "#Request.DSN#">
SELECT * FROM customerhistory
WHERE CustomerID = #URL.CustomerID#
</cfquery>

<cfquery name = "QryOrders" datasource = "#Request.DSN#">
SELECT * FROM orders
WHERE OrderNumber = '#url.OrderNumber#'
</cfquery>

<cfif qryOrders.recordcount IS 0>
	This order no longer exists.
	<cfabort>
</cfif>

<cfset PayMethod = "Credit Card">
<cfloop query = "qryOrders">
	<cfquery name = "qProc" datasource="#request.dsn#">
    SELECT * FROM cfsk_processors
    WHERE p_name = '#qryOrders.paymentmethod#'
    </cfquery>
    
    <cfoutput query = "qProc">
    	<cfset PayMethod = '#qProc.p_adminname#'>
    </cfoutput>
</cfloop>
<cfoutput query="QryOrders">

<table width="90%" border="0" align="center" cellpadding="4" cellspacing="0">
<tr>
<td><span style="font-size: 14px; font-weight: bold">Order Number </span><span style="font-size: 14px">#OrderNumber# - #dateformat(qryOrders.DateOfOrder, "mmm dd, yyyy")#<br />
  <span style="font-weight: bold">Customer Number: #CustomerID# </span></span></td>
<!---Payment Method--->
<td>
  <div align="right" style="font-weight: bold; font-size: 14px">Payment Method:

      #PayMethod#<br />
      Payment Status: #paymentstatus#</div></td>
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
<!---    Order Summary:</b> - Fraud Risk Level: 
    <cfif NOT FraudFlag IS ''><img src = "icons/#FraudFlag#Flag.gif"><cfelse>Not Available</cfif></div>
    <br>--->
      <center>
        <table width="90%" border="1" cellspacing="0" cellpadding="6" style="border-collapse: collapse" bordercolor="##111111">
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
            <td height="15" colspan="3" style="border-style: none" align="right">Taxes:</td>
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
</cfoutput>
<p>
<table width="90%" align="center" cellpadding="4" cellspacing="0" style="border:#000000 solid 1px;">
      <tr>
        <td height="15" Class="TableTitles"><strong>Billing Information</strong></td>
        <td height="15" valign="top" Class="TableTitles"><strong>Ship Order To:</strong></td>
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
        <td height="15" colspan="2" Class="TableTitles"><b>Customer Notes and Special Instructions</b></td>
      </tr>
      <tr>
        <td height="15" colspan="2"><cfif qryOrders.memo IS ''><p>&nbsp;<br />&nbsp;<cfelse>#qryOrders.memo#</cfif></td>
      </tr>
	</cfoutput>
</table>
<p>
<table width="90%" align="center" cellpadding="4" cellspacing="0" style="border:#000000 solid 1px;">
<tr>
<td bgcolor="#000000"><span style="font-weight: bold"><font color="#FFFFFF">Payment Information</span></td>
</tr>
<tr>
<td>
	<cfif ISDEFINED('ThePaymentMethod')>
	<cfif ThePaymentMethod IS 'CreditCard'>
	<cfoutput query="QryOrders">
	<b>Credit Card Information:</b><br />
	<cfif request.StoreCreditCardInfo IS 'Yes'>
    <cfset theCreditCardNumber = 'Data Removed'>
    <cfset theCardCode = 'Date Removed'>
    
    <cfif len(CreditCardNumber) GT 0>
		<cfset theCreditCardNumber = #replace(CreditCardNumber, "//", "/", "ALL")#>
        <cfset theCreditCardNumber = #replace(theCreditCardNumber, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")#>
        <cfif isdefined('session.secretkey')>
	    	<cfif session.secretkey IS request.secretkey>
        		<cftry>
				<cfset theCreditCardNumber = #decrypt(theCreditCardNumber, request.SeedString)#>
                <cfcatch>
                	<cfset theCreditCardNumber = 'Failed To Decrypt - did you change your Seed String?'>
                </cfcatch>
                </cftry>
            <cfelse>
                <cfset theCreditCardNumber = '#left(theCreditCardNumber, 4)#x*3/c01'>
            </cfif>
		<cfelse>
			<cfset theCreditCardNumber = '#left(theCreditCardNumber, 4)#x*3/c01'>        		    
        </cfif>
	</cfif>
    
    <cfif len(CCconfirmationNumber) GT 0>
		<cfset theCardCode = #replace(CCconfirmationNumber, "//", "/", "ALL")#>
        <cfset theCardCode = #replace(theCardCode, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")#>
		<cfif isdefined('session.secretkey')>
	    	<cfif session.secretkey IS request.secretkey>
	            <cftry>
				<cfset theCardCode = #decrypt(theCardCode, request.SeedString)#>
                <cfcatch>
                	<cfset theCardCode = 'Failed to Decode'>
                </cfcatch>
                </cftry>
            </cfif>
        </cfif>
    </cfif>
    
	Type:  CreditCardType<br>
	Number:  #theCreditCardNumber#<br>
	Exp:  #CreditCardExpire#<br>
	CardCode:  #theCardCode#<br />
    <cfif NOT isdefined('session.secretkey')>
        	<form method = "post" action="doorders.cfm?action=vieworder&ordernumber=#ordernumber#&customerid=#customerid#" name="form1">Enter Key To Decrypte Data: <input type = "password" size="15" value="" name="secretkey" /> <input type="submit" name="submitbutton" value="Go" /></form><br />
	</cfif>
    <cfif isdefined('session.secretkey')>
    	<cfif NOT session.secretkey is request.secretkey>
        	<form method = "post" action="doorders.cfm?action=vieworder&ordernumber=#ordernumber#&customerid=#customerid#" name="form1">Enter Key To Decrypte Data: <input type = "password" size="15" value="" name="secretkey" /> <input type="submit" name="submitbutton" value="Go" /></form>
        </cfif>
    </cfif>
    <a href = "doorders.cfm?action=remove_cardinfo&ordernumber=#ordernumber#&CustomerID=#customerid#">Clear</a> <a href = "#request.AdminPath#/helpdocs/remove_credit_card_data.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a>
	<cfelse>
	<p>
	You have chosen not to store credit card information.
	</cfif>
	</cfoutput>
	<cfelseif ThePaymentMethod IS 'PONumber'>
	<cfoutput query="QryOrders">
	PO Number Used:<br />
	#po_number#<br>
	</cfoutput>
	</cfif>
	</cfif>
</td>
</tr>
</table>
<p>
<table width = "90%" align="center" cellpadding="4" cellspacing="0" style="border:#000000 solid 1px;">
<tr>
<tr>
<td bgcolor="#000000"><span style="font-weight: bold"><font color="#FFFFFF">Order Notes</span></td>
</tr>
<td>
	<cfoutput query = "qryOrders">
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
<p>
<center><input type="submit" name="Print" value="Print this order" onClick="printme();"></center>
<cfquery name = "qryOrders" Datasource="#Request.dsn#">
SELECT * FROM orders
WHERE CustomerID = #url.CustomerID# AND NOT OrderNumber = '#url.OrderNumber#'
</cfquery>
<table width="90%" border="0" align="center" cellpadding="4">
      <tr class="TableTitles"> 
        <td colspan="7" align="left"><strong>Other Orders This Customer Placed </strong></td>
      </tr>
      <tr bgcolor="#CCCCCC"> 
        <td width="8%" align="left"><b> Date</b></td>
        <td width="12%" align="left"><b> Name</b></td>
        <td width="11%" align="left"><b> Order Number </b>        </td>
        <td width="10%" align="left"><b>Phone</b></td>
        <td width="11%" align="left"><b> Email</b></td>
        <td width="9%" align="left"> <b> Order Total</b></td>
        <td width="16%" align="left"><strong>Status</strong></td>
      </tr>
	<CFIF NOT #qryOrders.recordcount# IS 0>
      <cfloop query ="qryOrders">
        <!---Find the customer that ordered this--->
        <cfquery name = "qryCustomers" Datasource = "#Request.dsn#">
        SELECT * FROM customerhistory WHERE CustomerID = #CustomerID# 
        </cfquery>
        <cfoutput query = "qryCustomers"> 
          <cfset CustName = '#FirstName# #LastName#'>
          <cfset CustCity = '#City#'>
          <cfset CustState = '#State#'>
          <cfset CustPhone = '#PhoneNumber#'>
          <cfset CustEmail = '#EmailAddress#'>
        </cfoutput> <cfoutput> 
          <tr> 
            <td width="8%">#dateformat(DateOfOrder, "mm/dd/yy")#</td>
            <td width="12%"><a href="doorders.cfm?action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#" target="_blank"> 
              #CustName#</a></td>
            <td width="11%"><a href="doorders.cfm?action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#" target="_blank"> 
              #OrderNumber#</a></td>
            <td width="10%">#CustPhone#</td>
            <td width="11%"><a href="mailto:#CustEmail#"> 
              #CustEmail#</a></td>
            <td width="9%"> 
              <cfif request.EnableEuro IS 'Yes'>
                #lseurocurrencyformat(OrderTotal, "Local")# 
                <cfelse>
                #lscurrencyformat(OrderTotal, "Local")# 
              </cfif>
              </td>
            <td width="16%">#OrderStatus# </td>
          </tr>
        </cfoutput> 
      </cfloop>
	</cfif>
<CFIF #qryOrders.recordcount# IS 0>
	<tr>
    <td colspan="7"><strong>This Customer has no other orders on file.</strong></td>
	</tr>
  </CFIF>
</table>

<p>&nbsp;</p>
<p>&nbsp;</p>




















