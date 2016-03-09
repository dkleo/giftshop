<p align="left">The store header is located at the top of the front page of your 
  online store. Use the HTML editor below to edit this area.</p>
<cfinclude template = "../queries/qrystoreheader.cfm">

<center>
<cfoutput>
<form method="POST" action="doheadermanager.cfm">
<textarea name="storeheader" id="storeheader" style="width: 100%;" rows="300">#storeheader#</textarea>            	
<p align="center">
  <input type="hidden" Name="Action" Value="Update">
  <input type="submit" value="Update Store Header" name="B1"></p>
</form>
</cfoutput>
</center>


<cfoutput>
<script type="text/javascript">


	CKEDITOR.replace( 'storeheader',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'				
	});

</script>
</cfoutput>












