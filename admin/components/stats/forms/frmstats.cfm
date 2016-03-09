<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
<h2>Website Stats</h2>
<!---get stats for the current month and year--->

<cfparam name = "start_day" default = "1">
<cfparam name = "start_month" default = "#dateformat(now(), 'm')#">
<cfparam name = "start_year" default = "#dateformat(now(), 'yyyy')#">

<cfparam name = "end_day" default = "#dateformat(now(), 'd')#">
<cfparam name = "end_month" default = "#dateformat(now(), 'm')#">
<cfparam name = "end_year" default = "#dateformat(now(), 'yyyy')#">

<cfset start_date = createdate(start_year, start_month, start_day)>
<cfset end_date = createdate(end_year, end_month, end_day)>

<cfset c_unique = 0>
<cfset c_views = 0>
<cfset c_sales = 0>
<cfset c_clicks = 0>
<cfset c_earnings = 0.00>

<!---get page views and unique hits for current dates--->
<cfquery name = "qHits" datasource="#request.dsn#">
SELECT SUM(unique_hits) AS totalunique, SUM(page_views) AS totalpageviews FROM stats_hits
WHERE stats_date >= #createodbcdate(start_date)# AND stats_date <= #createodbcdate(end_date)#
</cfquery>

<cfquery name = "qClicks" datasource="#request.dsn#">
SELECT SUM(carts) AS totalcarts FROM stats_clicks
WHERE stats_date >= #createodbcdate(start_date)# AND stats_date <= #createodbcdate(end_date)#
</cfquery>

<cfquery name = "qYears" datasource="#request.dsn#">
SELECT DISTINCT stats_year AS syear FROM stats_hits
</cfquery>

<cfquery name = "qOrders" datasource="#request.dsn#">
SELECT * FROM orders 
WHERE OrderStatus = 'Completed' 
AND Paid='Yes' 
AND DATE(DateOfOrder) >= #createodbcdate(start_date)# 
AND DATE(DateOfOrder) <= #createodbcdate(end_date)#
</cfquery>

<!---get browser counts--->
<cfquery name = "qBrowsers" datasource="#request.dsn#">
SELECT SUM(hit_count) AS browsercount, user_agent FROM stats_useragents
WHERE stats_date >= #createodbcdate(start_date)# AND stats_date <= #createodbcdate(end_date)#
GROUP BY user_agent
ORDER BY browsercount DESC
</cfquery>

<!---get referrer counts--->
<cfquery name = "qReferrers" datasource="#request.dsn#">
SELECT SUM(hit_count) AS refcount, referrer FROM stats_referrers
WHERE stats_date >= #createodbcdate(start_date)# AND stats_date <= #createodbcdate(end_date)#
GROUP BY referrer
ORDER BY refcount DESC
</cfquery>

<cfquery name = "qOrderSum" datasource="#request.dsn#">
SELECT SUM(ordertotal) AS totalofsales FROM orders
WHERE OrderStatus = 'Completed' 
AND Paid='Yes' 
AND DATE(DateOfOrder) >= #createodbcdate(start_date)# 
AND DATE(DateOfOrder) <= #createodbcdate(end_date)#
</cfquery>

<cfoutput query = "qHits">
  <cfif len(trim(qHits.totalunique)) GT 0>
		<cfset c_unique = qHits.totalunique>
  </cfif>
  <cfif len(trim(qHits.totalpageviews)) GT 0>
	    <cfset c_views = qHits.totalpageviews>
  </cfif>
</cfoutput>

<cfoutput query = "qClicks">
  <cfif len(trim(qClicks.totalcarts)) GT 0>
		<cfset c_clicks = qClicks.totalcarts>
  </cfif>
</cfoutput>

<cfoutput query = "qOrderSum">
  <cfif len(trim(qOrderSum.totalofsales)) GT 0>
		<cfset c_earnings = qOrderSum.totalofsales>
  </cfif>
</cfoutput>

<cfset c_sales = qOrders.recordcount>

