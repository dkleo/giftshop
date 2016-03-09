<h2>Category Import Step 1</h2>
<p>Please note that this import feature may not work on all servers. If you experience a request timeout error, please seek out another method of importing your data until this feature can be improved.</p>
<form name="form1" method="post" action="index.cfm?action=import_step_2">
  <p>Select source: 
  <select name="importmethod">
      <option value="dsn">Import from another datasource</option>
      <!---coming soon <option value="xml">Import from an XML file</option>--->
      <option value="csv">Import from CSV</option>
  </select> 
  <input type="submit" name="Submit" value="Continue with import ---&gt;">
  </p>
</form>



















