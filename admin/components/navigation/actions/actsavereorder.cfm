<cfloop from = "1" to="#ListLen(form.LinkOrderBox)#" index="ordercount">
	<cfset ThisID = #ListGetAt(form.LinkOrderBox, ordercount)#>
	<cfquery name = "qrySetOrderValue" datasource="#request.dsn#">
	UPDATE nav_links
	SET OrderValue = #ordercount#
	WHERE ID = #ThisID#
	</cfquery>
</cfloop>

<cflocation url = "index.cfm?action=navigation.files.defaultaction&nView=#url.nView#&mView=#url.mView#&level=#level#">



