<form name="form1" method="post" action="index.cfm">
Start Date:
<select name="start_month" id="start_month">
    <option value="1"<cfif start_month eq 1> selected="selected"</cfif>>January</option>
    <option value="2"<cfif start_month eq 2> selected="selected"</cfif>>February</option>
    <option value="3"<cfif start_month eq 3> selected="selected"</cfif>>March</option>
    <option value="4"<cfif start_month eq 4> selected="selected"</cfif>>April</option>
    <option value="5"<cfif start_month eq 5> selected="selected"</cfif>>May</option>
    <option value="6"<cfif start_month eq 6> selected="selected"</cfif>>June</option>
    <option value="7"<cfif start_month eq 7> selected="selected"</cfif>>July</option>
    <option value="8"<cfif start_month eq 8> selected="selected"</cfif>>August</option>
    <option value="9"<cfif start_month eq 9> selected="selected"</cfif>>September</option>
    <option value="10"<cfif start_month eq 10> selected="selected"</cfif>>October</option>
    <option value="11"<cfif start_month eq 11> selected="selected"</cfif>>November</option>
    <option value="12"<cfif start_month eq 12> selected="selected"</cfif>>December</option>
</select>

<select name = "start_day" id="start_day">
    <cfloop from = "1" to="31" index="d">
        <cfoutput><option value="#d#" <cfif start_day IS d>selected="selected"</cfif>>#d#</option></cfoutput>
    </cfloop>
</select>

<select name="start_year" id="start_year" onChange="this.form.submit();">
	<cfoutput query = "qYears">
        <option value="#qYears.syear#"<cfif qYears.syear IS start_year> selected="selected"</cfif>>#qYears.syear#</option>
    </cfoutput>
 </select> 

&nbsp;&nbsp; End Date: 
<select name="end_month" id="end_month">
    <option value="1"<cfif end_month eq 1> selected="selected"</cfif>>January</option>
    <option value="2"<cfif end_month eq 2> selected="selected"</cfif>>February</option>
    <option value="3"<cfif end_month eq 3> selected="selected"</cfif>>March</option>
    <option value="4"<cfif end_month eq 4> selected="selected"</cfif>>April</option>
    <option value="5"<cfif end_month eq 5> selected="selected"</cfif>>May</option>
    <option value="6"<cfif end_month eq 6> selected="selected"</cfif>>June</option>
    <option value="7"<cfif end_month eq 7> selected="selected"</cfif>>July</option>
    <option value="8"<cfif end_month eq 8> selected="selected"</cfif>>August</option>
    <option value="9"<cfif end_month eq 9> selected="selected"</cfif>>September</option>
    <option value="10"<cfif end_month eq 10> selected="selected"</cfif>>October</option>
    <option value="11"<cfif end_month eq 11> selected="selected"</cfif>>November</option>
    <option value="12"<cfif end_month eq 12> selected="selected"</cfif>>December</option>
</select>

<select name = "end_day" id="end_day">
    <cfloop from = "1" to="31" index="d">
        <cfoutput><option value="#d#" <cfif end_day IS d>selected="selected"</cfif>>#d#</option></cfoutput>
    </cfloop>
</select>

<select name="end_year" id="end_year">
	<cfoutput query = "qYears">
        <option value="#qYears.syear#"<cfif qYears.syear IS end_year> selected="selected"</cfif>>#qYears.syear#</option>
    </cfoutput>
 </select> 

<input type = "submit" value="Update Report" name="sbmtbtn">
</form>


<table width="800" cellpadding="2" cellspacing="0">
<tr>
<td>
<cfchart format="jpg" scalefrom="0" chartwidth="550" title="Overview: #dateformat(start_date, 'mmm dd, yyyy')# to #dateformat(end_date, 'mmm dd, yyyy')#" fontsize="14">
    
	<cfchartseries type="horizontalbar" colorlist="Green,Blue,Purple,Red">    
    	
        <cfchartdata value="#c_unique#">
        <cfchartdata value="#c_views#">
        <cfchartdata value="#c_clicks#">
        <cfchartdata value="#c_sales#">
    
    </cfchartseries>
