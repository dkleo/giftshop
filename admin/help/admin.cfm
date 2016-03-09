<!---This allows you to administer the help content and create new content and add links to the 
control panel --->

<link href="../controlpanel.css" rel="stylesheet" type="text/css">

<!---If nothing is called then allow them to create new content--->
<cfif NOT ISDEFINED('url.action') AND NOT ISDEFINED('form.action')>
<div align="left">
<h2>Help Context Admin</h2>

 <cfif NOT qryLoginCheck.userlevel IS "admin" AND NOT qryLoginCheck.userlevel IS 'masteradmin'>
	<h3>Settings</h3>
    User accounts cannot change some settings.  Please login as an admin to change settings.
    <cfabort>
</cfif>
 
    <strong>Use this section of the control panel if you want to edit the quick<br />
  </strong><strong>help files that are accessed when you click on a help icon.<br>
  </strong></p>
    <p><a href="admin.cfm?action=new">Create new content</a></p>
    <p><a href="admin.cfm?action=viewindex">View Index</a></p>
</div>
</cfif>

<cfif ISDEFINED('url.action')>
	<cfif url.action IS 'view'>
		<cfinclude template = "forms/frmadmincontents.cfm">
	</cfif>
	<cfif url.action IS 'new'>
		<cfinclude template = "forms/frmadd.cfm">
	</cfif>
	<cfif url.action IS 'edit'>
		<cfinclude template = "forms/frmedit.cfm">
	</cfif>
	<cfif url.action IS 'delete'>
		<cfinclude template = "actions/actdelete.cfm">
	</cfif>
	<cfif url.action IS 'viewindex'>
		<cfinclude template = "forms/frmadminindex.cfm">
	</cfif>
</cfif>

<cfif ISDEFINED('form.action')>
	<cfif form.action IS 'add'>
		<cfinclude template = "actions/actadd.cfm">
	</cfif>
	<cfif form.action IS 'update'>
		<cfinclude template = "actions/actupdate.cfm">
	</cfif>
</cfif>



