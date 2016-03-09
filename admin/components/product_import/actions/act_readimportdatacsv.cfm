<cfparam name = "importmethod" default="">
<cfparam name = "fromdsn" default = "">
<cfparam name = "dsnun" default = "">
<cfparam name = "dsnpw" default = "">
<cfparam name = "csvfile" default = "">
<cfparam name = "tablename" default = "">
<cfparam name = "hascolumns" default = "Yes">

<!---read the uploaded file--->	
<cffile action = "read" file="#request.catalogpath#docs\#csvfile#" variable="csvfile">

<cfset totalrecords=0>

<cfset totalrecordstoimport = totalrecords>
<cfset progresscount = 0>

<cfset new_columnlist = "">

<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Creating columns in temporary table...';
</script>

<!---make column names--->
<cfset rowcount = 0>
<cfloop index="i" list="#csvfile#" delimiters="#chr(10)##chr(13)#">
	<cfset rowcount = rowcount + 1>
    <cfif rowcount IS 1>
    <cfloop from="1" to="#listlen(i, ',')#" index="c">
       <cfif hascolumns IS 'Yes'>
         <cfset thiscolname = listgetat('#i#', c, ",")>
         <cfset thiscolname = replace(thiscolname, " ", "_", "ALL")>
         <cfset thiscolname = replace(thiscolname, "__", "_", "ALL")>
         <cfset thiscolname = replace(thiscolname, '"', "", "ALL")>
         <cfset thiscolname = replace(thiscolname, '-', "", "ALL")>
		 <cfset thiscolname = replace(thiscolname, '/', "", "ALL")>
         <cfset thiscolname = replace(thiscolname, '\', "", "ALL")>
         <cfset thiscolname = replace(thiscolname, '@', "", "ALL")>
         <cfset thiscolname = replace(thiscolname, '##', "", "ALL")>
         <cfset thiscolname = replace(thiscolname, '!', "", "ALL")>
         <cfset thiscolname = replace(thiscolname, '?', "", "ALL")>
         <cfset thiscolname = replace(thiscolname, '<', "", "ALL")>                  
         <cfset thiscolname = replace(thiscolname, '>', "", "ALL")>                  
         <cfset thiscolname = replace(thiscolname, '(', "", "ALL")>                  
         <cfset thiscolname = replace(thiscolname, ')', "", "ALL")>                  
         <cfset thiscolname = replace(thiscolname, '+', "", "ALL")>                  
         <cfset thiscolname = replace(thiscolname, '=', "", "ALL")>                  
         <cfset thiscolname = replace(thiscolname, '*', "", "ALL")>                                                      
         <cfset thiscolname = replace(thiscolname, '&', "", "ALL")>                                                      
         <cfset thiscolname = replace(thiscolname, '^', "", "ALL")>                                                      
         <cfset thiscolname = replace(thiscolname, '%', "", "ALL")>                                                                        
         <cfset thiscolname = replace(thiscolname, '$', "", "ALL")>                                                                        
	   <cfelse>
          <cfset thiscolname = "column_#c#">  
       </cfif>
        
        <!---add column name--->
        <cfif request.dbtype IS 'mysql'>
            <cfquery name = "qryAddColumn" datasource="#request.dsn#">	
            ALTER TABLE temp_import
            ADD COLUMN #thiscolname# LONGTEXT NULL
            </cfquery>
        </cfif>
        <cfif request.dbtype IS 'msaccess'>
            <cfquery name = "qryAddColumn" datasource="#request.dsn#">	
            ALTER TABLE temp_import
            ADD COLUMN #thiscolname# MEMO NULL
            </cfquery>
        </cfif>
        
		<!---build the list of column names to be used below--->
		<cfset new_columnlist = listappend(new_columnlist, thiscolname, "^")>
        
    </cfloop>
    <cfelse>
        <cfbreak>
    </cfif>
</cfloop>

<!---set columnrow to 1 if file has column info--->
<cfif hascolumns IS 'Yes'>
	<cfset columnrow = 1>
<cfelse>
	<cfset columnrow = 0>
</cfif>       

<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Examining CSV File and preparing to import...';
</script>

<!---replace all doublequotes with ^^; these are escaped quotes within quotes and we need to get rid of them.--->
<cfset csvfile = replace(csvfile, '""', "^^", "ALL")>

<cfset qcount = len(csvfile)>

<!---loop over length of file, find text between quotes and replace each comma within the quotes with a pipe and a carriage return with
a \r\n--->
<cfset newcsvfile = csvfile>
<cfset startpos = 1>
<cfloop condition = "NOT startpos IS 0">
	<cfset progresscount = progresscount + 1>
	<!---find the quote in the front--->
	<cfset startpos = find('"', csvfile, startpos)>
	<cfif startpos GT 0>
		<cfset endpos = find('"', csvfile, startpos+1)>
		<cfset nextstartpos = endpos + 1>
		<cfset charcount = endpos - startpos>
		<cfif charcount LT 1>
			<cfset charcount = 1>
		</cfif>
		<cfset stringtoreplace = mid(csvfile, startpos, charcount)>
		<cfset newstring = replacenocase(stringtoreplace, ",", "|", "ALL")>
        <cfset newstring = rereplace(newstring, "[\r\n]", "\r\n", "ALL")>
        <!---replace in newcsvfile--->
        <cfif len(stringtoreplace) GT 0>
			<cfset newcsvfile = replacenocase(newcsvfile, stringtoreplace, newstring, "ONE")>
		</cfif>
    	<cfset startpos = nextstartpos>     
	</cfif>
</cfloop>

<!---remove all \r\n 's ...this will only be necessary if their import contains carriage returns within fields (as in html)--->
<cfset newcsvfile = replace(newcsvfile, "\r\n", "", "ALL")>
<cfset newcsvfile = replace(newcsvfile, ",,", ",0,", "ALL")>

<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Estimating total records to import...';
</script>

<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Importing data into temporary table...';
</script>

<cfloop index="i" list="#newcsvfile#" delimiters="#chr(10)##chr(13)#">
	<cfset totalrecords = totalrecords + 1>
</cfloop>

<cfset TotalRecordsToImport = totalrecords>

<cfset progresscount = 0>

<cfloop index="i" list="#newcsvfile#" delimiters="#chr(10)##chr(13)#">

	<cfset progresscount = progresscount + 1>

	<!---used for skipping first row if column names are included--->
	<cfif progresscount GT columnrow>

	<!---Insert blank row for current csv row--->
    <cfquery name = "qryInsertTempData" datasource="#request.dsn#">
    INSERT INTO temp_import
    (CAT_IMPRT_ID)
    VALUES
    (#progresscount#)	
    </cfquery>

    <!---Now loop over each column and insert it into the appropriate column in the database--->
    <cfset thisline = replace(i, ",,", '," ",', "ALL")>
    <cfloop from="1" to="#listlen(new_columnlist, '^')#" index="col">
        <cfset col_name = listgetat(new_columnlist, col, "^")>

		<cftry>
			<cfset col_valu = listgetat('#thisline#', col, ',')>
        <cfcatch>
			<h2 style="color: #FF0000">Error!</h2>
            It seems there is a problem with your CSV file!
            <p>
            Please make sure this file is comma delimited and please use the quotation mark (") as the text qualifier for best results.  The file you uploaded is in an invalid format or some of the csv data was not formed correctly.
            <p>
            <a href = "index.cfm">Click here to start over</a>
            <cfabort>
         </cfcatch>
        </cftry>

        
        <!---for this value, replace | (pipe) with comma so it will look right in db...if it's there--->
        <cfset col_valu = replace(col_valu, "|", ",", "ALL")>
        <!---replace " with nothing as it is the text qualifier and we don't want that in there--->
        <cfset col_valu = replace(col_valu, '"', '', "ALL")>
        <!---replace all instances of "\" with a double "\\" for mysql so it doesn't cause an error; mysql escape character/--->
        <cfset col_valu = replace(col_valu, "\", "\\", "ALL")>	            
    
        <!---Update column in db with this value--->
        <cfquery name = "qryInsertData" datasource="#request.dsn#">
        UPDATE temp_import
        SET #col_name# = '#col_valu#'
        WHERE CAT_IMPRT_ID = #progresscount#
        </cfquery>
            
        </cfloop>
	</cfif>

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