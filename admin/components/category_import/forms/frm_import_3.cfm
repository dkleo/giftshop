<h2>Category Import Step 3</h2>
<cfsetting requesttimeout="1200">
<cfflush interval="50">

<cfinclude template = "../displays/dsp_progressbar.cfm">  
  
<!---Import the data into a temporary table--->
<cfinclude template = "../actions/act_readimportdata.cfm">
 
<!---query the temporary data--->
<cfinclude template = "../queries/qry_temptable.cfm">

<cfset colnames = #qry_TempTable.columnlist#>
  
<p>Now you need to choose where to put the data you are trying to import.    If the the column doesn't match anything, then just leave it set to nothing. If you do not have data for a certain column, do not worry about it, because default values will be assigned. At minimum though you will need to provide the field for the name for each category. If you are running mysql, you may specify the unique id for each record. This unique ID, if refrenced in your product data, can then be used when importing products.<form name = "form1" method="post" <cfoutput>action="index.cfm?action=import_step_4"</cfoutput>>

<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td>
    <table width="600" border="1" cellspacing="0" cellpadding="6">
    <tr>
      <td width="50%" bgcolor="#0066CC"><span style="font-weight: bold; color: #FFFFFF">Column Name in your data </span></td>
      <td bgcolor="#0066CC"><span style="font-weight: bold; color: #FFFFFF">Type of data this is </span></td>
    </tr>
<cfloop from = "1" to = "#listlen(colnames)#" index="colcount">
<cfset thiscolname = '#listgetat(colnames, colcount)#'>
<cfif NOT thiscolname IS 'CAT_IMPRT_ID'>
    <cfoutput>
    <tr>
      <td>#thiscolname#</td>
      <td><select name="#thiscolname#_type">
        <option value="ignorecolumn" selected="selected">  </option>
		<cfif request.dbtype IS 'mysql'><option value="categoryid">Category Unique ID</option></cfif>
        <option value="categoryname">Cateogory Name</option>
        <option value="SubCategoryOf">Parent Category ID</option>
      </select>
      </td>
    </tr>
    </cfoutput>
</cfif>
</cfloop>
  </table>
  <p>
    <input type = "submit" name="button1" value="Complete Import"/>
  </p>
</td>
</tr>
</table>
</form>




















