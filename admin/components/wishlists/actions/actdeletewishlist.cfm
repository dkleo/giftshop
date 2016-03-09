<cfquery name = "DeleteWishList" datasource = "#request.dsn#">
DELETE FROM wishlists
WHERE ID = #url.id#
</cfquery>

<cflocation url = "dowishlists.cfm">
















