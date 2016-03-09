<cfparam name="CouponError" default="">

<cfoutput>
<script language="JavaScript">
 function ViewItem(itemid){
		window.location.href = 'index.cfm?action=ViewDetails&CartToken=#CartToken#&ItemID=' + itemid;
 }
</script>
</cfoutput>

<cfif NOT isdefined('session.CrtItemID') OR NOT isdefined('session.CrtProductID') OR NOT isdefined('session.CrtProductName') OR NOT isdefined('session.CrtQuantity') OR NOT isdefined('session.CrtPrice')
OR NOT isdefined('session.CrtWeight') OR NOT isdefined('session.CrtThumbNails') OR NOT isdefined('session.CrtOptions') OR NOT isdefined('session.CrtOptionFields') OR NOT isdefined('session.CrtType')
OR NOT isdefined('session.CrtApproved') OR NOT isdefined('session.CrtCoupons')>

<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
	<cfset session.CrtItemID="">
    <cfset session.CrtProductID="">
    <cfset session.CrtProductName = "">
    <cfset session.CrtQuantity = "">
    <cfset session.CrtPrice = "">
    <cfset session.CrtWeight = "">
    <cfset session.CrtThumbNails = "">
    <cfset session.Crtoptions = "">
    <cfset session.CrtOptionFields = "">
    <cfset session.CrtType = "">
    <cfset session.CrtApproved = "">
    <cfset session.CrtCoupons = "">
    <cfset session.wishlist = "">
    <cfset session.affilid = "">
    <cfset cookie.carttoken = "">
</cflock>

</cfif>

<cfif isdefined('session.CrtProductID')>
    <cflock scope="Session" type="EXCLUSIVE" timeout="10">
    <cfoutput>
    <cfset cart.CrtProductID = '#session.CrtProductID#'>
    <cfset cart.CrtProductName = '#session.CrtProductName#'>
    <cfset cart.CrtQuantity = '#session.CrtQuantity#'>
    <cfset cart.CrtPrice = '#session.CrtPrice#'>
    <cfset cart.CrtWeight = '#session.CrtWeight#'>
    <cfset cart.CrtThumbNails = '#session.CrtThumbNails#'>
    <cfset cart.CrtItemID = '#session.CrtItemID#'>
    <cfset cart.CrtCoupons = '#session.CrtCoupons#'>
    <cfset cart.CrtOptionFields = '#session.CrtOptionFields#'>
    </cfoutput>
    </cflock>
<cfelse>
    <cfset cart.CrtProductID = ''>
    <cfset cart.CrtProductName = ''>
    <cfset cart.CrtQuantity = ''>
    <cfset cart.CrtPrice = ''>
    <cfset cart.CrtWeight = ''>
    <cfset cart.CrtThumbNails = ''>
    <cfset cart.CrtItemID = ''>
    <cfset cart.CrtCoupons = ''>
    <cfset cart.CrtOptionFields = ''>
</cfif>    

<cfset TotalCartWeight=0>
<cfset TotalItemsInCart = 0>
<cfset CouponsTotal = 0>

<div>
<cfoutput><p>
<cfif #ListLen(Cart.CrtProductID, "^")# IS 0>
<center><h5>Your Cart is Empty</h5>
<img src="images/defaults/shoppingcart.gif" />
</center>
<p><cfset Cart.CartTotal = 0>

<center><a href="index.cfm?CartToken=#CartToken#"><font size="2" face="Verdana">Back to Catalog</font></a></center>

<!---removes all coupon codes if the cart it emptied--->
<cflock scope="session" type="exclusive" timeout="10">
	<cfset session.CrtCoupons = ''>
</cflock>

</cfif>
</cfoutput>

<cfif NOT #ListLen(Cart.CrtProductID, "^")# IS 0>

