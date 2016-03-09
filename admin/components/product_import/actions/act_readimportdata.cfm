<cfsetting requesttimeout="1200">

<cfset ProgressCount = 0>

<cfif dopart IS '1'>
<!---Attempt to create the temp table.  If an error is thrown then attempt to drop it and then create it.--->
<cftry>
    <cfquery name = "qryCreateTempTable" datasource="#request.dsn#">
        CREATE TABLE temp_import(CAT_IMPRT_ID INTEGER);
    </cfquery>
    <cfcatch type="database">
        <cfquery name = "qryClearTempTable" datasource="#request.dsn#">
            DROP TABLE temp_import
        </cfquery>
        <cfquery name = "qryCreateTempTable" datasource="#request.dsn#">
            CREATE TABLE temp_import(CAT_IMPRT_ID INTEGER);
        </cfquery>
    </cfcatch>
</cftry>

<cfif importmethod IS 'csv'>
	<cfinclude template = "act_readimportdatacsv.cfm">
</cfif>

<cfif importmethod IS 'dsn'>
	<cfinclude template = "act_readimportdatadsn.cfm">
</cfif>
</cfif>

<cfif dopart IS '2'>
<cfif importmethod IS 'dsn'>
	<cfinclude template = "act_readimportdatadsn_2.cfm">
</cfif>	
</cfif>
















