<cfinclude template = "../queries/qry_published.cfm">
<h2>Editing a Newsletter</h2>
<cfoutput query = "qryPublished">
 <form action = 'index.cfm?action=newsletter.manage.save&id=#id#&mytoken=#mytoken#' method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td>Date:</td>
      <td>#Dateformat(now(), "mm/dd/yyyy")#</td>
    </tr>
    <tr>
      <td width="13%"><span class="gen">Subject:</span> </td>
      <td width="87%"><label>
        <input name="Subject" type="text" size="45" value="#subject#">
      </label></td>
    </tr>
    <tr>
      <td valign="top"><span class="gen">Message Body:</span></td>
      <td><textarea style="width: 100%; height: 450px;" id="body" name="body">#body#</textarea></td>
    </tr>
    <tr>
      <td></td>
      <td><input name="Submit" type="submit" id="Submit" value="Save this Newsletter" /></td>
    </tr>
  </table>
  </form>
</cfoutput>


<cfoutput>
<script type="text/javascript">


	CKEDITOR.replace( 'body',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '/admin/filebrowser/browselinks_email.cfm',
		filebrowserImageBrowseUrl : '/admin/filebrowser/browse_email.cfm',
		filebrowserFlashBrowseUrl : '/admin/filebrowser/browseflash_email.cfm'				
	});

</script>
</cfoutput>