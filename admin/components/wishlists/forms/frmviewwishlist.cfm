<style type="text/css">
<!--
.style2 {font-size: 14pt}
-->
</style>

	<cfquery name = "qryWishlistids" datasource="#request.dsn#">
	SELECT * FROM wishlists
	WHERE ID = #url.ID#
	</cfquery>

		<cfoutput query = "qryWishlistids">
			<cfset WishListFound = #wishlistid#>	
		</cfoutput>

	    <cfquery name = "qryWishListItems" datasource="#request.dsn#">
		SELECT * FROM wishlistitems
		WHERE wishlistid = '#WishListFound#'
		</cfquery>
		
		<cfif qryWishListItems.recordcount IS 0>
			There are no items on this persons wishlist.
		</cfif>
		
		<cfif NOT qryWishListItems.recordcount IS 0>
			<!---Show a table of the items this person wants--->
			
			<cfoutput>This wishlist belongs to: #qryWishlistids.wishlistowner#</cfoutput>
			<p>
			<table width="100%" border = "0" align="center">
				<tr>
					<td width = "25%" class="tabletitles">Item</td>					
					<td width = "75%" class="tabletitles">Comments</td>
				</tr>

				<cfloop query = "qryWishListItems">
					<cfquery name = "FindItem" datasource="#request.dsn#">
					SELECT * FROM products
					WHERE ItemID = #wItemID#
					</cfquery>
				
					<cfoutput query = "FindItem">
					<tr>
						<td width = "25%" align="center">
						
					       <table border="0" cellpadding="3" cellspacing="0">
							  <tr> 
								<td align="center">
								<a href = "index.cfm?action=ViewDetails&ItemID=#ItemID#">
								<img src="#request.HomeURL#/photos/#Thumbnail#" Alt="#BriefDescription#" border="0"><br />
								<b>#ProductName#</b></a><b><br>
								</td>
								</tr>
							</table>
					
						</td>					
						<td width = "75%">#qryWishListItems.Comments#</td>
					 </tr>
					 </cfoutput>
				</table>
			</cfloop>	
		</cfif>















