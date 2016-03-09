<h2>Mark Error as Resolved/Unresolved</h2>
<p><strong>Please tell us how the error was fixed (If known). If you do not know how the error was fixed, then it is not necessary to mark it<br />
resolved. If you are submitting a report on how you fixed a problem, please try to be as descriptive as possible. We will review your<br />
fix and if we like it, we will share it with others that might run into the same problem you had. Thank you.</strong></p>

<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif isdefined('form.resolution')>
	
    <cfquery name = "qUpdateError" datasource="#request.dsn#">
    UPDATE errorlog
    SET resolved = '#form.resolved#',
    resolution = '#form.resolution#'
    WHERE id = #url.id#
    </cfquery>
   
    <cfhttp url="#request.supporturl#updateerror.cfm" method="post">
     <cfhttpparam type="formfield" name="errorid" value="#url.errorid#">
     <cfhttpparam type="formfield" name="notes" value="#form.resolution#">
	 <cfhttpparam type="formfield" name="resolved" value="#form.resolved#">
    </cfhttp>
 
 	<cfoutput>#cfhttp.FileContent#</cfoutput>   
 
 	<cflocation url = "dosetup.cfm?action=viewerrors">
</cfif>

<cfquery name = "qError" datasource="#request.dsn#">
SELECT * FROM errorlog
WHERE id = #url.id#
</cfquery>

<cfoutput query="qError">
<form name="form1" method="post" action="dosetup.cfm?action=MarkErrorResolved&id=#url.id#&errorid=#errorid#">
  <p>
    <textarea name="resolution" id="resolution" cols="55" rows="5">#resolution#</textarea>
</p>
  <p><strong>Resolved?</strong> 
    <select name="resolved" id="resolved">
      <option value="Yes" <cfif resolved IS 'Yes'>selected="selected"</cfif>>Yes</option>
      <option value="No" <cfif resolved NEQ 'Yes'>selected="selected"</cfif>>No</option>
    </select>
  </p>
  <p><strong>
    <input type="submit" name="button" id="button" value="Submit">
  </strong></p>
</form>
</cfoutput>
<p>&nbsp;</p>
