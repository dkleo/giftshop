
<!---<cfinclude template = "../queries/qrypages.cfm">--->

<!---Find the last Page order number and add one to it--->

<!---<cfset NewPageID = 0>
<cfoutput query = "qryPages">
<cfset NewPageID = #ID#>
</cfoutput>
<cfset NewPageID = NewPageID + 1>--->
<cfset newpage = "New Page">

<form id="theForm" method="post" action="dopages.cfm">
<!---<input type="hidden" name="PageID" value="#NewPageID#">--->

Page Name: 
<input name="PageTitle" type="text" value="New Page" size="60" maxlength="55">(55 characters max)

<cfoutput><textarea name="NewPage" id="NewPage" style="width: 100%;" rows="300">#NewPage#</textarea></cfoutput>

<input type="Hidden" Value="addpage" Name="Action">
<center><input type="Submit" value="Save" Name="Submit"></center>
</form>

<cfoutput>
<script type="text/javascript">


	CKEDITOR.replace( 'NewPage',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'				
	});

</script>
</cfoutput>