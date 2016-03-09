<cfparam name = "m" default="#dateformat(now(), 'm')#">
<cfparam name = "y" default="#dateformat(now(), 'yyyy')#">

<cfinclude template = "../queries/qry_posts.cfm">

<h2>Blog Posts</h2>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<form method="post" <cfoutput>action="index.cfm?action=blog.edit.default&mytoken=#mytoken#&isplugin=yes"</cfoutput>>
    <td><cfoutput><a href = "index.cfm?action=blog.edit.new&mytoken=#mytoken#&m=#m#&y=#y#&isplugin=yes">New Post</a></cfoutput></td>
    <td colspan="3" align="right">
		<select name="m" id="m" onchange="this.form.submit();">
					<option value="1"<cfif m eq 1> selected="selected"</cfif>>January</option>
					<option value="2"<cfif m eq 2> selected="selected"</cfif>>February</option>
					<option value="3"<cfif m eq 3> selected="selected"</cfif>>March</option>
					<option value="4"<cfif m eq 4> selected="selected"</cfif>>April</option>
					<option value="5"<cfif m eq 5> selected="selected"</cfif>>May</option>
					<option value="6"<cfif m eq 6> selected="selected"</cfif>>June</option>
					<option value="7"<cfif m eq 7> selected="selected"</cfif>>July</option>
					<option value="8"<cfif m eq 8> selected="selected"</cfif>>August</option>
					<option value="9"<cfif m eq 9> selected="selected"</cfif>>September</option>
					<option value="10"<cfif m eq 10> selected="selected"</cfif>>October</option>
					<option value="11"<cfif m eq 11> selected="selected"</cfif>>November</option>
					<option value="12"<cfif m eq 12> selected="selected"</cfif>>December</option>
    </select></td>
    <td width="10%" align="left">
		<cfquery name = "qryGetYears" datasource="#request.dsn#">
		SELECT DISTINCT blog_year FROM blog_posts
		ORDER BY blog_year ASC
		</cfquery>
		<select name="y" id="y" onchange="this.form.submit();">
		<cfoutput query = "qryGetYears">
			<option value="#blog_year#"<cfif y IS #blog_year#> selected="selected"</cfif>>#blog_year#</option>
		</cfoutput>
    </select>    </td>
  </tr>
</form>
  <tr>
    <td width="25%" bgcolor="#000099"><font color="#FFFFFF"><b>Date/Time</b></font></td>
    <td bgcolor="#000099"><font color="#FFFFFF"><b>Heading</b></font></td>
    <td width="10%" bgcolor="#000099"><b><font color="#FFFFFF">Replies</font></b></td>
    <td width="15%" bgcolor="#000099"><font color="#FFFFFF"><b>Category</b></font></td>
    <td width="10%" bgcolor="#000099"><font color="#FFFFFF"><b>Delete</b></font></td>
  </tr>
	<cfoutput query = "qry_Posts">
  <tr>
    <td>#dateformat(blog_date, "mm/dd/yyyy")# #timeformat(blog_time, "hh:mm tt")#</td>
    <td><a href="index.cfm?action=blog.edit.edit&mytoken=#mytoken#&blog_id=#blog_id#&m=#m#&y=#y#&isplugin=yes">#blog_headlines#</a></td>
    <td><cfinclude template = "../queries/qry_unapprovedreplies.cfm">
		<cfinclude template = "../queries/qry_postreplies.cfm">
		#qry_PostReplies.recordcount# <cfif qry_UAReplies.recordcount GT 0>
		<a href = "index.cfm?action=blog.edit.editreplies&blog_id=#blog_id#&mytoken=#mytoken#&m=#m#&y=#y#&isplugin=yes"><img src = "icons/warning.gif" width="16" border="0" alt="Some replies need to be approved!" title="Some replies need to be approved!" /></a></cfif></td>
    <td>&nbsp;</td>
    <td><a href="index.cfm?action=blog.edit.delete&mytoken=#mytoken#&blog_id=#blog_id#&m=#m#&y=#y#&isplugin=yes">Delete Post</a> </td>
  </tr>
	</cfoutput>
	<cfif qry_Posts.recordcount EQ 0>
	<tr>
	<td colspan = "5"><cfoutput>There were no posts in #MonthAsString(m)# of #y#</cfoutput></td>
	</tr>
	</cfif>
</table>



















