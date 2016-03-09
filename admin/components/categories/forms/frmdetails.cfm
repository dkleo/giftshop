<h2>Category HTML</h2>
<!---Read the contents of the file and then put it in the editor--->
</p>
<!---Read the file for this category--->

<cfif NOT directoryexists('#request.CatalogPath#docs#request.bslash#categories')>
	<cfdirectory action="create" directory="#request.CatalogPath#docs#request.bslash#categories" mode="666">
</cfif>

<cfif NOT fileexists('#request.CatalogPath#docs#request.bslash#categories#request.bslash#category_#url.categoryid#.cfm')>
	<!---if it doesn't exist then write it from the db.--->
    <cffile action = "write" file = "#request.CatalogPath#docs#request.bslash#categories#request.bslash#category_#url.categoryid#.cfm" output="" mode="666">
</cfif>

<!---read the category details if it exists--->
<cfset catdetails = ''>

<cffile action = "read"
file = "#request.CatalogPath#docs#request.bslash#categories#request.bslash#category_#url.categoryid#.cfm" 
variable = "catdetails">

<style type="text/css">
<!--
.style1 {
	font-size: 14pt;
	font-weight: bold;
}
-->
</style>
<form method="POST" action="index.cfm">
<cfoutput>
<table border="0" cellspacing="0"  width="100%" id="AutoNumber1">
<tr>
<td width="100%">
<span class="style1">Editing: #url.CategoryName#</span><br />
<center>
<input type = "hidden" name = "CategoryID" value="#url.CategoryID#" />
<textarea style="width: 100%; height: 500px;" id="details" name="details">#catdetails#</textarea>
		<input type="hidden" name="action" value="UpdateDetails">
    <input type="submit" name="Submit" value="Save" /></td>
</tr>
</table>
</cfoutput>
</form>

<cfoutput>
<script type="text/javascript">


	CKEDITOR.replace( 'details',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'				
	});

</script>
</cfoutput>