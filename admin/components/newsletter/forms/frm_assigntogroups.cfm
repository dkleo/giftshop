<h2>Newsletter Group Assignments</h2>
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
<cfparam name = "assignto" default = "0">

<cfif not isdefined('session.assignto')>
	<cflock scope="Session" type="ReadOnly" timeout="10">
		<cfset session.assignto = 1>
	</cflock>
</cfif>

<cfif NOT isdefined('form.viewgroup') AND NOT isdefined('url.viewgroup')>
<cfif ISDEFINED('session.viewgroup')>
	<cflock scope="Session" type="ReadOnly" timeout="10">
		<cfset viewgroup = #session.viewgroup#>
		<cfset disp = #session.disp#>
		<cfset start = #session.start#>
		<cfset assignto = #session.assignto#>
	</cflock>
</cfif>
</cfif>

<cflock scope="Session" type="Exclusive" timeout="10">
	<cfset session.disp = #disp#>
	<cfset session.viewgroup = #viewgroup#>
	<cfset session.start = start>
	<cfset session.assignto = #assignto#>
</cflock>

<cfif NOT viewgroup IS '0'>
	<cfinclude template = "../queries/qry_membersofgroup.cfm">
<cfelse>
	<cfinclude template = "../queries/qry_members.cfm">
</cfif>

<cfinclude template = "../queries/qry_groups.cfm">
	
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
  <cfif disp LT qrymembers.RecordCount + 1>
    <td>
	<div align="center"> <cfoutput> 
          <!---Display the page numbers--->
            <form name = "PageSelect" method="Post" Action="index.cfm?action=newsletter.manage.AssignToGroups&mytoken=#mytoken#">
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryMembers.RecordCount#" Step="#disp#"><a href = "doproducts.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
							<input type = "hidden" name = "assignto" value = "#assignto#">
							<input type = "hidden" name = "viewgroup" value = "#viewgroup#">
            </form>
        </cfoutput> </div>
	  </form>
	</td>
 </cfif>
    <td>
	
	<form name="Displayoptions" method="POST" Action="index.cfm?action=newsletter.manage.AssignToGroups&mytoken=#mytoken#">
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="999999" <cfif disp IS '999999'>SELECTED</cfif>>Display All</option>
		</select>
		<cfoutput>
			<input type = "hidden" name = "assignto" value = "#assignto#">
			<input type = "hidden" name = "viewgroup" value = "#viewgroup#">
		</cfoutput>
	</form>

<!---calculations for paginating--->
  <CFSET end=Start + disp>
  <CFIF Start + disp GREATER THAN qryMembers.RecordCount>
    <CFSET end=999>
   <CFELSE>
    <CFSET end=Start + disp - 1>
  </CFIF>
	</td>
  </tr>
</table>
<!---Add New member--->
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<form name="AddMember" method="post" <cfoutput>action="index.cfm?action=newsletter.member.AddMember&mytoken=#mytoken#"</cfoutput>>
</form>
  <tr>
    <td width="50%">
    <form name = "GroupView" <cfoutput>action="index.cfm?action=newsletter.manage.AssignToGroups&mytoken=#mytoken#"</cfoutput> method="post">
		View:
		<select name="viewgroup" <cfoutput>onChange="this.form.submit();"</cfoutput>>
				<option value = "0" <cfif viewgroup IS '0'>SELECTED</cfif>>None</option>
					<cfoutput query = "qryGroups">
					<option value = "#groupid#" <cfif viewgroup IS groupid>SELECTED</cfif>>#groupname#</option>
					</cfoutput>
        </select>
				<cfoutput><input type = "hidden" name = "assignto" value = "#assignto#"></cfoutput>
    </form>	</td>
    <td width="50%"><div align="right">
	<form name="myform" method="post" <cfoutput>action="index.cfm?action=newsletter.manage.AssignToGroups&mytoken=#mytoken#"</cfoutput>>
          Assign To:
          <select name="AssignTo" <cfoutput>onChange="this.form.submit();"</cfoutput>>	
						<option value = "0" <cfif assignto IS '0'>SELECTED</cfif>>(Remove from all groups)</option>					<cfoutput query = "qryGroups">
						<option value = "#groupid#" <cfif assignto IS #groupid#>SELECTED</cfif>>#groupname#</option>
					</cfoutput>
          </select>
          <cfoutput><input type = "hidden" name = "viewgroup" value="#viewgroup#"></cfoutput>
					<input type="button" name="SubmitButton" value="Update" onClick="mbrTable.submit()">
		</form>
    </div></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="20" bgcolor="#0066CC"><strong><font color="#FFFFFF">Select</font></strong></td>
    <td width="150" bgcolor="#0066CC"><strong><font color="#FFFFFF">Name</font></strong></td>
    <td width="212" bgcolor="#0066CC"><strong><font color="#FFFFFF">Email Address </font></strong></td>
    <td width="87" bgcolor="#0066CC"><strong><font color="#FFFFFF">Member of</font></strong></td>
    <td width="87" bgcolor="#0066CC"><strong><font color="#FFFFFF">Status</font></strong></td>
  </tr>
<form name = "mbrTable" <cfoutput>action="index.cfm?action=newsletter.manage.SaveGroupMembers&mytoken=#mytoken#"</cfoutput> method="post">
<cfloop query = "qryMembers" startrow="#start#" endrow="#end#">
  <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
    <td><cfoutput>
    <cfset AlreadyAssigned = 'No'>
    <cfloop from = "1" to="#listlen(groups)#" index="gcount">
      <cfset thisgroup = listgetat(groups, gcount)>
 	      <cfif thisgroup IS #assignto#>
  	        <cfset AlreadyAssigned = 'Yes'>
        </cfif>
     </cfloop>
     <input type = "Hidden" name="RemovedItems" value="#ID#" id="RemovedItems">
		<input type = "checkbox" name="SelectedItems" value="#ID#" id="SelectedItems" <cfif alreadyassigned IS 'Yes'>checked="checked"</cfif>> 
			<!---<input name="memberlist" type="checkbox" id="memberlist" value="#id#" />--->
		</cfoutput></td>
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
	<cfoutput><input type="hidden" value = "#viewgroup#" name="viewgroup">
	<input type="hidden" value="#assignto#" name="assignto"></cfoutput>
</form>
</table>
<cfif qryMembers.recordcount IS 0>
	No members found in this group!
</cfif>
<p>Note: A member can be assigned to more than one group. </p>





















