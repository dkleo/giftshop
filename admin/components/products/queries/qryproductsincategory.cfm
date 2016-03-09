<!---queries just the products in a specified category--->
<cfquery name = "qryAllproducts" datasource="#request.dsn#">
SELECT * FROM products
</cfquery>		

<cfset colnames = qryAllProducts.ColumnList>

<cfloop from = "1" to="#listlen(colnames)#" index="mycount">
	<cfset thiscol = listgetat(colnames, mycount)>
	<cfset "L#thiscol#" = "">
</cfloop>
	
	<cfset qryproducts = QueryNew("")>
	
<cfoutput query = "qryALLproducts">
	
<!---Get the category list for this product and loop over the list.  If the list contains
the selected category, add it to the query of products to display--->
<cfset CategoryList = '#Category#'>
<cfloop index="Mycount" From="1" To='#ListLen(CategoryList, "^")#'>	
	<cfset ThisCategory = '#ListGetAt(CategoryList, mycount, "^")#'>
	
	<cfif ThisCategory IS #SortOption#>
		  
	<cfloop from = "1" to="#listlen(colnames)#" index="mycount">
		<cfset thiscol = listgetat(colnames, mycount)>
		<cfset thisList = "L#thiscol#">
		<cfset "L#thiscol#" = ListAppend(evaluate(thisList), "#evaluate(thiscol)#", "|")>
	</cfloop>
	</cfif>
</cfloop>

</cfoutput>

<cfloop from = "1" to="#listlen(colnames)#" index="mycount">
	<cfset thiscol = listgetat(colnames, mycount)>	
	<cfset thisList = "L#thiscol#">
	<cfset "A#thiscol#"= ListToArray(evaluate(thisList), "|")>
</cfloop>
	<!---Now create a query based on the list values above--->
<cfloop from = "1" to="#listlen(colnames)#" index="mycount">
	<cfset thiscol = listgetat(colnames, mycount)>
	<cfset thisArray = "A#thiscol#">	
	<cfset "nColumnNumber#mycount#" = QueryAddColumn(qryproducts, "#thiscol#", evaluate(thisArray))>
</cfloop>















