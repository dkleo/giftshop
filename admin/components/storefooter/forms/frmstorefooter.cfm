<!---Custom Store footer--->
<cfinclude template="../queries/qrystorefooter.cfm">

<p align="left">The store footer is located at the bottom of the front page of your 
  online store. Use the HTML editor below to edit this area.</p>
<center>
<cfoutput>
<form method="POST" action="dofootermanager.cfm">
<textarea name="storefooter" id="storefooter" style="width: 100%;" rows="300">#storefooter#</textarea>	
<p align="center">
  <input type="hidden" Name="Action" Value="Update">
  <input type="submit" value="Update Store footer" name="B1"></p>
</form>
</cfoutput>
</center>


<cfoutput>
<script type="text/javascript">


	CKEDITOR.replace( 'storefooter',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'				
	});

</script>
</cfoutput>










