<cfinclude template = "../queries/qrycontacts.cfm">
<table border="0" cellpadding="2" width="100%" cellspacing="0">
<cfif NOT ISDEFINED('application.CurrentAlphaIndex')>
<cfset application.CurrentAlphaIndex = 'A'>
</cfif>
<cfif ISDEFINED('url.AlphaIndex')>
<cfset application.CurrentAlphaIndex = #url.AlphaIndex#>
</cfif>
<cfoutput query="qrycontacts">
<cfif #Left(CompanyName , 1)# IS #Application.CurrentAlphaIndex#>
	<tr>
	  <td width="100%" colspan="3" bgcolor="##99CCFF"><a href="index.cfm?action=Add"><img border="0" src="icons/icon_folder_new.gif" width="18" height="16" alt="New Contact"></a>
		<b><a href="index.cfm?Action=Edit&ContactID=#ContactID#&Index=#Application.CurrentAlphaIndex#"><img border="0" src="icons/icon_pencil.gif" alt="Edit this Contact" width="15" height="15"></a>
		<a href="index.cfm?Action=Delete&ContactID=#ContactID#&Index=#Application.CurrentAlphaIndex#"><img border="0" src="icons/icon_trashcan.gif" alt="Delete Contact" width="16" height="15"></a>
		<a href="viewnotes.cfm?ContactID=#ContactID#"><img border="0" src="icons/icon_folder_archive.gif" alt="View Notes" width="20" height="18"></a>
		Name:</b> <b>#CompanyName#</b></td>
	</tr>
	<tr>
	  <td width="27%"><b>Contact Person</b></td>
	  <td width="73%" colspan="2">#FirstName# #LastName#</td>
	</tr>
	<tr>
	  <td width="27%" ><b>City:</b> #City#</td>
	  <td width="39%" ><b>State:</b> #StateOrProvince#</td>
	  <td width="34%"><b>Zip Code:</b> #PostalCode#</td>
	</tr>
	<tr>
	  <td width="100%" colspan="3"><b>Phone:</b>
		#PhoneNumber# <b>Extension:</b> #PhoneExtension#</td>
	</tr>
	<tr>
	  <td width="100%" colspan="3"><b>Fax
		Number:</b> #FaxNumber#</td>
	</tr>
	<tr>
	  <td width="100%" colspan="3"><b>Mobile
		Number:</b> #MobilePhone#</td>
	</tr>
	<tr>
	  <td width="100%" colspan="3"><b>Email
		Address:</b> <a href="mailto:#EmailAddress#">#EmailAddress#</a></td>
	</tr>
	<tr>
	  <td width="100%" colspan="3"><b>Internet
		homepage:</b> <a href="http://#InternetSite#" target="_blank">#InternetSite#</a></td>
	</tr>
</cfif>
</cfoutput>
</table>
















