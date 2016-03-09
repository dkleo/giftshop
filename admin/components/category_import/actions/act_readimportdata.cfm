<cfparam name = "importmethod" default="">
<cfparam name = "fromdsn" default = "">
<cfparam name = "dsnun" default = "">
<cfparam name = "dsnpw" default = "">
<cfparam name = "xmlfile" default = "">
<cfparam name = "tablename" default = "">

<cfset ProgressCount = 0>

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

<!---<cfif importmethod IS 'xml'>
	<cfinclude template = "act_ReadImportDataXML.cfm">
</cfif>--->

<cfif importmethod IS 'csv'>
	<cfinclude template = "act_readimportdatacsv.cfm">
</cfif>

<cfif importmethod IS 'dsn'>
	<cfinclude template = "act_readimportdatadsn.cfm">
</cfif>




















