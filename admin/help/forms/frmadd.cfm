<form method="POST" action="admin.cfm">
    Title: <input name="helptitle" type="text" id="helptitle" size="30">
      <br>
    </div>
    <cfoutput>
    <textarea name="helpcontent" cols="40" rows="10"></textarea>

</cfoutput>
  <p align="center">
  <input type="hidden" Name="Action" Value="Add">
  <input type="submit" value="Add Help Information" name="B1"></p>
</form>


<script type="text/javascript">
	CKEDITOR.replace( 'helpcontent',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '/admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '/admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '/admin/filebrowser/browseflash.cfm'		
	});
</script>