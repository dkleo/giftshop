<cfinclude template = "../queries/qrypages.cfm">
<cfinclude template = "../queries/qrysubscriptions.cfm">  
<h2>Website Pages <cfoutput><a href = "#request.AdminPath#helpdocs/pages.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></h2>
<form method = "post" action="dopages.cfm?action=UpdatePermissions" name="updateform">
  <table width="100%" border="0" align="left" cellpadding="8" cellspacing="0" bordercolor="111111" id="AutoNumber1" style="border-collapse: collapse">
    <tr>
      <td width="37%"><a href = "dopages.cfm?action=NewPage">Create a New Page</a></td>
      <td><div align="right"><cfif isdefined('url.wasupdate')>
        <div align="center"><font color="#FF0000">Setting Saved</font></div>
      </cfif></div></td>
      <td>&nbsp;</td>
      <td><div align="right"></div></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td bgcolor="#000000"><font color="FFFFFF"><b>File Name</b></font></td>
      <td width="20%" bgcolor="#000000"><div align="center"><strong><font color="#FFFFFF">Subscriber Group</font></strong></div></td>
      <td width="15%" bgcolor="#000000"><div align="center"><font color="#FFFFFF"><strong>Password</strong></font></div></td>
      <td width="5%" bgcolor="#000000"><div align="center"></div></td>
      <td width="30%" bgcolor="#000000"><strong><font color="#FFFFFF">Alias</font></strong></td>
    </tr>
<cfset RowCount = 0>
<cfloop query = "qryPages">

<cfquery name = "qryPrivatePages" datasource="#request.dsn#">
SELECT * FROM private_pages
WHERE page_filename = '#qryPages.name#'
</cfquery>

<cfif right(name, 3) IS 'htm' OR right(name, 4) IS 'html' OR right(name, 3) IS 'cfm'>
<cfset RowCount = RowCount + 1>
    <cfoutput>
    <tr <cfif RowCount IS 2>bgcolor="E5E5E5"</cfif>>
      <td>&nbsp;&nbsp;<a href = "dopages.cfm?action=EditPage&ID=#qryPages.name#">#qryPages.name#</a></td>
      <td><div align="center">
        <input type = "hidden" name = "page_names" value="#qryPages.name#" />
        <select name="permissions" id="permissions">
          <option <cfif qryPrivatePages.recordcount IS '0'>SELECTED</cfif> value="0">Public</option>
          <cfloop query = "qrySubscriptions">
            <cfoutput>
              <option <cfif qryPrivatePages.subscription_id IS qrySubscriptions.r_id>SELECTED</cfif> value="#qrySubscriptions.r_id#">#r_name#</option>
            </cfoutput>
          </cfloop>
        </select>
      </div></td>
      <td><div align="center"><cfif qryPrivatePages.recordcount IS 0>
        <a href="dopages.cfm?action=setpassword&amp;pageid=#name#">Not Set</a>
        <cfelse><a href="dopages.cfm?action=setpassword&amp;pageid=#name#">#qryPrivatePages.pword#</a></cfif></div></td>
      <td>
	    <div align="center"><a href = "dopages.cfm?action=DeletePage&ID=#name#"><img src="icons/delete.gif" border="0" /></a> </div></td>
      <td>
        <cfset linkalias = replacenocase(qryPages.name, ".cfm", "", "ALL")>
        <cfset linkalias = replacenocase(linkalias, ".htm", "", "ALL")>
        <cfset linkalias = replacenocase(linkalias, ".html", "", "ALL")>
        <cfset linkalias = replacenocase(linkalias, " ", "-", "ALL")>

		<cfoutput><a href = "#request.homeurl##linkalias#" target="_blank">#request.homeurl##linkalias#</a></cfoutput>
      
      </td>
    </tr>
    </cfoutput>
	<cfif RowCount IS 2>
		<cfset RowCount = 0>
	</cfif>
</cfif>
</cfloop>
  <tr>
  	<td colspan = "5">
     <center><input type="submit" value="Update Permissions" name="submitbutton" /></center>
  </table>
</form>
  </center>
</div>







