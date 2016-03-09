<cfinclude template="../queries/qryhomepage.cfm">

<form method="POST" action="dohomepageeditor.cfm">
<cfoutput>
<table border="0" cellspacing="0"  width="100%" id="AutoNumber1">
<tr>
<td width="100%">
<textarea name="Homepage" id="Homepage" style="width: 100%;" rows="300">#homepage#</textarea>

<input type = "Hidden" Value = "Update" Name="Action">
<p align="center"><input type="submit" value="Update Home Page" name="S1"></td>
</tr>
</table>
</cfoutput>
</form>

<cfoutput>
<script type="text/javascript">


	CKEDITOR.replace( 'Homepage',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'				
	});

</script>
</cfoutput>