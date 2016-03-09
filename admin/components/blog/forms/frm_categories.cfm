<cfinclude template = "../queries/qry_categories.cfm">

<h2>Categories</h2>
<table width="400" border="0" cellspacing="0" cellpadding="4">
<form name = "newform" method="post" <cfoutput>action="index.cfm?action=blog.categories.add&mytoken=#mytoken#&isplugin=yes"</cfoutput>>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"><input name="blog_cat_name" type="text" id="blog_cat_name">
    <input type="submit" name="Submit" value="Add"></td>
  </tr>
</form>
  <tr>
    <td bgcolor="#000099"><b><font color="#FFFFFF">Name</font></b></td>
    <td width="20%" align="center" bgcolor="#000099"><b><font color="#FFFFFF">Delete</font></b></td>
  </tr>
<cfoutput query = "qry_Categories">
  <form name = "editform" method="post" action="index.cfm?action=blog.categories.update&mytoken=#mytoken#&isplugin=yes">
	<tr>
    <td><input name="blog_cat_name" type="text" size="30" value = "#blog_cat_name#"> <input type="submit" name="Submit2" value="Update"><input type="hidden" name = "blog_cat_id" value = "#blog_cat_id#"></td>
    <td align="center"><a href = "index.cfm?action=blog.categories.delete&mytoken=#mytoken#&blog_cat_id=#blog_cat_id#&isplugin=yes">Delete</a></td>
  </tr>
	</form>
</cfoutput>
</table>
<script language="javascript">
	newform.blog_cat_name.focus();
</script>




















