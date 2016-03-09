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
	 	thisorderid = PadDigits(orderid, 14);
		window.location.href = 'doorders.cfm?&action=vieworder&OrderNumber=' + thisorderid + '&CustomerID=' + custid;
 }
</script>

<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">
<!--- Start displaying with record 1 if not specified via url --->

<!---Establish a start/end date to display in drop down etc.--->
<cfset todayDate = Now()>
<cfset StartYear = #DatePart("yyyy", todaydate)#>
<cfset EndYear = StartYear + 2>

<cfif ISDEFINED('form.reportmonth')>
<cflock scope="Session" Type="Exclusive" Timeout="10">
<cfset Session.reportmonth = form.reportmonth>
<cfset session.reportyear = form.reportyear>
</cflock>
</cfif>

<cfif ISDEFINED('session.reportmonth')>
<cflock scope="Session" Type="ReadOnly" Timeout="10">
<cfset ThisReportMonth = '#session.ReportMonth#'>
<cfset ThisReportYear = '#session.ReportYear#'>
<cfset TempVar.reportmonth = '#Session.ReportMonth#'>
<cfset TempVar.ReportYear = '#session.ReportYear#'>
</cflock>
</cfif>

<cfif NOT ISDEFINED('session.reportmonth')>
<cfset ThisReportMonth = "99">
<cfset ThisReportYear = #DatePart("yyyy", Now())#>
</cfif>

<!---For pagination--->
<cfif ISDEFINED('session.disp')>
	<cflock scope="Session" type="Exclusive" timeout="10">
		<cfset disp = '#session.disp#'>
	</cflock>
</cfif>

<cfif ISDEFINED('form.disp')>
		<cfset disp = '#form.disp#'>
</cfif>

<!---Store the start variable in a session so that the last viewed page can always be called---> 
<cfif ISDEFINED('url.start')>
<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.start= '#url.start#'>
</cflock>
</cfif>

<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.disp = '#disp#'>
</cflock>

<cfif ISDEFINED('form.start')>
<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.start= '#form.start#'>
</cflock>
</cfif>

<cfif ISDEFINED('session.start')>
<cflock scope="Session" type="ReadOnly" timeout="10">
   <cfset start = '#session.start#'>
</cflock>
</cfif>

<cfif NOT ISDEFINED('url.start') AND NOT ISDEFINED('session.start')>
<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.start= '#start#'>
</cflock>
</cfif>

<cfset thecurrentdate = now()>

<cfparam name = "SortOrder" default="DESC">
<cfparam name = "SortBy" default="DateofOrder">
<cfparam name = "paid" default="yes">
<cfparam name = "reportmonth" default="#dateformat(thecurrentdate, 'm')#">
<cfparam name = "reportyear" default="#dateformat(thecurrentdate, 'yyyy')#">

<cfif SortOrder IS 'DESC'><cfset OppSortOrder = 'ASC'></cfif>
<cfif SortOrder IS 'ASC'><cfset OppSortOrder = 'DESC'></cfif>

<!---QUERY THE DATABASE--->
<cfinclude template='../queries/qryarchives.cfm'>
<cfinclude template='../queries/qrysales.cfm'>

<cfset TotalSales = 0>

<cfif NOT qryArchives.recordcount IS 0>
<!--- Get Last Order --->
<cfoutput query="qryAllArchives">
 <cfset LastOrder = '#DateOfOrder#'>
</cfoutput>

<!--- Get The First Order--->
<cfloop query="qryAllArchives" startrow="1" endrow="1">
  <cfset FirstOrder = '#DateOfOrder#'>
</cfloop>

<!---Now find the start and end years--->
<cfoutput>
<cfif ISDEFINED('FirstOrder')>
<cfset StartYear = #DatePart("yyyy", FirstOrder)#>
<cfset EndYear = #DatePart("yyyy", LastOrder)#>
</cfif>

<cfif NOT ISDEFINED('FirstOrder')>
<cfset StartYear = #DatePart("yyyy", Now())#>
<cfset EndYear = #DatePart("yyyy", Now())#>
</cfif>

