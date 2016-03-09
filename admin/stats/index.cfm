<cfsetting requestTimeOut = "1200">
<div align="center">
  <p><strong><font size="4">Store Statistics</font></strong></p>
  <p>&nbsp;</p>
  <p>

<cfset TodaysDate = #Dateformat(Now(), "yyyy-mm-dd")#>
<cfset DayOfWeekVal = #DayOfWeek(TodaysDate)#>
<cfset FirstDayOfWeek = #DateAdd("d", -DayOfWeekVal, TodaysDate)#>
<cfset DaysInThisMonth = #DaysInMonth(TodaysDate)#>
<cfset CurrentMonth = #Month(TodaysDate)#>
<cfset CurrentYear = #Year(TodaysDate)#>
<cfset FirstDayOfThisMonth = '#CurrentYear#-#CurrentMonth#-01'>
<cfset CurrentMonth = #MonthAsString(CurrentMonth)#>
<cfset LastYear = #CurrentYear# - 1>
<cfset FirstDayOfLastYear = "01/01/#LastYear#">
<cfset LastDayOfLastYear = "12/31/#LastYear#">

<!---AutoArchive anything older than this year--->
<!---Find all of last years stuff and put it in the archives table--->
<cfset ArchMonthCount = 1>
<cfset ArchMonthTotalU = 0>
<cfset ArchMonthTotalPV = 0>

<cfloop From = "1" To="12" Index="ArchiveCount">

<cfset ArchMonthChartFirstDayOfMonth = "#Year(FirstDayOfLastYear)#-#ArchMonthCount#-01">
<cfset ArchMonthChartDaysInMonth = #DaysInMonth(ArchMonthChartFirstDayOfMonth)#>

<cfloop From="1" To="#ArchMonthChartDaysInMonth#" index="myCount">
	<!---Set the value of the next day in the loop--->
	<cfset ArchNextDayOfMonth = #DateAdd("d", ArchiveCount - 1, ArchMonthChartFirstDayOfMonth)#>
	<!---Query the database to see how many unique hits for this day--->
	<cfquery name = "qryUniqueDay" Datasource = "#request.dsn#">
	SELECT * FROM stats 
	WHERE datedata = #createodbcdate(ArchNextDayOfMonth)#
	</cfquery>

	<!---Get a total of Unique hits for this month--->
	<cfset ArchMonthTotalU = ArchMonthTotalU + #qryUniqueDay.RecordCount#>

	<cfoutput query = "qryUniqueDay">
		<!---Add up the total pageviews for this month--->
		<cfset ArchMonthTotalPV = ArchMonthTotalPV + #QryUniqueDay.PageViews#>
	</cfoutput>
</cfloop>


