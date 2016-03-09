<!---Displays a list of all past payouts--->
<cfquery name = "qryPayouts" datasource="#request.dsn#">
SELECT DISTINCT transdate FROM afl_transactions
WHERE TransType = 0
</cfquery>

<cfif qryPayouts.recordcount IS 0>
	You do not have any payouts on record yet!
<cfelse>
	<form method = "post" action="index.cfm?action=viewpayouts" name="payoutform">
	Select Payout Date: <select name = "PayoutDate">
		<cfoutput query = "qryPayouts">
		<option value = "#transdate#">#dateformat(transdate, "mmmm dd, yyyy")#</option>
		</cfoutput>
	</select>
	<input type = "submit" value="View Payouts" name="submitpayoutdate" />
	</form>
</cfif>











