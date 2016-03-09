<cfquery name="Cart" datasource="giftshop">
  SELECT
  Product.ID,
  Name,
  SKU,
  Price * Quantity as Price,
  Quantity,
  CartItem.ID as ItemID
FROM Product INNER JOIN CartItem ON Product.ID = CartItem.ProductID
WHERE CartID = <cfqueryparam value="#session.cartID#"/>;
</cfquery>
<cfquery name="Gifts" datasource="giftshop">
  SELECT
  Product.ID,
  Product.Name,
  Product.SKU,
  Product.Price,
  Product.Description,
  DeliveryOption.Option AS DeliveryOption,
  Product.Image
FROM Product
  INNER JOIN ProductCategory ON Product.ID = ProductCategory.ProductID
  INNER JOIN Category ON ProductCategory.CategoryID = Category.ID
  INNER JOIN DeliveryOption ON Product.DeliveryOption = DeliveryOption.ID
WHERE Category.Name = 'Add On'
</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="description" content="Clean Slide Responsive Vcard Template"/>
  <meta name="keywords" content="jquery, Responsive Vcard, Template, Vcard, Clean Slide"/>
  <meta http-equiv="X-UA-Compatible" content="IE=9"/>
  <meta http-equiv="X-UA-Compatible" content="IE=7"/>
<cfoutput><title>Checkout | #application.seoPageTitle#</title></cfoutput>

  <!-- Loading Google Web fonts -->
  <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'/>
  <link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300,700' rel='stylesheet' type='text/css'/>
  <link href='http://fonts.googleapis.com/css?family=IM+Fell+DW+Pica' rel='stylesheet' type='text/css'/>
  <link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css'/>

  <!-- CSS Files -->
  <link href="assets/css/reset.css" rel="stylesheet" type="text/css"/>
  <link href="assets/css/style.css" rel="stylesheet" type="text/css" id="color"/>
  <link href="assets/css/typography.css" rel="stylesheet" type="text/css" id="customFont"/>
  <link href="assets/css/arial_content.css" rel="stylesheet" type="text/css" id="contentfont"/>

  <!-- include jQuery library -->
  <script type="text/javascript" src="assets/js/jquery-1.7.min.js"></script>

  <script>
    $(document).ready(function() {

      $(".removeFromCart").click(function(event) {

            var tr = event.target.closest('tr');
            var itemID = event.target.name;
            $.get("cartapi.cfc?method=removeFromCart&itemID="+itemID, function(data) {
              location.reload();
            });
      });

    });

  </script>

  <!---<script src="assets/js/raphael.js" type="text/javascript"></script>--->
  <!---<script src="assets/js/init.js" type="text/javascript"></script>--->


</head>

<body>

<!-- wrapper -->
<div class="clr" id="top-head">&nbsp;</div>
<div id="container">
  <!--header -->
<div id="header">
<div class="logo-bg">
  <!--logo -->
  <div class="logo">
    <img src="assets/images/logo.png" alt="Logo" width="202" height="52" border="0" id="logo"/>
  </div>

  <!--head right -->
<div class="right">

  <!--// Navigation //-->
<cfinclude template="topnav.cfm"/>
  <!--// Navigation End //-->
</div>
  <!--// -head right end //-->
</div>
  <!--// logo bg end //-->
</div>
  <!--header end -->

  <!-- Content Start -->

  <!--Card  -->
<div id="content">
<div class="card-pattern">
  <!-- blog -->
<div id="blog">
  <div class="clr">
    <div class="top-bg1">
      <div class="top-left">
        <div><h1>My Order</h1></div>
      </div>
    </div>
    <div class="clr">
      <div class="pat-bottomleft">&nbsp;</div>
      <div class="pat-bottomright">&nbsp;</div>
    </div>
  </div>
<div class="blog-top">
<div class="clr">
<div class="left">
<cfif Cart.recordcount GT 0>


    <table class="cart" cellspacing="5" style="width:100%;margin-top: 2em;">
    <caption id="itemMsg"></caption>
      <thead>
      <tr style="background:silver;color:black">
        <th>Product</th>
        <th>Unit Price</th>
        <th>Quantity</th>
        <th>Total</th>
        <th>&nbsp;</th>
      </tr>
      </thead>
        <cfset total = 0>
        <cfoutput query="Cart">
            <tr style="border:1px solid silver;">
            <td>
                #Cart.Name#
            </td>
            <td style="text-align: right;">
                #NumberFormat(Cart.Price, "$9.99")#
            </td>
            <td style="text-align: center;">#Cart.Quantity#
            </td>
            <td><cfset itemTotal = Cart.Quantity * Cart.Price>#NumberFormat(itemTotal, "$9.99")#
            </td>
            <td><button name="#Cart.ItemID#" class="removeFromCart" style="color:red;cursor:pointer">[X]</button></td>
                <cfset total = total + itemTotal>
            </tr>
        </cfoutput>

        <cfoutput>
            <tr>
              <td colspan="3" style="border: 0;"></td>
                <td style="border-left: 1px solid ##aaa; text-align: right;">Total:&nbsp;&nbsp;</td>
          <td style="font-weight: bold; border-left: 0;">#NumberFormat(total, "$9.99")#</td>
            <td style="border-left: 0;">&nbsp;</td>
          </tr>
        </cfoutput>
    </table>

<cfelse>
    <h6>There are no items in your cart.</h6>
</cfif>
</div>
</div>
</div>
</div>
  <div class="clr"></div>
</div> <!--blog end -->

  <div class="clr"></div>
</div><!--card pattern end -->
  <div class="clr "></div>
</div>          <!--content end -->
<div class="bottom-shade"></div>
</div>  <!--Container / wrapper end -->
</body>
</html>