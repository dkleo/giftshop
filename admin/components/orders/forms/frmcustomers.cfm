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
		window.location.href = 'doorders.cfm?&action=editcustomer&CustomerID=' + thisorderid + '&CustomerID=' + custid;
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
<cfparam name = "SortBy" default="LastName">

<cfif SortOrder IS 'DESC'><cfset OppSortOrder = 'ASC'></cfif>
<cfif SortOrder IS 'ASC'><cfset OppSortOrder = 'DESC'></cfif>

<!---QUERY THE DATABASE--->
<cfinclude template='../queries/qrycustomers.cfm'>
<h2>Customers</h2>
    <table width="100%" border="0" cellpadding="4" cellspacing="0">
      <tr>
        <td colspan="4" align="left"></td>
        <td align="left">&nbsp;</td>
        <td align="left">
		<cfoutput> 
          <!---Display the page numbers--->
          <cfif disp LT qryCustomers.RecordCount + 1>         
			<form name = "PageSelect" method="Post" action="doorders.cfm?action=viewcustomers">
			<div align="left">
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryCustomers.RecordCount#" Step="#disp#">
				<a href = "doproducts.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
            </form></div>
          </cfif>
        </cfoutput></td>
        <td align="left"><form name="Displayoptions" method="POST" Action="doorders.cfm?action=viewcustomers">
		<div align="left">
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="100" <cfif disp IS '9999999'>SELECTED</cfif>>Display All</option>
		</select>
	</form>
	</div>	</td>
        <td align="left">&nbsp;</td>
	  </tr>

      <tr bgcolor="#000000"> 
        <td width="12%" height="30" align="left"><b> <font color="#FFFFFF">Name</font></b></td>
        <td align="left"><b> <font color="#FFFFFF">Address</font></b></td>
        <td width="10%" align="left"><b> <font color="#FFFFFF">City</font></b> </td>
        <td width="5%" align="left"><b><font color="#FFFFFF">State</font></b></td>
        <td width="5%" align="left"><b> <font color="#FFFFFF">Zip</font></b></td>
        <td width="5%" align="left"> <b> <font color="#FFFFFF">Country</font></b></td>
        <td width="15%" align="left"><strong><font color="#FFFFFF">Email</font></strong></td>
        <td width="10%" align="left"><font color="#FFFFFF"><strong>Phone</font></strong></td>
        <td width="10%" align="left"><font color="#FFFFFF">
        <div align="center"><strong>Pricing Level</strong></div></font></td>
      </tr>
	  <cfset rowcount = 0>

		  <!---Set up variables for paginating--->
		  <CFSET end=Start + disp>
		  <CFIF Start + disp GREATER THAN qryCustomers.RecordCount>
			<CFSET end=qryCustomers.RecordCount>
			<CFELSE>
			<CFSET end=start + disp>
		  </CFIF>
		  
	  <cfset BlankAccountsList = "">
      <cfoutput>
	  <cfloop query ="qryCustomers" startRow="#Start#" endrow="#End#">
          <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
            <td height="25"><a href="doorders.cfm?action=EditCustomer&CustomerID=#CustomerID#"> 
              <cfif NOT #LastName# IS '' AND NOT #FirstName# IS ''>#LastName# #FirstName#<cfelse>EDIT BLANK ACCT<cfset BlankAccountsList = BlankAccountsList & "^#CustomerID#"></cfif></a></td>
            <td><a href="doorders.cfm?action=EditCustomer&CustomerID=#CustomerID#">#Address#</a></td>
            <td>#City#</td>
            <td>#State#</td>
            <td>#Zipcode#</td>
			<td>#Country#</td>
            <td><a href="mailto:#EmailAddress#">#EmailAddress#</a></td>
            <td>#PhoneNumber#</td>
            <td><div align="center">#pricelevel#</div></td>
          </tr>
        </cfloop>
		</cfoutput> 
    </table>

<cfif NOT ListLen(BlankAccountsList, "^") IS 0>
	<cfoutput>
	<form name="form1" method="post" action="doorders.cfm">
	  <input type="hidden" name="BlankAccountsList" value="#BlankAccountsList#">
	  <input type="hidden" name="action" value="RemoveBlankAccounts">
	  <input type="submit" name="Submit" value="Remove Blank Accounts">
	</form>
	</cfoutput>
</cfif>




















