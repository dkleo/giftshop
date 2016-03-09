<html>
<head>
<title>Control Panel Menu</title>
</head>
<link href="../controlpanel.css" rel="stylesheet" type="text/css">
<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<cfparam name = "mytoken" default = "NULL">
<!---Determines what state the menu item is in when the page first loads--->
<cfparam name = "MainState" default="Closed">
<cfparam name = "productsState" default="Closed">
<cfparam name = "OptionsState" default="Closed">
<cfparam name = "SalesState" default="Closed">
<cfparam name = "EmailListState" default="Closed">
<cfparam name = "ContentState" default="Closed">
<cfparam name = "OrdersState" default="Closed">
<cfparam name = "AffiliatesState" default="Closed">
<cfparam name = "blogState" default="Closed">
<cfparam name = "CategoriesState" default="Closed">
<cfparam name = "CommentsState" default="Closed">

<!--- JavaScript function to expand and collapse tree elements --->
<script>
	function ExpandMenu(Entity) {
	
		Main.style.display = "none";
		Sales.style.display = "none";
		Content.style.display = "none";
		Categories.style.display = "none";
		products.style.display = "none";
		Options.style.display = "none";
		Orders.style.display = "none";
		EmailList.style.display = "none";
		affiliates.style.display = "none";
		blog.style.display = "none";
		comments.style.display = "none";
	
		DTT_TableID = Entity;
		DTT_ImageID = "IMG" + Entity;
		DTT_Image = document.getElementById(DTT_ImageID);
		DTT_Table = document.getElementById(DTT_TableID);
		if(DTT_Table.style.display == "none") {
			DTT_Table.style.display = "block";
		}
		else {
			DTT_Table.style.display = "none";
		}
	}
</script>	
			