</cfoutput>
</cfif>

    <table width="100%" border="0" cellpadding="2" cellspacing="0">
      <tr>
        <td colspan="9" align="left"><h2>Archived Orders</h2></td>
      </tr>
      <tr>
        <td colspan="4" align="left">
		<form method="POST" action="doorders.cfm">
  <p align="left"><select size="1" name="ReportMonth">
  <option Value='99' <cfif ThisReportMonth IS '99'>SELECTED</cfif>>All Months</option>
  <option Value='1' <cfif ThisReportMonth IS '1'>SELECTED</cfif>>January</option>
  <option Value='2' <cfif ThisReportMonth IS '2'>SELECTED</cfif>>February</option>
  <option Value='3' <cfif ThisReportMonth IS '3'>SELECTED</cfif>>March</option>
  <option Value='4' <cfif ThisReportMonth IS '4'>SELECTED</cfif>>April</option>
  <option Value='5' <cfif ThisReportMonth IS '5'>SELECTED</cfif>>May</option>
  <option Value='6' <cfif ThisReportMonth IS '6'>SELECTED</cfif>>June</option>
  <option Value='7' <cfif ThisReportMonth IS '7'>SELECTED</cfif>>July</option>
  <option Value='8' <cfif ThisReportMonth IS '8'>SELECTED</cfif>>August</option>
  <option Value='9' <cfif ThisReportMonth IS '9'>SELECTED</cfif>>September</option>
  <option Value='10' <cfif ThisReportMonth IS '10'>SELECTED</cfif>>October</option>
  <option Value='11' <cfif ThisReportMonth IS '11'>SELECTED</cfif>>November</option>
  <option Value='12' <cfif ThisReportMonth IS '12'>SELECTED</cfif>>December</option>
  </select> 
  <select name="ReportYear">
  <cfoutput>
  <cfloop Index="ThisYear" From="#StartYear#" To="#EndYear#">
  <option <cfif #ThisYear# IS #ThisReportYear#>SELECTED</cfif>>#ThisYear#</option>
  </cfloop>
  </cfoutput>
  </select>
  <select name = "paid">
  	<option value="yes" <cfif paid IS 'yes'>SELECTED</cfif>>Marked As Paid</option>
    <option value="no" <cfif paid IS 'no'>SELECTED</cfif>>Marked As Unpaid</option>
  </select>
  <input type="hidden" value="1" name = "Start" />
  <input type="hidden" value="ViewArchives" name="Action">
  <input type="submit" value="List Orders" name="B1">
  </Form></p>		</td>
        <td align="left">&nbsp;</td>
        <td align="left">
		<cfoutput> 
          <!---Display the page numbers--->
          <cfif disp LT qryArchives.RecordCount + 1>         
			<form name = "PageSelect" method="Post" action="doorders.cfm?action=viewarchives&paid=#paid#&reportmonth=#reportmonth#&reportyear=#reportyear#">
			<p align="left">
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryArchives.RecordCount#" Step="#disp#">
				<a href = "doproducts.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
            </form></p>
          </cfif>
        </cfoutput></td>
        <td align="left">
        <cfoutput>
        <form name="Displayoptions" method="POST" Action="doorders.cfm?action=viewarchives&paid=#paid#&reportmonth=#reportmonth#&reportyear=#reportyear#">
		<p align="left">
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="100" <cfif disp IS '9999999'>SELECTED</cfif>>Display All</option>
		</select>
	</form>
    </cfoutput>
	</p>	</td>
        <td align="left">&nbsp;</td>
        <td align="left">&nbsp;</td>
      </tr>
