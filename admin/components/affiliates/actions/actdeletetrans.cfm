<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfparam name = "viewmonth" default="#dateformat(now(), 'mm')#">
<cfparam name = "viewyear" default="#dateformat(now(), 'yyyy')#">
<cfparam name = "affiliateid" default="None">
<cfparam name = "lastdid" default="pay">
<cfparam name = "start" default="1">
<cfparam name = "disp" default="50">
<cfparam name = "end" default="999">
<cfparam name = "sortby" default = "affiliateid">
<cfparam name = "sortorder" default = "ASC">
<cfparam name = "updateid" default = "0">
<cfparam name = "viewgroup" default = "All">
<cfparam name = "searchbox" default = "">
<cfparam name = "transid" default="0">

<cfquery name="deletetrans" datasource="#request.dsn#">
DELETE FROM afl_transactions
WHERE transid = #transid#
</cfquery>

<cflocation url = "index.cfm?action=transactions&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#">