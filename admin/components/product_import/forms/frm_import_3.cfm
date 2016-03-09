<cfparam name = "importmethod" default="">
<cfparam name = "fromdsn" default = "">
<cfparam name = "dsnun" default = "">
<cfparam name = "dsnpw" default = "">
<cfparam name = "xmlfile" default = "">
<cfparam name = "tablename" default = "">
<cfparam name = "dopart" default = "1">

<h2>Product Import Step 3</h2>
<cfsetting requesttimeout="1200">
<cfflush interval="50">

<!---get columns in products table so we can build a list of names and types--->
<cfquery name = "qryProducts" datasource="#request.dsn#" maxrows="1">
SELECT * FROM products
</cfquery>

<!--- Get the column list.--->
<cfset lstColumns = qryProducts.ColumnList>

<cfset col_names = "">
<cfset col_types = "">

<!---Loop over the columns in the query.--->
<!---
<cfloop index="intColumn" from="1" to="#ListLen( lstColumns )#" step="1">
 <cfset col_names = listappend(col_names, "#qryProducts.GetMetaData().GetColumnName(JavaCast( 'int', intColumn ))#", "^")>
 <cfset col_types = listappend(col_types, "#qryProducts.GetMetaData().GetColumnTypeName(JavaCast( 'int', intColumn ))#", "^")>
</cfloop>
--->

<!---delete first one because that is itemid field.--->
<!---<cfset col_names = listdeleteat(col_names, 1, "^")>
<cfset col_types = listdeleteat(col_types, 1, "^")>--->

<cfif not dopart IS '3'>
<cfinclude template = "../displays/dsp_progressbar.cfm">
</cfif>
  
<!---Import the data into a temporary table--->
<cfinclude template = "../actions/act_readimportdata.cfm">
 
<!---query the temporary data--->
<cfinclude template = "../queries/qry_temptable.cfm">

<!---only show the columns they can import into--->
<cfset col_names = 'ProductID,SKU,brand,ProductName,BriefDescription,Price,WholesalePrice,ListPrice,UnitsInStock,Category,Details,Weight,mfg,upc,ImageURL,Thumbnail'>
<cfset col_titles = 'Product ID,SKU (Unique), Brand, Item Name, Short Description, Price, Wholesale Price, List Price, Default Number In Stock,Category or List of Categories, Full Details, Weight, Manufacturer, UPC, URL/Filename for Image (if applicable), URL/Filename of Thumbnail (if applicable)'>
<cfset col_types = 'VARCHAR,VARCHAR,VARCHAR,VARCHAR,VARCHAR,FLOAT,VARCHAR,VARCHAR,INTEGER,VARCHAR,LONGTEXT,VARCHAR,VARCHAR,VARCHAR,VARCHAR,VARCHAR'>

<cfset col_names = replace(col_names, ",", "^", "ALL")>
<cfset col_titles = replace(col_titles, ",", "^", "ALL")>
<cfset col_types = replace(col_types, ",", "^", "ALL")>

<cfset colnames = #qry_TempTable.columnlist#>
  
<p>Now you need to choose where to put the data you are trying to import. Select the column in your data that matches the columns in your store.<form name = "form1" method="post" <cfoutput>action="index.cfm?action=import_step_4"</cfoutput>>


<table width="100%" align="left" cellpadding="0" cellspacing="0">
<tr>
<td>
<table width="95%" align="left" cellpadding="4" cellspacing="0">
<tr>
  <td colspan="2"><input name="delete_all" type="checkbox" id="delete_all" value="delete_all" /> 
    Check here if you want to delete all items from your catalog before importing these.</td>
</tr>
<tr>
	<td colspan="2">Choose how to assign categories</td>
</tr>
<tr>
  <td width="30%" valign="top">
    <input name="cat_assignmethod" type="radio" value="selectone" checked="checked" />
    Put all into this category: 
    <select name="DefaultCategory">
      <option value = "0" SELECTED>Set Inactive</option>
      <cf_CategoryTree Directory="/"
        Datasource="#request.dsn#">  
    </select>    </td>
    <td valign="top">
	<input type="radio" name="cat_assignmethod" value="usecolumn" />Determined by:
    <select name="category_guide">
	<cfloop from = "1" to = "#listlen(colnames)#" index="colcount">    
	<cfset thiscolname = '#listgetat(colnames, colcount)#'>
		<cfif NOT thiscolname IS 'CAT_IMPRT_ID'>
			<cfoutput><option value="#thiscolname#">#thiscolname#</option></cfoutput>
	    </cfif>
    </cfloop>
    </select>
    <br />
    using:  
    <select name="catval_type" id="catval_delim">
    	<option value = "type_id">An ID Number (Integer)</option>
        <option value = "type_name">The actual Name</option>
    </select>
	<br />
	which contains:
    <select name="catval_del" id="catval_del">
    	<option value = "_">Single (No Delimiter)</option>
        <option value = "|">Multiple '|' Delimited</option>
        <option value = "^">Multiple '^' Delimited</option>
        <option value = ",">Multiple ',' Delimited</option>
    </select>
    Value(s).    </td>
</tr>
</table>
</tr>
<tr>
<td>
  <table width="700" border="1" align="left" cellpadding="6" cellspacing="0">
    <tr>
      <td width="50%" bgcolor="#0066CC"><span style="font-weight: bold; color: #FFFFFF">Import Into...</span></td>
      <td bgcolor="#0066CC"><span style="font-weight: bold; color: #FFFFFF">Column In Your Data</span></td>
      <td bgcolor="#0066CC"><span style="font-weight: bold; color: #FFFFFF">Actual DB Column</span></td>
    </tr>
<cfloop from = "1" to = "#listlen(col_names, '^')#" index="colcount">
<cfset thiscol_name = listgetat(col_names, colcount, "^")>
<cfset thiscol_title = listgetat(col_titles, colcount, "^")>
<cfset thisCol_type = listgetat(col_types, colcount, "^")>
<cfif NOT thiscolname IS 'CAT_IMPRT_ID'>
<cfoutput>
    <tr>
      <td>#thiscol_title#</td>
      <td>
      <input type="hidden" name="dbcols" value="#thiscol_name#" />
      <input type="hidden" name="dbcoltypes" value="#thiscol_type#" />
      <select name="colsmatch">
        <option value="ignorecolumn" selected="selected"> </option>
		<cfloop from = "1" to = "#listlen(colnames)#" index="c">
			<cfset thisColname = listgetat(colnames, c)>
            <option value="#thisColname#" <cfif thisCol_name IS thiscolname>selected="selected"</cfif>>
            #thisColname#</option>
		</cfloop>
      </select>
      </td>
      <td>#thiscol_name#</td>
    </tr>
    </cfoutput>
</cfif>
</cfloop>
  </table>
  </td>
</tr>
</table>
  <p>
    <input type = "submit" name="button1" value="Complete Import"/>
  </p>
</form>















