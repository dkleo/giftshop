<cfquery name = "qryStates" datasource="#request.dsn#">
SELECT * FROM states WHERE showthis ='yes'
Order By State ASC
</cfquery>












