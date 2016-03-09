<cfinclude template = "../queries/qrywishlists.cfm">

<h2>Wishlists</h2>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr class = "tabletitles">
    <td width="25%"><strong>Date Created </strong></td>
    <td width="25%"><strong>Wishlist ID </strong></td>
    <td width="40%"><strong>Wishlist Name </strong></td>
    <td width="10%"><div align="center"><strong>Delete</strong></div></td>
  </tr>
<cfoutput query = "qryWishlists">
  <tr>
    <td><a href = "dowishlists.cfm?action=viewlist&id=#id#">#dateformat(CreatedOn, "mm/dd/yyyy")#</a></td>
    <td><a href = "doWishlists.cfm?action=viewlist&id=#id#">#WishlistID#</a></td>
    <td><a href = "doWishlists.cfm?action=viewlist&id=#id#">#Wishlistname#</a></td>
    <td><div align="center"><a href = "doWishlists.cfm?action=deletelist&id=#id#"><img src="icons/delete_miniicon.gif" alt="Delete Wishlist" width="24" height="21" border="0"></a></div></td>
  </tr>
</cfoutput>
</table>
<p>&nbsp;</p>

















