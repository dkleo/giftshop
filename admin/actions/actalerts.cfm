<!---File figures out if there is anything that needs the users attention--->
<cfset TotalAlerts = 0>

<!---Check the settings table and see if they have an email address entered--->
<cfquery name = "qryCompanyinfo" datasource="#request.dsn#">
SELECT * FROM companyinfo
</cfquery>

<!---Get New Orders--->
<cfquery name = "qryNewOrders" datasource="#request.dsn#">
SELECT * FROM orders WHERE OrderStatus = <cfqueryparam value="Received" cfsqltype="cf_sql_varchar"> 
AND NOT OrderCompleted = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
AND paid = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
</cfquery>

<!---Check for categories--->
<cfquery name = "qryCategories" datasource="#request.dsn#">
SELECT * FROM categories
</cfquery>

<!---Check for Products--->
<cfquery name = "qryProducts" datasource="#request.dsn#">
SELECT * FROM products
</cfquery>

<!---Check for affiliate messages--->
<cfquery name = "qryMessages" datasource="#request.dsn#">
SELECT * FROM afl_messages WHERE wasread = <cfqueryparam value="No" cfsqltype="cf_sql_varchar">
</cfquery>

<table width="100%" cellpadding="2" cellspacing="0" align="center">

<!---Check to make sure they have an email address specified--->
<cfif len(request.emailaddress) IS 0>
	<cfset TotalAlerts = TotalAlerts + 1>
	<cfoutput>
<tr>
<td width = "25" align="center">
	<img src = "images/attention_red.gif"> 
</td>
<td valign="middle">You need to specify an email address in your <a href = "#request.AdminPath#setup/dosetup.cfm">setting</a>.
</td>
</tr>
	</cfoutput>
</cfif>

<!---Check for new orders--->
<cfif qryNewOrders.recordcount GT 0>
	<cfset TotalAlerts = TotalAlerts + 1>
	<cfoutput>
<tr>
<td width = "25" align="center">
	<img src = "images/attention_yellow.gif"> 
</td>
<td valign="middle">You have new orders! <a href = "#request.AdminPath#components/orders/doorders.cfm">View them here</a>.
</td>
</tr>
	</cfoutput>
</cfif>

<!---Check for Categories--->
<cfif qryCategories.recordcount LT 1>
	<cfset TotalAlerts = TotalAlerts + 1>
<cfoutput>
<tr>
<td width = "25" align="center">
	<img src = "images/attention_red.gif"> 
</td>
<td valign="middle">You do not have any categories setup for you catalog.  <a href = "#request.AdminPath#components/categories/docategories.cfm">Set them up here</a>.
</td>
</tr>
	</cfoutput>
</cfif>

<!---Check for Products--->
<cfif qryProducts.recordcount LT 1>
	<cfset TotalAlerts = TotalAlerts + 1>
	<cfoutput>
<tr>
<td width = "25" align="center">
	<img src = "images/attention_red.gif"> 
</td>
<td valign="middle">You do not have any products in your catalog.  <a href = "#request.AdminPath#components/products/doproducts.cfm?action=add">Add one now</a>.
</td>
</tr>
	</cfoutput>
</cfif>

<!---Check for Affiliate Messages--->
<cfif qrymessages.recordcount GT 0>
	<cfset TotalAlerts = TotalAlerts + 1>
	<cfoutput>
<tr>
<td width = "25" align="center">
	<img src = "images/attention_yellow.gif"> 
</td>
<td valign="middle">You have one or more messages from your affiliates.  <a href = "#request.AdminPath#components/affiliates/index.cfm?action=messages">Read them now</a>.
</td>
</tr>
	</cfoutput>
</cfif>

<!---If no alerts then display a tip from the database--->
<cfquery name="qTips" datasource="#request.dsn#">
	SELECT * from tips
</cfquery>

<cfset displayRow = randRange(1,qTips.recordcount)>

<cfoutput query = "qTips" startrow="#displayRow#" maxrows="1">
<tr>
<td width = "25" align="center">
	<img src = "images/attention_green.gif"> 
</td>
<td valign="middle">Tip: #tipcontent#
</td>
</tr>
</cfoutput>
</table>