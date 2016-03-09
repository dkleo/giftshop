<cfif NOT ISDEFINED('session.wishlist')>
	<center><font size="1"><b>Your wishlist is empty</b></font></center>
      <div align="center"><br>
	  <cfoutput>
        <img name="ShoppingCart" src="images/wishlist.gif" alt="">
		</cfoutput>
		<p>
		<cfoutput><a href = "index.cfm?action=editwishlist&CartToken=#CartToken#">Load a saved wishlist</a></cfoutput>
	 </div>	
</cfif>

<cfif ISDEFINED('session.wishlist')>
	<cflock scope="session" type="readonly" timeout="10">	
		<cfset Tempvar.wishlistid = #session.wishlist#>
	</cflock>

	<cfquery name = "qryWishlistitems" datasource="#request.dsn#">
		SELECT * FROM wishlistitems
		WHERE wishlistid = '#Tempvar.wishlistid#'
	</cfquery>
	
<div align="center">
<cfif #qryWishlistitems.recordcount# IS 0>
	<center><font size="1"><b>Your wishlist is empty</b></font></center>
      <div align="center"><br>
	  <cfoutput>
                <img name="ShoppingCart" src="images/Wishlist.gif" alt="">
		</cfoutput>
		<p>
		<cfoutput><a href = "index.cfm?action=editwishlist&load=yes&CartToken=#CartToken#">Load a saved wishlist</a></cfoutput>
	 </div>	
</cfif>

<cfif NOT #qryWishlistitems.recordcount# IS 0>
     <table width="100%" border="0" cellspacing="0" cellpadding="2">
        <tr> 
          <td Class="TableCells"><strong><font size="1">Item</font></strong></td>
		  <td Class="TableCells"><strong><font size="1">Del</font></strong></td>
        </tr>
        <cfloop query = "qryWishlistitems">

			 <cfquery name = "qryProducts" datasource="#request.dsn#">
				SELECT * FROM products
				WHERE itemid = #qryWishlistitems.wItemid#
			</cfquery>
			
			 <cfoutput query = "qryProducts">
			  <tr> 
				<cfset TheProductName = #ProductName#>
				<cfif Len(#ProductName#) GT 25>
					<cfset TheProductName = '#left(TheProductName, 25)#...'>
				</cfif>
				<td with="95%" Class="TableCells"><font size="1">#TheProductName#</font></a></td>
				<td with="5%" Class="TableCells"><center><font size="1"><a href = "index.cfm?action=DeleteFromWishList&id=#qryWishListItems.id#&CartToken=#CartToken#">X</a></font></center></td>
			  </tr>
			</cfoutput>
        </cfloop>
      </table>
	  <p>
		<cfoutput>
  <center><a href="index.cfm?action=editwishlist&CartToken=#CartToken#">Edit</a> | <a href="index.cfm?action=editwishlist&load=yes&CartToken=#CartToken#">Load</a></center> </cfoutput>
	</cfif>
</cfif>





