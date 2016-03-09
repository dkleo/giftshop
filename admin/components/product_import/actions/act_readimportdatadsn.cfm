<cfquery name = "qry_CatalogToImport" datasource="#fromdsn#" username="#dsnun#" password="#dsnpw#">
SELECT * FROM #tablename#
</cfquery>

<!--- Get the column list.--->
<cfset lstColumnsIMP = qry_CatalogToImport.ColumnList>

<cfset col_namesIMP = "">
<cfset col_typesIMP = "">

<!---Loop over the columns in the query and build a list of columns and column types--->
<cfloop index="intColumnIMP" from="1" to="#ListLen( lstColumnsIMP )#" step="1">
 <cfset col_namesIMP = listappend(col_namesIMP, "#qry_CatalogToImport.GetMetaData().GetColumnName(JavaCast( 'int', intColumnIMP ))#", "^")>
 <cfset col_typesIMP = listappend(col_typesIMP, "#qry_CatalogToImport.GetMetaData().GetColumnTypeName(JavaCast( 'int', intColumnIMP ))#", "^")>
</cfloop>

<!---now create the columns based on what is in the columnlist of the query--->
<cfset progresscount = 0>
<cfset TotalRecordsToImport = #listlen(col_namesIMP, "^")#>

<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Creating columns in temporary table.  Please wait!';
</script>

<cfloop from = "1" to = "#listlen(col_namesIMP, '^')#" index="mycount">
	<cfset thiscolname = "#listgetat(col_namesIMP, mycount, '^')#">
	<cfset thiscoltype = "#listgetat(col_typesIMP, mycount, '^')#">

	<cfif thiscoltype IS 'VARCHAR'>
        <cfset thiscoltype = 'LONGTEXT'>
    </cfif>

    <cfquery name = "qryAddColumn" datasource="#request.dsn#">	
    ALTER TABLE temp_import
    ADD COLUMN #thiscolname# #thiscoltype# NULL
    </cfquery>

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

<cfoutput>
	<script language="javascript">
	window.location.href = "index.cfm?action=import_step_3&fromdsn=#fromdsn#&dsnun=#dsnun#&dsnpw=#dsnpw#&tablename=#tablename#&importmethod=#importmethod#&dopart=2";
	</script>
</cfoutput>















