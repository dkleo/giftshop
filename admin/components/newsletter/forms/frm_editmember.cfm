<!---Edit a member--->
<cfinclude template = "../queries/qry_amember.cfm">

<h2>Editing a Member</h2>

<cfloop query = "qryMember">
<form name="EditMember" method="post" <cfoutput>action="index.cfm?action=newsletter.member.UpdateMember&mytoken=#mytoken#"</cfoutput>>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td colspan="2"><table width="100%%" border="0" cellspacing="0" cellpadding="4" style="border: #000000 1px dotted;">
      <tr>
        <td width="35%" bgcolor="#000000"><b><font color="#FFFFFF">Name</font></b></td>
        <td width="35%" bgcolor="#000000"><b><font color="#FFFFFF">Email Address </font></b></td>
        <td width="20%" bgcolor="#000000"><b><font color="#FFFFFF">Member of*: </font></b></td>
        <td bgcolor="#000000">&nbsp;</td>
      </tr>
      <tr>
        <td><cfoutput><input name="name" type="text" size="35" value="#name#" /></cfoutput></td>
        <td><cfoutput><input name="emailaddress" type="text" size="35" value="#emailaddress#" /></cfoutput></td>
        <td>
				<cfif listlen(groups) is 0>
					<select name="groups">
						<option>Nothing</option>
						</select>
				</cfif>
				<cfif NOT listlen(groups) is 0>
				<select name="groups">
				<cfloop from = "1" to = "#listlen(groups)#" index="mycount">
				<cfset TheGroupID = ListGetAt(Groups, mycount)>
				<cfinclude template = "../queries/qry_groups.cfm">
					<cfoutput query = "qryGroups"><option>#groupname#</option></cfoutput>
				</cfloop>
					</select>
				</cfif>
				</td>
    <td align="center"><input type="hidden" value="#url.id#" name="ID"><input type="submit" name="Submit3" value="Update Member Info" /></td>
	</tr>
</table>
</form>
* Groups displayed are for informational purposes.  If you want to change which group(s) this member is assigned to, change it under the group assignments.
</cfloop>




















