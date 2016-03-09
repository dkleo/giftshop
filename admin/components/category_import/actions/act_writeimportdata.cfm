<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Importing your categories.  Please wait!';
</script>
  
  <cfset waserror = 0>
   
  <cfset ProgressCount = 0>
  
  <cfset thedateadded = now()>
  <!---query the temporary table and get the column names.  Then look for each form fields and figure out
	  which field it is.  If the column isn't to be ignored then add a new column by that name in the
	  database--->
  <cfinclude template = "../queries/qry_temptable.cfm">
  
  <cfset colnames = #qry_TempTable.columnlist#>
  
  <!---Insert a new record for each record in the temp table--->
  <cfloop query = "qry_TempTable">
    <cfquery name = "qryInsertBlankRow" datasource="#request.dsn#">
    INSERT INTO categories
    (ImportKey)
    VALUES
    ('ImportRow#qry_TempTable.CAT_IMPRT_ID#')
    </cfquery>		
  </cfloop>

  <!---Set default values--->
  <cfloop query = "qry_TempTable">
	<!---set some defaults first--->

    <cfquery name = "qryUpdateBlankRows" datasource="#request.dsn#">
    UPDATE categories
    SET permissions = '0',
    ShowSubCats = 'Yes',
    CategoryLayout = '#request.ProductLayout#',
	CategoryImage = 'None',
    CategoryPath = '/',
    Ordervalue = 1,
    subcategoryof = '0'
    WHERE ImportKey = 'ImportRow#qry_TempTable.CAT_IMPRT_ID#'
    </cfquery>		
  </cfloop>

  <!---now loop over the columns and set each one to what is in the temp table--->	 
  <cfloop from = "1" to = "#listlen(colnames)#" index="colcount">		
	<cfset ProgressCount = 0>
    <cfset thiscol = ListGetAt(colnames, colcount)>
    <cfset formToLookFor = '#thiscol#_type'>
    <cfset formValue = 'ignore'>
    <!---Now get the value of the form--->
    <cfif isdefined(formToLookFor)>
      <cfset formValue = evaluate(formToLookFor)>
    </cfif>
    
    <!---If not ignored then proceed importing the values into the appropriate column--->
	<cfif NOT thiscol IS 'CAT_IMPRT_ID'>
        <cfif NOT formValue IS 'ignorecolumn'>		
      
          <!---Now query this column and put it each value in the corresponding category table--->
          <cfquery name = "qry_TempColumn" datasource="#request.dsn#">
          SELECT #thiscol#,CAT_IMPRT_ID FROM temp_import
          </cfquery>
    
          <cfset TotalRecordsToImport = qry_TempColumn.Recordcount>
                
            <cfloop query = "qry_TempColumn">
            <cfset ProgressCount = ProgressCount + 1>
            <cfset thisvalue = #evaluate(thiscol)#>
            <cfset thisvalue = replace(thisvalue, "'", "''", "ALL")>
            <cftry>
    
              <cfquery name = "qry_addToCatalog" datasource="#request.dsn#">
               UPDATE categories
               SET #formValue# = '#thisvalue#'
               WHERE ImportKey = 'ImportRow#qry_TempColumn.CAT_IMPRT_ID#'
              </cfquery>
    
              <cfcatch type="database">
                <!---logs error message for this record if it fails.--->
                <cfoutput> 
                    <cfset waserror = 'Yes'>
                    <cfset extrainfo = '- Attempted to set #formValue# to #thisvalue#'>
                    <cfinclude template = "act_logerror.cfm">
                </cfoutput>
              </cfcatch>
         	 </cftry>
              
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
            document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Importing data for #thiscol# column';
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
  </cfif>
  </cfif>
              
  </cfloop>
  
  <!---Delete the importkeys--->

  <cfquery name = "qry_RemoveImportKeys" datasource="#request.dsn#">
  UPDATE categories
  SET ImportKey = ''
  </cfquery>	
  </p>

<!---Delete temporary table--->
 <cfquery name = "qry_RemoveTempData" datasource="#request.dsn#">
  DELETE FROM temp_import
  </cfquery>	

<!---build category paths--->
<cfinclude template = "act_setpaths.cfm">
<p>
<center><h2>Category Import Complete!</h2></center>
<p>
<cfif waserror IS 'Yes'>
There were some errors that occurred during the import process.  
<br />You can read the details in the error log section of your control panel.
</cfif>



