<!---HTML--->
<style type="text/css">
<!--
.style2 {color: #FFFFFF}
.style5 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
td {line-height: 20px;}
-->
</style>
<table width = "260" cellpadding="0" cellspacing="0">
<tr>
<td height="500" valign="top"><!---Outer table left side (menus)--->
<cfoutput>

<!---menu header--->
<table width = "100%" cellpadding="4" cellspacing="0">
<tr>
    <td bgcolor="##000000" height="30" style="padding-left: 5px;"><a href="#request.AdminPath#about.cfm" target="main" class="style2"><img src="../images/icon_house.gif" alt="Control Panel Home" width="20" height="16" border="0" /><span class="style5"> Home</span></span></a>
 <a href="#request.AdminPath#logoff.cfm" target="_parent" class="style2"></a><a href="#request.Supporturl#help/index.cfm" target="main" class="style2"><img src="../images/icon_info.gif" alt="Info" width="19" height="19" border="0" /> <span class="style5">Help</span></a>&nbsp <a href="#request.AdminPath#logoff.cfm" target="_parent" class="style2"><img src="../images/icon_logout.gif" alt="Logout" width="23" height="22" border="0" /> <span class="style5">Logout</span></a> </td>
    </tr>
</table>
<br>
<!---Menu Items--->
<table align="center" width="100%" cellpadding="6" cellspacing="0">
<tr>
<td>
<table width = "95%" cellpadding="4" cellspacing="0">
<tr class="NavTitle" onClick="javascript:ExpandMenu('Main')">
<td width="90%" class="NavTitle">Settings and Tools</td>
</tr>
</table>
<!---Settings--->
<span id="Main" <cfif MainState IS 'Closed'>style="display: none;"</cfif>>
<table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
<tr>
  <td valign="top"><p>&raquo; <a href="#request.AdminPath#setup/dosetup.cfm" target="main">Store Information</a><br>      
    &raquo; <a href="#request.AdminPath#setup/dosetup.cfm?action=variables" target="main">Store Settings</a><br>      
    &raquo; <a href="#request.AdminPath#components/processors/index.cfm?action=selectgateway" target="main">Primary Payment Gateway</a><br>      
    &raquo; <a href="#request.AdminPath#components/processors/index.cfm?action=select3rdparty" target="main"> 3rd Party Processors</a><br>
    &raquo; <a href="#request.AdminPath#setup/dosetup.cfm?action=paymentmethods" target="main">Payment Settings</a><br>      
    <cfif qryLoginCheck.userlevel IS 'masteradmin'>&raquo; <a href="#request.AdminPath#components/processors/index.cfm" target="main">Edit Payment Processors</a><br></cfif>
    &raquo; <a href="#request.AdminPath#setup/dosetup.cfm?action=custombuttons" target="main">Customize 
        Buttons</a><br>      
    &raquo; <a href="#request.AdminPath#setup/dosetup.cfm?action=storecolors" target="main">Store 
        Colors</a><br>
    &raquo; <a href="#request.AdminPath#setup/dosetup.cfm?action=WidgetSetup" target="main">Widget Settings</a><br>  
    <cfif qryLoginCheck.userlevel IS 'masteradmin' OR qryLoginCheck.userlevel IS 'admin'>
    	&raquo; <a href="#request.AdminPath#components/users/index.cfm" target="main">Control Panel Users</a><br>  
    </cfif>
    &raquo; <a href="#request.AdminPath#components/stats/index.cfm" target="main">Website Statistics</a><br> 
    <cfif qryLoginCheck.userlevel IS 'masteradmin'>
	    &raquo; <a href="#request.AdminPath#setup/dosetup.cfm?action=viewerrors" target="main">Store Error Reports</a><br>
	</cfif>
    <!--- &raquo; <a href="#request.AdminPath#stats/index.cfm" target="main">Store Stats</a><br>--->  
    &raquo; <a href="#request.AdminPath#components/contactform/index.cfm" target="main">Contact Form</a>
        <br>
    &raquo; <a href="#request.AdminPath#setup/dosetup.cfm?action=bannedips" target="main">Banned IP List</a>
           <br>
     <cfif qryLoginCheck.userlevel IS 'masteradmin'>
	    &raquo; <a href="#request.AdminPath#help/admin.cfm" target="main">Quick Help Admin</a>     	
     </cfif>
      </p>
    </td>
</tr>
</table>
</span>
<table width = "95%" cellpadding="4" cellspacing="0">
  <tr class="NavTitle" onClick="javascript:ExpandMenu('Sales')"> 
    <td class="NavTitle">Shipping & Taxes</td>
  </tr>
</table>
<span id="Sales" <cfif SalesState IS 'Closed'>style="display: none;"</cfif>>
<table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
  <tr> 
    <td valign="top">&raquo; <a href="#request.AdminPath#components/shipping/doshipping.cfm" target="main">Set 
      Method </a><br>      
      &raquo; <a href="#request.AdminPath#components/shipping/doshipping.cfm?action=surcharge" target="main">Shipping 
      Surcharges</a><br>      
      &raquo; <a href="#request.AdminPath#components/shipping/doshipping.cfm?action=freezones" target="main">Shipping 
      Free Zones</a><br>      
      &raquo; <a href="#request.AdminPath#components/shipping/doshipping.cfm?action=shippingareas" target="main">Shipping 
      Areas</a>
      <br>
      &raquo; <a href="#request.AdminPath#setup/dosetup.cfm?action=taxes" target="main">Tax 
      Table</a>
  <br></td>
  </tr>
</table>
</span>
  <table width = "95%" cellpadding="4" cellspacing="0">
      <tr class="NavTitle" onClick="javascript:ExpandMenu('Content')"> 
          
        <td class="NavTitle">Pages & Files</td>
      </tr>
</table>
<span id="Content" <cfif ContentState IS 'Closed'>style="display: none;"</cfif>> 
<table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
<tr> 
<td valign="top">&raquo; <a href="#request.AdminPath#components/pages/dopages.cfm" target="main">Site Pages</a><br>  &raquo; <a href="#request.AdminPath#components/links/dolinks.cfm" target="main">Link Widget</a><br>  &raquo; <a href="#request.AdminPath#components/homepageeditor/dohomepageeditor.cfm" target="main">Edit 
  Homepage</a><br>  &raquo; <a href="#request.AdminPath#components/storeheader/doheadermanager.cfm" target="main">Store 
  Header</a><br>  &raquo; <a href="#request.AdminPath#components/storefooter/dofootermanager.cfm" target="main">Store 
  Footer</A><br>  &raquo; <a href="#request.AdminPath#components/imagelibrary/doimagelibrary.cfm" target="main">Website 
    Images</a><br>    
    &raquo; <a href="#request.AdminPath#components/filemanager/index.cfm" target="main">File Manager</a><br>    &raquo; <a href="#request.AdminPath#components/navigation/index.cfm" target="main">Site Navigation</a><br>
    &raquo; <a href="#request.AdminPath#components/pages/dopages.cfm?action=findreplace" target="main">Find and Replace</a><br>      
    </td>
</tr>
</table>
</span>
<!---Categories--->
<table width = "95%" cellpadding="4" cellspacing="0">
<tr class="NavTitle" onClick="javascript:ExpandMenu('Categories')">
<td width="90%" class="NavTitle">Categories</td>
</tr>
</table>
<span id="Categories" <cfif CategoriesState IS 'Closed'>style="display: none;"</cfif>>
<table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
<tr>
  <td valign="top">&raquo; <a href="#request.AdminPath#components/categories/index.cfm" target="main">Edit 
        Categories </a><br>        &raquo; <a href="#request.AdminPath#components/categories/index.cfm?action=ChangeOrder" target="main">Order of Categories</a><br>        &raquo; <a href="#request.AdminPath#components/products/doproducts.cfm?action=categories" target="main">Item Category Assignments</A><br>        &raquo; <a href="#request.AdminPath#components/category_import/index.cfm?action=import" target="main">Import Categories</A><br>
  </td>
</tr>
</table>
</span>
<!---Product Catalog--->
<table width = "95%" cellpadding="4" cellspacing="0">
<tr class="NavTitle" onClick="javascript:ExpandMenu('products')"> 
  <td class="NavTitle">Product Catalog</td>
</tr>
</table>
<span id="products" <cfif productsState IS 'Closed'>style="display: none;"</cfif>>
<table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
<tr> 
<td valign="top"> <p>&raquo; <a href="#request.AdminPath#components/products/doproducts.cfm?start=1" target="main">Edit 
      products</a><br>
      &raquo; <a href="#request.AdminPath#components/products/doproducts.cfm?action=new" target="main">New 
      Product </a> <br>
      &raquo; <a href="#request.AdminPath#components/products/doproducts.cfm?action=newfromtemplate" target="main">New 
      Product From Template </a> <br>
      &raquo; <a href="#request.AdminPath#components/products/doproducts.cfm?action=FeaturedItems" target="main">Featured 
      Items </a> <br>
      &raquo; <a href="#request.AdminPath#components/products/doproducts.cfm?action=ChangeOrder" target="main">Default Order of Items</a>
     <br>
     &raquo; <a href="#request.AdminPath#components/products/photomanager/dophotomanager.cfm" target="main">Product 
      Images</a> <br>
      &raquo; <a href="#request.AdminPath#components/products/doproducts.cfm?action=viewstats" target="main">Product 
      Stats</a><br>
      &raquo; <a href="#request.AdminPath#components/inventory/doinventory.cfm" target="main">Inventory</a> <br>
      &raquo; <a href="#request.AdminPath#components/products/doproducts.cfm?action=pricing" target="main">Adjust Prices</A><br>
      &raquo; <a href="#request.AdminPath#components/suppliers/index.cfm" target="main">Suppliers</a> <br>
      &raquo; <a href="#request.AdminPath#components/couponcodes/index.cfm" target="main">Coupons</a> <br>
      &raquo; <a href="#request.AdminPath#components/sales/dosales.cfm" target="main"> Schedule a Sale </a> <br>
      &raquo; <a href="#request.AdminPath#components/wishlists/dowishlists.cfm" target="main">Wishlists</a> 
        <br>
        &raquo; <a href="#request.AdminPath#components/brochures/dobrochures.cfm" target="main">Brochures</a>
  <br>
  &raquo; <a href="#request.AdminPath#components/giftcards/dogiftcards.cfm?action=default" target="main">Gift Cards</a><br>
  &raquo; <a href="#request.AdminPath#components/reviews/index.cfm" target="main">Product Reviews</a><br>
  &raquo; <a href="#request.AdminPath#components/product_import/index.cfm?action=import" target="main">Import Products</A><br>
  &raquo; <a href="#request.AdminPath#components/image_import/index.cfm?action=import" target="main">Import Product Images</A><br>
  </td>
</tr>
</table>
</span>
<!---Options--->
<table width = "95%" cellpadding="4" cellspacing="0">
<tr class="NavTitle" onClick="javascript:ExpandMenu('Options')"> 
  
<td class="NavTitle">Product Options</td>
</tr>
</table>
<span id="Options" <cfif OptionsState IS 'Closed'>style="display: none;"</cfif>>
<table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
<tr> 
  <td valign="top">&raquo; <a href="#request.AdminPath#components/options/dooptions.cfm" target="main">Build Options for an Item </a> <br />
    &raquo; <a href="#request.AdminPath#components/options/dooptions.cfm?action=editalloptions" target="main">View/Edit All Options</a><br>    &raquo; <a href="#request.AdminPath#components/options/dooptions.cfm?action=adddropdown&amp;newdropdown=yes&amp;itemid=0" target="main"> Create a Drop 
    Down</a><br>    
    &raquo; <a href="#request.AdminPath#components/options/dooptions.cfm?action=addradiolist&amp;newradiolist=yes&amp;itemid=0" target="main">Create a Radio 
    List</a><br>    &raquo; <a href="#request.AdminPath#components/options/dooptions.cfm?action=addformfield&amp;type=textbox&amp;itemid=0" target="main">Create an Input 
      Box </a><br>
      &raquo; <a href="#request.AdminPath#components/options/dooptions.cfm?action=addformfield&amp;type=textarea&amp;itemid=0" target="main">Create A Muti-Lined TextBox<br>
      </a>&raquo; <a href="#request.AdminPath#components/options/dooptions.cfm?action=addformfield&amp;type=checkbox&amp;itemid=0" target="main">Create a Checkbox</a><br>      &raquo; <a href="#request.AdminPath#components/options/dooptions.cfm?action=addformfield&amp;type=hidden&amp;itemid=0" target="main">Create a Hidden Field </a></td>
</tr>
</table>
</span>
<!---ORDERS--->
<table width = "95%" cellpadding="4" cellspacing="0">
<tr class="NavTitle" onClick="javascript:ExpandMenu('Orders')"> 
  <td class="NavTitle">Customers and Orders</td>
</tr>
</table>
<span id="Orders" <cfif OrdersState IS 'Closed'>style="display: none;"</cfif>>
<table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
<tr> 
  <td valign="top">&raquo; <a href="#request.AdminPath#components/orders/doorders.cfm" target="main">View 
    Orders</a><br>    &raquo; <a href="#request.AdminPath#components/orders/doorders.cfm?action=viewarchives" target="main">Order Archives</a><br>    &raquo; <a href="#request.AdminPath#components/orders/doorders.cfm?action=Delete" target="main">Delete 
    Orders </a><br>
    &raquo; <a href="#request.AdminPath#components/orders/doorders.cfm?action=viewsales" target="main">Sales 
    Reports<br>
    </a>&raquo; <a href="#request.AdminPath#components/orders/doorders.cfm?action=ViewCustomers" target="main">Customers</a><br>    &raquo; <a href="#request.AdminPath#components/orders/doorders.cfm?action=searchorders" target="main">Search 
    Orders</a><br />    &raquo; <a href="#request.AdminPath#components/tickets/index.cfm" target="main">Support Tickets</a> <br>    &raquo; <a href="#request.AdminPath#components/shoppingcarts/doshoppingcarts.cfm" target="main">Shopping Carts</a><br>    &raquo; <a href="#request.AdminPath#components/subscriptions/index.cfm" target="main">Subscribers</a><br>    &raquo; <a href="#request.AdminPath#components/ponumbers/index.cfm" target="main">Manage PO Numbers</a><br>
    
    </td>
</tr>
</table>
</span> 

<!---Email List--->
  <table width = "95%" cellpadding="4" cellspacing="0">
    <tr class="NavTitle" onClick="javascript:ExpandMenu('EmailList')"> 
      <td class="NavTitle">Newsletter </td>
    </tr>
  </table>
<span id="EmailList" <cfif emailliststate is 'closed'>style="display: none;"</cfif>="<cfif emaillistState IS 'Closed'>style="display: none;"</cfif>">
  <table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
    <tr>
      <td valign="top">&raquo; <a href="#request.AdminPath#components/newsletter/index.cfm?action=members" target="main">View 
        Subscribers</a><br>        &raquo; <a href="#request.AdminPath#components/newsletter/index.cfm?action=groups" target="main">Subscriber Groups</a><br>        &raquo; <a href="#request.AdminPath#components/newsletter/index.cfm?action=default" target="main">Create 
          a Message</a><br>          &raquo; <a href="#request.AdminPath#components/newsletter/index.cfm?action=send" target="main">View/Send Messages </a><br>          &raquo; <a href="#request.AdminPath#components/newsletter/index.cfm?action=AssignToGroups" target="main">Group Assignments</a><br>          &raquo; <a href="#request.AdminPath#components/newsletter/index.cfm?action=editsettings" target="main">Newletter Settings</a></td>
    </tr>
  </table>
</span>
<!---Affiliates--->
<table width = "95%" cellpadding="4" cellspacing="0">
    <tr class="NavTitle" onClick="javascript:ExpandMenu('affiliates')"> 
      
    <td class="NavTitle">Affiliate System</td>
    </tr>
</table>
<span id="affiliates" <cfif affiliatesstate is 'closed'>style="display: none;"</cfif>>
  <table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
    <tr> 
      
    <td valign="top">&raquo; <a href="#request.AdminPath#components/affiliates/index.cfm?action=affiliates" target="main">View Affiliates</a><br>      &raquo; <a href="#request.AdminPath#components/affiliates/index.cfm?action=pay" target="main">Pay Affiliates</a><br>      &raquo; <a href="#request.AdminPath#components/affiliates/index.cfm?action=messages" target="main">Messages</a><br>      &raquo; <a href="#request.AdminPath#components/affiliates/index.cfm?action=banners" target="main">Banners</a><br>
      &raquo; <a href="#request.AdminPath#components/affiliates/index.cfm?action=sellingtools" target="main">Selling Tools</a><br>
&raquo; <a href="#request.AdminPath#components/affiliates/index.cfm?action=homepage" target="main">Edit Homepage</a><br>
&raquo; <a href="#request.AdminPath#components/affiliates/index.cfm?action=menu" target="main">Customize the Menu</a></td>
    </tr>
  </table>
</span>	
<!---Blog--->
<table width = "95%" cellpadding="4" cellspacing="0">
    <tr class="NavTitle" onClick="javascript:ExpandMenu('blog')"> 
    <td class="NavTitle">Blog</td>
    </tr>
  </table>
<span id="blog" <cfif blogstate is 'closed'>style="display: none;"</cfif>>
  <table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
    <tr>     
    <td valign="top">&raquo; <a href="#request.AdminPath#components/blog/index.cfm" target="main">Blog Posts</a><br>      &raquo; <a href="#request.AdminPath#components/blog/index.cfm?action=blog.edit.new&isplugin=yes" target="main">New Post</a><br>      &raquo; <a href="#request.AdminPath#components/blog/index.cfm?action=blog.settings.default&isplugin=yes" target="main">Blog Settings</a><br>
      &raquo; <a href="#request.AdminPath#components/blog/index.cfm?action=blog.links.default&isplugin=yes" target="main">Blog Links<br>
      </a>&raquo; <a href="#request.AdminPath#components/blog/index.cfm?action=blog.categories.default" target="main">Blog Categories </a><br>			</td>
    </tr>
  </table>
</span>
<!---Comments--->
<table width = "95%" cellpadding="4" cellspacing="0">
    <tr class="NavTitle" onClick="javascript:ExpandMenu('comments')"> 
    <td class="NavTitle">Comments</td>
    </tr>
  </table>
<span id="comments" <cfif CommentsState is 'closed'>style="display: none;"</cfif>>
  <table width = "95%" cellpadding="4" cellspacing="0" border="0" class="navmenu">
    <tr>     
    <td valign="top">
    &raquo; <a href="#request.AdminPath#components/comments/index.cfm" target="main">Moderate Comments</a><br>      
    &raquo; <a href="#request.AdminPath#components/comments/index.cfm?action=delete" target="main">Delete Unapproved Comments</a><br>      
    &raquo; <a href="#request.AdminPath#components/comments/index.cfm?action=moderate_approved" target="main">Remove Approved Comments</a>
    </td>
    </tr>
  </table>
</span>
</td>
</tr>
</table>

</cfoutput></td>
<!---Outer table right side (shadow)--->
<td width="6" background="../images/rightsiteshadow.gif"></td>
</tr>
<!---bottom shadowing--->
<tr>
<td height="10" background="../images/menushadow.gif" style="background-position:top;"></td>
<td align="left" valign="top"><img src="../images/sitebottomright.gif"></td>
</tr>
</table>
</body>
</html>



