<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


<cfinclude template='../queries/qrycontacts.cfm'>

<!---first verify that it's okay to delete this contact.  If so, then
go back to index.cfm and pass the URL variable DeleteOK--->
<cfif NOT isdefined('url.DeleteOK')>
<cfoutput query = "qrycontacts">
   <p align="center"><font color="##FF0000"><b>#CompanyName#</b></font></p>
</cfoutput>
     <p align="center"><font color="#800000"><b>You are about to delete the 
     contact named above. Deleting a contact can not be undone. Are you sure you want <br>
	 to delete this contact from the address book?</b></font></p>
     <cfoutput>
	 <p align="center">
	 <a href="index.cfm?Action=Delete&DeleteOK=YES&ContactID=#url.contactid#">
	 YES</a> | <a href="index.cfm?action=view">NO</a></b></p>
	 </cfoutput>
</cfif>

<!---since DeleteOK is defined, it's been confirmed so it's okay to delete this
contact from the database--->

<cfif isdefined('url.DeleteOK')>
<cfquery name = "DeleteContact" datasource = #request.dsn#>
DELETE FROM contacts
WHERE ContactID = #url.ContactID#
</cfquery>
<cflocation url="index.cfm?action=View">
</cfif>




















