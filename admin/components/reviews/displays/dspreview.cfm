<cfinclude template = "../queries/qryreviews.cfm">

<cfquery name = "qryProduct" datasource="#request.dsn#">
SELECT productname FROM products
WHERE itemid = #qryReviews.itemid#
</cfquery>

<cfoutput><h2>Review of #qryProduct.productname#</h2></cfoutput>

<cfoutput query = "qryReviews">
Reviewed On: #dateformat(review_date, "mmm dd, yyyy")#<br />
By: #reviewer#
<p>
Value: #value#<br />
Features: #features#</br>
Quality: #quality#<br />
Performance: #performance#<br />
</p>
<p>
#details#
</p>
<a href = "index.cfm?start=#url.start#&disp=#url.disp#&viewtype=#url.viewtype#">Go Back</a>
</cfoutput>

















