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

<!---Insert the data--->
<cfset progresscount = 0>

<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Importing data into temporary table.  Please wait!';
</script>

<!---Start an id count so we can reference each record by assigning a unique value--->
<cfset thisid = 1>
<cfset TotalRecordsToImport = qry_CatalogToImport.Recordcount>
<cfset todaysdate = now()>

<cfloop query="qry_CatalogToImport">
<cfset ProgressCount = ProgressCount + 1>
	<!---insert record (query is built dynamically)--->
	<cfquery name = "qryInsertTempData" datasource="#request.dsn#">
	INSERT INTO temp_import
	(CAT_IMPRT_ID
	<cfloop from = "1" to = "#listlen(col_namesIMP, '^')#" index="mycount">
		<cfset thiscol = "#listgetat(col_namesIMP, mycount, '^')#">
		,#thiscol#		    	
    </cfloop>    
    )
	VALUES
	(#thisid#
	<cfloop from = "1" to = "#listlen(col_namesIMP, '^')#" index="mycount2">
		<cfset thiscol = "#listgetat(col_namesIMP, mycount2, '^')#">
        <cfset thiscoltype = "#listgetat(col_typesIMP, mycount2, '^')#">
        <cfset thisval = "qry_CatalogToImport." & #thiscol#>
        <cfset thisactualval = #evaluate(thisval)#>
     <cfif len(trim(thisactualval)) GT 0>
     	<cfif thiscoltype IS 'INTEGER' OR thiscoltype IS 'FLOAT' OR thiscoltype IS 'DECIMAL' OR thiscoltype IS 'DOUBLE' OR thiscoltype IS 'TINYINT'>
        ,#thisactualval#
        <cfelseif thiscoltype IS 'TEXT' OR thiscoltype IS 'VARCHAR' OR thiscoltype IS 'LONGTEXT' OR thiscoltype IS 'MEMO'>
        ,'#thisactualval#'
        <cfelseif thiscoltype IS 'DATE' OR thiscoltype IS 'DATETIME' OR thiscoltype IS 'TIME'>
        ,#createodbcdate(thisactualval)#
        <cfelse>
        ,''
        </cfif>
     </cfif>
        
     <cfif len(trim(thisactualval)) IS 0>   
        <cfif thiscoltype IS 'INTEGER' OR thiscoltype IS 'FLOAT' OR thiscoltype IS 'DECIMAL' OR thiscoltype IS 'DOUBLE' or thiscoltype IS 'TINYINT'>
        ,0
		<cfelseif thiscoltype IS 'TEXT' OR thiscoltype IS 'VARCHAR' OR thiscoltype IS 'LONGTEXT' OR thiscoltype IS 'MEMO'>
        ,''
        <cfelseif thiscoltype IS 'DATE' OR thiscoltype IS 'DATETIME' OR thiscoltype IS 'TIME'>
        ,#createodbcdate(todaysdate)#
        <cfelse>
        ,''
        </cfif>        
     </cfif>
	</cfloop>    
    )	
	</cfquery>	
	
    
	<!---loop over each column and insert the value of this row
	<cfloop from = "1" to = "#listlen(col_namesIMP, '^')#" index="mycount">
		<cfset thiscol = "#listgetat(col_namesIMP, mycount, '^')#">
        <cfset thiscoltype = "#listgetat(col_typesIMP, mycount, '^')#">
        <cfset thisval = "qry_CatalogToImport." & #thiscol#>
        <cfset thisactualval = #evaluate(thisval)#>
        
        <!---insert the record into the database--->
		<cfif NOT len(trim(thisactualval)) IS 0>
			<cfif thiscoltype IS 'INTEGER' OR thiscoltype IS 'FLOAT' OR thiscoltype IS 'DECIMAL'>
				<cfquery name = "qryInsertData" datasource="#request.dsn#">
				UPDATE temp_import
				SET #thiscol# = #thisactualval#
				WHERE CAT_IMPRT_ID = #thisid#
				</cfquery>
			</cfif>
	
			<cfif thiscoltype IS 'TEXT' OR thiscoltype IS 'VARCHAR' OR thiscoltype IS 'LONGTEXT' OR thiscoltype IS 'MEMO'>
				<cfquery name = "qryInsertData" datasource="#request.dsn#">
				UPDATE temp_import
				SET #thiscol# = '#thisactualval#'
				WHERE CAT_IMPRT_ID = #thisid#
				</cfquery>
			</cfif>        
			
			<cfif thiscoltype IS 'DATE' OR thiscoltype IS 'DATETIME' OR thiscoltype IS 'TIME'>
				<cfquery name = "qryInsertData" datasource="#request.dsn#">
				UPDATE temp_import
				SET #thiscol# = #createodbcdate(thisactualval)#
				WHERE CAT_IMPRT_ID = #thisid#
				</cfquery>
			</cfif>        
        </cfif>
    </cfloop>--->

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

<!---redirect and show the table and select boxes--->
<cfoutput>
	<script language="javascript">
	window.location.href = "index.cfm?action=import_step_3&fromdsn=#fromdsn#&dsnun=#dsnun#&dsnpw=#dsnpw#&tablename=#tablename#&importmethod=#importmethod#&dopart=3";
	</script>
</cfoutput>















