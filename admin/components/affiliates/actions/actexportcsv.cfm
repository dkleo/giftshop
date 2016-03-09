<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Styles--->
<style type="text/css">
<!--
.style2 {font-size: 24px}
.style3 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<!---Default Values--->
<cfparam name = "viewmonth" default="#dateformat(now(), 'mm')#">
<cfparam name = "viewyear" default="#dateformat(now(), 'yyyy')#">
<cfparam name = "affiliateid" default="None">
<cfparam name = "lastdid" default="pay">
<cfparam name = "start" default="1">
<cfparam name = "disp" default="50">
<cfparam name = "end" default="999">
<cfparam name = "sortby" default = "affiliateid">
<cfparam name = "sortorder" default = "ASC">
<cfparam name = "updateid" default = "0">
<cfparam name = "viewgroup" default = "All">
<cfparam name = "searchbox" default = "">

<cfif affiliateid IS 'None'>
<p>Error:  Must pass a valid affiliateid
  <cfabort>
  </cfif>

  <!---Figure their current balance.  
This is all the current transactions that have not been paid out yet--->
  <cfquery name = "qryTransactions" datasource="#request.dsn#">
SELECT * FROM afl_transactions
WHERE AffiliateID = '#affiliateid#' AND paid = 'No'
  </cfquery>

  <!---If above returns zero records then set the balance to zero, otherwise add it up--->
  <cfset accountbalance = 0.00>
  <cfoutput query = "qryTransactions">
    <!---If there is a commission, then add it to the balance due--->
    <cfif len(commission) GT 0>
      <cfset accountbalance = accountbalance + #commission#>
    </cfif>
  </cfoutput>

  <!---Query the transactions for the currently selected month/year--->
  <cfquery name = "qryMonthTransactions" datasource="#request.dsn#">
SELECT * FROM afl_transactions
WHERE AffiliateID = '#affiliateid#' 
<cfif NOT ViewMonth IS '00'>AND TransMonth = #ViewMonth#</cfif> AND TransYear = #ViewYear#
ORDER BY TransDate DESC
  </cfquery>

  <!---Get the years to display in the year box--->
  <cfquery name = "qryYears" datasource="#request.dsn#">
SELECT DISTINCT TransYear FROM afl_transactions
WHERE affiliateID = '#affiliateid#'
  </cfquery>
  
  <!---Get the Affiliate Info--->
  <cfquery name = "qryAffiliate" datasource="#request.dsn#">
	SELECT * FROM afl_affiliates
	WHERE affiliateID = '#affiliateid#'
  </cfquery>
  
<cfsavecontent variable = "xlsfile">
affiilateid,date,description,order,order_status,sale,commission,payment,paid,check_number
</cfsavecontent>

<cffile action="write" addnewline="yes" output="#xlsfile#" file="#request.catalogpath#admin#request.bslash#affiliatepayments#request.bslash##affiliateid#-#viewmonth##viewYear#.csv">

<cfloop query = "qryMonthTransactions">
  
  <cfquery name = "qOrder" datasource="#request.dsn#">
  SELECT * FROM orders WHERE ordernumber = '#OrderNumber#'
  </cfquery>

  <cfset customerid = 0>
  
  <cfoutput query = "qOrder">
  	<cfset customerid = qOrder.customerid>
  </cfoutput>

<cfsavecontent variable = "xlsfile">
  <cfoutput>  
	#affiliateid#,#dateformat(transdate, "mm/dd/yyyy")#,#TransDesc#,#OrderNumber#,#OrderStatus#,<cfif TransType IS '0'>0.00<cfelse>#dollarformat(SaleAmount)#</cfif>,<cfif TransType IS '0'>0.00<cfelse>#dollarformat(Commission)#</cfif>,<cfif TransType IS '0'>#dollarformat(Payout)#<cfelse>0.00</cfif>,#paid#,#checknumber#
  </cfoutput>
</cfsavecontent>

<cffile action="append" addnewline="yes" output="#xlsfile#" file="#request.catalogpath#admin#request.bslash#affiliatepayments#request.bslash##affiliateid#-#viewmonth##viewYear#.csv">

  
  </cfloop>

</table>

<h2>Transaction Export</h2>
The report has been created and is ready to download.
<p>
<cfoutput><a href = "#request.homeurl#admin/affiliatepayments/#affiliateid#-#viewmonth##viewyear#.csv">Click here to download it</a>

<p>
<a href = "index.cfm?action=transactions&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#">Go back</a>
</p>
</cfoutput>