<!---Update the archives--->

	 <cfquery name = "InsertArchivedInfo" datasource="#request.dsn#">
	 	INSERT INTO stats_archive
		 (Month, pageviews, uniques, Year)
		 VALUES
		 ('#ArchMonthCount#', #ArchMonthTotalPV#, #ArchMonthTotalU#, '#LastYear#')
	 </cfquery>

<!---Now go to the next month--->
<cfset ArchMonthCount = ArchMonthCount + 1>
<cfset ArchMonthTotalU = 0>
<cfset ArchMonthTotalPV = 0>
</cfloop>

<!---Remove old data from the stats table--->
	<cfquery name = "QryFindThis" datasource="#request.dsn#">
	 DELETE FROM stats
	 WHERE datedata between #createodbcdate(FirstDayOfLastYear)# and #createodbcdate(LastDayOfLastYear)#
	 </cfquery>

<!----********End of Archive Process*********----->

<!---Find the total UNIQUE hits for the week--->
<cfquery name = "qryUniqueWeek" Datasource = "#request.dsn#">
SELECT * FROM stats 
WHERE datedata between #createodbcdate(todaysDate)# and #createodbcdate(FirstDayOfWeek)#
</cfquery>

<!---Total Unique Hits--->
<cfquery name = "qryTotalUnique" Datasource = "#request.dsn#">
SELECT * FROM stats 
</cfquery>

<!---Total Page Views Hits--->
<cfquery name = "qryTotalPageViews" Datasource = "#request.dsn#">
SELECT SUM(PageViews) AS sum_Pageviews FROM stats 
</cfquery>

<cfset ChartString = ''>
<!---Create the list of values for each day by looping from 1 to 7--->
<cfloop From="1" To="7" index="myCount">
	<!---Set the value of the next day in the loop--->
	<cfset NextDayOfWeek = #DateAdd("d", myCount, FirstDayOfWeek)#>
	<!---Query the database to see how many unique hits for this day--->
	<cfquery name = "qryUniqueDay" Datasource = "#request.dsn#">
	SELECT * FROM stats 
	WHERE datedata = #createodbcdate(NextDayOfWeek)#
	</cfquery>

	<cfset ChartString = #ListAppend(ChartString, qryUniqueDay.RecordCount)#>

</cfloop>
<!---Now show the chart--->
<p>
  <cf_statsChart
	title="Unique Hits (This Week)"
	values="#ChartString#"
	legend="Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday"> 


<!---Build the Total UNIQUE Hits This Month Table Days 1-15--->
<cfset ChartString = ''>
<cfset ChartString2 = ''>

<!---Create the list of values for each day by looping from 1 to 7--->
<cfloop From="1" To="15" index="myCount">
	<!---Set the value of the next day in the loop--->
	<cfset NextDayOfMonth = #DateAdd("d", myCount - 1, FirstDayOfThisMonth)#>
	<!---Query the database to see how many unique hits for this day--->
	<cfquery name = "qryUniqueDay" Datasource = "#request.dsn#">
	SELECT * FROM stats 
	WHERE datedata = #createodbcdate(NextDayOfMonth)#
	</cfquery>

	<!---Keep a running total for this month--->

	<cfset ChartString = #ListAppend(ChartString, qryUniqueDay.RecordCount)#>
	<cfset ChartString2 = #ListAppend(ChartString2, myCount)#>
</cfloop>
<p> 
    <!---Now show the chart--->
    <cf_statsChart
	title="Unique Hits (This Month - #CurrentMonth#) 1st - 15th"
	values="#ChartString#"
	legend="#ChartString2#">

<cfset ChartString = ''>
<cfset ChartString2 = ''>


<!---Build the Total UNIQUE Hits This Month Table Days 16th through end of month--->
<cfset ChartString = ''>
<cfset ChartString2 = ''>

<!---Create the list of values for each day by looping from 1 to 7--->
<cfloop From="16" To="#DaysInThisMonth#" index="myCount">
	<!---Set the value of the next day in the loop--->
	<cfset NextDayOfMonth = #DateAdd("d", myCount - 1, FirstDayOfThisMonth)#>
	<!---Query the database to see how many unique hits for this day--->
	<cfquery name = "qryUniqueDay" Datasource = "#request.dsn#">
	SELECT * FROM stats 
	WHERE datedata = #createodbcdate(NextDayOfMonth)#
	</cfquery>

	<!---Keep a running total for this month--->

	<cfset ChartString = #ListAppend(ChartString, qryUniqueDay.RecordCount)#>
	<cfset ChartString2 = #ListAppend(ChartString2, myCount)#>
</cfloop>
<p> 
    <!---Now show the chart--->
    <cf_statsChart
	title="Unique Hits (This Month - #CurrentMonth#) 16th - #DaysInThisMonth#"
	values="#ChartString#"
	legend="#ChartString2#">

<cfset ChartString = ''>
<cfset ChartString2 = ''>




<!---Find the number of Unique hits for each month in the year--->

<cfset MonthCount = 1>
<cfset MonthTotal = 0>

<cfloop From = "1" To="12" Index="Mycount2">

<cfset MonthChartFirstDayOfMonth = "#Year(TodaysDate)#-#MonthCount#-01">
<cfset MonthChartDaysInMonth = #DaysInMonth(MonthChartFirstDayOfMonth)#>

<cfloop From="1" To="#MonthChartDaysInMonth#" index="myCount">
	<!---Set the value of the next day in the loop--->
	<cfset NextDayOfMonth = #DateAdd("d", myCount - 1, MonthChartFirstDayOfMonth)#>
	<!---Query the database to see how many unique hits for this day--->
	<cfquery name = "qryUniqueDay" Datasource = "#request.dsn#">
	SELECT * FROM stats 
	WHERE datedata = #createodbcdate(NextDayOfMonth)#
	</cfquery>

	<!---Keep a running total for this month--->
	<cfset MonthTotal = MonthTotal + #qryUniqueDay.RecordCount#>
</cfloop>

<cfset MonthCount = MonthCount + 1>
<cfset ChartString = #ListAppend(ChartString, MonthTotal)#>
<cfset MonthTotal = 0>
</cfloop>
<p>
 <cf_statsChart
	width="800"
	title="Unique Hits (This Year)"
	values="#ChartString#"
	legend="January,February,March,April,May,June,July,August,September,October,November,December"> 

<p>

<cfset ChartString = ''>
<cfset ChartString2 = ''>
<!---Find the number of Unique hits for each month LAST year--->

<cfset MonthCount = 1>
<cfset MonthTotal = 0>

<cfloop From = "1" To="12" Index="Mycount2">

	<!---Query the database to see how many unique hits for last Month/Year--->
	<cfquery name = "qryUniqueDay" Datasource = "#request.dsn#">
	SELECT * FROM stats_archive
	WHERE Month = '#MonthCount#' AND Year = '#LastYear#'
	</cfquery>

	<!---Keep a running total for this month--->
	<cfset MonthTotal = #qryUniqueDay.uniques#>

	<cfset MonthCount = MonthCount + 1>
	<cfset ChartString = #ListAppend(ChartString, MonthTotal)#>
	<cfset MonthTotal = 0>
</cfloop>
<p>
 <cf_statsChart
	width="800"
	title="Unique Hits (#LastYear#)"
	values="#ChartString#"
	legend="January,February,March,April,May,June,July,August,September,October,November,December"> 

<p>


<!---Show the Browsers used chart--->
<table width = "50%">
<tr>
<td Width="50%"></td>
<td Width="50%"></td>
</tr>

<cfset ChartString = ''>
<cfset ChartString2 = ''>

<!---<cfquery name = "qryBrowserList" Datasource = "#request.dsn#">
SELECT DISTINCT Browser FROM stats 
</cfquery>

<cfloop query = "qryBrowserList">

<cfif NOT qryBrowserList.Browser CONTAINS 'bot' AND NOT qryBrowserList.Browser CONTAINS 'crawler' AND NOT qryBrowserList.Browser CONTAINS 'archiver' AND NOT qryBrowserList.Browser CONTAINS 'scooter'>--->

<cfquery name = "qryBrowsersIE" datasource="#request.dsn#">
SELECT * FROM stats
WHERE Browser = 'Internet Explorer'
</cfquery>

<cfquery name = "qryBrowsersMozilla" datasource="#request.dsn#">
SELECT * FROM stats
WHERE Browser = 'Mozilla'
</cfquery>

<cfquery name = "qryBrowsersSafari" datasource="#request.dsn#">
SELECT * FROM stats
WHERE Browser = 'Safari'
</cfquery>

<cfquery name = "qryBrowsersOpera" datasource="#request.dsn#">
SELECT * FROM stats
WHERE Browser = 'Mozilla Firebird'
</cfquery>

<cfquery name = "qryBrowsersUnknown" datasource="#request.dsn#">
SELECT * FROM stats
WHERE Browser = 'Unknown'
</cfquery>

<cfquery name = "qryBrowsersAll" datasource="#request.dsn#">
SELECT * FROM stats
</cfquery>

<cfset TotalNonOther = qryBrowsersIE.recordcount + qryBrowsersMozilla.recordcount + qryBrowsersUnknown.recordcount + qryBrowsersOpera.recordcount>
<cfset TotalOther = qryBrowsersAll.Recordcount - TotalNonOther> 

<!---<cfset ChartString = #ListAppend(ChartString, qryNumberOfBrowsers.RecordCount)#>
<cfset ChartString2 = #ListAppend(ChartString2, qryBrowserList.Browser)#>--->

<cfoutput>
<cfset ChartString = 'Internet Explorer,Mozilla,Opera,Safari,Unknown,Other'>
<cfset ChartString2 = '#qryBrowsersIE.RecordCount#,#qryBrowsersMozilla.Recordcount#,#qryBrowsersOpera.recordcount#,#qryBrowsersSafari.recordcount#,#qryBrowsersUnknown.recordcount#,#TotalOther#'>

</cfoutput>

<!---</cfif>--->

<!---</cfloop>--->

</table>

<cfoutput>
 <cf_statsChart
	width="800"
	title="Browser Types Used"
	values="#ChartString2#"
	legend="#ChartString#"> 
</cfoutput>

  </p>
  <p>&nbsp;</p>
  <cfquery name="qryReferers" datasource="#request.dsn#">
  SELECT * FROM stats
  WHERE Referer > ''
  ORDER BY VisitorID DESC
  </cfquery>
  <table width="75%" border="0" cellpadding="2" cellspacing="0"> 
    <tr>
      <td bgcolor="#003399"><font color="#FFFFFF"><strong>Last 50 Known Referers</strong></font></td>
    </tr>
	<cfoutput query = "qryReferers" maxrows = "50">
	<tr>
      <td><a href="#Referer#" Target="_blank">#Referer#</a></td>
    </tr>
	</cfoutput>
    <tr>
  </table>

<p>
  <cfquery name = "qryBrowserList" Datasource = "#request.dsn#">
	SELECT DISTINCT Browser FROM stats 
   </cfquery>

  <table width="75%" border="0" cellpadding="2" cellspacing="0">
    <tr bgcolor="#003399"> 
      <td colspan="2"><font color="#FFFFFF"><strong>Bots that visited your website</strong></font></td>
    </tr>
    <tr> 
      <td><strong>Last Visit</strong></td>
      <td><strong>Name of Bot</strong></td>
    </tr>
    <cfloop query = "qryBrowserList">
	<cfif qryBrowserList.Browser CONTAINS 'bot' OR qryBrowserList.Browser CONTAINS 'crawler' OR qryBrowserList.Browser CONTAINS 'archiver' OR qryBrowserList.Browser CONTAINS 'scooter'>
      <cfquery name = "qrybots" datasource="#request.dsn#">
      SELECT * FROM stats WHERE Browser = '#qryBrowserList.Browser#' ORDER By 
      datedata ASC 
      </cfquery>
      <cfoutput query = "qryBots" startrow="#qryBots.RecordCount#"> 
        <tr> 
          <td>#datedata#</td>
          <td>#qryBots.Browser#</td>
        </tr>
      </cfoutput> 
	</cfif>
    </cfloop>
  </table>
</div>





