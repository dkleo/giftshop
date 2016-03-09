<div>
<h2>Editing a Customer</h2>
<!---First get this customer's info from the database--->
<cfquery name = "qryCustomers" datasource = "#Request.DSN#">
SELECT * FROM customerhistory
WHERE CustomerID = #URL.CustomerID#
</cfquery>

<cfquery name = "qLevels" datasource="#request.dsn#">
SELECT DISTINCT level FROM products_pricing
</cfquery>

<cfoutput query = "qryCustomers">
<form Method="Post" Action="doorders.cfm">
  <table width="90%" border="3" align="center" cellpadding="0" cellspacing="0" bordercolor="##000000" dwcopytype="CopyTableCell">
    <tr> 
      <td bordercolor="##000000"><table width="100%" border="0" cellpadding="4" cellspacing="0">
        <tr class="TableTitles"> 
              <td colspan="2"><div align="left"> 
                  <strong><em>Default Billing Information</em></strong>
                </div></td>
            </tr>
            <tr> 
              <td width="45%"><b>First Name:</b></td>
              <td width="55%"><b> 
                <input name="FirstName" type="text" id="FirstName" value="#FirstName#" size="41">
                </b></td>
            </tr>
            <tr> 
              <td><strong>Last Name:</strong></td>
              <td><b> 
                <input name="LastName" type="text" id="LastName" value="#LastName#" size="41">
                </b></td>
            </tr>
            <tr> 
              <td><strong>Business Name (If any):</strong></td>
              <td><b> 
                <input name="BusinessName" type="text" id="BusinessName" value="#BusinessName#" size="41">
                </b></td>
            </tr>
            <tr> 
              <td><b>Address:</b></td>
              <td><textarea rows="2" name="destaddress" cols="39">#Address#</textarea></td>
            </tr>
            <tr> 
              <td><b>City:</b></td>
              <td><input name="destcity" type="text" value="#City#" size="41";></td>
            </tr>
            <tr> 
              <td><b>State/Province</b></td>
              <td> <input name="destState" type="text" id="destState" value="#State#" size="10">              </td>
            </tr>
            <tr> 
              <td><strong>Country</strong></td>
              <td> <input name="destcountry" type="text" id="destcountry" value="#Country#" size="15"></td>
            </tr>
            <tr> 
              <td><b>Postal Code:</b></td>
              <td><input name="destpostal" type="text" value="#zipCode#" size="41";></td>
            </tr>
            <tr> 
              <td valign="top"><b>Phone Number</b></td>
              <td valign="top"><input name="PhoneNumber" type="text" value="#PhoneNumber#" size="41"></td>
            </tr>
            <tr>
              <td colspan="2" valign="top">&nbsp;</td>
            </tr>
            <tr> 
              <td colspan="2" valign="top" class="TableTitles"><div align="left"> 
                  <strong><em>Default Shipping Information</em></strong>
                </div></td>
            </tr>
            <tr> 
              <td><strong>First Name:</strong></td>
              <td><b> 
                <input name="ShipFirstName" type="text" id="ShipFirstName" value="#ShipFirstName#" size="41">
                </b></td>
            </tr>
            <tr> 
              <td><strong>Last Name:</strong></td>
              <td><b> 
                <input name="ShipLastName" type="text" id="ShipLastName" value="#ShipLastName#" size="41">
                </b></td>
            </tr>
            <tr> 
              <td><strong>Business Name (If any):</strong></td>
              <td><b> 
                <input name="ShipBusinessName" type="text" id="ShipBusinessName" value="#ShipBusinessName#" size="41">
                </b></td>
            </tr>
            <tr> 
              <td><b>Shipping Address:</b></td>
              <td><textarea name="ShipAddress" cols="39" rows="2" id="ShipAddress" >#shipAddress#</textarea></td>
            </tr>
            <tr> 
              <td><b>City:</b></td>
              <td><input name="ShipCity" type="text" id="ShipCity" value="#ShipCity#" size="41"></td>
            </tr>
            <tr> 
              <td><b>State/Province</b></td>
              <td><input name="ShipState" type="text" id="ShipState" value="#ShipState#" size="10"></td>
            </tr>
            <tr> 
              <td><strong>Country</strong></td>
              <td><input name="ShipCountry" type="text" id="ShipCountry" value="#ShipCountry#" size="15">              </td>
            </tr>
            <tr> 
              <td><b>Postal Code:</b></td>
              <td><input name="ShipZip" type="text" id="ShipZip2" value="#ShipZip#" size="41"></td>
            </tr>
            <tr> 
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr Class="Tabletitles"> 
              <td><strong><em>Login Information</em></strong></td>
              <td>&nbsp;</td>
            </tr>
            <tr> 
              <td><strong>Email Address</strong></td>
              <td> <input name="EmailAddress" type="text" id="EmailAddress" value="#EmailAddress#" size="35"></td>
            </tr>
            
            <tr> 
              <td><strong>Pricing Level</strong></td>
              <td><select name="pricelevel" id="pricelevel">
              <option value="0" <cfif qryCustomers.pricelevel IS '0'>selected</cfif>>0 (Default Pricing)</option>
			  <cfloop query="qLevels">
              	<option value="#qLevels.level#" <cfif qryCustomers.pricelevel IS qLevels.level>selected</cfif>>Level #qLevels.level#</option>
              </cfloop>
              </select>              </td>
            </tr>
            <tr> 
              <td colspan="2">
			  <cfset ThisCustomerID = '#CustomerID#'>
			  <input type = "hidden" Name="Action" Value="UpdateCustomer">
				<input type = "hidden" Name="CustomerID" Value="#CustomerID#">
				<center><input type = "submit" Name="Submit" Value="Update Customer Info"></center></td>
            </tr>
      </table></td>
    </tr>
  </table>

