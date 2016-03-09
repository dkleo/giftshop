<!---Archives Selected Orders--->
<!---Loop over the items that need to be archived and mark them as archived--->
<cfif ISDEFINED('form.OrderCompleted')>
<cfloop index="LoopIndex" FROM="1" TO="#ListLen(form.OrderCompleted)#">
	<cfset UpdateThisItem = ListGetAt(#form.OrderCompleted#, LoopIndex)>

	<cfquery name = "ChangeToCompleted" datasource = "#request.dsn#">
		UPDATE orders
		SET OrderCompleted = 'Yes'
		WHERE OrderID = #UpdateThisItem#
	</cfquery>
</cfloop>
</cfif>

<cflocation URL="doorders.cfm">



















