<h2>Possible Solutions</h2>

<cfif NOT url.errorid IS '0'>

    <cfhttp url="#request.supporturl#getsolutions.cfm" method="post">
    <cfhttpparam type="formfield" name="errorid" value="#url.errorid#">
    </cfhttp>

	<cfset response = cfhttp.FileContent>

    <cfquery name = "qError" datasource="#request.dsn#">
    select * FROM errorlog
    WHERE errorid = '#url.errorid#'
    </cfquery>

	<cfoutput query="qError">
    	Error Message: #brief#<p>&nbsp;</p>
    </cfoutput>

	<cfif listlen(response, "|") GT 0>
        <cfset errorcode = trim(listgetat(response, 1, "|"))>
        <cfset totalsolutions = trim(listgetat(response, 2, "|"))>
        <cfset solutions = "">
    
        <cfoutput>
        <cfif totalsolutions GT 0>
            <cfset solutions = listgetat(response, 3, "|")>
            Error id :#errorcode#
            <p>&nbsp;</p>
            One or more possible solutions to your error message have been found.  The following information may assist you.  If you fix the error yourself, please mark it as fixed and share
            with us how you fixed it if you do not use one of the solutions below.
            <p>&nbsp;</p>
            <cfset solution_count = 0>
            <cfloop from = "1" to = "#listlen(solutions, '^')#" index="scount">
                <cfset solution_count = solution_count + 1>
                <cfset this_solution = listgetat(solutions, scount, "^")>
                Solution #solution_count#: #this_solution#
              <p>&nbsp;</p>
            </cfloop>
       <cfelse>
       Error id: #errorcode#
       <p>
       At this time there are no solutions for this error message.  If you fix the problem on your own, please
       mark the error fixed and tell <br />
       us how you fixed it.  Check back again at a later date to see if there is a solution to this problem.  Thank you.</p>
       </cfif>
            
       </cfoutput>
	<cfelse>
		We could not contact the server.  Please check your connection settings or try your request later.
    </cfif>
	
<cfelse>
	You must submit an error report before possible solutions can be given.
</cfif>