<form action="doorders.cfm" method="POST" name="myform">    
	  <tr bgcolor="#CCCCCC">
        <td width="4%" align="left" bgcolor="#000000">&nbsp;</td> 
        <td width="4%" align="left" bgcolor="#000000"><div align="center"> <font color="#FFFFFF"><b> 
            <input type="checkbox" name="ArchiveAll" value="Check All" onclick="if (this.checked){checkAll(document.myform.OrderCompleted)} else if(!this.checked){uncheckAll(document.myform.OrderCompleted)};">
        </b></font></div></td>
        <td width="8%" align="left" bgcolor="#000000"><font color="#FFFFFF"><b> <cfoutput><a href="doorders.cfm?action=viewarchives&sortby=DateOfOrder&SortOrder=#OppSortOrder#&reportmonth=#reportmonth#&reportyear=#reportyear#&disp=#disp#&start=#start#&paid=#paid#"></cfoutput><font color="#FFFFFF"><b> 
		<cfif sortby IS 'DateOfOrder'><cfoutput><img src="images/i.p.sort.#lcase(sortorder)#.gif" border="0" /></cfoutput></cfif>
		Date</a></b></font></td>
        <td align="left" bgcolor="#000000"><b> <font color="#FFFFFF">Name</font></b></td>
        <td width="11%" align="left" bgcolor="#000000"><font color="#FFFFFF"><b><cfoutput><a href="doorders.cfm?action=viewarchives&sortby=OrderNumber&SortOrder=#OppSortOrder#&reportmonth=#reportmonth#&reportyear=#reportyear#&disp=#disp#&start=#start#&paid=#paid#"></cfoutput><font color="#FFFFFF"><b> <cfif sortby IS 'OrderNumber'><cfoutput><img src="images/i.p.sort.#lcase(sortorder)#.gif" border="0" /></cfoutput></cfif>OrderID</a></b></font> </td>
        <td width="9%" align="left" bgcolor="#000000"> <font color="#FFFFFF"><b> <cfoutput><a href="doorders.cfm?action=viewarchives&sortby=OrderTotal&SortOrder=#OppSortOrder#&reportmonth=#reportmonth#&reportyear=#reportyear#&disp=#disp#&start=#start#&paid=#paid#"></cfoutput><font color="#FFFFFF"><b> <cfif sortby IS 'OrderTotal'><cfoutput><img src="images/i.p.sort.#lcase(sortorder)#.gif" border="0" /></cfoutput></cfif> 
          Total</a></b></font></td>
        <td width="5%" align="left" bgcolor="#000000"><cfoutput><a href="doorders.cfm?action=viewarchives&sortby=OrderStatus&SortOrder=#OppSortOrder#&reportmonth=#reportmonth#&reportyear=#reportyear#&disp=#disp#&start=#start#&paid=#paid#">
          <cfif sortby IS 'OrderStatus'><img src="images/i.p.sort.#lcase(sortorder)#.gif" border="0" /></cfif>
          <font color="##FFFFFF"><b>Status</b></font></a></cfoutput></td>
        <td width="5%" align="left" bgcolor="#000000"><div align="center"><font color="#FFFFFF"><b>Payment<br />
          Method</b></font></div></td>
        <td width="5%" align="left" bgcolor="#000000"><div align="center"><font color="#FFFFFF"><strong>Payment<br />
        Received?</strong></font></div></td>
        <td width="15%" align="left" bgcolor="#000000"><div align="center"></div></td>
      </tr>
	  <cfset rowcount = 0>
	  
		  <!---Set up variables for paginating--->
		  <CFSET end=Start + disp>
		  <CFIF Start + disp GREATER THAN qryarchives.RecordCount>
			<CFSET end=qryarchives.RecordCount>
			<CFELSE>
			<CFSET end=start + disp - 1>
		  </CFIF>
	  
      <cfloop query ="qryArchives" startrow="#start#" endrow="#end#">
        <!---Find the customer that ordered this--->
		<cfif NOT isnumeric(CustomerID)>
			<cfset CustomerID = 0>
		</cfif>
				
        <cfquery name = "qryCustomers" Datasource = "#Request.dsn#">
        SELECT * FROM customerhistory WHERE CustomerID = #CustomerID# 
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
		  <cfset rowcount=rowcount + 1> 
          <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
            <td align="center">
			<cfset trname = replace(ordernumber, "-", "", "ALL")>
			<img src="icons/expand.gif" width="9" height="9" onclick="javascript: ExpandOrder('#trname#');" name="IMG#trname#" id="IMG#trname#" /></td> 
            <td><p align="center">  
                <input type="checkbox" name="OrderCompleted" value="#OrderID#">
                <input type="Hidden" Name="OrderID" Value="#OrderID#">
				<input type="Hidden" Name="trnames" Value="#trname#" />
                <input type = "hidden" Name="OrderNumber" Value="#OrderNumber#">
                <input type = "hidden" Name="OldOrderStatus" Value="#OrderStatus#">
                <input type = "hidden" Name="CustEmail" Value="#CustEmail#">
                <input type = "hidden" Name="pnref" Value="#pnref#">
                <cfif len(transactiontype) GT 0>
                	<input type = "hidden" Name="TransType" Value="#transactiontype#">
                <cfelse>
	                <input type = "hidden" Name="TransType" Value="NA">
				</cfif>
             </p></td>
            <td onclick="EditOrder(#ordernumber#, #CustomerID#);">#dateformat(DateOfOrder, "mmm dd, yyyy")#</td>
            <td onclick="EditOrder(#ordernumber#, #CustomerID#);"><a href="doorders.cfm?action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#"> 
               
              <cfif NOT ISDEFINED('CustName')>
                DELETED 
                <cfelse>
                #CustName# 
              </cfif>
            </a></td>
            <td onclick="EditOrder(#ordernumber#, #CustomerID#);"><a href="doorders.cfm?action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#"> 
              #OrderNumber#
            <cfif len(pnref) GT 0><br />- #pnref#</cfif></a></td>
            <td> 
              <cfif request.EnableEuro IS 'Yes'>
                #lseurocurrencyformat(OrderTotal, "Local")# 
                <cfelse>
                #lscurrencyformat(OrderTotal, "Local")# 
              </cfif>
            </td>
            <td>#OrderStatus#</td>
            <td><div align="center"><img src="../../icons/#qProc.orders_icon#" alt="#qProc.p_adminname#" title="Credit Card"/></div></td>
            <td><div align="center">#paid#</div></td>
            <td align="left">
