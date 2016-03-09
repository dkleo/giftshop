<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif isdefined('form.approvelist')>
	<cfloop from = "1" to = "#listlen(form.approvelist)#" index="aCount">
		<cfset thisid = listgetat(form.approvelist, aCount)>
		
		<cfquery name = "UpdateApproved" datasource="#request.dsn#">
		DELETE FROM comments WHERE id = '#thisid#'
		</cfquery>
	</cfloop>
</cfif>

<center>
  <p>&nbsp;</p>
  <p><b>Comments were deleted</b><br></p>
</center>




