<table width="100%" class="ViewCartTableContainer" cellspacing="0" cellpadding="0">
<tr>
<td>

  <cfset CrtTotal = 0>
  <p><b>Your cart contains the following <cfoutput>#ListLen(Cart.CrtProductID, "^")#</cfoutput> Item(s):</b> 
    <cfset CrtTotal = 0>
  </p>
  
<cfform name="cartform" action="index.cfm?CartToken=#CartToken#" METHOD = "POST">

  <div align="center"> 
        <table width="100%" border="0" cellpadding="4" cellspacing="0" class="ViewCartTable">
          <tr> 
            <!---Display the thumbnail if enabled and it is included--->
			<td valign="middle" class="TableTitles" <cfif request.CartThumbnails IS 'Yes'>width="15%"</cfif>><div align="left" class="viewcarttitle"></div></td>
            <td width="40%" valign="middle" class="TableTitles"><div align="left" class="viewcarttitle">Item</div></td>
            <td width="10%" valign="middle" class="TableTitles"><div align="center" class="viewcarttitle">Each</div></td>
            <td width="10%" valign="middle" class="TableTitles"><div align="center" class="viewcarttitle">Remove</div></td>
            <td width="15%" valign="middle" class="TableTitles"><div align="center" class="viewcarttitle">Quantity</div></td>
            <td width="25%" align="center" valign="middle" class="TableTitles"><div align="right"class="viewcarttitle">Price</div></td>
          </tr>
          <cfset mycount=1>
          <cfoutput> 
            <cfloop index="IndexCount" from="1" To="#ListLen(Cart.CrtProductID, "^")#">
              <cfset ThisProductID = '#ListGetAt(Cart.CrtProductID, IndexCount, "^")#'>
              <cfset ThisQuantity = '#ListGetAt(Cart.CrtQuantity, IndexCount, " ^")#'>
              <cfset ThisItemID = '#ListGetAt(Cart.CrtItemID, IndexCount, " ^")#'>
              <cfset TempItemID = ThisItemID>
              <cfset ThisThumbNail = '#ListGetAt(Cart.CrtThumbNails, IndexCount, "^")#'>
              <cfset ThisWeight = '#ListGetAt(Cart.CrtWeight, IndexCount, "^")#'>
              <cfset NumberOfThisItem = #ListGetAt(Cart.CrtQuantity, IndexCount, " ^")#>
              <cfset TotalCartWeight = #TotalCartWeight# + (#ThisWeight# * #ThisQuantity#)>
              <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                <td valign="middle"  class="cartcontents"> 
				 <center>
                  <cfif request.CartThumbnails IS 'Yes'>
                        <img src="#request.secureurl#photos/tiny/#ThisThumbnail#" border="0" />
                   </cfif>
                </center>				</td>
                    <td align="left" valign="middle" class="cartcontents" onclick="ViewItem(#thisitemid#);"> 
			    #ListGetAt(Cart.CrtProductName, IndexCount, "^")#</td>
                <td  class="cartcontents"><div align="center"> 
                    <cfset TotalOfItems = #ListGetAt(Cart.CrtPrice, IndexCount, "^")#>
                    <cfset QuantityOfItem = #ListGetAt(Cart.CrtQuantity, IndexCount, "^")#>
                    <cfset PriceEach = TotalOfItems / QuantityOfItem>
                    <cfif #request.EnableEuro# IS 'Yes'>
                      #lseurocurrencyformat(PriceEach, "Local")# 
                </cfif>
                    <cfif NOT #request.EnableEuro# IS 'Yes'>
                      #lscurrencyformat(PriceEach, "Local")# 
                  </cfif>
                </div></td>
                <td class="cartcontents"> <div align="center"> 
                    <cfinput type="checkbox" name="DeleteList" value="#thisitemid#">
                    <cfinput type="Hidden" Name = "CartIndex" Value = "#IndexCount#">
                </div></td>
                <td class="cartcontents"><p align="center"> 
                    <cfinput type="hidden" Name="OldQuantity" Value="#ListGetAt(Cart.CrtQuantity, IndexCount, " ^")#">
                    <input type = "text" name = "ChangeQuantity" value="#ListGetAt(Cart.CrtQuantity, IndexCount, " ^")#" size="4" />
                    <!---#ListGetAt(Cart.CrtQuantity, IndexCount, " ^")#---></font> 
                    <cfset TotalItemsInCart = #TotalItemsInCart# + #ListGetAt(Cart.CrtQuantity, IndexCount, " ^")#>
                </p></td>
                <td class="cartcontents" height="1" align="right" valign="middle" > <cfset TotalOfItems = #ListGetAt(Cart.CrtPrice, IndexCount, "^")#> 
                  <cfif #request.EnableEuro# IS 'Yes'>
                    <div align="right">#lseurocurrencyformat(TotalOfItems, "Local")# </div>
                  </cfif> <cfif NOT #request.EnableEuro# IS 'Yes'>
                    <div align="right">#lscurrencyformat(TotalOfItems, "Local")# </div>
                  </cfif></td>
                <cfset CrtTotal = #CrtTotal# + #TotalOfItems#>
              </tr>
              <cfif mycount IS 2>
                <cfset mycount = 0>
              </cfif>
              <cfset mycount = mycount + 1>
            </cfloop>
          </cfoutput> 
		  <!---figure total--->
          <cfset Cart.OrderTotal = #CrtTotal#>
          <cfset Cart.TotalItemsInCart = #TotalItemsInCart#>

		  <cfif NOT request.enablecoupons IS 'No'>
          <tr> 
            <td colspan="6" align="left" valign="middle" class="cartcontents">
            
            <!---Coupon Code Table--->
            <table width="100%" cellpadding="2" cellspacing="0" class="CouponCodeTable">
            <tr>
            <td>
            <strong>Enter
                a Coupon  Number (if you have one):</strong></td>
          </tr>
  
          <tr> 
            <td colspan="6" align="left" valign="middle">
			<cfinput name="CouponCode" type="text" id="CouponCode" size="30"> 
			<a href = "##" onclick="cartform.submit();">Add Coupon</a><br /></td>
          </tr>
          </table>          
          </td>
   		</tr>
		</cfif>
        