<div align="center">
			<img src="../../icons/print_16.gif" alt="Print Order" title="Print Order" width="16" height="16" onClick="printme('#OrderNumber#');" style="cursor:pointer;"/>&nbsp;
			<img src="icons/vieworder.gif" title="Quick View" alt="Quick View" onClick="viewme('#OrderNumber#');" style="cursor:pointer;">
			</div></td>
          </tr>
        </cfoutput>
		  <!---****ORDER INFORMATION SPAN (ADDED VER 1.06 (JW)****--->
		  <!---create the order information span that will be shown only if they expand it--->
		  
		  <tr>
		  <td colspan="10" align="left" style="padding-left:50px;">
		  <span style="display:none;" <cfoutput>name="#trname#" id="#trname#"</cfoutput>>
		  	<table width="100%" cellpadding="6" cellspacing="0" style="border: #000000 1px solid;">

			<!---***BACKWORD COMPATIBLITY CHECK***--->
			<!---Update this order if it's an order placed on version 1.05 or earlier--->	
			<cfif NOT listlen(crtShipped, "^") IS listlen(crtItemID, "^")>
				<cfif OrderStatus IS 'Received' OR OrderStatus IS 'In Process' OR OrderStatus IS 'Updated' OR OrderStatus IS 'Cancelled'>
					<cfset setallto = 'No'>
				<cfelse>
					<cfset setallto = 'Yes'>
				</cfif>
				
				<cfset cart.shipped = "">
				<cfset cart.tracking = "">
				<cfset cart.package = "">
				<cfloop from = "1" to = "#listlen(crtItemID, '^')#" index="mycount">
					<cfset cart.shipped = listappend(cart.shipped, setallto, "^")>
					<!---set the tracking numbers all to the one on the order if there is
					one--->
					<cfset cart.tracking = listappend(cart.tracking, trackingnumber, "^")>
					<cfset cart.package = listappend(cart.package, '1', "^")>
				</cfloop>
				
				<cfquery name = "qryUpdateOrder" datasource="#request.dsn#">
				UPDATE orders SET crtShipped = '#cart.shipped#',
				crtTrackingNumbers = '#cart.tracking#',
				crtPackageNumber = '#cart.Package#'
				WHERE ordernumber = '#ordernumber#'
				</cfquery>
				
				<cfset crtShipped = #cart.shipped#>
				<cfset crtTrackingNumbers = #cart.Tracking#>
				<cfset crtPackageNumber = #cart.Package#>
			</cfif>
			<!---***END COMPATABILITY CHECK***--->

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
			
			
			<cfloop from = "1" to = "#listlen(crtItemID, '^')#" index="mycount">
			<cfset oItemID = listgetat(crtItemID, mycount, "^")>
			<cfset oProductID = listgetat(crtItemID, mycount, "^")>
			<cfset oProductName = listgetat(crtProductName, mycount, "^")>
			<cfset oQuantity = listgetat(crtQuantity, mycount, "^")>
			<cfif listlen(crtShipped, "^") LT mycount>
				<cfset oShipped = 'NA'>
			<cfelse>
				<cfset oShipped = listgetat(crtShipped, mycount, "^")>
			</cfif>	
			<cfif listlen(crtTrackingNumbers, "^") LT mycount>
				<cfset oTracking = '#trackingnumber#'>
			<cfelse>
				<cfset oTracking = listgetat(crtTrackingNumbers, mycount, "^")>				
			</cfif>
			<cfif listlen(crtPackageNumber, "^") LT mycount>
				<cfset oPackage = '1'>
			<cfelse>
			<cfset oPackage = listgetat(crtPackageNumber, mycount, "^")>
			</cfif>
			<cfoutput>		
			<tr>
			<td width = "60%" bgcolor="##CCCCCC" align="left">
				#oProductID# - #oProductName#			</td>
			<td width = "10%" bgcolor="##CCCCCC" align="center">
				#oQuantity#			</td>
			<td width = "10%" bgcolor="##CCCCCC" align="center">
				<!---FOR BACKWARDS COMPATABILITY--->
				
				<cfif OrderStatus CONTAINS 'FEDEX'>
					<cfset oShipped = 'Fedex'>
				</cfif>
				<cfif OrderStatus CONTAINS 'UPS'>
					<cfset oShipped = 'UPS'>
				</cfif>
				<cfif OrderStatus CONTAINS 'USPS'>
					<cfset oShipped = 'USPS'>
				</cfif>
				<cfif OrderStatus IS 'Shipped'>
					<cfset oShipped = 'Shipped'>
				</cfif>
				<cfif OrderStatus IS 'Cancelled'>
					<cfset oShipped = 'Cancelled'>
				</cfif>				
				#oShipped#
			</td>
			<td width = "10%" bgcolor="##CCCCCC" align="center">#oTracking#</td>
			<td width = "10%" bgcolor="##CCCCCC" align="center">#oPackage#</td>	
			</tr>
			</cfoutput>
			</cfloop>
			<tr>
			<td colspan = "5" bgcolor="#CCCCCC" align="left">
			Notes:<br />
			<cfoutput>#notes#</cfoutput>			</td>
			</tr>
			<tr>
			<td colspan = "5" bgcolor="#CCCCCC" align="left">
			<cfoutput>
			<cfif NOT ShippingMethod IS '' AND NOT ShippingMethod IS 'N/A'>
				<b>Ship Order by</b> #ShippingMethod#<br />
			</cfif>
			<b>Quoted Shipping Cost:</b> #dollarformat(QuotedShipping)#
			<p>
			REFERRED BY: <cfif NOT qryArchives.affiliateid IS ''><a href = "#request.adminpath#/components/affiliates/index.cfm?action=transactions&affiliateid=#qryArchives.affiliateid#">#qryArchvies.affiliateid#</a><cfelse>None.</cfif>
            <cfif len(payment_pending_reason) GT 0>Pending Reason: #payment_pending_reason#</cfif>
            <cfif len(transid) GT 0>Transaction ID: #transid#<br /></cfif>            
			</cfoutput>			</td>
			</tr>
		  </table>
		  </span>		  </td>  
		  </tr>
		  <!---***End Order Information span***---> 
 		  <!---***Begin HIDDEN Print Display***--->
		  <tr>
		  <td colspan="10" align="left" style="height:1px;">
		  <span style="display:none;" name="PrintRow" id="PrintRow">
				<cfinclude template = "dspprintorder.cfm">		  
		  </span>
		  </td>
		  </tr>

		<cfif rowcount IS 2><cfset rowcount=0></cfif>
      </cfloop>
    </table>
  <input type = "hidden" name="action" value="updatearchives">
<p align="center"><input type="submit" value="Unarchive Orders" name="B1">
</p>
</form>



















