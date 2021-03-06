<cfparam name = "view_resolved" default="No">

<script LANGUAGE="JavaScript">
	function ConfirmDelete()
	{
	var agree=confirm("Are you sure you want to clear the entire error log?");
	if (agree)
		location.replace('dosetup.cfm?action=clearerrorlog'); 
	else
		return false ;
	}
</script>

<cfquery name = "qryErrorLog" datasource="#request.dsn#">
SELECT * FROM errorlog
WHERE resolved = '#view_resolved#'
</cfquery>

<style type="text/css">
<!--
.style3 {color: #FFFFFF; font-weight: bold; }
-->
</style>
<h2>Error Log <cfoutput><a href = "#request.AdminPath#helpdocs/error_log.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></h2>
<p>This log stores any errors generated by your website. If an error occurs the custom error page is shown to the customer. Please note that some errors may be generated by bots visiting your site and not actual customers.<br />
Regardless of what generated the error, please submit all error messages to the developer so that they can be analyzed and patched if necessary. Thank you.</p>

<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>Error log is hidden in demo mode for secuirty reasons</strong></font>
	<cfabort>
</cfif>


<p><a href="##"  onclick="javascript:ConfirmDelete();">Clear Entire Log</a>  &nbsp;|&nbsp; 
  <cfif view_resolved IS 'No'><a href="dosetup.cfm?action=viewerrors&view_resolved=yes">View Resolved Errors</a><cfelse>
<a href="dosetup.cfm?action=viewerrors&view_resolved=no">View Unresolved Errors</a></cfif>&nbsp;|&nbsp;<a href="dosetup.cfm?action=customerror">Edit Error Page</a></p>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="10%" bgcolor="#000000"><span class="style3">Error Number</span></td>
    <td width="15%" bgcolor="#000000"><span class="style3">Date and Time</span></td>
    <td bgcolor="#000000"><span class="style3">Message</span></td>
    <td bgcolor="#000000" width="5%"><span class="style3">Reported?</span></td>
    <td bgcolor="#000000" width="25%"></td>
  </tr>
<cfoutput query = "qryErrorLog">
  <tr>
    <td>#id#</td>
    <td>#dateformat(errordate, "mmmm dd, yyyy")# at #timeformat(errordate, "hh:mm")#</td>
    <td><div style="width: 500px; height: 35px; overflow: auto;">#brief#</div></td>
    <td><cfif errorid IS '0'>No<cfelse>Yes</cfif></td>
    <td><a href = "dosetup.cfm?action=ViewErrorDetail&id=#id#">View</a> &nbsp;| &nbsp;<a href="dosetup.cfm?action=DeleteError&id=#id#">Delete</a>&nbsp; <cfif NOT errorid IS '0'>| &nbsp;
      <cfif qryErrorLog.resolved IS 'No'><a href = "dosetup.cfm?action=MarkErrorResolved&id=#id#">Mark Resolved</a><cfelse><a href = "dosetup.cfm?action=MarkErrorUnResolved&id=#id#">Mark Unresolved</a></cfif> &nbsp;|&nbsp; <a href = "dosetup.cfm?action=viewsolutions&amp;errorid=#errorid#">Possible Solutions</a>
      </cfif></td>
  </tr>
</cfoutput>
</table>