<!---*********FIGURE IN COUPONS*******--->

<cfif not #ListLen(cart.CrtCoupons, "^")# IS 0>
    <tr>
    <td colspan = '6'>
	<table width="100%" cellpadding="6" cellspacing="0">
	<tr> 
	  <td width="25%" align="left" valign="middle" class="TableTitles"><strong><font size="1">Coupon Code</font></strong></td>
	  <td align="left" valign="middle" class="TableTitles"><font size="1"><strong>Description</strong></font></td>
	  <td width="10%" align="left" valign="middle" class="TableTitles"><div align="center"><font size="1"><strong>Remove</strong></font></div></td>
	</tr>

    <cfloop from="1" to="#listlen(cart.CrtCoupons, '^')#" index='maincouponcount'>
	  	<cfset ThisCoupon = #ListGetAt(cart.CrtCoupons, maincouponcount, "^")#>
	  	<cfinclude template = '../queries/qrycoupons.cfm'>
	  	<cfset limitstring = ''>
	  	<!---If there's a limit specify there is (not applicable to entire catalog coupons)--->
	  	<cfif NOT #qryCoupons.cLimit# IS 0>
			<cfset limitstring = 'limit #qryCoupons.cLimit#'>
	 	 </cfif>

	  	<!---***Set the description***--->
		<cfinclude template = "crtFigureCoupons.cfm">

		  <cfoutput> 
			<tr> 
			  <td align="left" valign="middle" class="CouponRow">#ThisCoupon#</td>
			  <td align="left" valign="middle" class="CouponRow">#ThisDescription#</td>
			  <td valign="middle" class="CouponRow">
			    <div align="center">
			      <cfinput type="checkbox" name="RemoveCouponList" value="#maincouponcount#">
		          </div></td>
			</tr>
		  </cfoutput>
	</cfloop>
    </table>
    </td>
    </tr>
