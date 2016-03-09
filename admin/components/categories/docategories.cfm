
<cftry>
<cfif NOT ISDEFINED('url.Action') AND NOT ISDEFINED('form.Action')>
		<cfinclude template = "forms/frmcategories.cfm">
</cfif>
	  <cfif isdefined('url.action')>
	  <cfif url.action IS 'NewCategory'>
	  	<cfinclude template = "forms/frmNewCategory.cfm">
	  </cfif>
	  <cfif url.action IS 'Delete'>
	  	<cfinclude template = "actions/actdelete.cfm">
	  </cfif>
	  <cfif url.action IS 'RemovePic'>
	  	<cfinclude template = "actions/actremovepic.cfm">
	  </cfif> 
	  <cfif url.action is 'ChangeSubCategory'>
	  	<cfinclude template = 'forms/frmsetsub.cfm'>
	  </cfif>    
	  <cfif url.action is 'ChangeOrder'>
	  	<cfinclude template = 'forms/frmchangeorder.cfm'>
	  </cfif>    
  	  <cfif url.action is 'SetImage'>
	  	<cfinclude template = 'forms/frmimage.cfm'>
	  </cfif> 
	  <cfif url.action is 'EditDetails'>
	  	<cfinclude template = 'forms/frmdetails.cfm'>
	  </cfif>    
	  <cfif url.action IS 'UpdateOrder'>
	  	<cfinclude template = "actions/actsavereorder.cfm">
	  </cfif>
	  <cfif url.action IS 'UpdateOrder'>
	  	<cfinclude template = "actions/actSaveReorder.cfm">
	  </cfif>      
	  <cfif url.action IS 'SetLinkImage'>
	  	<cfinclude template = "forms/frmlinkimage.cfm">
	  </cfif>
	  <cfif url.action IS 'RemoveLinkPic'>
	  	<cfinclude template = "actions/actremovelinkpic.cfm">
	  </cfif>      
</cfif>
	  
<cfif isdefined('form.action')>  
		  <cfif form.action IS 'Add'>
              <cfinclude template = "actions/actadd.cfm">
          </cfif>
	  <cfif form.action IS 'UpdateCategories'>
		  <cfinclude template = "actions/actupdatecategories.cfm">
	  </cfif>
	  <cfif form.action IS 'UpdateSub'>
		  <cfinclude template = "actions/actupdatesub.cfm">
	  </cfif>
	  <cfif form.action IS 'Upload'>
		  <cfinclude template = "actions/actupload.cfm">
	  </cfif>
	  <cfif form.action IS 'UploadLinkImage'>
		  <cfinclude template = "actions/actuploadlinkimage.cfm">
	  </cfif>
	  <cfif form.action IS 'UpdateDetails'>
		  <cfinclude template = "actions/actupdatedetails.cfm">
	  </cfif> 	  
</cfif>
      

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>

      	  











