<!--- Start displaying with record 1 if not specified via url --->
<CFPARAM name="start" default="1">
<!--- Number of records to display on a page --->
<CFPARAM name="disp" default="#request.MaxRecords#">
<CFPARAM name="end" default="25">


<cfset StartYear = '2002'>
<cfset EndYear = '2003'>

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

<cfinclude template='../queries/qrysearchorders.cfm'>
<cfinclude template='../queries/qrysales.cfm'>

<CFSET end=Start + disp>
<CFIF start + disp GREATER THAN qrySearchorders.RecordCount>
  <CFSET end=999>
<CFELSE>
  <CFSET end=disp>
</CFIF>
<h2>Search Results</h2>
<cfinclude template='../queries/qrySearchorders.cfm'>
<CFIF qrySearchorders.recordcount IS 0 AND qrySearchCustomers.recordcount IS 0>
  <div align="center">No orders were found that matched your search criteria.</div>
</CFIF>
<CFIF NOT qrySearchorders.recordcount IS 0 OR NOT qrySearchCustomers.recordcount IS 0>
<form action="doorders.cfm" method="POST" >
    
<table border="0" width="100%">
  <tr bgcolor="#CCCCCC"> 
        <td width="8%" align="left"><b> <font size="1">Order Number</font></b></td>
    <td width="12%" align="left"><b> <font size="1">Name</font></b></td>
        <td width="11%" align="left"><b> <font size="1">City</font></b> </td>
        <td width="10%" align="left"><b><font size="1">State</font></b></td>
        <td width="11%" align="left"><b> <font size="1">Date of Order</font></b></td>
        <td width="9%" align="left"> <b> <font size="1">Country</font></b></td>
        <td width="16%" align="left"><strong><font size="1">Email Address</font></strong></td>
        <td width="19%" align="left"><font size="1"><strong>Phone Number</strong></font></td>
  </tr>
	<cfif NOT qrySearchCustomers.recordcount IS 0>
      <cfloop query ="qrySearchCustomers">
	  <cfquery name = "qryorders" datasource="#request.dsn#">
	  	SELECT * FROM orders WHERE CustomerID = #CustomerID#
	  </cfquery>
		<cfoutput query = "qryorders">
          <tr> 
            <td width="12%"><a href="doorders.cfm?action=ViewOrder&OrderNumber=#qryorders.OrderNumber#&CustomerID=#qryorders.CustomerID#"> 
              <font size="1">#qryorders.OrderNumber#</font></a></td>
            <td width="18%"><font size="1">#qrySearchCustomers.FirstName# #qrySearchCustomers.LastName# </font></td>
            <td width="11%"><font size="1">#qrySearchCustomers.City#</font></td>
            <td width="7%"><font size="1">#qrySearchCustomers.State#</font></td>
            <td width="8%"><font size="1"><font size="1">#dateformat(qryorders.DateOfOrder, "mm/dd/yy")#</font></font></td>
			<td width="12%"><font size="1">#qrySearchCustomers.Country#</font></td>
            <td width="16%"><a href="mailto:#qrySearchCustomers.EmailAddress#"><font size="1">#qrySearchCustomers.EmailAddress#</font></a></td>
            <td width="16%"><font size="1">#qrySearchCustomers.PhoneNumber#</font></td>
          </tr>
		  </cfoutput>
        </cfloop> 
	</cfif>
  <cfloop query ="qrySearchorders">
    <!---Find the customer that ordered this--->
    <cfquery name = "qryCustomers" Datasource = "#Request.dsn#">
    SELECT * FROM customerhistory WHERE CustomerID = #CustomerID# 
    </cfquery>
	<cfoutput> 
      <tr> 
         <td width="8%"><a href="doorders.cfm?action=vieworder&OrderNumber=#qrySearchorders.OrderNumber#&CustomerID=#qryCustomers.CustomerID#"><font size="1">#qrySearchorders.OrderNumber#</font></a></td>    
         <td width="12%"><font size="1">#qryCustomers.FirstName# #qryCustomers.LastName#</font></td>    
         <td width="11%"><font size="1">#qryCustomers.City#</font></td>    
         <td width="10%"><font size="1">#qryCustomers.State#</font></a></td>    
		 <td width="11%"><font size="1">#dateformat(qrySearchorders.DateofOrder, "mm/dd/yy")#</font></td>
       	 <td width="9%"><font size="1">#qryCustomers.Country#</font></td>
         <td width="16%"><font size="1"><a href="mailto:#qryCustomers.EmailAddress#"><font size="1">#qryCustomers.EmailAddress#</font></a></td>
        <td width="19%"><font size="1">#qryCustomers.PhoneNumber#</font></td>
      </tr>
    </cfoutput> 
  </cfloop>
</table>
</form>
</cfif>



















