<!---
  Created by Derek on 3/6/16.
--->
<cfscript>
  currentPage = getToken(cgi.script_name, 3, "/");
  currentPage = isNull(currentPage) ? "index.cfm" : currentPage;
</cfscript>
<div class="menu_nav">
  <div id="nav-wrap">
    <ul class="arrowunderline" id="nav">
      <li class="specials" <cfif currentPage EQ "index.cfm">id="selected"</cfif>>
        <a href="index.cfm">Specials</a>
      </li>
          <li class="same_day_delivery" <cfif currentPage EQ "same_day_delivery.cfm">id="selected"</cfif>>
        <a href="same_day_delivery.cfm">Same Day Delivery</a>
      </li>
          <li class="get_well" <cfif currentPage EQ "get_well.cfm">id="selected"</cfif>>
        <a href="get_well.cfm">Get Well</a>
      </li>
          <li class="baskets" <cfif currentPage EQ "baskets.cfm">id="selected"</cfif>>
        <a href="baskets.cfm">Baskets</a>
      </li>
          <li class="checkout" <cfif currentPage EQ "cart.cfm">id="selected"</cfif>>
        <a href="cart.cfm">My Cart</a>
      </li>
    </ul>
  </div>
</div>