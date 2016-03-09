<cfdirectory action="list" name="qFiles" directory="#request.catalogpath#docs#request.bslash#" type="file">
<style type="text/css">
<!--
.style1 {
	color: #990000;
	font-weight: bold;
}
-->
</style>

<cfif NOT directoryexists('#request.catalogpath#docs_backup')>
	<cfdirectory action="create" directory="#request.catalogpath#docs_backup" mode="777">
</cfif>

<cfif isdefined('form.files')>

<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


	<cfif form.files IS 'selectedfiles'>

      <cfloop list="#form.select_files#" delimiters="," index="thisfilename">
    
        <cfif right(thisfilename, 4) IS '.cfm' OR right(thisfilename, 4) IS '.htm' OR right(thisfilename, 5) IS '.html'>
          <cffile action="read" variable="thisfile" file="#request.catalogpath#docs#request.bslash##thisfilename#">
                
                <cfset newfile = replacenocase(thisfile, form.findwhat, form.replacewith, "ALL")>
               
                <!---backup original--->
          <cffile action="copy" source="#request.catalogpath#docs#request.bslash##thisfilename#" destination="#request.catalogpath#docs_backup#request.bslash##thisfilename#">
                
                <!---write new file--->
          <cffile action="write" output="#newfile#" file="#request.catalogpath#docs#request.bslash##thisfilename#">
                
		</cfif>
      </cfloop>

        <span class="style1">Find and replace was completed successfully.</span>

    <cfelse>
    
    <cfloop query = "qFiles">

   	  <cfset thisfilename = qFiles.name>
      <cfif right(thisfilename, 4) IS '.cfm' OR right(thisfilename, 4) IS '.htm'>
       	<cffile action="read" variable="thisfile" file="#request.catalogpath#docs#request.bslash##thisfilename#">
            
            <cfset newfile = replacenocase(thisfile, form.findwhat, form.replacewith, "ALL")>
            
            <!---backup original--->
        <cffile action="copy" source="#request.catalogpath#docs#request.bslash##thisfilename#" destination="#request.catalogpath#docs_backup#request.bslash##thisfilename#">
            
            <!---write new file--->
       	<cffile action="write" output="#newfile#" file="#request.catalogpath#docs#request.bslash##thisfilename#">
            
	  </cfif>
    </cfloop>
    
	<span class="style1">Find and replace was completed successfully.</span>
    </cfif>
    
</cfif>

<h2>Find and Replace</h2>
<p>This function performs a simple find and replace in pages that you have in your docs folder. </p>
<p>Note: This may take a couple minutes to complete depending on the number of files in your site.</p>
<form name="form1" method="post" action="dopages.cfm?action=findreplace">
  <p>
    <input name="files" type="radio" id="files" value="allfiles" checked>
  All Files</p>
  <p>
    <input type="radio" name="files" id="files2" value="selectedfiles">
    Only Selected Files Below  </p>
  <p>
    <select name="select_files" size="5" id="selected_files">
    <cfloop query = "qFiles">
    	<cfoutput><option value="#qFiles.name#">#qFiles.name#</option></cfoutput>
    </cfloop>
    </select>
  (Hold down CTRL and click your mouse button to select multipe files.</p>
  <p>Find What?<br> 
    <textarea name="findwhat" id="findwhat" cols="75" rows="8"></textarea>
  </p>
  <p>Replace with What?</p>
  <p>
    <textarea name="replacewith" id="replacewith" cols="75" rows="8"></textarea>
</p>
  <p>
    <input type="submit" name="button" id="button" value="Find and Replace">
  </p>
</form>
<p>&nbsp;</p>
