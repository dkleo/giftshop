<form name="myform" id="myform" method="post" <cfoutput>action="index.cfm?action=blog.edit.approvereplies&mytoken=#mytoken#&blog_id=#url.blog_id#&isplugin=yes&m=#url.m#&y=#url.y#"</cfoutput>>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function checkAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}

function uncheckAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}

function checkOne(field, i)
{
if (field[i].checked == true) {
field[i].checked = false ;
}
else {
field[i].checked = true;
}
}

function Confirm()
{
var agree=confirm("Any unchecked replies will be disapproved and DELETED!  Are you sure you want to continue?");
if (agree)
	document.myform.submit();
else
	return false;
}

-->
</SCRIPT>

<cfparam name = "blog_id" default="0">

<cfinclude template = "../queries/qry_unapprovedreplies.cfm">

<p><b><font size="4">Replies that need  approved</font></b></p>
<p>
Place a checkmark next to each reply you want to approve.  If you do not place a checkmark in the box
next to a reply it will be disapproved and will be deleted.
<br>
<input type="button" name="CheckAllBtn" value="Check All" onclick = "checkAll(document.myform.ApproveList)" />
      <input type="button" name="CheckNoneBtn" value="Uncheck All" onclick = "uncheckAll(document.myform.ApproveList)" />
<input type = "button" name="mybutton" value = "Approve/Disapprove" onclick="javascript: Confirm(); return false"> 
[<cfoutput><a href ="index.cfm?action=blog.edit.default&m=#url.m#&y=#url.y#&mytoken=#mytoken#&isplugin=yes">Go back</a></cfoutput>]</p>
<table width="100%" border="1" cellspacing="0" cellpadding="4">
 <cfloop query = "qry_UAreplies">
 <cfoutput>
  <tr>
		<td align="left">#reply_contents#</td>
		<td align="center" width="5%"><input type="checkbox" name="ApproveList" value="#reply_id#">
		<input type="hidden" name="MasterList" value="#reply_id#"></td>
  </tr>
  <tr>
	</cfoutput>
	</cfloop>
</table>
</form>



















