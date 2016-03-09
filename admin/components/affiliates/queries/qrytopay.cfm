<!---zero out all so that they won't show up if they are not in the current view--->
<cfquery name = "qryUpdateBalance" datasource="#request.dsn#">
UPDATE afl_affiliates
SET cPending = 0
</cfquery>

<!---loop over each one and add set balance so that they will display.--->
<cfquery name = "qryAffiliates" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
</cfquery>

<cfloop query = "qryAffiliates">
	<!---Get just the transactions that have not been paid--->
	<cfquery name = "qryTransactions" datasource="#request.dsn#">
	SELECT * FROM afl_transactions 
	WHERE paid = 'No' AND affiliateid = '#qryAffiliates.affiliateid#' AND transmonth <= #viewmonth# AND transyear <= #viewyear#
	</cfquery>
	
	<cfset TotalToPay = 0>
	<cfloop query = "qryTransactions">
		<cfset TotalToPay = TotalToPay + qryTransactions.commission>
	</cfloop>

	<!---Update affiliate balance--->
	<cfquery name = "qryUpdateBalance" datasource="#request.dsn#">
	UPDATE afl_affiliates
	SET cPending = #TotalToPay#
	WHERE affiliateid = '#qryAffiliates.affiliateid#'
	</cfquery>
</cfloop>

<!---Now query just the ones with a balance.  The balance is what the store owner owes
the affiliate--->
<cfquery name = "qryToPay" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE cPending > 0 
<cfif taxinfo IS 'Yes'>AND has1099 = 'Yes'</cfif>
<cfif taxinfo IS 'No'>AND has1099 = 'No'</cfif>
</cfquery>












