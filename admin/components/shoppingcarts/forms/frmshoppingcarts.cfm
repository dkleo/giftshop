<cfinclude template = "../queries/qryshoppingcarts.cfm">

<h2>Shopping Carts</h2>
<p> Shopping carts are stored in your database when a customer initiates the checkout process. When a customer finalizes their order they shopping cart is deleted. Any shopping carts showing up here were abandoned after the checkout process. You can review and remove these shopping carts from your database. </p>
<p><span style="font-weight: bold">NOTE: To avoid interruptions for customers that may be checking out right now, the delete all link below will NOT delete shopping carts for the current date. </span></p>
<p><a href="doshoppingcarts.cfm?action=deleteall">Delete all</a></p>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr class="TableTitles">
    <td width="15%">Date</td>
    <td width="27%">Cart Token </td>
    <td width="22%"><div align="center">Number Of Items in Cart </div></td>
    <td width="36%"><div align="center">Actions</div></td>
  </tr>
<cfoutput query = "qryShoppingCarts">
  <tr>
    <td>#DateEntered#</td>
    <td>#CartToken#</td>
    <td><div align="center">#ListLen(CrtItemID, "^")#</div></td>
    <td><div align="center"><a href="doshoppingcarts.cfm?action=viewcart&carttoken=#carttoken#">View</a>  |  <a href="doshoppingcarts.cfm?action=deletecart&carttoken=#carttoken#">Delete</a></div></td>
  </tr>
</cfoutput>
</table>
















