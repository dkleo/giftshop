<h2>Affiliates</h2>
<!---Gives the ability to assign members to groups--->
<STYLE>
<!--
  .selecttr { background-color: #FFFFFF;}
  .normal { background-color: #FFFFFF;}
  .highlight { background-color: #FFFFCC; cursor="default"}
//.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<!---setup some variables for pagination--->
<cfparam name = "start" default="1">
<cfparam name = "disp" default="50">
<cfparam name = "end" default="999">
<cfparam name = "sortby" default = "affiliateid">
<cfparam name = "sortorder" default = "ASC">
<cfparam name = "updateid" default = "0">
<cfparam name = "viewgroup" default = "All">
<cfparam name = "searchbox" default = "">

<cflock scope="Session" type="Exclusive" timeout="10">
	<cfset session.disp = #disp#>
	<cfset session.viewgroup = #viewgroup#>
	<cfset session.start = #start#>
	<cfset session.sortby = #sortby#>
	<cfset session.sortorder = #sortorder#>
	<cfset session.searchbox = #searchbox#>
</cflock>

<cfinclude template = "../queries/qryaffiliates.cfm">
<cfinclude template = "../queries/qrygroups.cfm">
	
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td colspan="3" valign="top">Click on the affiliateID to edit their informaiton. Click on their email address to launch your default email client. </td>
  </tr>
  <tr>
    <td width="25%" valign="top">
	<form name="Displayoptions" method="POST" Action="index.cfm?action=affiliates">
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="999999" <cfif disp IS '999999'>SELECTED</cfif>>Display All</option>
		</select>
		<cfoutput><input type = "hidden" name = "searchbox" value="#searchbox#">
		<input type = "hidden" name = "viewgroup" value="#viewgroup#">
		</cfoutput>
	</form>
<!---calculations for paginating--->
  <CFSET end=Start + disp>
  <CFIF Start + disp GREATER THAN qryAffiliates.RecordCount>
    <CFSET end=999>
   <CFELSE>
    <CFSET end=Start + disp - 1>
  </CFIF></td>
    <td valign="top"><cfif disp LT qryAffiliates.RecordCount + 1>
	<div align="center"> <cfoutput> 
          <!---Display the page numbers--->
            <form name = "PageSelect" method="Post" Action="index.cfm?action=affiliates">
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryAffiliates.RecordCount#" Step="#disp#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page #PageCount#</option>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
				<input type = "hidden" value = "#disp#" name="disp">
				<input type = "hidden" name = "searchbox" value="#searchbox#">
				<input type = "hidden" name = "viewgroup" value="#viewgroup#">
            </form>
        </cfoutput></div>
	  </cfif>		
    </td>
	<td width="35%" valign="top" with="25%">
    	<!---group--->
        <cfoutput>
        <form name="viewgroup" action="index.cfm?disp=#disp#&start=1&sortby=#sortby#&sortorder=#sortorder#">
        	<select name="viewgroup" id="viewgroup" OnChange="this.form.submit();">
            <option value="all">All Groups</option>
        	<cfloop query="qrygroups">
            <option value="#groupid#" <cfif viewgroup IS groupid>selected="selected"</cfif>>#groupname# (#groupid#)</option>
            </cfloop>
            </select>
        </form>
        </cfoutput>
	</td>
  </tr>
  <tr>
    <td colspan="2" valign="top">
		<form id="form1" name="form1" method="post" action="index.cfm?action=affiliates">
        Sorty By: 
      <select name="sortby" onchange="this.form.submit();">
        <option value="lastname" <cfif sortby IS 'lastname'>SELECTED</cfif>>Last Name</option>
        <option value="firstname" <cfif sortby IS 'firstname'>SELECTED</cfif>>First Name</option>
        <option value="email" <cfif sortby IS 'email'>SELECTED</cfif>>Email Address</option>
        <option value="city" <cfif sortby IS 'city'>SELECTED</cfif>>City</option>
        <option value="state" <cfif sortby IS 'state'>SELECTED</cfif>>State</option>
        <option value="sales" <cfif sortby IS 'sales'>SELECTED</cfif>>Number of Sales</option>
		<option value="affiliateid" <cfif sortby IS 'affiliateid'>SELECTED</cfif>>Affiliate ID</option>
        </select>
      <select name="sortorder" onchange="this.form.submit();">
        <option value="ASC" <cfif sortorder IS 'ASC'>SELECTED</cfif>>Ascending</option>
        <option value="DESC" <cfif sortorder IS 'DESC'>SELECTED</cfif>>Descending</option>
      </select>
			<cfoutput>
			<input type = "hidden" name = "start" value="#start#">
			<input type = "hidden" name = "display" value="#disp#">
			<input type = "hidden" name = "viewgroup" value="#viewgroup#">
			<input type = "hidden" name = "searchbox" value="#searchbox#">
			</cfoutput>
      </form>    </td>
    <td align="left" valign="top">
		<form id="form1" name="form1" method="post" action="index.cfm?action=affiliates">
		Search: <cfoutput><input name="searchbox" type="text" id="searchbox" size="20" value="#searchbox#" /></cfoutput> <input type="submit" name="Submit" value="Submit" />
		</form></td>
  </tr>
</table>
<!---Header row--->
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="0" bgcolor="#0066CC"><strong><font color="#FFFFFF">Name</font></strong></td>
    <td width="20%" bgcolor="#0066CC"><strong><font color="#FFFFFF">Email Address </font></strong></td>
    <td width="15%" align="left" bgcolor="#0066CC"><font color="#FFFFFF"><b>City</b></font></td>
    <td width="10%" align="left" bgcolor="#0066CC"><font color="#FFFFFF"><b>State</b></font></td>
    <td width="5%" bgcolor="#0066CC"><b><font color="#FFFFFF">Sales</font></b></td>
    <td width="10%" bgcolor="#0066CC"><strong><font color="#FFFFFF">Affiliate ID </font></strong></td>
    <td width="5%" bgcolor="#0066CC"><div align="center"><span class="style1">Group</span></div></td>
    <td width="15%" bgcolor="#0066CC"><div align="center" class="style1"></div></td>
  </tr>
<!---begin listing them--->
<form name = "mbrTable" <cfoutput>action="index.cfm?action=delete"</cfoutput> method="post">
<cfloop query = "qryAffiliates" startrow="#start#" endrow="#end#">
  <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
    <td nowrap="nowrap"><cfoutput>#firstname# #lastname#</cfoutput></td>
    <td nowrap="nowrap"><cfoutput><a href = "mailto: #email#">#email#</a> <cfif updateid IS #affiliateid#><font color="##FF0000">Updated</font></cfif></cfoutput></td>
    <td nowrap="nowrap"><cfoutput>#city#</cfoutput></td>
    <td nowrap="nowrap"><cfoutput>#state#</cfoutput></td>
    <td>	
	
    <cfquery name = "qSales" datasource="#request.dsn#">
    SELECT * FROM orders
    WHERE affiliateid = '#qryAffiliates.affiliateid#'
    AND paid = 'Yes'
    </cfquery>
    
	<cfoutput>#qSales.recordcount#</cfoutput>	</td>
    <td><cfoutput><a href="index.cfm?action=transactions&lastdid=affiliates&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sortorder=#sortorder#">#AffiliateID#</a></cfoutput></td>
    <td><div align="center"><cfoutput>#groupid#</cfoutput></div></td>
    <td><div align="center">
      <cfoutput>
        <div align="center">
        <a href="index.cfm?action=delete&amp;affiliateid=#affiliateid#&amp;id=#id#&disp=#disp#&start=#start#&searchbox=#searchbox#&sortby=#sortby#&sortorder=#sortorder#">Delete</a>&nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="index.cfm?action=edit&amp;affiliateid=#affiliateid#&amp;id=#id#&disp=#disp#&start=#start#&searchbox=#searchbox#&sortby=#sortby#&sortorder=#sortorder#">Settings</a>
      </div>
      </cfoutput></td>
  </tr>
</cfloop>
</form>
</table>
<cfif qryAffiliates.recordcount IS 0>
	No members found!
</cfif>











