<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Disapprove of all on the master list first then change to approved the ones on the approved list--->

<!---Disapprove all the ones on the master list first; this would be all newely uploaded images--->
<cfif isdefined('form.masterlist')>
	<cfloop from = "1" to = "#listlen(form.masterlist)#" index="mCount">
		<cfset thisid = listgetat(form.masterlist, mCount)>
		
		<cfquery name = "UpdateDApproved" datasource="#request.dsn#">
		UPDATE blog_reply SET approved = '0' 
		WHERE reply_id = '#thisid#'
		</cfquery>
	</cfloop>
</cfif>

<!---Now mark approved ONLY the ones that are checked; this will leave the unchecked ones unapproved--->
<cfif isdefined('form.approvelist')>
	<cfloop from = "1" to = "#listlen(form.approvelist)#" index="aCount">
		<cfset thisid = listgetat(form.approvelist, aCount)>
		
		<cfquery name = "UpdateApproved" datasource="#request.dsn#">
		UPDATE blog_reply SET approved = '1' where reply_id = '#thisid#'
		</cfquery>
	</cfloop>
</cfif>

<!---Delete the comments that were dissapproved--->
<cfquery name = "qryDeleteUnapproved" datasource="#request.dsn#">
DELETE FROM blog_reply
WHERE approved = 0 AND reply_blog_id = '#url.blog_id#'
</cfquery>

<center>
  <p>&nbsp;</p>
  <p><b>Replies were approved/disapproved</b><br>
<cfoutput>
    <a href = "index.cfm?action=blog.edit.default&m=#url.m#&y=#url.y#&isplugin=yes&mytoken=#mytoken#">Back to Posts</a>
</cfoutput>
    </p>
</center>




















