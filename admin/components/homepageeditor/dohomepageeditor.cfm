<cftry>

<h2 align="left">Homepage 
  <!---by default display the form--->
</h2>
<cfif NOT isdefined ('url.action') AND NOT isdefined('form.action')> 

<cfinclude template = 'forms/frmhomepageeditor.cfm'>
</cfif>

<!---actions--->

<cfif isdefined('form.action')>
<cfif form.action IS 'Update'>
<cfinclude template = 'actions/actupdate.cfm'>
</cfif>
</cfif>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>









