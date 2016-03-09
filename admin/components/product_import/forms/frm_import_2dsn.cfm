<form method="post" enctype="multipart/form-data" name="form1" <cfoutput>action="index.cfm?action=Prep_Import"</cfoutput>>
<p>Enter the name of the datasource you have setup to import from:	
  <input name = "fromdsn" type = "text" value="" size="30">
  </p>
<p>Datasource username (if needed): 
  <input name = "dsnun" type = "text" id="dsnun" value="" size="30">
  <br>
  <br>
  Datasource password (if needed):
  <input name = "dsnpw" type = "text" id="dsnpw" value="" size="30">
</p>
<p>What is the name of the <strong>product </strong>table you want to import from? 
  <input name="tablename" type="text" id="tablename" size="30" />
</p>
<p>NOTE: Check your spelling (pay attention to case with MySQL)! If you mistype it, you will get an error. </p>
<p>
  <cfoutput><input type = "hidden" value="#form.importmethod#" name = "importmethod"></cfoutput>
  <input type="submit" name="Submit" value="Continue with import ---&gt;">
</p>
</form>















