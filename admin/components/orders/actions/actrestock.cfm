<!---restock items that were cancelled--->

<!---Loop over the list and if they are marked cancelled or returned then restock the item--->

<cfloop from = "1" to = "#listlen(shippedlist)#" index="s">
	<!---Get this itemid, it's new status and it's old status--->
	<cfset s_itemid = listgetat(itemids, s)>
	<cfset s_quantity = listgetat(quantities, s)>
	<cfset s_status = listgetat(shippedlist, s)>
	<cfset s_oldstatus = listgetat(shippedlist, s)>
	
	<!---change stock if status changed--->
	<cfif NOT s_status IS s_oldstatus>

		<!---restock if cancelled--->
		<cfif s_status IS 'Cancelled' OR s_status IS 'Returned'>
			<!---get current stock level--->
			<cfquery name = "qryStock" datasource="#request.dsn#">
			SELECT UnitsInStock FROM products WHERE itemid = #s_itemid#
			</cfquery>

			<!---If item still exists in catalog then update stock--->
			<cfif qryStock.recordcount GT 0>			
			
				<cfset newstock = qryStock.UnitsInStock + s_quantity>
				
				<cfquery name = "qryUpdateStock" datasource="#request.dsn#">
				UPDATE products SET UnitsInStock = #newstock#
				WHERE itemid = #s_itemid#
				</cfquery>
			</cfif>
		</cfif>
		
		<!---Take out of stock if item is anything other than cancelled or discontinued--->
		<cfif NOT s_status IS 'Cancelled' AND NOT s_status IS 'Returned' AND NOT s_status IS 'Discontinued'>
			<!---get current stock level--->
			<cfquery name = "qryStock" datasource="#request.dsn#">
			SELECT UnitsInStock FROM products WHERE itemid = #s_itemid#
			</cfquery>

			<!---If item still exists in catalog then update stock--->
			<cfif qryStock.recordcount GT 0>			
				<cfset newstock = qryStock.UnitsInStock - s_quantity>
	
				<!---If result less then zero reset to zero--->
				<cfif newstock LT 0>
					<cfset newstock = 0>
				</cfif>
				
				<cfquery name = "qryUpdateStock" datasource="#request.dsn#">
				UPDATE products SET UnitsInStock = #newstock#
				WHERE itemid = #s_itemid#
				</cfquery>
			</cfif>
		</cfif>
	
		
		<!---If item is dicontinued set stock to zero--->
		<cfif NOT s_status IS 'Discontinued'>
			<cfquery name = "qryUpdateStock" datasource="#request.dsn#">
			UPDATE products SET UnitsInStock = 0
			WHERE itemid = #s_itemid#
			</cfquery>
		</cfif>
	</cfif>
</cfloop>



















