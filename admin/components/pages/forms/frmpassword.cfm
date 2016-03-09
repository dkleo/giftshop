<cfparam name = "pageid" default="none">

<cfset current_pass = ''>

<cfquery name = "qPages" datasource="#request.dsn#">
SELECT * FROM private_pages
WHERE page_filename = '#pageid#'
</cfquery>

<cfoutput query = "qPages">
	<cfset current_pass = qPages.pword>
</cfoutput>

<cfif isdefined('form.pword')>

	<cfif qPages.recordcount GT 0>
		<cfif isdefined('form.clearpassword')>
            <cfquery name = "qClearPass" datasource="#request.dsn#">
            DELETE FROM private_pages 
            WHERE page_filename = '#pageid#'
            </cfquery>
        <cfelse>
            <cfquery name = "qClearPass" datasource="#request.dsn#">
            UPDATE private_pages SET pword = '#form.pword#'
            WHERE page_filename = '#pageid#'
            </cfquery>
        </cfif>
	<cfelse>
    
    		<cfquery name="qInsertPass" datasource="#request.dsn#">
            INSERT INTO private_pages
            (page_filename, subscription_id, pword, groupid)
            VALUES
            ('#pageid#', '0', '#form.pword#', '0')
            </cfquery>
             	
    </cfif>
	
	<cflocation url = "dopages.cfm">
    
</cfif>


<form method = "post" action="dopages.cfm?action=setpassword">

<cfoutput>
<input type = "hidden" name="pageid" value="#pageid#" />
<h2>Change Page Password</h2>
<br />
Change Password for this page to:  <input type = "text" name="pword" value="#current_pass#" />
<p><input type="checkbox" name="clearpassword" value="true" /> Check here to clear the password</p>
<p><input type="submit" value="Change Password" name="submitbutton" /></p>
</cfoutput>

</form>







