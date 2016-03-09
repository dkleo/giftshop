<cfinclude template = "../queries/qrycompanyinfo.cfm">

<!---Loop over the items that need to be unarchived and mark them as unarchived--->
<cfif ISDEFINED('form.OrderCompleted')>
<cfloop index="LoopIndex" FROM="1" TO="#ListLen(form.OrderCompleted)#">
	<cfset UpdateThisItem = ListGetAt(#form.OrderCompleted#, LoopIndex)>
	<cfquery name = "ChangeToCompleted" datasource = "#request.dsn#">
		UPDATE orders
		SET OrderCompleted = 'No'
		WHERE OrderID = #UpdateThisItem#
	</cfquery>
</cfloop>
</cfif>
Archives were updated!
<p>
<cfinclude template = "../forms/frmarchives.cfm">




















