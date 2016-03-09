<cfquery name="getaccount" datasource="#Request.DSN#">
SELECT * from afl_affiliates
order by sales DESC
</cfquery>











