<cfinclude template='../queries/qrycustomers.cfm'>

<cfparam name = "BlankAccountsList" default="">

<CFIF #qryCustomers.recordcount# IS 0>
  <h2 align="center">There are no Customers in your database.</h2>
</CFIF>
<CFIF NOT #qryCustomers.recordcount# IS 0>
    <table width="100%" border="0" cellpadding="4" cellspacing="2">
      <tr bgcolor="#CCCCCC"> 
        <td width="12%" align="left"><b> <font size="1">Name</font></b></td>
        <td width="18%" align="left"><b> <font size="1">Address</font></b></td>
        <td width="11%" align="left"><b> <font size="1">City</font></b> </td>
        <td width="7%" align="left"><b><font size="1">State</font></b></td>
        <td width="8%" align="left"><b> <font size="1">Zip</font></b></td>
        <td width="12%" align="left"> <b> <font size="1">Country</font></b></td>
        <td width="16%" align="left"><strong><font size="1">Email</font></strong></td>
        <td width="16%" align="left"><font size="1"><strong>Phone</strong></font></td>
      </tr>
	  <cfset BlankAccountsList = "">
      <cfoutput query ="qryCustomers">
          <tr> 
            <td width="12%" height="25"><a href="doorders.cfm?action=EditCustomer&CustomerID=#CustomerID#"> 
              <font size="1"><cfif NOT #LastName# IS '' AND NOT #FirstName# IS ''>#LastName# #FirstName#<cfelse>EDIT BLANK ACCT<cfset BlankAccountsList = BlankAccountsList & "^#CustomerID#"></cfif></font></a></td>
            <td width="18%"><a href="doorders.cfm?action=EditCustomer&CustomerID=#CustomerID#"><font size="1">#Address#</font></a></td>
            <td width="11%"><font size="1">#City#</font></td>
            <td width="7%"><font size="1">#State#</font></td>
            <td width="8%"><font size="1">#Zipcode#</font></td>
			<td width="12%"><font size="1">#Country#</font></td>
            <td width="16%"><a href="mailto:#EmailAddress#"><font size="1">#EmailAddress#</font></a></td>
            <td width="16%"><font size="1">#PhoneNumber#</font></td>
          </tr>
        </cfoutput> 
    </table>
    <p align="center">&nbsp;</p>
</cfif>
<cfif NOT ListLen(BlankAccountsList, "^") IS 0>
<cfoutput>
<form name="form1" method="post" action="doorders.cfm">
  <input type="hidden" name="BlankAccountsList" value="#BlankAccountsList#">
  <input type="hidden" name="action" value="RemoveBlankAccounts">
  <input type="submit" name="Submit" value="Remove Blank Accounts">
</form>
</cfoutput>
</cfif>



















