<cfparam name = "blog_date" default="#now()#">
<cfparam name = "blog_time" default="#now()#">
<cfparam name = "blog_headlines" default="">
<cfparam name = "blog_contents" default="">
<cfparam name = "blog_category" default="None">
<cfparam name = "blog_id" default="0">
<cfparam name = "m" default="#dateformat(now(), 'm')#">
<cfparam name = "y" default="#dateformat(now(), 'y')#">
<cfparam name = "ErrorMessage" default="">

<cfinclude template = "../queries/qry_post.cfm">
<cfinclude template = "../queries/qry_categories.cfm">

<p><h2>Editing Blog Post</h2>
</p>
<cfoutput query = "qry_Post"><a href ="index.cfm?action=blog.edit.default&m=#m#&y=#y#&mytoken=#mytoken#&isplugin=yes">Go back</a>
  <form name="form1" method="post" action="index.cfm?action=blog.edit.update&m=#m#&y=#y#&mytoken=#mytoken#&isplugin=yes">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td colspan="2">#ErrorMessage#</td>
    </tr>
  <tr>
    <td width="100">Date/Time:</td>
    <td>#dateformat(blog_date, "mm/dd/yyyy")# #timeformat(blog_time, "hh:mm tt")#</td>
  </tr>
  <tr>
    <td>Category:</td>
    <td><select name="blog_cat">
			<cfloop query = "qry_Categories">
				<option value = "#blog_cat_id#" <cfif #qry_post.blog_cat# IS #blog_cat_id#>selected="selected"</cfif>>#blog_cat_name#</option>
			</cfloop>
    </select>    </td>
  </tr>
  <tr>
    <td>Headline:</td>
    <td><input type="text" name="blog_headlines" value="#blog_headlines#"></td>
  </tr>
  <tr>
    <td valign="top">Content:</td>
    <td><textarea name="blog_contents" cols="50" rows="10">#blog_contents#</textarea>		</td>
  </tr>
  <tr>
    <td><center>
		  <input type="hidden" name="blog_id" value = "#blog_id#">
    </center>    </td>
    <td><input type="submit" name="Submit" value="Update Blog Post" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
</cfoutput>

<script type="text/javascript">
	CKEDITOR.replace( 'blog_contents',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '/admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '/admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '/admin/filebrowser/browseflash.cfm'		
	});
</script>