</cfif>
<!---*********END OF COUPONS*******--->

          <tr>
            <td valign="middle">&nbsp;</td>
            <td valign="middle"></td>
            <td valign="middle">&nbsp;</td>
            <td valign="middle">&nbsp;</td>
            <td valign="middle"><div align="right"><strong>Discounts:</strong></div></td>
            <td align="right" valign="middle" class="CartTotals">
			<cfif #request.EnableEuro# IS 'Yes'>
                <cfoutput>
                  <div align="right"><b>#lseurocurrencyformat(CouponsTotal, "Local")#</b></div>
                </cfoutput> 
              </cfif> 
			  <cfif NOT #request.EnableEuro# IS 'Yes'>
                <div align="right"><cfoutput><b>#lscurrencyformat(CouponsTotal, "Local")#</b></cfoutput>                  </div>
			  </cfif></td>
          </tr>
          <tr>
		  	<cfset CrtTotal = CrtTotal - CouponsTotal>
			<cfif CrtTotal LT 0><cfset CrtTotal = 0></cfif> 
            <td valign="middle">&nbsp;</td>
            <td valign="middle"> </td>
            <td valign="middle">&nbsp;</td>
            <td valign="middle">&nbsp;</td>
            <td valign="middle"><div align="right"><b>Total:</b></div></td>
            <td align="right" valign="middle" class="CartTotals">
			<cfif #request.EnableEuro# IS 'Yes'>
			    <div align="right"><cfoutput><b>#lseurocurrencyformat(CrtTotal, "Local")#</b></cfoutput>			        </div>
			</cfif>
			  <div align="right">
			    <cfif NOT #request.EnableEuro# IS 'Yes'>
			      <cfoutput><b>#lscurrencyformat(CrtTotal, "Local")#</b></cfoutput> 
			        </cfif>
			    </div></td>
            <cfset Cart.CartTotal = #CrtTotal#>
          </tr>
        </table>
    </div>
	<table width = "100%">
	<tr>
	    <td width="50%" valign="middle" colspan="3">
        <cfif isdefined('request.ContinueShopping')>
        <cfif len(trim(request.ContinueShopping)) GT 0>
		<cfoutput>
	        <a href = "index.cfm?CartToken=#CartToken#">
              <img src="#request.ContinueShopping#" name="ContinueShopping" id="ContinueShopping" border="0" alt="Checkout" 
              title="Checkout" class="CheckoutButton" onclick="location.replace('index.cfm?CartToken=#CartToken#')">
            </a>
        </cfoutput>
		</cfif>
        </cfif>
        </td>
		<td width="50%" valign="middle" colspan="3"><div align="right"> 
            <!---Display the Update Cart Button--->
            <cfinput type="Hidden" name="action" value="UpdateCart">
             <cfoutput> 
                <input type="Image" src="#request.UpdateCart#" name="UpdateCart" value="UpdateCart" alt="Update Cart" title="Update Cart" class="UpdateCartButton" id="Updatecart">
              </cfoutput> 
<!---Display the Proceed To Checkout Button--->		
	        <cfoutput>
	          <a href = "#request.SecureURL#index.cfm?action=checkout&CartToken=#CartToken#">
              <img src="#request.CheckoutButton#" name="CheckoutButton" id="CheckoutButton" border="0" alt="Checkout" title="Checkout" class="CheckoutButton" onclick="location.replace('#request.SecureURL#index.cfm?action=Checkout&CartToken=#CartToken#')">
	        </cfoutput> 
	    </div>
	 	</td>
	</tr>
 </table>
<p>
  <div align="center" class="CouponError"><cfoutput>#CouponError#</cfoutput></div>
</td>
</tr>
</table>
</cfform>
</cfif>
<p>
<!---Display cart version info--->
<cfquery name = "qryVersion" datasource="#request.dsn#">
SELECT version from versioninfo
</cfquery>