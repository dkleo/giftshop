<cftry>
<cfif NOT ISDEFINED('url.action') AND NOT ISDEFINED('form.action')>
<cfinclude template="queries/qrylinks.cfm">
<cfinclude template="forms/frmlinks.cfm">
</cfif>

<cfif ISDEFINED('url.action')>
		<cfif url.action is 'AddsiteLink'>
			<cfinclude template = 'forms/frmsitelinks.cfm'>
		</cfif>
		<cfif url.action is 'AddCustomLink'>
			<cfinclude template = 'forms/frmcustomlinks.cfm'>
		</cfif>	
        <cfif url.action is 'Delete'>
          <cfinclude template = 'actions/actdelete.cfm'>
        </cfif>
		 <cfif url.action is 'Edit'>
          <cfinclude template = 'forms/frmedit.cfm'>
        </cfif>
 		  <cfif url.action is 'Exit'>
          <cflocation URL = '#request.AdminPath#'>
        </cfif>
      </cfif> 
	  
	  <cfif ISDEFINED('form.action')>
        <cfif form.action IS 'Add'>
          <cfinclude template = 'actions/actadd.cfm'>
        </cfif>
        <cfif form.action IS 'AddSiteLink'>
          <cfinclude template = 'actions/actaddsitelink.cfm'>
        </cfif>
        <cfif form.action IS 'AddCustomLink'>
          <cfinclude template = 'actions/actaddcustomlink.cfm'>
        </cfif>
		<cfif form.action IS 'Update'>
          <cfinclude template = 'Actions/actupdate.cfm'>
        </cfif>
</cfif> 

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>