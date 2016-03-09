<cfparam name="subscription" default="0">
<cfparam name="searchstring" default="null">

<cfinclude template = "../queries/qrysubscriptions.cfm">
<cfinclude template = "../queries/qrycustomers.cfm">
<cfinclude template = "../queries/qrysubscribers.cfm">
<cfinclude template = "../queries/qryorders.cfm">

<h2>Subscriptions</h2>

<cfif qrySubscriptions.recordcount IS 0>
You do not have any subscriptions setup.  To use subscriptions, you must have at least one subscription item setup.
</cfif>

<table width="100%" border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td colspan="5">
    <form method="post" action="index.cfm" name="changesubscription">
      <select name="subscription" id="subscription">
        <option <cfif subscription IS '0'>SELECTED</cfif> value="0">---Select Subscription---</option>
        <cfloop query = "qrySubscriptions">
          <cfoutput>
            <option <cfif subscription IS qrySubscriptions.r_id>selected="selected"</cfif> value="#qrySubscriptions.r_id#">#r_name#</option>
          </cfoutput>
        </cfloop>
      </select> <input type="submit" name="button" id="button" value="View">
      <cfif isdefined('url.wasupdate')><font color="#FF0000"><b>Subscriptions were updated!</b></font></cfif></form></td>
      <td colspan="2">
      <cfif NOT subscription IS '0'>
      <cfoutput><div align="right"><a href="index.cfm?action=addaccounts&amp;subscription=#subscription#">Add Accounts</a></div></cfoutput>
      </cfif>
      </td>
  </tr>
  <tr>
    <td width="20%" height="33" bgcolor="#000000"><span style="color: #FFFFFF; font-weight: bold">Name</span></td>
    <td width="20%" bgcolor="#000000"><span style="font-weight: bold; color: #FFFFFF">Signed Up On</span></td>
    <td width="20%" bgcolor="#000000"><span style="font-weight: bold; color: #FFFFFF">Status</span></td>
    <td width="20%" bgcolor="#000000"><span style="font-weight: bold; color: #FFFFFF">Order Number</span></td>
    <td width="20%" bgcolor="#000000"><span style="font-weight: bold; color: #FFFFFF">Expires On</span></td>
    <td width="10%" bgcolor="#000000"><div align="center"><span style="color: #FFFFFF; font-weight: bold">Paid</span></div></td>
    <td width="20%" bgcolor="#000000"><div align="center"><span style="font-weight: bold; color: #FFFFFF">Order Status</span></div></td>
  </tr>  
<cfloop query = "qrySubscribers">

	<!---Get their info from the customerhistory table--->
    <cfquery name = "qryCustomerInfo" dbtype="query">
    SELECT * FROM qryCustomers WHERE customerid = #qrySubscribers.CustomerID#
    </cfquery>
	
    <!---Get order status and if paid--->
    <cfquery name = "qryOrder" dbtype = "query">
    SELECT paid, orderstatus FROM qryOrders
    WHERE ordernumber = '#qrySubscribers.ordernumber#'
    </cfquery>
    
  <cfoutput>  
  <form name="updateform" method="post" action="index.cfm?action=updateaccounts&subscription=#subscription#&searchstring=#searchstring#">
  <tr>
    <td>#qryCustomerInfo.firstname# #qryCustomerInfo.lastname#</td>
    <td>#dateformat(qrySubscribers.startdate, "mmm dd, yyyy")#</td>
    <td>
    <input type = "hidden" name = "ids" value="#id#" />
    <select name = "status">
    <option <cfif qrySubscribers.status IS 'pending'> SELECTED </cfif>>Pending</option>
    <option <cfif qrySubscribers.status IS 'active'> SELECTED </cfif>>Active</option>
    <option <cfif qrySubscribers.status IS 'stopped'> SELECTED </cfif>>Stopped</option>
   	<option <cfif qrySubscribers.status IS 'expired'> SELECTED </cfif>>Expired</option>
	</select>    </td>
    <td>
	<cfif NOT qrySubscribers.ordernumber IS 'None'><a href="#request.adminpath#components/orders/doorders.cfm?action=vieworder&OrderNumber=#qrySubscribers.OrderNumber#&CustomerID=#qrySubscribers.CustomerID#" target="_blank">#qrySubscribers.ordernumber#</a>
	<cfelse>
    None
	</cfif></td>
    <td>#dateformat(qrySubscribers.expiredate, "mmm dd, yyyy")#</td>
    <td><div align="center"><cfif NOT qrySubscribers.ordernumber IS 'None'>
    	#qryOrder.paid#
        <cfelse>
        N/A
        </cfif>
        </div></td>
    <td><div align="center">
    <cfif NOT qrySubscribers.ordernumber IS 'None'>
    #qryOrder.orderstatus#
    <cfelse>
    N/A
    </cfif>
    </div></td>
  </tr>
  </cfoutput>
</cfloop>
<cfif qrySubscribers.recordcount IS 0>
<tr>
	<td colspan = "7">There are no members in the currently viewed subscription item</td>
</tr>
<cfelse>
<tr>
	<td colspan = "7"><input type = "submit" value="Update Accounts" name="submitbutton" /></td>
</tr>
</cfif>
</form>
</table>
<p>&nbsp;</p>
















