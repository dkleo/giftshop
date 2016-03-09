<cfquery name = "qryorders" datasource="#request.dsn#">
SELECT * FROM orders WHERE paid = 'Yes'
</cfquery>

<CFQUERY Name ="qrySales" datasource = "#request.dsn#">
SELECT * FROM orders
Where Paid = 'yes'
order By DateOforder ASC
</CFQUERY>

<cfset TotalSales = 0>

<cfoutput query="qrySales">
    <cfset TotalSales = TotalSales + orderTotal>
</cfoutput>

<strong>You have had a total of <cfoutput>#qryorders.recordcount#</cfoutput> orders placed in your store.</strong>
<br>

<cfset statlist = 'Received,Updated,In Process,Completed,On Hold'>

<cfloop list="#statlist#" index="this_status">

	<cfquery name="qStatusCount" dbtype="query">
	SELECT * FROM qryorders WHERE orderStatus = '#this_status#'
	</cfquery>
	
    <cfoutput>Orders #this_status#: <a href = "components/orders/doorders.cfm">#qStatusCount.recordcount#</a><br></cfoutput>
    
 </cfloop>
 <br>
<cfoutput><strong>Total of Sales To Date:</strong>  <cfif request.EnableEuro IS 'Yes'>#lseurocurrencyformat(TotalSales, "Local")#<cfelse>#lscurrencyformat(TotalSales, "Local")#</cfif></cfoutput>