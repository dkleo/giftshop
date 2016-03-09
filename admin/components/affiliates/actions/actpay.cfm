<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---loop over each affiliate to pay--->
<style type="text/css">
<!--
.style3 {color: #000000; font-weight: bold; }
-->
</style>

<cfset htmloutput = "">


<cfif NOT listlen(form.affiliates) IS listlen(form.checknumber)>
You have left a checknumber field blank!  Please hit the back button in your browser, and enter a
0 (zero) in each field next to the affiliates you do NOT wish to pay at this time.
</cfif>

<cfset paymentdate = #dateformat(now(), "mm/dd/yyyy")#>
<cfset paymentdatefile = #dateformat(now(), "mmddyy")#>
<cfset paymenttimefile = #timeformat(now(), "hhmmss")#>

<cfparam name = "viewmonth" default="#dateformat(now(), 'm')#">
<cfparam name = "viewyear" default="#dateformat(now(), 'yyyy')#">

<cfoutput><h2>Accounts Paid on: #paymentdate#</h2></cfoutput>

<cfsavecontent variable="colnames">
affiliateid,name,address,address2,city,state,zip,country,phone,email,checknumber,amount
</cfsavecontent>

<cfset csv_filename = 'po-#paymentdatefile#-#paymenttimefile#.csv'>

<cffile action="write" file="#request.catalogpath#admin#request.bslash#affiliatepayments#request.bslash#po-#paymentdatefile#-#paymenttimefile#.csv" output="#colnames#"> 

<cfloop from = "1" to = "#listlen(form.affiliates)#" index="aff">

<!---Set affiliateid--->
<cfset current_afl = listgetat(form.affiliates, aff)>
<!---Set check number--->
<cfset current_chk = listgetat(form.checknumber, aff)>
<!---Set Amount of check--->
<cfset current_amt = listgetat(form.PaymentAmount, aff)>

<cfif NOT current_chk IS '0'>

	<!---make sure a check of the same number is not already inserted.  If there is one then ignore
	Helps prevent duplicate entries on browser refresh--->
	<cfquery name = "dupCheck" datasource="#request.dsn#">
	SELECT * FROM afl_transactions
	WHERE checknumber = '#current_chk#'
	</cfquery>
		
	<cfif dupCheck.recordcount IS 0>	
		<cfset CurrentDate = now()>
		<cfset CurrentMonth = dateformat(CurrentDate, "mm")>
		<cfset CurrentYear = dateformat(CurrentDate, "yyyy")>
		
        <!---insert record of payment--->
		<cfquery name = "qryInsertPayment" datasource="#request.dsn#">
		INSERT INTO afl_transactions
		(AffiliateID, TransDate, TransMonth, TransYear, TransType, TransDesc, Payout, CheckNumber, paid)
		VALUES
		('#current_afl#', #CurrentDate#, #CurrentMonth#, #CurrentYear#, '0', 'Payment - Commissions for #viewmonth#/#viewyear#', #current_amt#, #current_chk#, 'NA')
		</cfquery>
		
		<!---Update all transactions for this affiliate and mark as paid for the selected month and year and any outstanding balance from prior months.--->
		<cfquery name = "qryUpdatePaidStatus" datasource="#request.dsn#">
		UPDATE afl_transactions
		SET paid = 'Yes',
        checknumber = #current_chk#,
        csv_file = '#csv_filename#'
		WHERE affiliateid = '#current_afl#' AND TransMonth <= #viewmonth# AND transyear <= #viewyear#
		</cfquery>
	</cfif>		

<!---Update this affiliates amount paid with the current amount plus the amount of this check (for
		history tracking--->
		<cfquery name = "qryAffiliate" datasource="#request.dsn#">
		SELECT * FROM afl_affiliates
		WHERE affiliateid = '#current_afl#'
		</cfquery>

	<cfloop query = "qryAffiliate">
		<cfset newcpaid = cPaid + current_amt>
		
		<cfquery name = "qryUpdateAmountPaid" datasource="#request.dsn#">
		UPDATE afl_affiliates
		SET cPaid = #newcpaid#,
		cPending = 0
		WHERE affiliateid = '#current_afl#'
		</cfquery>
	</cfloop>

<!---Output the information for printing (addresses and who check should be sent to and amount--->
<cfoutput query = "qryAffiliate">

<cfsavecontent variable="thisone">
<table width="100%" cellpadding="4" cellspacing="0" style="border: ##999999 1px dotted">
<tr>
  <td bgcolor="##CCCCCC"><span class="style3">To</span></td>
  <td align="center" bgcolor="##CCCCCC"><span class="style3">Amount</span></td>
  <td align="center" bgcolor="##CCCCCC"><span class="style3">Check Number </span></td>
  <td align="center" bgcolor="##CCCCCC"><span class="style3">Affiliate ID</span></td>
</tr>
<tr>
<td width = "50%">#CheckName#<br />
#Address1#<br />
#Address2#<br />
#city#, #state# &nbsp;#zip#<br />
#Country#</td>
<td width="15%" align="center">
	#dollarformat(current_amt)#</td>
<td width="15%" align="center">
	#current_chk#</td>
<td width="20%" align="center">
	#AffiliateID#</td>
</tr>
</table>
</cfsavecontent>
<br />

<!---build CSV File--->
<cfsavecontent variable="thisline">
<cfoutput>#AffiliateID#,#CheckName#,#address1#,#address2#,#city#,#state#,#zip#,#country#,#phone#,#email#,#current_chk#,#current_amt#</cfoutput>
</cfsavecontent>

</cfoutput>

<cffile action="append" addnewline="yes" output="#thisline#" file="#request.catalogpath#admin#request.bslash#affiliatepayments#request.bslash#po-#paymentdatefile#-#paymenttimefile#.csv">

<cfset htmloutput = "#htmloutput##thisone#">

</cfif>
</cfloop>


<h2>Payout Summary</h2>
<p>
<cfoutput><a href = "#request.homeurl#admin/affiliatepayments/po-#paymentdatefile#-#paymenttimefile#.csv" target="_blank">Download CSV Data File</a></cfoutput>
<p>
<cfoutput>#htmloutput#</cfoutput>
</p>











