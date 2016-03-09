<!---Gives the ability to assign members to groups--->
<STYLE>
<!--
  .selecttr { background-color: #FFFFFF;}
  .normal { background-color: #FFFFFF;}
  .highlight { background-color: #FFFFCC; cursor="default"}
//-->
</style>

<!---setup some variables for pagination--->
<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">
<cfparam name = "sortorder" default = "emailaddress">
<cfparam name = "sortby" default = "ASC">
<cfparam name = "updateid" default = "0">
<cfparam name = "viewgroup" default = "0">

<cflock scope="Session" type="Exclusive" timeout="10">
	<cfset session.disp = #disp#>
	<cfset session.viewgroup = #viewgroup#>
	<cfset session.start = start>
</cflock>


<cfif NOT viewgroup IS '0'>
	<cfinclude template = "../queries/qry_membersofgroup.cfm">
<cfelse>
	<cfinclude template = "../queries/qry_members.cfm">
</cfif>

<cfinclude template = "../queries/qry_groups.cfm">

<h2>Newsletter Subscribers</h2>	
<div style="float: left; width: 85%">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="25%">
	<form name="Displayoptions" method="POST" Action="index.cfm?action=newsletter.manage.members&mytoken=#mytoken#">
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="999999" <cfif disp IS '999999'>SELECTED</cfif>>Display All</option>
		</select>
	</form>

<!---calculations for paginating--->
  <CFSET end=Start + disp>
  <CFIF Start + disp GREATER THAN qryMembers.RecordCount>
    <CFSET end=999>
   <CFELSE>
    <CFSET end=Start + disp - 1>
  </CFIF>
		</td>
    <td><cfif disp LT qrymembers.RecordCount + 1>
	<div align="center"> <cfoutput> 
          <!---Display the page numbers--->
            <form name = "PageSelect" method="Post" Action="index.cfm?action=newsletter.manage.members&mytoken=#mytoken#">
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryMembers.RecordCount#" Step="#disp#"><a href = "doproducts.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
            </form>
        </cfoutput> </div>
	  </form>
	  </cfif>&nbsp;
			</td>
	<td with="25%">
  <form name = "GroupSelect" method="Post" Action="index.cfm?action=newsletter.manage.members&mytoken=#mytoken#">
		View Group: <select name = "viewgroup" OnChange="this.form.submit();">
		<option value = "0" <cfif viewgroup IS '0'>SELECTED</cfif>>All Members (none)</option>
		<cfoutput query = "qrygroups">
			<option value = "#groupid#" <cfif viewgroup IS #groupid#>SELECTED</cfif>>#groupname#</option>
		</cfoutput>
		</select>
	</form>
	</td>
  </tr>
</table>
<!---Add New member--->
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<form name="AddMember" method="post" <cfoutput>action="index.cfm?action=newsletter.member.AddMember&mytoken=#mytoken#"</cfoutput>>
  <tr>
    <td colspan="2"><table width="100%%" border="0" cellspacing="0" cellpadding="4" style="border: #000000 1px dotted;">
      <tr>
        <td valign="bottom"><b>Add New Member </b></td>
        <td colspan="3"><div align="right"></div></td>
        </tr>
      <tr>
        <td width="35%" bgcolor="#000000"><b><font color="#FFFFFF">Name</font></b></td>
        <td width="35%" bgcolor="#000000"><b><font color="#FFFFFF">Email Address </font></b></td>
        <td width="20%" bgcolor="#000000"><b><font color="#FFFFFF">Assign to* : </font></b></td>
        <td bgcolor="#000000">&nbsp;</td>
      </tr>
      <tr>
        <td bgcolor="#CCCCCC"><input name="name" type="text" size="35" /></td>
        <td bgcolor="#CCCCCC"><input name="emailaddress" type="text" size="35" /></td>
        <td bgcolor="#CCCCCC">
				<select name = "groups">
					<option value="0">None</option>
					<cfoutput query = "qryGroups">
						<option value = "#groupid#">#groupname#</option>
					</cfoutput>
				</select>				</td>
        <td align="center" bgcolor="#CCCCCC"><input type="submit" name="Submit3" value="Add New Member" /></td>
      </tr>
    </table></td>
  </tr>
</form>
  <tr>
    <td width="48%">
    <form name = "SearchForm" <cfoutput>action="index.cfm?action=newsletter.manage.members&mytoken=#mytoken#"</cfoutput> method="post">
	<input name="searchbox" type="text" size="25">
    <input type="submit" name="Submit" value="Search">
	</form>	</td>
    <td width="50%"><div align="right">
	<form name="myform" method="post" action="">
          <input type="button" name="Submit2" value="Delete Selected" onClick="mbrTable.submit()">
	  </form>
    </div></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="20" bgcolor="#0066CC"><strong><font color="#FFFFFF">Del</font></strong></td>
    <td width="150" bgcolor="#0066CC"><strong><font color="#FFFFFF">Name</font></strong></td>
    <td width="212" bgcolor="#0066CC"><strong><font color="#FFFFFF">Email Address </font></strong></td>
    <td width="87" bgcolor="#0066CC"><strong><font color="#FFFFFF">Member of</font></strong></td>
    <td width="87" bgcolor="#0066CC"><strong><font color="#FFFFFF">Status</font></strong></td>
  </tr>
<form name = "mbrTable" <cfoutput>action="index.cfm?action=newsletter.manage.DeleteMembers&mytoken=#mytoken#"</cfoutput> method="post">
<cfloop query = "qryMembers" startrow="#start#" endrow="#end#">
  <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
    <td><cfoutput>
      <input name="memberlist" type="checkbox" id="memberlist" value="#id#" />    </cfoutput></td>
    <td><cfoutput>#name#</cfoutput></td>
    <td><cfoutput><a href="index.cfm?action=newsletter.members.editmember&mytoken=#mytoken#&id=#id#">#emailaddress#</a> <cfif updateid IS #id#><font color="##FF0000">Updated</font></cfif></cfoutput></td>
    <td>
	<cfif listlen(groups) is 0>
		<select name="select">
			<option>Nothing</option>
    	</select>
	</cfif>
	<cfif NOT listlen(groups) is 0>
	<select name="select">
	<cfloop from = "1" to = "#listlen(groups)#" index="mycount">
	<cfset TheGroupID = ListGetAt(Groups, mycount)>
	<cfinclude template = "../queries/qry_groups.cfm">
	  <cfoutput query = "qryGroups"><option>#groupname#</option></cfoutput>
	</cfloop>
    </select>
	</cfif>    </td>
    <td><cfoutput><a href = "index.cfm?action=newsletter.manage.setstatus&mytoken=#mytoken#&id=#id#&status=#active#">#active#</a>
	</cfoutput></td>
  </tr>
</cfloop>
	<cfoutput query = "qryGroups" maxrows="1">
		<input type ="hidden" value = "#groupid#" name = "groupid" />
	</cfoutput>
</form>
</table>
<cfif qryMembers.recordcount IS 0>
	No members found!
</cfif>
<p>* Members can become part of more than one group. Use the Group Assignments feature to assign them to multiple groups. </p>
</div>
<div style="float:right; width: 15%;">
<div style="text-align:center;">
<a href="http://aweber.com/?357699" title="Email Marketing">
<img src="http://www.aweber.com/banners/email_marketing/120X600_an.gif" alt="Email Marketing $19/Month!" style="border:none;" /></a>
</div>
</div>