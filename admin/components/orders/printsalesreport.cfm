<cfset FirstOrder = 'N/A'>
<cfset LastOrder = 'N/A'>
<cfset NumberOfSales = 0>
<cfset StartYear = '2003'>
<cfset EndYear = '2003'>

<cfinclude template="queries/qrysales.cfm">

<cfif qrySales.recordCount IS 0>
<div align="center"><strong>There are no orders on file!</strong></div>
<cfabort>
</cfif>

<cfif ISDEFINED('form.reportmonth')>
<cfset ThisReportMonth = '#form.ReportMonth#'>
<cfset ThisReportYear = '#form.ReportYear#'>
</cfif>

<cfif NOT ISDEFINED('form.reportmonth')>
<cfset ThisReportMonth = #DatePart("m", Now())#>
<cfset ThisReportYear = #DatePart("yyyy", Now())#>
</cfif>

<cfset TotalSales = 0>

<cfif NOT qrySales.recordcount IS 0>
<!--- Get Last Order and Calculate Total Sales--->
<cfoutput query="qrySales">
<cfset LastOrder = '#DateOfOrder#'>
<cfset TotalSales = TotalSales + OrderTotal>
</cfoutput>

<!--- Get The First Order--->
<cfoutput query="qrySales" startrow="1" maxrows="1">
<cfset FirstOrder = '#DateOfOrder#'>
</cfoutput>
</cfif>

<cfif NOT FirstOrder IS 'N/A'>
<cfset NumberOfSales = #qrySales.RecordCount#>
<cfset StartYear = #DatePart("yyyy", FirstOrder)#>
<cfset EndYear = #DatePart("yyyy", LastOrder)#>
</cfif>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="AutoNumber1">
  <cfoutput> 
    <tr> 
      <td width="25%"><div align="center"><strong><font size="2">Total of Sales 
          to Date: </font></strong><font size="2"><u> 
          <cfif request.EnableEuro IS 'Yes'>
            #lseurocurrencyformat(TotalSales, "Local")# 
            <cfelse>
            #lscurrencyformat(TotalSales, "Local")# 
          </cfif>
          </u></font></div></td>
      <td width="25%"><div align="center"><strong><font size="2">Total Sales</font></strong> 
          <font size="2"><strong>to Date:</strong> <u><font size="2" face="Verdana">#NumberOfSales#</u></font></div></td>
      <td width="25%"><div align="center"><strong><font size="2">First Order on:</font></strong> 
          <font size="2"><u>#DateFormat(FirstOrder, "mm/dd/yyyy")#</u></font></div></td>
      <td width="25%"><div align="center"><strong><font size="2">Last Order on:</font></strong> 
          <font size="2"><u>#DateFormat(LastOrder, "mm/dd/yyyy")#</u></font></div></td>
    </tr>
  </cfoutput> 
</table>
  <p align="center"><font size="4">Online Sales Report</font></p>
  <cfoutput>
<cfif NOT ThisReportMonth IS '99'>
<cfif ThisReportMonth IS '1'><cfset TheMonth = 'January'></cfif>
<cfif ThisReportMonth IS '2'><cfset TheMonth = 'February'></cfif>
<cfif ThisReportMonth IS '3'><cfset TheMonth = 'March'></cfif>
<cfif ThisReportMonth IS '4'><cfset TheMonth = 'April'></cfif>
<cfif ThisReportMonth IS '5'><cfset TheMonth = 'May'></cfif>
<cfif ThisReportMonth IS '6'><cfset TheMonth = 'June'></cfif>
<cfif ThisReportMonth IS '7'><cfset TheMonth = 'July'></cfif>
<cfif ThisReportMonth IS '8'><cfset TheMonth = 'August'></cfif>
<cfif ThisReportMonth IS '9'><cfset TheMonth = 'September'></cfif>
<cfif ThisReportMonth IS '10'><cfset TheMonth = 'October'></cfif>
<cfif ThisReportMonth IS '11'><cfset TheMonth = 'November'></cfif>
<cfif ThisReportMonth IS '12'><cfset TheMonth = 'December'></cfif>
<div align="center"><font size="4">#TheMonth# </cfif>#ThisReportYear#</font></div>
<div align="center"></cfoutput>
    <center>
      <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="85%" id="AutoNumber2">
        <tr bgcolor="#CCCCCC"> 
          <td width="33%"><strong> Date of Order</strong></td>
          <td width="33%"><div align="right"><strong> Order Amount</strong></div></td>
          <td width="34%"><div align="right"><strong> Sales Tax</strong></div></td>
        </tr>
        <cfset TotalOfTaxes = 0>
        <cfset TotalOfOrders = 0>
        <cfif NOT #ThisReportMonth# IS '99'>
          <cfoutput query = "qrySales"> 
            <cfif #DatePart("yyyy", DateofOrder)# IS #ThisReportYear# AND #DatePart("m", DateofOrder)# IS #ThisReportMonth#>
              <tr> 
                <td width="33%">#dateformat(DateOfOrder, "mm/dd/yyyy")#</td>
                <td width="33%"><div align="right">
				<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(OrderTotal, "Local")#<cfelse>#LSCurrencyFormat(OrderTotal, "Local")#</cfif></div></td>
                <td width="34%"><div align="right"><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(FiguredTax, "Local")#<cfelse>#LSCurrencyFormat(FiguredTax, "Local")#</cfif></div></td>
              </tr>
              <cfset TotalOfTaxes = #TotalofTaxes# + #FiguredTax#>
              <cfset TotalOfOrders = #TotalOfOrders# + #OrderTotal#>
            </cfif>
          </cfoutput> 
        </cfif>
        <cfif #ThisReportMonth# IS '99'>
          <cfoutput query = "qrySales"> 
            <cfif #DatePart("yyyy", DateofOrder)# IS ThisReportYear>
              <tr> 
                <td width="33%">#dateformat(DateOfOrder, "mm/dd/yyyy")#</td>
                <td width="33%"><div align="right"><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(OrderTotal, "Local")#<cfelse>#LSCurrencyFormat(OrderTotal, "Local")#</cfif></div></td>
                <td width="34%"><div align="right"><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(FiguredTax, "Local")#<cfelse>#LSCurrencyFormat(FiguredTax, "Local")#</cfif></div></td>
              </tr>
              <cfset TotalOfTaxes = #TotalofTaxes# + #FiguredTax#>
              <cfset TotalOfOrders = #TotalOfOrders# + #OrderTotal#>
            </cfif>
          </cfoutput> 
        </cfif>
        <tr> 
          <td width="33%" bgcolor="#C0C0C0"><strong> TOTALS</strong></td>
          <td width="33%" bgcolor="#C0C0C0"><div align="right"><strong><cfoutput>
		  <cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(TotalOfOrders, "Local")#<cfelse>#LSCurrencyFormat(TotalOfOrders, "Local")#</cfif></cfoutput></strong></div></td>
          <td width="34%" bgcolor="#C0C0C0"><div align="right"><strong><cfoutput><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(TotalOfTaxes, "Local")#<cfelse>#LSCurrencyFormat(TotalOfTaxes, "Local")#</cfif></cfoutput></strong></div></td>
        </tr>
      </table>
    </center>
  </div>










