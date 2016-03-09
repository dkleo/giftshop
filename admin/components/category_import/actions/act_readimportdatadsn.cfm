<cfquery name = "qry_CatalogToImport" datasource="#fromdsn#" username="#dsnun#" password="#dsnpw#">
SELECT * FROM #tablename#
</cfquery>

<!---now create the columns based on what is in the columnlist of the query--->
<cfset progresscount = 0>
<cfset TotalRecordsToImport = #listlen(qry_CatalogToImport.columnlist)#>

<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Creating columns in temporary table.  Please wait!';
</script>

<cfloop from = "1" to = "#listlen(qry_CatalogToImport.columnlist)#" index="mycount">
	<cfset thiscolname = "#listgetat(qry_CatalogToImport.columnlist, mycount)#">

	<cfif NOT thiscolname IS 'CAT_IMPRT_ID'>
			<cfquery name = "qryAddColumn" datasource="#request.dsn#">	
			ALTER TABLE temp_import
			ADD COLUMN #thiscolname# VARCHAR(255) NULL
			</cfquery>
	</cfif>
	
	<cfset progresscount = progresscount + 1>
	
	<!---Modify the progress bar--->
	<cfset ProgressPercentage = ProgressCount / TotalRecordsToImport>
	<cfset ProgressPercentage = ProgressPercentage * 100>
	<cfset ProgressPercentage = #Round(ProgressPercentage)#>
	
	<cfset NegProgress = 100 - ProgressPercentage>
	
	<cfoutput>
	
	<cfif NOT ProgressPercentage IS 100>
	<script language="JavaScript">
		document.getElementById('progpos').style.width = "#ProgressPercentage#%";
		document.getElementById('progneg').style.width = "#NegProgress#%";
		document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Completed';
	</script>
	</cfif>
	
	<cfif ProgressPercentage IS 100>
	<script language="JavaScript">
		document.getElementById('progpos').style.width = "#ProgressPercentage#%";
		document.getElementById('progneg').style.width = "#NegProgress#%";
		document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Completed!';
	</script>
	</cfif>
	</cfoutput>
	
</cfloop>

<!---Insert the data--->

<cfset progresscount = 0>

<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Importing data into temporary table.  Please wait!';
</script>

<!---Start an id count so we can reference each record by assigning a unique value--->
<cfset thisid = 1>
<cfset TotalRecordsToImport = qry_CatalogToImport.Recordcount>
<cfloop query="qry_CatalogToImport">
<cfset ProgressCount = ProgressCount + 1>
	<!---create a new row--->

	<cfquery name = "qryInsertTempData" datasource="#request.dsn#">
	INSERT INTO temp_import
	(CAT_IMPRT_ID)
	VALUES
	(#thisid#)	
	</cfquery>	
	
	<!---loop over each column and insert the value of this row--->
		<cfloop from = "1" to="#listlen(qry_CatalogToImport.columnlist)#" index="mycount">
			<!---get the value of the selected item in this row--->
			<cfset thiscol = listgetat(qry_CatalogToImport.columnlist, mycount)>
			<cfset thisval = "qry_CatalogToImport." & #thiscol#>
			<cfset thisactualval = #evaluate(thisval)#>
			
			<!---insert the record into the database--->
			<cfquery name = "qryInsertData" datasource="#request.dsn#">
			UPDATE temp_import
			SET #thiscol# = '#thisactualval#'
			WHERE CAT_IMPRT_ID = #thisid#
			</cfquery>

		</cfloop>
	<cfset thisid = thisid + 1>	
	
	<!---Modify the progress bar--->
	<cfset ProgressPercentage = ProgressCount / TotalRecordsToImport>
	<cfset ProgressPercentage = ProgressPercentage * 100>
	<cfset ProgressPercentage = #Round(ProgressPercentage)#>
	
	<cfset NegProgress = 100 - ProgressPercentage>
	
	<cfoutput>
	
	<cfif NOT ProgressPercentage IS 100>
	<script language="JavaScript">
		document.getElementById('progpos').style.width = "#ProgressPercentage#%";
		document.getElementById('progneg').style.width = "#NegProgress#%";
		document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Completed';
	</script>
	</cfif>
	
	<cfif ProgressPercentage IS 100>
	<script language="JavaScript">
		document.getElementById('progpos').style.width = "#ProgressPercentage#%";
		document.getElementById('progneg').style.width = "#NegProgress#%";
		document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Completed!';
	</script>
	</cfif>
	</cfoutput>

</cfloop>




















