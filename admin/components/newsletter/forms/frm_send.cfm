<h2>Send Newsletter</h2>
<cfinclude template = "../queries/qry_groups.cfm">
<cfinclude template = "../queries/qry_published.cfm">
<font size="3">Sending out <cfoutput query = "qryPublished"><b>#subject#: #dateformat(createdon, "mm/dd/yyyy")#</b></cfoutput></font>
<p>Select to send this newsletter to all subscribers or just to a specific group (if you do not have any groups created you can only send it to all subscribers).</p>
<cfoutput>
<form id="form1" name="form1" method="post" action="index.cfm?action=newsletter.manage.SendNewsletter&nl_id=#qryPublished.id#&mytoken=#mytoken#">
</cfoutput>
  <p>
    <input name="Sendto" type="radio" value="SendToAll" checked="checked" /> 
  Send to all members.</p>
  <cfif NOT qryGroups.recordcount IS 0>
  <p>
    <input name="Sendto" type="radio" value="SendToGroup" /> 
    Send this to a specific group ---&gt; 
    <select name="groupid" id="groupid">
		<cfoutput query = "qryGroups">
			<option value="#groupid#">#groupname#</option>
		</cfoutput>
    </select>
  </cfif>
  <p>
    <input type="submit" name="Submit" value="Continue ---&gt;" />
  </p>
</form>




















