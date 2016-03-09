<cfquery name = "qrySender" datasource="#request.dsn#">
SELECT * FROM afl_affiliates WHERE affiliateID = '#senderid#'
</cfquery>












