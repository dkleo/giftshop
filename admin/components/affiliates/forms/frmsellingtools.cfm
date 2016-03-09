<!---If the file doesn't exist then create a new blank file--->
<h2>Selling Tools Page</h2>
<cfif NOT fileexists('#request.CatalogPath#affiliates#request.bslash#pages#request.bslash#sellingtools.cfm')>
	<cffile action = "write" file = "#request.CatalogPath#affiliates#request.bslash#pages#request.bslash#sellingtools.cfm" output=" ">
</cfif>

<cffile action = "read"
file = "#request.CatalogPath#affiliates#request.bslash#pages#request.bslash#sellingtools.cfm" 
variable = "PageContent">

<cfoutput>
<form id="theForm" method="post" action="index.cfm?action=updatesellingtools">
<textarea name="EditPage" id="EditPage" style="width: 100%;" rows="300">#PageContent#</textarea>
<input type="Hidden" Value="UpdatePage" Name="Action">
<center><input type="Submit" value="Save" Name="Submit"></center>
</form>
</cfoutput>
 
<script type="text/javascript">
	CKEDITOR.replace( 'EditPage',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '/admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '/admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '/admin/filebrowser/browseflash.cfm',
		enterMode : CKEDITOR.ENTER_DIV	
	});
</script>
