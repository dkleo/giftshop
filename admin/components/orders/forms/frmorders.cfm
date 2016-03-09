<script>
function printme(ordernumber)
{
	var a = window.open('','','width=640,height=480,scrollbars=1');
	var elname = 'print_'+ordernumber;
	a.document.open("text/html");
	a.document.write(document.getElementById(elname).innerHTML);
	a.document.close();
	a.print();
}

function viewme(ordernumber)
{
	var a = window.open('','','width=640,height=480,scrollbars=1');
	var elname = 'print_'+ordernumber;
	a.document.open("text/html");
	a.document.write(document.getElementById(elname).innerHTML);
	a.document.close();
}


</script>

<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 9px;
}
-->
</style>
<h2>Orders</h2>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function checkAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}

function uncheckAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}
//  End -->
</script>

<script>
	function ExpandOrder(Entity) {
		DTT_TableID = Entity;
		DTT_ImageID = "IMG" + Entity;
		DTT_Image = document.getElementById(DTT_ImageID);
		DTT_Table = document.getElementById(DTT_TableID);
		if(DTT_Table.style.display == "none") {
			DTT_Table.style.display = "block";
			DTT_Image.src = 'icons/collapse.gif';
		}
		else {
			DTT_Table.style.display = "none";
			DTT_Image.src = 'icons/expand.gif';
		}
	}
</script>	

<script>
	function CheckField(fieldname) {
	if(fieldname.value == '') {
 	 alert('Field Cannot be blank!');
	 fieldname.value = "0";	
	}
	}
</script>