</cfchart></td>
<td width="250" valign="top" style="padding-top: 50px;">
	<cfoutput>
	<table width="100%" cellpadding="6" cellspacing="5">
    <tr>
        <td width="5%" bgcolor="Green">&nbsp;</td>
    	<td>Unique Hits</td>
        <td width="10%"><strong>#c_unique#</strong></td>
    </tr>
    <tr>
        <td width="5%" bgcolor="Blue">&nbsp;</td>
    	<td>Page Views</td>
        <td><strong>#c_views#</strong></td>
    </tr>
    <tr>
        <td width="5%" bgcolor="Purple">&nbsp;</td>
    	<td>Shopping Carts</td>
        <td><strong>#c_clicks#</strong></td>
    </tr>
    <tr>
        <td width="5%" bgcolor="Red">&nbsp;</td>
    	<td>Sales (#dollarformat(c_earnings)#)*</td>
        <td><strong>#c_sales# </strong></td>
    </tr>
	</table>
	</cfoutput></td>
</tr>
<tr>
  <td>
	<p>* Sales count shown includes only orders marked as paid and completed.	</p>
	<p>&nbsp;</p></td>
  <td style="padding: 10px;"></td>
</tr>
<tr>
  <td colspan="2" style="border-top: solid 1px #999999;">
  	<cfoutput>
  	  <h3>Orders From #dateformat(start_date, 'mmm dd, yyyy')# to #dateformat(end_date, 'mmm dd, yyyy')#</h3>
  	</cfoutput>  </td>
  </tr>
<tr>
  <td colspan="2" style="padding: 10px;"><table width="100%" border="0" cellspacing="0" cellpadding="6">
    <tr>
      <td bgcolor="#000000"><span class="style1">Date</span></td>
      <td bgcolor="#000000"><span class="style1">Order Number</span></td>
      <td bgcolor="#000000"><span class="style1">Name</span></td>
      <td bgcolor="#000000"><span class="style1">Taxes</span></td>
      <td bgcolor="#000000"><span class="style1">Shipping</span></td>
      <td bgcolor="#000000"><span class="style1">Total</span></td>
    </tr>
	<cfset tax_total = 0>
    <cfset ship_total = 0>
    <cfset orders_total = 0>
    
    <cfoutput query="qOrders">
    <tr>
      <td>#dateformat(qOrders.dateoforder, "mm/dd/yyyy")#</td>
      <td>#qOrders.ordernumber#</td>
      <td>#qOrders.shipfirstname# #left(qOrders.shiplastname, 1)#</td>
      <td>#qOrders.figuredtax#</td>
      <td>#qOrders.quotedshipping#</td>
      <td>#qOrders.ordertotal#</td>    
    </tr>
    <cfset tax_total = tax_total + qOrders.figuredtax>
    <cfset ship_total = ship_total + qOrders.quotedshipping>
    <cfset orders_total = orders_total + qOrders.ordertotal>
	</cfoutput>
    <!---totals--->
    <cfoutput>
  	<tr>
    	<td style="border-top: 1px ##666666 solid;"><strong>TOTALS</strong></td>
    	<td style="border-top: 1px ##666666 solid;">&nbsp;</td>
    	<td style="border-top: 1px ##666666 solid;">&nbsp;</td>
    	<td style="border-top: 1px ##666666 solid;"><strong>#dollarformat(tax_total)#</strong></td>
    	<td style="border-top: 1px ##666666 solid;"><strong>#dollarformat(ship_total)#</strong></td>
    	<td style="border-top: 1px ##666666 solid;"><strong>#dollarformat(orders_total)#</strong></td>        
    </tr>
    </cfoutput>                          
  </table></td>
</tr>
<tr>
  <td colspan="2" style="border-top: solid 1px #999999;"><h3>Browsers</h3>

<cfchart format="jpg" scalefrom="1" chartwidth="800" title="Top 5 Browsers (#dateformat(start_date, 'mmm dd, yyyy')# to #dateformat(end_date, 'mmm dd, yyyy')#)" fontsize="14">
    
	<cfchartseries type="bar" colorlist="Green,Blue,Purple,Red,Yellow">    
    
    <cfoutput query = "qBrowsers" maxrows="5">	
    
    <cfset this_agent = 'Other'>	
	<cfif findNoCase("iphone", qBrowsers.user_agent)>
    	<cfset this_agent = 'iPhone'>
    </cfif>
	<cfif findNoCase("MSIE", qBrowsers.user_agent)>
    	<cfset this_agent = 'Internet Explorer'>
    </cfif>
	<cfif findNoCase("Firefox", qBrowsers.user_agent)>
    	<cfset this_agent = 'Firefox'>
    </cfif>
	<cfif findNoCase("Chrome", qBrowsers.user_agent)>
    	<cfset this_agent = 'Google Chrome'>
    </cfif>
	<cfif findNoCase("Opera", qBrowsers.user_agent)>
    	<cfset this_agent = 'Opera'>
    </cfif>
	<cfif findNoCase("Netscape", qBrowsers.user_agent)>
    	<cfset this_agent = 'Netscape'>
    </cfif>
	<cfif findNoCase("Navigator", qBrowsers.user_agent)>
    	<cfset this_agent = 'Netscape'>
    </cfif>
	<cfif findNoCase("Safari", qBrowsers.user_agent)>
    	<cfset this_agent = 'Safari'>
    </cfif>
	<cfif findNoCase("Android", qBrowsers.user_agent)>
    	<cfset this_agent = 'Android'>
    </cfif>
	<cfif findNoCase("Flock", qBrowsers.user_agent)>
    	<cfset this_agent = 'Flock'>
    </cfif>
	<cfif findNoCase("Konqueror", qBrowsers.user_agent)>
    	<cfset this_agent = 'Konqueror'>
    </cfif>
	<cfif findNoCase("Slurp", qBrowsers.user_agent)>
    	<cfset this_agent = 'Yahoo Slurp'>
    </cfif>
	<cfif findNoCase("Google", qBrowsers.user_agent)>
    	<cfset this_agent = 'Google Bot'>
    </cfif>
            
        <cfchartdata item="#this_agent#" value="#qBrowsers.browsercount#">
    </cfoutput>

	<cfif qBrowsers.recordcount LT 5>
	<cfloop from="#qBrowsers.recordcount#" to="5" index="i">
		<cfchartdata item=" " value="0">
    </cfloop>
    </cfif>
    </cfchartseries>
</cfchart></td>
</tr>
<tr>
  <td colspan="2" style="border-top: solid 1px #999999;"><h3>Referring Websites</h3>

<cfchart format="jpg" scalefrom="1" chartwidth="800" title="Top 5 Referrers (#dateformat(start_date, 'mmm dd, yyyy')# to #dateformat(end_date, 'mmm dd, yyyy')#)" fontsize="14">
    
	<cfchartseries type="bar" colorlist="Green,Blue,Purple,Red,Yellow">    
    
    <cfoutput query = "qReferrers" maxrows="5">	
	  <cfset r_domain = listgetat(qReferrers.referrer, 1, "?")>
      <cfset r_domain = replacenocase(r_domain, 'http://www.', '', 'ONE')>
      <cfset r_domain = replacenocase(r_domain, 'http://', '', 'ONE')>
      <cfset r_domain = listgetat(r_domain, 1, "/")>
        <cfchartdata item="#r_domain#" value="#qReferrers.refcount#">
    </cfoutput>

	<cfif qReferrers.recordcount LT 5>
	<cfloop from="#qReferrers.recordcount#" to="5" index="i">
		<cfchartdata item=" " value="0">
    </cfloop>
    </cfif>
    </cfchartseries>
</cfchart>
</td>
</tr>
<tr>
  <td colspan="2" style="border-top: solid 1px #999999;"><h3>Search Terms</h3>

  <table width="100%" cellpadding="6" cellspacing="0">
  <cfoutput query = "qReferrers">
  
  <cfif qReferrers.referrer CONTAINS '?p=' OR qReferrers.referrer CONTAINS '?q=' OR qReferrers.referrer CONTAINS '&q=' OR qReferrers.referrer CONTAINS '&p=' >
  
  <!---extract the search terms from the url--->
  <cfset r_domain = listgetat(qReferrers.referrer, 1, "?")>
  <cfset r_domain = replacenocase(r_domain, 'http://www.', '', 'ONE')>
  <cfset r_domain = replacenocase(r_domain, 'http://', '', 'ONE')>
  <cfset r_domain = listgetat(r_domain, 1, "/")>
  <cfif listlen(qReferrers.referrer, "?") GT 1>
  	<cfset r_query = listgetat(qReferrers.referrer, 2, "?")>
  <cfelse>
  	<cfset r_query = qReferrers.referrer>
  </cfif>
  
  <cfset r_query = replace(r_query, "&", "|&", "ALL")>

  <cfset list_count = 0>
  <cfloop list="#r_query#" delimiters="|" index="list_item">
  <cfset list_count = list_count + 1>
  <cfif left(list_item, 3) IS '&q=' OR left(list_item, 3) IS '&p=' OR left(list_item, 2) IS 'q=' OR left(list_item, 2) IS 'p='>
    <cfset r_searchwords = replacenocase(list_item, "&p=", "")>
    <cfset r_searchwords = replacenocase(r_searchwords, "&q=", "")>
    <cfset r_searchwords = replacenocase(r_searchwords, "?q=", "")>   
    <cfset r_searchwords = replacenocase(r_searchwords, "?p=", "")>
    <cfset r_searchwords = replacenocase(r_searchwords, "p=", "")>
    <cfset r_searchwords = replacenocase(r_searchwords, "q=", "")>
  </cfif>
  </cfloop>
  

	<tr>
    	<td>
		#urldecode(r_searchwords)#	        	
        </td>
        <td width="25%">
        	#r_domain#
        </td>
        <td width="10%">
        #qReferrers.refcount#
        </td>
    </tr>

  </cfif>
  </cfoutput>
  </table>
  
  </td>
</tr>
</table>
