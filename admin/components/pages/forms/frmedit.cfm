<!---If the file doesn't exist then create a new blank file--->
<cfif NOT fileexists('#request.CatalogPath#docs#request.bslash##ID#')>
	<cffile action = "write" file = "#request.CatalogPath#docs#request.bslash##url.ID#" output=" ">
</cfif>

<cffile action = "read"
file = "#request.CatalogPath#docs#request.bslash##url.ID#" 
variable = "PageContent"
>

<cfoutput>
<form id="theForm" method="post" action="dopages.cfm">
<input type="hidden" name="OldPageRef" Value="#ID#">
<textarea name="EditPage" id="EditPage" style="width: 100%;" rows="300">#PageContent#</textarea>
<input type="Hidden" Value="#url.ID#" Name="PageRef">
<input type="Hidden" Value="UpdatePage" Name="Action">
<center><input type="Submit" value="Save" Name="Submit"></center>
</form>
</cfoutput>


<cfoutput>
<script type="text/javascript">


	CKEDITOR.replace( 'EditPage',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'				
	});

</script>
</cfoutput>