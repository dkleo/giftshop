<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif isdefined('form.Approved')>
<cfloop from = "1" to = "#listlen(form.Approved)#" index="a">
	<cfset thisApproved = listgetat(form.Approved, a)>

    <cfquery name = "qryUpdateApproved" datasource="#request.dsn#">
    UPDATE product_reviews
    SET approved = 'Yes'
    WHERE ID = #thisApproved#
    </cfquery>

	<!---get all approved reviews and calculate the rating and insert total reviews into products table--->
	<cfquery name = "qryFindReview" datasource="#request.dsn#">
    SELECT * FROM product_reviews
    WHERE id = #thisApproved#
    </cfquery>

	<cfquery name = "qryReviewsForItem" datasource="#request.dsn#">
    SELECT * FROM product_reviews
    WHERE itemid = '#qryFindReview.itemid#'
    </cfquery>

	<!---update product with totals--->
	<cfset totalrating = 0>
    <cfset totalreviews = 0>
    
	<cfoutput query="qryReviewsForItem">
        <cfset totalrating = totalrating + rating>
    	<cfset totalreviews = totalreviews + 1>
	</cfoutput>
    
    <cfif NOT totalrating IS 0>
        <cfset avgrating = totalrating / qryReviewsForItem.recordcount>
    <cfelse>
        <cfset avgrating = 0.00>
    </cfif>	

	<cfquery name = "qryUpdateItem" datasource="#request.dsn#">
    UPDATE products
    SET reviews = #totalreviews#,
    rating = #avgrating#
    WHERE itemid = #qryFindReview.itemid#
    </cfquery>

</cfloop>
</cfif>

<cflocation url = "index.cfm?start=#form.start#&disp=#form.disp#&viewtype=#form.viewtype#">















