<h2>Custom Error Page</h2>

<cfif isdefined('form.errorpage')>

<cffile action = "write" file="#request.catalogpath#error.cfm" output="#form.errorpage#">
Your custom error page has been saved.  <a href = "dosetup.cfm?action=viewerrors">Back to error log</a>

<cfelse>

<cffile action="read" file="#request.catalogpath#error.cfm" variable="errorpage">
<form method="POST" action="dosetup.cfm?action=customerror">
<cfoutput>
<table border="0" cellspacing="0"  width="100%" id="AutoNumber1">
<tr>
<td width="100%">
<textarea name="errorpage" id="errorpage" style="width: 100%;" rows="100">#errorpage#</textarea>
<p align="center"><input type="submit" value="Save Custom Error Page" name="S1"></p></td>
</tr>
</table>
</cfoutput>
</form>

<cfoutput>
<script type="text/javascript">
	CKEDITOR.replace( 'errorpage',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'
	});
</script>
</cfoutput>

</cfif>