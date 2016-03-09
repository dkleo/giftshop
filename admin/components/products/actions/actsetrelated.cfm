<!---loop over the list and set the item--->
<cfset newlist = ''>

<cfquery name = "GetList" datasource="#request.dsn#">
SELECT * FROM products 
WHERE itemid = #url.ritem#
</cfquery>

<cfoutput query = "GetList">
	<cfset newlist = #similaritems#>
</cfoutput>

<cfif ISDEFINED('form.addrelated')>
	<cfloop from="1" To="#ListLen(form.addrelated)#" index="MyCount">
		<cfset ThisItemID = #ListGetAt(form.addrelated, MyCount)#>
		
		<cfset newlist = listappend(newlist, ThisItemID, "^")>
		
		<cfquery name = "UpdateOrderValues" datasource="#request.dsn#">
		UPDATE products
		SET similaritems = '#newlist#'
		WHERE ItemID = #url.ritem#
		</cfquery>
	</cfloop>
</cfif>

<cflocation url = "doproducts.cfm?action=relateditems&ritem=#url.ritem#">

















