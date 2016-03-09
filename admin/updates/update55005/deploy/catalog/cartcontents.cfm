<cfif NOT ISDEFINED('session.CartTotal')>
<cflock scope="Session" Type="Exclusive" Timeout="10">
<cfset session.CartTotal = 0>
</cflock>
</cfif>

<cfif NOT ISDEFINED('session.CrtProductID')>
<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
	<cfset session.CrtItemID="">
	<cfset session.CrtProductID="">
	<cfset session.CrtProductName = "">
	<cfset session.CrtQuantity = "">
	<cfset session.CrtPrice = "">
	<cfset session.CrtWeight = "">
	<cfset session.CrtThumbNails = "">
	<cfset session.Crtoptions = "">
	<cfset session.CrtType = "">
	<cfset session.CrtApproved = "">
	<cfset session.CrtCoupons = "">
</cflock>
</cfif>

<div align="center">
<!---Create some temporary variables to use instead of using session variables--->
<cflock scope="Session" Type="Exclusive" Timeout="10">
<cfset cart.CrtProductID = "#Session.CrtProductID#">
<cfset cart.CrtPrice = "#Session.CrtPrice#">
<cfset cart.CrtQuantity = "#session.CrtQuantity#">
<cfset cart.CrtItemID = '#session.CrtItemID#'>
<cfset cart.CrtProductName = '#session.CrtProductName#'>
</cflock>

<cfset CrtTotal = 0>

<cfif #ListLen(Cart.CrtProductID, "^")# IS 0>
<cfset CrtTotal = 0>
<div class="CartContentsEmptyMessage">Your Cart is empty</div>
      <div align="center"><br>
	  <cfoutput>
        <img name="ShoppingCart" src="images/defaults/shoppingcartsm.gif" class="ShoppingCartImage">
		</cfoutput>
	 </div>		
</cfif>
      <cfif NOT #ListLen(Cart.CrtProductID, "^")# IS 0>
      <table width="100%" border="0" cellspacing="0" cellpadding="2" class="CartContentsTable">
        <tr> 
          <td Class="TableCells"><span class="CartContentsColumnTitles">ProdID</span></td>
          <td Class="TableCells"><span class="CartContentsColumnTitles">Qty</span></td>
            <td Class="TableCells"><span class="CartContentsColumnTitles">Price</span></strong></td>
        </tr>
        <cfloop index="IndexCount" from="1" To="#ListLen(Session.CrtProductID, "^")#">
		<cfoutput>
          <cfset TotalOfItems = #ListGetAt(Cart.CrtPrice, IndexCount, "^")#>
          <cfset ItemQty = #ListGetAt(Cart.CrtQuantity, IndexCount, "^")#>
          <cfset ProductID = #ListGetAt(Cart.CrtProductID, IndexCount, "^")#>
		  <cfset ProductName = #ListGetAt(Cart.CrtProductName, IndexCount, "^")#>
		  <cfset ThisItemID = #ListGetAt(Cart.CrtItemID, IndexCount, "^")#>
          <cfset CrtTotal = #CrtTotal# + #TotalOfItems#>
          <tr> 
			<cfset ProductName = #ListGetat(ProductName, 1, "<")#>
            <td width="50%"><a href="index.cfm?carttoken=#carttoken#&action=ViewDetails&ItemID=#ThisItemID#" title="#productname#">Item #IndexCount#</a></td>
            <td width="25%">#ItemQty#</td>
            <td width="25%"><cfif #request.EnableEuro# IS 'Yes'>
                #lseurocurrencyformat(TotalOfItems, "Local")# 
			</cfif> 
			<cfif NOT #request.EnableEuro# IS 'Yes'>
                #lscurrencyformat(TotalOfItems, "Local")# 
			</cfif></td>
          </tr>
		</cfoutput>
        </cfloop>
          <tr>
            <td>&nbsp;</td>
            <td><div align="right"><strong>Total:</strong></div></td>
            <td><b><cfif #request.EnableEuro# IS 'Yes'>
            <cfoutput><b>#lseurocurrencyformat(CrtTotal, "Local")#</b></cfoutput> </cfif> <cfif NOT #request.EnableEuro# IS 'Yes'>
            <cfoutput><b>#lscurrencyformat(CrtTotal, "Local")#</b></cfoutput> </cfif></b></td>
          </tr>
      </table>
	  <center><cfoutput><a href="index.cfm?carttoken=#carttoken#&action=View">View/Edit Cart</a></cfoutput></center>
</cfif>



