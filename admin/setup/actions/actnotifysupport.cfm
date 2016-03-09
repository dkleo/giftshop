<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---sends notification to support concerning an error report and attempts to look up a solutions for it--->
<cfquery name = "qryError" datasource="#request.dsn#">
SELECT * FROM errorlog
WHERE id = #url.id#
</cfquery>

<cfloop query = "qryError">
<!---strip out paths from brief for error matching--->
<cfset compare_path = replace(#request.catalogpath#, "#request.bslash#", "#request.bslash##request.bslash#", "ALL")>
<cfset errormsg = replacenocase(brief, compare_path, "")>

<cfquery name = "qVersion" datasource="#request.dsn#">
SELECT * FROM versioninfo
</cfquery>

<cfhttp url="#request.supporturl#submiterror.cfm" method="post" port="80">
 <cfhttpparam type="formfield" name="errordate" value="#errordate#">
 <cfhttpparam type="formfield" name="errordetail" value="#errordetail#">
 <cfhttpparam type="formfield" name="brief" value="#brief#">
 <cfhttpparam type="formfield" name="website" value="#request.homeurl#">
 <cfhttpparam type="formfield" name="errormsg" value="#errormsg#">
 <cfhttpparam type="formfield" name="version" value="#qVersion.version#">
 <cfhttpparam type="formfield" name="errorid" value="#url.errorid#">
 <cfhttpparam type="formfield" name="emailaddress" value="#request.emailaddress#">
</cfhttp>

<cfset response = cfhttp.FileContent>

<cfif listlen(response, "|") GT 0>
	<cfset errorcode = trim(listgetat(response, 1, "|"))>
    <cfset totalsolutions = trim(listgetat(response, 2, "|"))>
	<cfset solutions = "">

	<cfquery name = "qryUpdateErrorCode" datasource="#request.dsn#">
    UPDATE errorlog SET errorid = '#errorcode#'
    WHERE id = #qryError.id#
    </cfquery>

	<cfoutput>
	<cfif totalsolutions GT 0>
    	<cfset solutions = listgetat(response, 3, "|")>

        <h2>Your error was submitted</h2>
        It received an id of #errorcode#
        <p>&nbsp;</p>
        
    	One or more possible solutions to your error message have been found.  If you do not have access to support and you need to 
        fix the error yourself, <br />
        the following information may assist you.  If you fix the error yourself, please mark it as fixed and share
        with us how you fixed it.
	    <p>&nbsp;</p>
        <cfset solution_count = 0>
        <cfloop from = "1" to = "#listlen(solutions, '^')#" index="scount">
        	<cfset solution_count = solution_count + 1>
        	<cfset this_solution = listgetat(solutions, scount, "^")>
            Solution #solution_count#: #this_solution#
          <p>&nbsp;</p>
        </cfloop>
   <cfelse>
   <h2>Your error was submitted</h2>
   It received an id of #errorcode#
   <p>
   Thank you for submitting the error message you received.  If you have access to support, someone will contact you in regards to the error once it has
   been fixed.  <br />
   At this time there were solutions currently available for this error message.  If you have to the fix the problem on your own, please
   mark the error fixed and tell <br />
   us how you fixed it.  Thank you.	</p>
   </cfif>
        
   </cfoutput>

<cfelse>
Sorry, but the request to send the error report to support has failed.  Please try again later.
</cfif>

</cfloop>