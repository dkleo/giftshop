<!---Disapprove of all on the master list first then change to approved the ones on the approved list--->
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Disapprove all the ones on the master list first; this would be all newely uploaded images--->
<cfif isdefined('form.masterlist')>
	<cfloop from = "1" to = "#listlen(form.masterlist)#" index="mCount">
		<cfset thisid = listgetat(form.masterlist, mCount)>
		
		<cfquery name = "UpdateDApproved" datasource="#request.dsn#">
		UPDATE comments SET approved = '0' 
		WHERE id = '#thisid#'
		</cfquery>
	</cfloop>
</cfif>

<!---Now mark approved ONLY the ones that are checked; this will leave the unchecked ones unapproved--->
<cfif isdefined('form.approvelist')>
	<cfloop from = "1" to = "#listlen(form.approvelist)#" index="aCount">
		<cfset thisid = listgetat(form.approvelist, aCount)>
		
		<cfquery name = "UpdateApproved" datasource="#request.dsn#">
		UPDATE comments SET approved = '1' where id = '#thisid#'
		</cfquery>
	</cfloop>
</cfif>

<center>
  <p>&nbsp;</p>
  <p><b>Comments were approved</b><br></p>
</center>




















