<cfparam name = "paid" default="yes">

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

<cfparam name = "SortOrder" default="DESC">
<cfparam name = "SortBy" default="DateofOrder">

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
        <td colspan="8" align="left"><h2><strong>Delete Orders</strong></h2>
        <p>As a precaution, your are required to archive orders that you want to delete first. Only archived orders show up in this list.</p></td>
      </tr>
      <tr>
        <td colspan="4" align="left">
		<form method="POST" action="doorders.cfm?action=delete">
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
  <input type="submit" value="List Orders" name="B1">
  </Form></p>		</td>
        <td align="left">&nbsp;</td>
        <td align="left">
		<cfoutput> 
          <!---Display the page numbers--->
          <cfif disp LT qryArchives.RecordCount + 1>         
			<form name = "PageSelect" method="Post" action="doorders.cfm?action=delete">
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
        <td align="left"><form name="Displayoptions" method="POST" Action="doorders.cfm?action=delete">
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
	</p>	</td>
        <td align="left">&nbsp;</td>
      </tr>
<form action="doorders.cfm?action=delete" method="POST" name="myform">
      <tr> 
        <td width="4%" align="left" bgcolor="#000000"><p align="center"><strong><font color="#FFFFFF" size="1">Delete</strong></p></td>
        <td width="8%" align="left" bgcolor="#000000"><cfoutput><a href="doorders.cfm?action=delete&sortby=DateOfOrder&SortOrder=#OppSortOrder#"></cfoutput><font color="#FFFFFF"><b> 
		<cfif sortby IS 'DateOfOrder'><cfoutput><img src="images/i.p.sort.#sortorder#.gif" border="0" /></cfoutput></cfif>
		Date</a></b></font></td>
        <td width="12%" align="left" bgcolor="#000000"><font color="#FFFFFF"><b>Name</b></font></td>
        <td width="11%" align="left" bgcolor="#000000"><b><cfoutput><a href="doorders.cfm?action=delete&sortby=OrderNumber&SortOrder=#OppSortOrder#"></cfoutput><font color="#FFFFFF"><b> <cfif sortby IS 'OrderNumber'><cfoutput><img src="images/i.p.sort.#sortorder#.gif" border="0" /></cfoutput></cfif>Order 
          Number</a></b></font> </td>
        <td width="9%" align="left" bgcolor="#000000"><cfoutput><a href="doorders.cfm?action=delete&sortby=OrderTotal&SortOrder=#OppSortOrder#"></cfoutput><font color="#FFFFFF"><b> <cfif sortby IS 'OrderTotal'><cfoutput><img src="images/i.p.sort.#sortorder#.gif" border="0" /></cfoutput></cfif>Order 
          Total</a></b></font></td>
        <td width="16%" align="left" bgcolor="#000000"><cfoutput><a href="doorders.cfm?action=delete&sortby=OrderStatus&SortOrder=#OppSortOrder#"></cfoutput><font color="#FFFFFF"><b> <cfif sortby IS 'OrderStatus'><cfoutput><img src="images/i.p.sort.#sortorder#.gif" border="0" /></cfoutput></cfif>
          <strong>Status</strong><strong></a></strong></font></td>
        <td width="9%" align="left" bgcolor="#000000"><font color="#FFFFFF"><strong>Tracking No.</strong></font></td>
        <td width="5%" align="left" bgcolor="#000000"><div align="center"><font color="#FFFFFF"><strong>Payment<br />
        Received?</strong></font></div></td>
      </tr>
	  <cfset rowcount = 0>

		  <!---Set up variables for paginating--->
		  <CFSET end=Start + disp>
		  <CFIF Start + disp GREATER THAN qryarchives.RecordCount>
			<CFSET end=qryarchives.RecordCount>
			<CFELSE>
			<CFSET end=start + disp>
		  </CFIF>
		  
      <cfloop query ="qryArchives" startRow="#Start#" endrow="#End#">
        <!---Find the customer that ordered this--->
        <cfquery name = "qryCustomers" Datasource = "#Request.dsn#">
        SELECT * FROM customerhistory WHERE CustomerID = #CustomerID# 
        </cfquery>
        
          <cfset CustName = 'DELETED'>
          <cfset CustCity = 'DELETED'>
          <cfset CustState = 'DELETED'>
          <cfset CustPhone = 'DELETED'>
          <cfset CustEmail = 'DELETED'>

        <cfoutput query = "qryCustomers"> 
          <cfset CustName = '#LastName#, #FirstName#'>
          <cfset CustCity = '#City#'>
          <cfset CustState = '#State#'>
          <cfset CustPhone = '#PhoneNumber#'>
          <cfset CustEmail = '#EmailAddress#'>
        </cfoutput> 
		 <cfoutput>
		  <cfset rowcount=rowcount + 1> 
          <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
            <td width="4%"> <p align="center">  
                <input name="OrderDeleted" type="checkbox" id="OrderDeleted" value="#OrderID#">
                <input type="Hidden" Name="OrderID" Value="#OrderID#">
                <input type = "hidden" Name="OrderNumber" Value="#OrderNumber#">
                <input type = "hidden" Name="OldOrderStatus" Value="#OrderStatus#">
                <input type = "hidden" Name="CustEmail" Value="#CustEmail#">
                 </p></td>
            <td width="8%" onclick="EditOrder(#ordernumber#, #CustomerID#);">#dateformat(DateOfOrder, "mm/dd/yy")#</td>
            <td width="12%" onclick="EditOrder(#ordernumber#, #CustomerID#);"><a href="doorders.cfm?&action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#"> 
               
              <cfif NOT ISDEFINED('CustName')>
                DELETED 
                <cfelse>
                #CustName# 
              </cfif>
              </a></td>
            <td width="11%" onclick="EditOrder(#ordernumber#, #CustomerID#);"><a href="doorders.cfm?&action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#"> 
              #OrderNumber#</a></td>
            <td width="9%"> 
              <cfif request.EnableEuro IS 'Yes'>
                #lseurocurrencyformat(OrderTotal, "Local")# 
                <cfelse>
                #lscurrencyformat(OrderTotal, "Local")# 
              </cfif>
              </td>
            <td width="16%"><a href="doorders.cfm?&action=vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#"> 
            </a>#OrderStatus#</td>
            <td width="9%"> #TrackingNumber# </td>
            <td width="5%"><div align="center">
              #paid#
            </div></td>
           </tr>
        </cfoutput> 
		<cfif rowcount IS 2><cfset rowcount=0></cfif>
      </cfloop>
    </table>
    <p align="center"> 
      <cfoutput>
      <input type="hidden" value="Delete" Name="Action">
      <input type="hidden" value="#disp#" name="disp" />
      <input type="hidden" value="#start#" name="start" />
      <input type="hidden" value="#paid#" name="paid" />
      </cfoutput>
      <input type="submit" value="Delete Orders" name="B1">
    </p>
</form>



















