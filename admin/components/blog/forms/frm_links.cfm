<cfinclude template = "../queries/qry_links.cfm">

<h2>Links</h2>
<table width="550" border="0" cellspacing="0" cellpadding="4">
<form name = "newform" method="post" <cfoutput>action="index.cfm?action=blog.links.add&mytoken=#mytoken#&isplugin=yes"</cfoutput>>
  
  <tr>
    <td colspan="2">Title:
      <input name="blog_link_name" type="text" id="blog_link_name">
     URL:  <input name="blog_link_url" type="text" id="blog_cat_url">
    <input type="submit" name="Submit" value="Add"></td>
  </tr>
</form>
  <tr>
    <td bgcolor="#000099"><b><font color="#FFFFFF">Name</font></b></td>
    <td width="20%" align="center" bgcolor="#000099"><b><font color="#FFFFFF">Delete</font></b></td>
  </tr>
<cfoutput query = "qry_Links">
	<tr>
    <td>#blog_Link_Name# (#blog_Link_Url#)</td>
    <td align="center"><a href = "index.cfm?action=blog.links.delete&mytoken=#mytoken#&blog_link_id=#blog_link_id#&isplugin=yes">Delete</a></td>
  </tr>
</cfoutput>
</table>
<script language="javascript">
	newform.blog_link_name.focus();
</script>





















