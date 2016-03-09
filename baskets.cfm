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
WHERE Category.Name = 'Baskets';
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
  <cfoutput><title>Personalized Gift Baskets | #application.seoPageTitle#</title></cfoutput>

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
  <!-- portfolio -->
<div id="portfolio">
  <div class="clr">
    <div class="top-bg1">
      <div class="top-left">
        <div>
          <h1>Personalized Gift Baskets</h1>
        </div>
      </div>
    </div>
    <div class="clr">
      <div class="pat-bottomleft">&nbsp;</div>
      <div class="pat-bottomright">&nbsp;</div>
    </div>
  </div>
  <div class="clr">
    <h6>
      <span>Find the perfect get well gift basket for any patient or occasion with Treasures Gift Shop.</span> Same day delivery to your loved one’s bedside to celebrate and support them.
    </h6>
  </div>
  <div class="clr hline">&nbsp;</div>
<div class="clr">
<ul class="product-list results">
<cfoutput query="Gifts">
    <div>
    <li>
    <div itemprop="itemListElement" itemscope="" itemtype="http://schema.org/Product">
    <div class="product-image-container">
    <div class="image-holder img-container">
      <div class="feature-overlay"></div>
        <a href="productdetail.cfm?id=#Gifts.ID#">
        <img alt="#Gifts.Name#" class="listimg" src="#Gifts.Image#" style="display: inline;">
  </a>
  </div>
  </div>
  <div class="delivery-info">
  <span>
  <em>
    <img alt="" style="height: 12px;" src="assets/images/sameday-arrow.gif" />
    #Gifts.DeliveryOption#
    </em>
    </span>
    </div>
        <a href="productdetail.cfm?id=#Gifts.ID#">
    <span itemprop="name" class="name">#Gifts.Name#</span>
  </a>
  <div itemprop="offers" itemscope="" itemtype="http://schema.org/Offer" itemref="item_price">
  <span itemprop="price">
  <span class="price">$#Gifts.Price#</span>
  </span>
  <span style="display: none" itemprop="name" class="name">#Gifts.Name#</span>
  </div>
  </div>
  </li>

  </div>
</cfoutput>
</ul>
</div>
  <!-- clr end -->
  <div class="clr"></div>
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