<STYLE>
<!--
  .selecttr { background-color: #FFFFFF; cursor: pointer;}
  .initial { background-color: #000000; color:#000000; cursor: pointer; }
  .normal { background-color: #FFFFFF; cursor: pointer; }
  .highlight { background-color: #CCCCCC; cursor: pointer; }
  .delcheckbox {cursor: None;} 
//-->
</style>

<script language=javascript runat=server> 
 
    function PadDigits(n, totalDigits) 
    { 
        n = n.toString(); 
        var pd = ''; 
        if (totalDigits > n.length) 
        { 
            for (i=0; i < (totalDigits-n.length); i++) 
            { 
                pd += '0'; 
            } 
        } 
        return pd + n.toString(); 
    } 
 
</script>

<script language="JavaScript">
 function EditOrder(orderid, custid){
	 	thisorderid = orderid;
		window.location.href = 'doorders.cfm?action=vieworder&OrderNumber=' + thisorderid + '&CustomerID=' + custid;
 }
</script>

<cfparam name = "SortOrder" default="DESC">
<cfparam name = "SortBy" default="DateofOrder">
<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">

<cfif SortOrder IS 'DESC'><cfset OppSortOrder = 'ASC'></cfif>
<cfif SortOrder IS 'ASC'><cfset OppSortOrder = 'DESC'></cfif>

<cfinclude template='../queries/qryorders.cfm'>

<cfif isdefined('url.ordersupdated')>
<font color="#FF0000"><strong>Orders were updated!</strong></font>
</cfif>

<cfoutput>
<form method = "post" action="doorders.cfm?SortOrder=#lcase(sortorder)#&sortby=#sortby#">
View Orders Marked as <select name="paid">
<option <cfif #paid# IS 'Yes'>selected="selected"</cfif> value="Yes">Paid</option>
<option <cfif #paid# IS 'No'>selected="selected"</cfif> value="No">Unpaid</option>
</select>
<!---pages---->
<select name="start" OnChange="this.form.submit();">
<cfset PageCount = 1>
<cfloop Index="Pages" FROM="1" TO="#qryOrders.RecordCount#" Step="#disp#">
<a href = "doproducts.cfm?start=#Pages#">
  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
  #PageCount#</option></a>
  <cfset PageCount = PageCount + 1>
</cfloop>
</select>
<!---number to display--->
<select name = "disp" onchange="this.form.submit();">
    <option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
    <option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
    <option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
    <option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
    <option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
    <option value="100" <cfif disp IS '9999999'>SELECTED</cfif>>Display All</option>
</select> 
<input type="submit" name="viewbtn" value="View" />
</form>
</cfoutput>
<form <cfoutput>action="doorders.cfm?paid=#paid#&SortOrder=#lcase(sortorder)#&sortby=#sortby#"</cfoutput> method="POST" name="myform">
    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
	  <tr bgcolor="#CCCCCC">
        <td width="3%" align="left" bgcolor="#000000">&nbsp;</td> 
        <td width="3%" align="left" bgcolor="#000000"><p align="center"><b> 
            <input type="checkbox" name="ArchiveAll" value="Check All" onclick="if (this.checked){checkAll(document.myform.OrderCompleted)} else if(!this.checked){uncheckAll(document.myform.OrderCompleted)};">
        </b></p></td>
        <td width="10%" align="left" bgcolor="#000000"><b> <cfoutput><a href="doorders.cfm?action=vieworders&sortby=DateOfOrder&SortOrder=#OppSortOrder#&paid=#paid#"></cfoutput><font color="#FFFFFF"><b> 
		<cfif sortby IS 'DateOfOrder'><cfoutput><img src="images/i.p.sort.#lcase(sortorder)#.gif" border="0" /></cfoutput></cfif>
		Date (mm/dd/yy)</a></b></font></td>
        <td align="left" bgcolor="#000000"><b> <font color="#FFFFFF">Name</font></b></td>
        <td width="11%" align="left" bgcolor="#000000"><cfoutput><a href="doorders.cfm?action=vieworders&sortby=OrderNumber&SortOrder=#OppSortOrder#&paid=#paid#"></cfoutput><cfif sortby IS 'OrderNumber'><cfoutput><img src="images/i.p.sort.#lcase(sortorder)#.gif" border="0" /></cfoutput></cfif><font color="#FFFFFF"><b>OrderID</a></b></font></td>
        <td width="9%" align="left" bgcolor="#000000"> <cfoutput><a href="doorders.cfm?action=vieworders&sortby=OrderTotal&SortOrder=#OppSortOrder#&paid=#paid#"></cfoutput><cfif sortby IS 'OrderTotal'><cfoutput><img src="images/i.p.sort.#lcase(sortorder)#.gif" border="0" /></cfoutput></cfif> 
          <font color="#FFFFFF"><b>Total</a></b></font></td>
        <td width="5%" align="left" bgcolor="#000000"><cfoutput><a href="doorders.cfm?action=vieworders&sortby=OrderStatus&SortOrder=#OppSortOrder#&paid=#paid#"></cfoutput><cfif sortby IS 'OrderStatus'><cfoutput><img src="images/i.p.sort.#lcase(sortorder)#.gif" border="0" /></cfoutput></cfif>
          <font color="#FFFFFF"><b>Status</b></font></a></strong></td>
        <td width="5%" align="left" bgcolor="#000000"><div align="center"><font color="#FFFFFF"><b>Payment<br />
          Method</span></div></td>
        <td width="5%" align="left" bgcolor="#000000"><div align="center"><font color="#FFFFFF"><b>Payment<br />
        Received?</b></font></div></td>
        <td width="5%" align="left" bgcolor="#000000"><div align="center"><font color="#FFFFFF"><b>Pymnt</b></font><br />
        Status</div></td>
        <td width="15%" align="left" bgcolor="#000000"><div align="center"></div></td>
      </tr>
	  <cfset myrowcount = 0>
 
 		  <!---Set up variables for paginating--->
		  <CFSET end=Start + disp>
		  <CFIF Start + disp GREATER THAN qryorders.RecordCount>
			<CFSET end=qryorders.RecordCount>
			<CFELSE>
			<CFSET end=start + disp - 1>
		  </CFIF>
 
      <cfloop query ="qryOrders" startrow="#start#" endrow="#end#">
	   <!---***DisplayOrder***--->
        <!---Find the customer that ordered this--->
        <cfquery name = "qryCustomers" Datasource = "#Request.dsn#">
        SELECT * FROM customerhistory 
		WHERE CustomerID = #qryOrders.CustomerID#
        </cfquery>

		<cfquery name = "qryOrderedItems" datasource="#request.dsn#">
        SELECT * FROM orders_items
        WHERE ordernumber = '#qryOrders.OrderNumber#'
        </cfquery>
        
        <cfquery name = "qProc" datasource="#request.dsn#">
        SELECT orders_icon, p_adminname FROM cfsk_processors
        WHERE p_name = '#paymentmethod#'
        </cfquery>
        
          <cfset CustName = 'DELETED'>
          <cfset CustCity = 'DELETED'>
          <cfset CustState = 'DELETED'>
          <cfset CustPhone = 'DELETED'>
          <cfset CustEmail = 'DELETED'>
          
        <cfoutput query = "qryCustomers"> 
		  <cfif len(businessname) GT 0>
		  	<cfset CustName = '#trim(BusinessName)# (#trim(FirstName)# #trim(LastName)#)'>
		  <cfelse>
		    <cfset CustName = '#trim(LastName)#, #trim(FirstName)#'>
		  </cfif>
          <cfset CustCity = '#trim(City)#'>
          <cfset CustState = '#trim(State)#'>
          <cfset CustPhone = '#trim(PhoneNumber)#'>
          <cfset CustEmail = '#trim(EmailAddress)#'>
        </cfoutput>
        
        <!---Check email value to see if empty to prevent error on update--->
        <cfif len(CustEmail) IS 0>
        	<cfset CustEmail = 'NONE'>
        </cfif>
        
		 <cfoutput>
		  <cfset myrowcount=myrowcount + 1> 
          <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
            <cfset trname = replace(ordernumber, "-", "", "ALL")>
			<td align="center" onclick="javascript: ExpandOrder('#trname#');">
			<img src="icons/expand.gif" width="9" height="9" name="IMG#trname#" id="IMG#trname#" /></td> 
            <td><p align="center">  
                <input type="checkbox" name="OrderCompleted" value="#OrderID#">
                <input type="Hidden" Name="OrderID" Value="#OrderID#">
				<input type="Hidden" Name="trnames" Value="#trname#" />
                <input type = "hidden" Name="OrderNumber" Value="#OrderNumber#">
                <input type = "hidden" Name="OldOrderStatus" Value="#OrderStatus#">
                <input type = "hidden" Name="CustEmail" Value="'#CustEmail#'">
                <input type = "hidden" Name="pnref" Value="#pnref#">
                <cfif len(transactiontype) GT 0>
                	<input type = "hidden" Name="TransType" Value="#transactiontype#">
                <cfelse>
	                <input type = "hidden" Name="TransType" Value="NA">
				</cfif>
             </p></td>
            <td onclick="EditOrder('#ordernumber#', '#CustomerID#');">#dateformat(DateOfOrder, "mm/dd/yy")# #timeformat(DateOfOrder, "hh:mm tt")#</td>
            <td onclick="EditOrder('#ordernumber#', '#CustomerID#');"><a href="doorders.cfm?action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#"> 
               
              <cfif NOT ISDEFINED('CustName')>
                DELETED 
                <cfelse>
                #CustName# 
              </cfif>
            </a></td>
            <td onclick="EditOrder('#ordernumber#', '#CustomerID#');"><a href="doorders.cfm?action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#"> 
              #OrderNumber# <cfif len(pnref) GT 0><br />#pnref#</cfif></a></td>
            <td> 
              <cfif request.EnableEuro IS 'Yes'>
                #lseurocurrencyformat(OrderTotal, "Local")# 
                <cfelse>
                #lscurrencyformat(OrderTotal, "Local")# 
              </cfif>
            </td>
            <td><a href="doorders.cfm?action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#"> 
              </a> <select name="OrderStatus">
                <option <cfif #OrderStatus# IS 'Received'>SELECTED</cfif>>Received</option>
                <option <cfif #OrderStatus# IS 'Updated'>SELECTED</cfif>>Updated</option>
                <option <cfif #OrderStatus# IS 'In Process'>SELECTED</cfif>>In 
                Process</option>
                <option <cfif #OrderStatus# IS 'Completed'>SELECTED</cfif>>Completed</option>
                <option <cfif #OrderStatus# IS 'On Hold'>SELECTED</cfif>>On 
                Hold</option>
                <option <cfif #OrderStatus# IS 'Cancelled'>SELECTED</cfif>>Cancelled</option>
                <option <cfif #OrderStatus# IS 'Other - See Notes'>SELECTED</cfif>>Other</option>
            </select></td>
            <td><div align="center">
            	<img src="../../icons/#qProc.orders_icon#" alt="#qProc.p_adminname#" title="Credit Card"/>			
			</div></td>
            <td><div align="center">
              <label>
              <select name="ispaid">
			  	<option class = "PaidSelectNo" value = "No" <cfif paid is 'No'>SELECTED</cfif>>NO </option>
				<option class = "PaidSelectYes" value = "Yes" <cfif paid is 'Yes'>SELECTED</cfif>>YES <cfif len(transactiontype) GT 0> (#transactiontype#)</cfif></option>
              </select>
              </label>
            </div></td>
            <td>
            <select name = "paymentstatus">
            	<option value="None" <cfif len(paymentstatus) IS 0>SELECTED</cfif>>None</option>
                <option value="Canceled_Reversal" <cfif paymentstatus IS 'Canceled_Reversal'>SELECTED</cfif>>Cancelled</option>
                <option value="Completed" <cfif paymentstatus IS 'Completed'>SELECTED</cfif>>Completed</option>
                <option value="Pending" <cfif paymentstatus IS 'Pending'>SELECTED</cfif>>Pending</option>
                <option value="Failed" <cfif paymentstatus IS 'Failed'>SELECTED</cfif>>Failed</option>
                <option value="Denied" <cfif paymentstatus IS 'Dendied'>SELECTED</cfif>>Denied</option>
                <option value="Refunded" <cfif paymentstatus IS 'Refunded'>SELECTED</cfif>>Refunded</option>
                <option value="Reversed" <cfif paymentstatus IS 'Reversed'>SELECTED</cfif>>Reversed</option>
			</select>
            </td>
            <td><div align="right">
            <!---display option to print fedex label if shippped by fedex--->
			<cfset displayfedexlink = 'No'>
			<cfloop from = "1" to = "#listlen(crtItemID, '^')#" index="mycount">
				<cfset oShipped = listgetat(crtShipped, mycount, "^")>
				<cfif oshipped IS 'Fedex'>
					<cfset displayfedexlink = 'Yes'>
				</cfif>
			</cfloop>
			
			<cfif displayfedexlink IS 'Yes'>
				<cfoutput><a href = "doorders.cfm?action=PrintFedexLabel&OrderID=#orderid#&ordernumber=#ordernumber#"><img src = "icons/fedex_logo.gif" border="0" alt="Print a Fedex Shipping Label for this order" title="Print a Fedex Shipping Label for this order" /></a></cfoutput>
			</cfif>	
			<img src="icons/print_16.gif" width="16" height="16" onClick="printme('#OrderNumber#');" style="cursor:pointer;" title="Print This Order" alt="Print This Order"/>&nbsp;
			<img src="icons/vieworder.gif" onClick="viewme('#OrderNumber#');" style="cursor:pointer;" title="View This Order" alt="View This Order">
			<a href="doorders.cfm?action=BadOrder&CustomerID=#CustomerID#&OrderNumber=#OrderNumber#">
				<img src="icons/deleteorder.gif" border="0" alt="Quick Delete Order" title="Quick Delete Order"></a>                
                </div></td>
          </tr>
        </cfoutput>
		  <!---****ORDER INFORMATION SPAN****--->
		  <!---create the order information span that will be shown only if they expand it--->
		  
		  <tr>
		  <td colspan="11" align="left" style="padding-left:50px;">
		  <span style="display:none;" <cfoutput>name="#trname#" id="#trname#"</cfoutput>>
		  	<table width="100%" cellpadding="6" cellspacing="0" style="border: #000000 1px solid;">
			<tr>
			<td bgcolor="#000000" width = "60%" align="left">
				<b><font color="#FFFFFF">Item</b>			</td>
			<td bgcolor="#000000" width = "10%" align="center">
				<b><font color="#FFFFFF">Quantity</b>			</td>
			<td bgcolor="#000000" width = "10%" align="center">
				<b><font color="#FFFFFF">Status</b>			</td>
			<td bgcolor="#000000" width = "10%" align="center">
				<b><font color="#FFFFFF">Tracking</b>			</td>
			<td bgcolor="#000000" width = "10%" align="center">
				<b><font color="#FFFFFF">PackageID</b>			</td>	
			</tr>
			
			
			<cfloop query = "qryOrderedItems">
			<cfset oItemID = itemid>
			<cfset oProductID = itemsku>
			<cfset oProductName = itemname>
			<cfset oQuantity = quantity>
			<cfset oShipped = item_status>
			<cfset oTracking = item_tracking>				
			<cfset oPackage = item_package>
			<cfoutput>
            <tr>
			<td width = "60%" bgcolor="##CCCCCC" align="left">
				#oProductName# (SKU: #oProductID#)</td>
			<td width = "10%" bgcolor="##CCCCCC" align="center">
				#oQuantity#			</td>
			<td width = "10%" bgcolor="##CCCCCC" align="center">
				<input type = "hidden" name="oldshipped_#trname#" value = "oShipped" />
				<select name = "shipped_#trname#">
				<option <cfif oShipped IS 'Pending' OR oShipped IS 'No'>SELECTED</cfif>>Pending</option>
				<option <cfif oShipped IS 'Processing'>SELECTED</cfif>>Processing</option>
				<option <cfif oShipped IS 'Waiting'>SELECTED</cfif>>Waiting</option>
				<option <cfif oShipped IS 'Shipment Pending'>SELECTED</cfif>>Shipment Pending</option>
				<option <cfif oShipped IS 'Shipped'>SELECTED</cfif>>Shipped</option>
				<option <cfif oShipped IS 'Partial'>SELECTED</cfif>>Partial</option>																
				<option <cfif oShipped IS 'Backordered'>SELECTED</cfif>>Backordered</option>																
				<option <cfif oShipped IS 'Cancelled'>SELECTED</cfif>>Cancelled</option>																
				<option <cfif oShipped IS 'Returned'>SELECTED</cfif>>Returned</option>																
				<option <cfif oShipped IS 'Discontinued'>SELECTED</cfif>>Discontinued</option>																								
				<option value="UPS" <cfif oShipped IS 'UPS'>SELECTED</cfif>> Shipped UPS</option>
				<option value="USPS" <cfif oShipped IS 'USPS'>SELECTED</cfif>>Shipped USPS</option>
				<option value="Fedex" <cfif oShipped IS 'Fedex'>SELECTED</cfif>>Shipped Fedex</option>
				<option value="DHL" <cfif oShipped IS 'DHL'>SELECTED</cfif>>Shipped DHL</option>
				<option value="SpeeDee" <cfif oShipped IS 'SpeeDee'>SELECTED</cfif>>Shipped Spee-Dee</option>
				</select>
				<cfif oShipped IS 'Fedex'>
					<cfif fileexists(expandpath('.#request.bslash#labels#request.bslash##oTracking#.png'))>
						<a href = "#request.adminpath#components/orders/labels/#oTracking#.png" target="_blank">View label</a>
					</cfif>
				</cfif>			</td>
			<td width = "10%" bgcolor="##CCCCCC" align="center">
				<input type = "text" name="trackingnumber_#trname#" value="#oTracking#" size="15" onchange="javascript: CheckField(this)" />			</td>
			<td width = "10%" bgcolor="##CCCCCC" align="center">
				<input type = "text" name="package_#trname#" value="#oPackage#" size="6" onchange="javascript: CheckField(this)" />			</td>	
			</tr>
			<input type = "hidden" name = "itemid_#trname#" value="#oItemid#" />
			<input type = "hidden" name = "quantity_#trname#" value="#oQuantity#" />
			</cfoutput>
			</cfloop>
			<tr>
			<td colspan = "5" bgcolor="#CCCCCC" align="left">
			Notes:<br />
			<cfoutput><textarea cols="75" rows="5" name="notes_#trname#">#notes#</textarea></cfoutput>			</td>
			</tr>
			<tr>
			<td colspan = "5" bgcolor="#CCCCCC" align="left">
			<cfoutput>
			<cfif NOT ShippingMethod IS '' AND NOT ShippingMethod IS 'N/A'>
				<b>Ship Order by</b> #ShippingMethod#<br />
			</cfif>
			<b>Quoted Shipping Cost:</b> #dollarformat(QuotedShipping)#
			<p>
			REFERRED BY: <cfif NOT qryOrders.affiliateid IS ''><a href = "#request.adminpath#/components/affiliates/index.cfm?action=transactions&affiliateid=#qryOrders.affiliateid#">#qryOrders.affiliateid#</a><cfelse>None.</cfif><br />
            <cfif len(payment_pending_reason) GT 0>Pending Reason: #payment_pending_reason#</cfif>
            <cfif len(transid) GT 0>Transaction ID: #transid#<br /></cfif>
            <cfif len(accesscode) GT 0>Certificate/Access Code Used: #accesscode#</cfif>
			</cfoutput>			</td>
			</tr>
		  </table>
		  </span>		  </td>  
		  </tr>
		  <!---***End Order Information span***---> 
		  <!---***Begin HIDDEN Print Display***--->
		  <tr>
		  <td colspan="11" align="left" style="height:1px;">
		  <span style="display:none;" name="PrintRow" id="PrintRow">
				<cfinclude template = "dspprintorder.cfm">
		  </span>		  </td>
		  </tr>

		<cfif myrowcount IS 2><cfset myrowcount=0></cfif>
      </cfloop>
    </table>
<cfif qryOrders.recordcount GT 0>
<select name = "action">
	<option>Update Orders</option>
    <option>Archive Selected</option>
</select><input type="submit" value="Update" name="actionbtn">
<cfelse>
<em><strong>There are currently no orders to display.</strong></em>
</cfif>
</form>




















