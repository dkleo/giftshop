<cffile action="read" file="#request.catalogpath#admin#request.bslash#helpdocs#request.bslash##url.filename#" variable="HelpContents">

<cfoutput>
<cfset HTMLCode = '<a href = "##request.AdminPath##/helpdocs/#url.filename#" onclick="NewWindow(this.href' & ",'Help','375','450','yes');return false;" & '")><b><img src = "##request.AdminPath##/images/help.gif" border="0" /></b></a>'>

<form method="POST" action="admin.cfm">
    HTML Code: <br>
    <font size="1"> Copy and paste this to create a link to this help content.</font><br>
    <textarea name="htmlcode" cols="40" rows="10">#HTMLCode#</textarea>
<br>
    <textarea name="EditPage" cols="40" rows="10">#HelpContents#</textarea>

<p align="center">
  <input type="hidden" Name="filename" Value="#url.filename#">
  <input type="hidden" Name="Action" Value="Update">
  <input type="submit" value="Update Help Information" name="B1"></p>
</form>
</cfoutput>

<script type="text/javascript">
	CKEDITOR.replace( 'EditPage',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '/admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '/admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '/admin/filebrowser/browseflash.cfm'		
	});
</script>

