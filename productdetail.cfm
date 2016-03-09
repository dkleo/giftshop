<cfquery name="Gift" datasource="giftshop">
SELECT
    Product.ID,
    Product.Name,
    Product.SKU,
    Product.Price,
    Product.Description,
    Product.Image,
    DeliveryOption.Option DeliveryOption FROM Product
  INNER JOIN DeliveryOption ON Product.DeliveryOption = DeliveryOption.ID
  WHERE Product.ID =
    <cfqueryparam value="#url.ID#"/>;
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
<cfoutput><title>Product Details | #application.seoPageTitle#</title></cfoutput>

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

  <!---<script src="assets/js/raphael.js" type="text/javascript"></script>--->
  <!---<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>--->
  <script>
    $(document).ready(function() {
      $("#addToCartBtn").click(function(e) {        //#
        var giftID = $("#giftID").val();         //#
        var giftQty = $("#giftQty").val();    //#
        var giftCounter = $( "#giftCounter").val();
        var giftTotal = parseInt(giftCounter) + parseInt(giftQty);
        $.get("cartapi.cfc?method=addToCart&productID="+giftID+"&quantity="+giftQty, function(data) {
          var itemMsg = (giftTotal > 1) ? "items" : "item";
          $( "#itemMsg" ).text(giftTotal + " " + itemMsg + " added to cart.") ;      //#
          $( "#giftCounter").val(giftTotal);
        });

      });

    });

  </script>
</head>

<body>

<!-- wrapper -->
<div class="clr" id="top-head">&nbsp;</div>
<div id="container">
  <!--header -->
<div id="header">
<div class="logo-bg">
  <!--logo -->
  <div class="logo" onclick="document.location='/giftshop'">
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
  <!-- portfolio -->
<div id="">
  <div class="clr">
    <div class="top-bg1">
      <div class="top-left">
        <div>
          <h1>Product Details</h1>
        </div>
      </div>
    </div>
    <div class="clr">
      <div class="pat-bottomleft">&nbsp;</div>
      <div class="pat-bottomright">&nbsp;</div>
    </div>
  </div>
  <div class="clr">

  </div>
  <div class="clr hline">&nbsp;</div>
<div class="main-content">
<div class="product-info"><h6>
<cfoutput>#Gift.Name#</cfoutput></h6>
  <br>
  <p align="center">
  </p>
  <p align="center">
  </p>
<div itemscope="" itemtype="http://schema.org/Product">
<div class="product-container">
<div class="product-image product-image-container">
<div class="img-container">
    <img itemprop="image" src="
<cfoutput>#Gift.Image#</cfoutput>" alt=“
<cfoutput>#Gift.Name#</cfoutput>">
  <div class="feature-overlay">
  </div>
  <br>
  <div class="delivery-info"><span><em><img src="assets/images/sameday-arrow.gif" class="flip-horizontal">&nbsp;&nbsp;&nbsp;<a href="javascript:history.back(-1)">Go Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="assets/images/sameday-arrow.gif">
<cfoutput>#Gift.DeliveryOption#</cfoutput></em></span></div>
</div>



</div>

<div class="description">
<span itemprop="description">
<p>
<cfoutput>#Gift.Description#</cfoutput>
</p>
</span>
</div>

<span class="code">SKU:
<cfoutput>#Gift.SKU#</cfoutput></span>
  <div class="price-container">

    <div itemprop="offers" itemscope="" itemtype="http://schema.org/Offer" itemref="item1_price">
      <span class="price-label">Price: </span>
      <span class="price" itemprop="price">$39.95</span>
    </div>

  </div>
  <div class="cart-controls">
    <div>
      <label for="txtQty">Quantity:</label>
      <input id="giftQty" name="txtQty" type="text" value="1" maxlength="10" size="2" class="textBoxStyle">
      <input id="giftID" type="hidden" value="<cfoutput>#Gift.ID#</cfoutput>" />
      <input id="giftCounter" type="hidden" value="0" />
    </div>
    <div>
      <a id="addToCartBtn" class="text-button">
        add to cart
      </a>
    </div>

  <div id="itemMsg"></div>

  </div>




  <div class="delivery">

  </div>

</div>

</div>

</div>
</div>

</div>

</div>
  <!-- portfolio end -->

  <div class="clr"></div>
</div><!--card pattern end -->
  <div class="clr "></div>
</div>          <!--content end -->
<div class="bottom-shade"></div>
</div>  <!--Container / wrapper end -->
</body>
</html>