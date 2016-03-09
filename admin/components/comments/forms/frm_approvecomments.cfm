<form name="myform" id="myform" method="post" action="index.cfm?action=approve">
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
document.myform.submit();
}

-->
</SCRIPT>

<cfparam name = "blog_id" default="0">

<cfinclude template = "../queries/qry_unapprovedcomments.cfm">

<p><b><font size="4">Comments that need moderation </font></b></p>
<p>
Place a checkmark next to each comment you want to approve.<br>
<input type="button" name="CheckAllBtn" value="Check All" onclick = "checkAll(document.myform.ApproveList)" />
      <input type="button" name="CheckNoneBtn" value="Uncheck All" onclick = "uncheckAll(document.myform.ApproveList)" />
<input type = "button" name="mybutton" value = "Approve Checked Comments" onclick="javascript: Confirm(); return false">
</p>
<table width="100%" border="1" cellspacing="0" cellpadding="4">
 <cfloop query = "qry_UAreplies">
 <cfoutput>
  <tr>
		<td align="left">
        Name: #poster_name#<br />
        Email: #poster_email#
        <p>&nbsp;</p>
        #comment#</td>
		<td align="center" width="5%"><input type="checkbox" name="ApproveList" value="#id#">
		<input type="hidden" name="MasterList" value="#id#"></td>
  </tr>
  <tr>
	</cfoutput>
	</cfloop>
</table>
</form>



















