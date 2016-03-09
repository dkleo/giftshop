<cfif isdefined('form.Approved')>
<cfloop from = "1" to = "#listlen(form.Approved)#" index="a">
	<cfset thisApproved = listgetat(form.Approved, a)>
	
    <cfquery name = "qryUpdateApproved" datasource="#request.dsn#">
    DELETE FROM product_reviews
    WHERE ID = #thisApproved#
    </cfquery>

</cfloop>
</cfif>
<cflocation url = "index.cfm?start=#form.start#&disp=#form.disp#&viewtype=#form.viewtype#">