</div>
<div align="center">
<p>
<a href = "doorders.cfm?action=DeleteCustomer&CustomerID=#CustomerID#">DELETE THIS CUSTOMER</a>
  <p>Note: Deleting a customer will not clear the order for this 
    customer out of the database. It will only remove their info.. If you want 
    to remove an order, you need to click on the Delete orders Icon</p>
</p>
</div>
</cfoutput>
</form>
  <cfquery name = "qryOrders" Datasource="#Request.dsn#">
SELECT * FROM orders
WHERE CustomerID = #ThisCustomerID#
</cfquery>
<CFIF #qryOrders.recordcount# IS 0>
    <p align="center"><strong>This Customer has no orders on file!</strong></p>
  </CFIF>
  <CFIF NOT #qryOrders.recordcount# IS 0>
    <table border="0" width="100%">
      <tr class="TableTitles"> 
        <td colspan="8" align="left"><div align="center"><strong>Orders</strong></div></td>
      </tr>
      <tr bgcolor="#CCCCCC"> 
        <td width="8%" align="left"><b> Date</b></td>
        <td width="12%" align="left"><b> Name</b></td>
        <td width="11%" align="left"><b> Order Number </b> 
        </td>
        <td width="10%" align="left"><b>Phone</b></td>
        <td width="11%" align="left"><b> Email</b></td>
        <td width="9%" align="left"> <b> Order Total</b></td>
        <td width="16%" align="left"><strong>Status</strong></td>
        <td width="19%" align="left"><strong>Tracking No.</strong></td>
      </tr>
      <cfloop query ="qryOrders">
        <!---Find the customer that ordered this--->
        <cfquery name = "qryCustomers" Datasource = "#Request.dsn#">
        SELECT * FROM customerhistory WHERE CustomerID = #CustomerID# 
        </cfquery>
        <cfoutput query = "qryCustomers"> 
          <cfset CustName = '#FirstName# #LastName#'>
          <cfset CustCity = '#City#'>
          <cfset CustState = '#State#'>
          <cfset CustPhone = '#PhoneNumber#'>
          <cfset CustEmail = '#EmailAddress#'>
        </cfoutput> <cfoutput> 
          <tr> 
            <td width="8%">#dateformat(DateOfOrder, "mm/dd/yy")#</td>
            <td width="12%"><a href="doorders.cfm?action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#"> 
            #CustName#</a></td>
            <td width="11%"><a href="doorders.cfm?action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#"> 
            #OrderNumber#</a></td>
            <td width="10%">#CustPhone#</td>
            <td width="11%"><a href="mailto:#CustEmail#"> 
            #CustEmail#</a></td>
            <td width="9%"> 
              <cfif request.EnableEuro IS 'Yes'>
                #lseurocurrencyformat(OrderTotal, "Local")# 
                <cfelse>
                #lscurrencyformat(OrderTotal, "Local")# 
              </cfif>
              </td>
            <td width="16%">#OrderStatus# </td>
            <td width="19%"> #TrackingNumber#</td>
          </tr>
        </cfoutput> 
      </cfloop>
    </table>
</cfif>




















