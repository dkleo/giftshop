<cfparam name = "Sortby" default="DateOfOrder">
<cfparam name = "SortOrder" default = "ASC">

<!---Call this query if the reportyear and reportmonth variables are not present--->
<cfif NOT ISDEFINED('TempVar.reportYear') AND NOT ISDEFINED('TempVar.reportmonth')>
    <CFQUERY Name ="qryArchives" DATASOURCE = "#request.dsn#">
    SELECT *
    FROM orders
    <cfif NOT isdefined('url.OrderID')>WHERE OrderCompleted = 'Yes' AND paid = '#paid#'</cfif>
    <cfif isdefined('url.OrderID')>WHERE OrderID = #url.OrderID# AND paid = '#paid#'</cfif>
    <cfif NOT Sortby IS 'LastName'>
        ORDER BY #SortBy# #SortOrder#
    </cfif>
    </CFQUERY>
</cfif>
    
<!---qry All Archives--->
<CFQUERY Name ="qryAllArchives" DATASOURCE = "#request.dsn#">
SELECT *
FROM orders
WHERE OrderCompleted = 'Yes' AND paid = '#paid#'
ORDER BY DateOfOrder ASC
</CFQUERY>


<!---=======BEGIN CUSTOM QUERY =====--->

<!---In order to ensure compatability with both access and mysql (or any other database format for that
matter), we cannot query the database with the datepart function.  Instead we must build a custom query
by querying the archived orders then selecting each one that matches the month and year and putting them
into our custom query.  The code below builds that custom query (which, of course, will be called 
qryArchives).  

NOTE:  If you use an Access database you can simply use the code below.  As far as I know, this query
will only work with MS Access.  It does not work with MySQL and it probably doesn't work with MS SQL
either.  If you use it, comment out or delte everything else.

--- Access Code ----

<CFQUERY Name ="qryArchives" DATASOURCE = "#request.dsn#">
 	SELECT *
	FROM Orders
	WHERE OrderCompleted = 'Yes'
	<cfif ISDEFINED('TempVar.reportmonth')><cfif NOT TempVar.reportmonth IS '99'>AND (((DatePart('m', [DateofOrder]))=#TempVar.ReportMonth#))</cfif></cfif>
	<cfif ISDEFINED('TempVar.reportYear')>AND (((DatePart('yyyy', [DateofOrder]))=#TempVar.ReportYear#))</cfif>
	ORDER BY DateOfOrder DESC
</CFQUERY>

--->

<cfif ISDEFINED('TempVar.reportYear') AND ISDEFINED('TempVar.reportmonth')>
<!---Build a query based on the year and the month selected (or entire year if no month selected--->

<cfset qryArchives = QueryNew("")>
<cfset listofvars = "">
<cfset listofcols = "">

<!---Now query all the archived orders--->
<CFQUERY Name ="qryEveryArchived" DATASOURCE = "#request.dsn#">
SELECT *
FROM orders
WHERE OrderCompleted = 'Yes' AND paid = '#paid#'
</CFQUERY>

<!---Create empty lists--->
<cfloop from = "1" to="#listlen(qryEveryArchived.columnlist)#" index="lst">
	<cfset thiscol = #listgetat(qryEveryArchived.columnlist, lst)#>
	<cfset thisvar = "L#thiscol#">
	<cfset listofvars = ListAppend(listofvars, thisvar, "|")>
	<cfset listofcols = ListAppend(listofcols, thiscol, "|")>
	<cfset "L#thiscol#" = "">
</cfloop>

<!---Loop over each order and see if it matches the selected month and year.  If so add it to
the list.--->
<cfoutput query = "qryEveryArchived">

<!---If a month is selected, then find those matching the month and year--->
<cfif NOT TempVar.reportmonth IS '99'>
	<cfif #DatePart('m', DateofOrder)# IS #TempVar.ReportMonth# AND #DatePart('yyyy', DateofOrder)# IS #TempVar.ReportYear#>

			<!---Loop over the list of variables and insert and append to each one--->
			<cfloop from = "1" to="#listlen(listofvars, '|')#" index="v">
				<cfset thisvar = listgetat(listofvars, v, '|')>
				<!---get the corresponding column name in the db--->
				<cfset thiscol = listgetat(listofcols, v, '|')>
				<cfset valuetoget = "qryEveryArchived.#thiscol#">
				<cfset "#thisvar#" = listappend(evaluate(thisvar), evaluate(valuetoget), '|')>
			</cfloop>
	</cfif>
</cfif>

<!---If a year is selected, then find those matching the year--->
<cfif TempVar.reportmonth IS '99'>
	<cfif #DatePart('yyyy', DateofOrder)# IS #TempVar.ReportYear#>
			<!---Loop over the list of variables and insert and append to each one--->
			<cfloop from = "1" to="#listlen(listofvars, '|')#" index="v">
				<cfset thisvar = listgetat(listofvars, v, '|')>
				<!---get the corresponding column name in the db--->
				<cfset thiscol = listgetat(listofcols, v, '|')>
				<cfset valuetoget = "qryEveryArchived.#thiscol#">
				<cfset "#thisvar#" = listappend(evaluate(thisvar), evaluate(valuetoget), '|')>
			</cfloop>
	</cfif>
</cfif>

</cfoutput>

<cfset listofarrays = "">

<!---Now make each list an array so it can be converted into a column in the custom query--->
<cfloop from = "1" to="#listlen(listofvars, '|')#" index="v">
	<cfset thisvar = listgetat(listofvars, v, '|')>
	<cfset thiscol = listgetat(listofcols, v, '|')>
	<cfset thisarray = listtoarray(evaluate(thisvar), '|')>
	<cfset arrayname = "A#thiscol#">
	<cfset "#arrayname#" = #thisarray#>
	<cfset listofarrays = listappend(listofarrays, "#arrayname#", "|")>
</cfloop>

<!---insert each array into the query--->
<cfloop from = "1" to="#listlen(listofarrays, '|')#" index="v">
	<cfset thisarray = listgetat(listofarrays, v, '|')>
	<cfset thiscol = listgetat(listofcols, v, '|')>
	<cfset "nColumnNumber#v#" = QueryAddColumn(qryArchives, "#thiscol#", #evaluate(thisarray)#)>
</cfloop>
</CFIF>

<cfset qryOrders = qryArchives>

















