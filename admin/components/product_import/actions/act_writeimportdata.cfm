<cfquery name = "qrySetCurrentProducts" datasource="#request.dsn#">
UPDATE products
SET importkey = 'NONE'
</cfquery>

<!---delete all items from the catalog if they wanted to--->

<cfif isdefined('form.delete_all')>
    <cfquery name="qDelete" datasource="#request.dsn#">
    DELETE FROM products
    </cfquery>
    
    <cfquery name="qDelete" datasource="#request.dsn#">
    DELETE FROM products_images
    </cfquery>
    
    <cfquery name="qDelete" datasource="#request.dsn#">
    DELETE FROM product_categories
    </cfquery>
    
    <cfquery name="qDelete" datasource="#request.dsn#">
    DELETE FROM product_files
    </cfquery>
</cfif>

<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Importing your catalog.  Please wait!';
</script>
  
<cfset waserror = 0>

<cfset ProgressCount = 0>

<cfset thedateadded = now()>
<!---query the temporary table and get the column names.  Then look for each form fields and figure out
  which field it is.  If the column isn't to be ignored then add a new column by that name in the
  database--->
<cfinclude template = "../queries/qry_temptable.cfm">

<cfset colnames = qry_TempTable.ColumnList>
<cfset totalrecordstoimport = qry_TempTable.recordcount>
<p>
<!---Insert a new record for each record in the temp table--->
<cfloop query = "qry_TempTable">

	<cfset progresscount = progresscount + 1>
    
	<cfset insertdate = dateformat(now(), "mmddyy")>
    <cfset inserttime = timeformat(now(), "hhmmss")>
	<cfset uniquesku = "#insertdate##inserttime##qry_TempTable.CAT_IMPRT_ID#">

	<cfset todaysdate = now()>

    <cfquery name = "qryInsertBlankRow" datasource="#request.dsn#">
    INSERT INTO products
    (ImportKey
    <cfloop from = "1" to = "#listlen(form.dbcols)#" index="colcount">		
        <cfset thiscol = ListGetAt(form.dbcols, colcount)>
        <cfset thismatch = ListGetAt(form.colsmatch, colcount)>
        <cfif NOT thismatch Is 'ignorecolumn'>
          ,<cfoutput>#thiscol#</cfoutput>
         </cfif>
	</cfloop>
    )
    VALUES
    ('ImportRow#qry_TempTable.CAT_IMPRT_ID#'
    <cfloop from = "1" to = "#listlen(form.dbcols)#" index="ccount">		
        <cfset Imp_col = ListGetAt(form.dbcols, ccount)>       
        <cfset thismatch = ListGetAt(form.colsmatch, ccount)>
	    <cfif NOT thismatch Is 'ignorecolumn'>
		<cfset imp_typ = ListGetAt(form.dbcoltypes, ccount)>
        <cfset colval = "qry_TempTable.#thismatch#">
	    <cfset thisvalue = #evaluate(colval)#>
        <cfset thisvalue = replace(thisvalue, "'", '"', "ALL")>		  
		  <cfoutput>
			<cfif imp_typ IS 'INTEGER' OR imp_typ IS 'FLOAT' OR imp_typ IS 'DECIMAL' OR imp_typ IS 'DOUBLE'>
		        <cfif len(trim(thisvalue)) GT 0>
                    ,#thisvalue#
				<cfelse>
                	,0
                </cfif>            
			<cfelseif imp_typ IS 'TEXT' OR imp_typ IS 'VARCHAR' OR imp_typ IS 'LONGTEXT' OR imp_typ IS 'MEMO'>
				<cfif len(trim(thisvalue)) GT 0>
		            ,'#thisvalue#'
				<cfelse>
                	,''
                </cfif>
            <cfelseif imp_typ IS 'DATE' OR imp_typ IS 'DATETIME' OR imp_typ IS 'TIME'>
				<cfif len(trim(thisvalue)) GT 0>
                    ,#createodbcdate(thisvalue)#
                <cfelse>
                    ,#createodbcdate(todaysdate)#
                </cfif>
            <cfelse>
	            ,''
            </cfif>
            </cfoutput>
          </cfif> 
	</cfloop>    
    )
  </cfquery>
		  
	<!---Modify the progress bar--->

	<cfset ProgressPercentage = ProgressCount / TotalRecordsToImport>
	<cfset ProgressPercentage = ProgressPercentage * 100>
	<cfset ProgressPercentage = #Round(ProgressPercentage)#>
	
	<cfset NegProgress = 100 - ProgressPercentage>
	
	<cfoutput>
	
	<cfif ProgressPercentage LT 100>
	<script language="JavaScript">
		document.getElementById('progpos').style.width = "#ProgressPercentage#%";
		document.getElementById('progneg').style.width = "#NegProgress#%";
		document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Importing products into catalog...';
	</script>
	</cfif>
	
	<cfif ProgressPercentage IS 100>
	<script language="JavaScript">
		document.getElementById('progpos').style.width = "#ProgressPercentage#%";
		document.getElementById('progneg').style.width = "#NegProgress#%";
		document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Process Completed!';
	</script>
	</cfif>
	</cfoutput>  
	<!---end progress bar update--->		  
</cfloop>
		  
<!---assign imported products to categories (or set all to inactive)--->
<cfinclude template = "act_assigntocategories.cfm">

<!---Delete the importkeys--->
<cfquery name = "qry_RemoveImportKeys" datasource="#request.dsn#">
UPDATE products
SET ImportKey = ''
</cfquery>	

<!---Delete temporary table--->
<cfquery name = "qry_RemoveTempData" datasource="#request.dsn#">
DELETE FROM temp_import
</cfquery>

<p>
<center><h2>Product Import Complete!</h2></center>
<p>
<cfif waserror IS 'Yes'>
There were some errors that occurred during the import process.  
<br />You can read the details in the error log section of your control panel.
</cfif>















