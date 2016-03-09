<cffile action="read" file="#request.catalogpath#admin#request.bslash#helpdocs#request.bslash##url.filename#" variable="helpcontent">

<cfoutput>
<table height="100%" border="0" width="100%">
<tr>
<td height = "90%" valign="top">
#helpcontent#
</td>
<tr>
      <td heigh = "10%" valign="middle"> <a href = "admin.cfm?action=edit&amp;filename=#url.filename#"><font size="1">Edit 
        Content</font></a> | <a href = "admin.cfm?action=new"><font size="1">New 
        Content</font></a> | <a href = "admin.cfm?action=delete&amp;filename=#url.filename#"><font size="1">Remove 
        Content</font></a> | <a href="admin.cfm?action=viewindex"><font size="1">Contents</font></a></td>
</tr>
</table>
</cfoutput>








