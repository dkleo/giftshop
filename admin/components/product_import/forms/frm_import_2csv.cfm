<h2>Import Categories From CSV</h2>

<form method="post" enctype="multipart/form-data" name="form1" action="index.cfm?action=Prep_Import">
<p>IMPORTANT: Your CSV file needs to contain comma delimited data with a double quote (&quot;) as the text qualifier (field values are surrounded with &quot;'s). If it is not in this standard format, this import will not work correctly.</p>
<p>Select the CSV file from you hard drive: 
  <input name="csvfilefield" type="file" size="45" width="40">
</p>
<p>
  Does the first row contain column names?
  <select name="hasColumns" id="hasColumns">
  	<option value="Yes" selected="selected">Yes</option>
    <option value="No">No</option>
  </select> 
  (it is recommended that your csv file includes column names)</p>
<p>
  <cfoutput><input type="hidden" name="importmethod" value="#form.importmethod#" /></cfoutput>
  <input type = "submit" name="submitbutton" value="Continue With Import --->">
</p>
</form>















