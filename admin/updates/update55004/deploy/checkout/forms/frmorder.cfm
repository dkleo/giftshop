<!--- If the cart is empty, then display a message and link to return to the catalog--->
<cfset processpage = 'Yes'>

<cfoutput>
<cfif NOT isdefined('session.CrtProductID')>
<p align="center"><b><font color="##FF0000">Your shopping Cart is empty</font></b>
      <br>
		<img src="images/defaults/shoppingcart.gif">
		<p>
      <center><a href="index.cfm?carttoken=#carttoken#"><font size="2" face="Verdana">Back to Catalog</font></a></center>
<cfset processpage = 'No'>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</cfif>
</cfoutput>


<cfif processpage IS 'Yes'>

<cflock scope="Session" type="EXCLUSIVE" timeout="10">
<cfoutput>
<cfset cart.CrtProductID = '#session.CrtProductID#'>
<cfset cart.CrtProductName = '#session.CrtProductName#'>
<cfset cart.CrtQuantity = '#session.CrtQuantity#'>
<cfset cart.CrtPrice = '#session.CrtPrice#'>
<cfset cart.CrtWeight = '#session.CrtWeight#'>
<cfset Cart.CrtThumbNails = '#session.CrtThumbNails#'>
<cfset Cart.CrtItemID = '#session.CrtItemID#'>
<cfset Cart.CrtCoupons = '#session.CrtCoupons#'>
<cfset cart.CrtOptionFields = '#session.CrtOptionFields#'>
</cfoutput>
</cflock>

<cfoutput>
<cfif #ListLen(Cart.CrtProductID, "^")# IS 0>
<p align="center">&nbsp;</p>
  <center>
  <div align="center"><b><font color="##FF0000">Your shopping Cart is empty</font></b> 
	  <br>
	<img src="images/defaults/shoppingcart.gif">
  </div>
  <div align="center">
<a href="index.cfm?carttoken=#carttoken#">Back to Catalog</a>
<cfset processpage = 'No'></div>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</cfif>
</cfoutput> 

<cfif NOT #ListLen(Cart.CrtProductID, "^")# IS 0>
<cfset CrtTotal = 0> <!---Used to determine the price of items in the cart--->
<cfset CartTaxTotal = 0> <!---Is used when figuring up the amount that is taxed--->
<cfset TotalItemsInCart = 0> <!---The actual Number of items in the cart--->
<cfset ShippingTotal = 0> <!---Total to base shipping charges on for Price/percentage based calculations--->
<cfset ShippingItems = 0> <!---Total to base shipping charges on for Quantity Based calculations--->
<cfset Cart.TotalCartWeight=0> <!---Total weight of the items in the cart for weight based calculations--->
<cfset TotalShipItems = 0>
<cfset TotalShippingCosts = 0>
<cfset freeshipping = "No">
<!---for gift cards--->
<cfset giftcode = ''>
<cfset gMessage = 'Credits'>
<cfset couponstotal = 0>
<cfset cart.surcharges = 0>
<cfset askforshipping = 'No'>
<cfset m_afftotal = 0>
<cfset afftotal = 0>
<cfset recur_total = 0>
<cfset subscription_items = ''>

<!---for membership commission, which is special to BT--->
<cfset give_mcomm = 'No'>

<!---Set values for figuring out gift certificate--->
<cfif isdefined('form.giftcode')>
	<cfset giftcode = form.giftcode>
</cfif>

<cfset GiftCardTotal = '0.00'>

<!---displays what is in the cart--->
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="ViewCartTableContainer">
<tr>
	<td colspan="2">	  
		
		<!---Show items ordered---> 
        <table width="100%" cellspacing="0" cellpadding="3" class="ViewCartTable">
		<tr>
            <td height="19" colspan="4" nowrap>
                <table width="100%" border="0" cellspacing="0" cellpadding="4">
                  <tr>
                    <td width="86%"><strong>Your cart contains the following <cfoutput>#ListLen(Cart.CrtProductID, "^")#</cfoutput> Item(s):</strong></td>
                    <td width="14%"><div align="right"><a href="index.cfm?action=view">Edit Cart Contents</a></div></td>
                  </tr>
                </table>
                </td>
		</tr>
		<tr> 
			<td width="80%" align="left" nowrap class="TableTitles"><div align="left"><b>Name</b></div></td>
			<td width="5%" nowrap class="TableTitles"><b>Qty</b></td>
			<td width="5%" nowrap class="TableTitles"><div align="center"><strong>Price Each</strong></div></td>
			<td width="10%" align="center" class="TableTitles"><div align="right"><strong>Total</strong></div></td>
		</tr>
		<!---loop over the items in the shopping cart--->
		<cfloop index="IndexCount" from="1" To="#ListLen(Cart.CrtProductID, "^")#">
		<cfset isrecitem = 'No'>
		<!---Creates a variable for tracking the actual number of items in the cart--->
		<cfset TotalItemsInCart = #TotalItemsInCart# + #ListGetAt(Cart.CrtQuantity, IndexCount, " ^")#>
        <!---Pick out the the item for the list and get it's info--->
        <cfset ThisItemID = "#ListGetAt(Cart.CrtItemID, indexcount, "^")#">
        <cfset ThisProductID = '#ListGetAt(Cart.CrtProductID, IndexCount, "^")#'>
        <cfset ThisQuantity = '#ListGetAt(Cart.CrtQuantity, IndexCount, "^")#'>
        <cfset ThisWeight = '#ListGetAt(Cart.CrtWeight, IndexCount, "^")#'>
        <cfset NumberOfThisItem = #ListGetAt(Cart.CrtQuantity, IndexCount, " ^")#>

		<!---If the membership item is found then set a variable so we can tell if someone gets the membership signup bonus/commission--->
        <cfset PriceEach = #ListGetAt(Cart.crtPrice, IndexCount, "^")# / #NumberOfThisItem#>
        <!---The price of Each of these item--->
        <cfset ThisItemWeight = #ThisWeight# * #NumberOfThisItem#>
        <!---Weight based on number of this item in the cart---->
        <cfset TotalOfItems = #ListGetAt(Cart.CrtPrice, IndexCount, "^")#>
        <!---The total price of this item in the shopping cart--->
        <!---Query the database to see if this item gets taxes and shipping applied to it--->
        <cfquery name = "FindProduct" datasource = "#request.dsn#">
        SELECT * FROM products WHERE ItemID = <cfqueryparam value="#ThisItemID# " cfsqltype="cf_sql_varchar">
        </cfquery>

		<!---check if it's a recuring item and if so then add to recuring total (not cart total)--->
        <cfquery name = "qIsSub" datasource="#request.dsn#">
        select * from products_subscriptions
        where itemid = <cfqueryparam value="#ThisItemID#" cfsqltype="cf_sql_varchar">
        </cfquery>        
        
        <!---if this is a recuring item (it is charged on a monthly or yearly basis) then add to recurring total not the carttotal)--->
        <cfif qIsSub.recordcount GT 0>
          	<cfif NOT qIsSub.r_frequency IS 'N'>
            	<cfset isrecitem = 'yes'>
                <!---create a list of subscription items on this order--->
                <cfset subscription_items = listappend(subscription_items, ThisItemID)>
            </cfif>
        </cfif>
        
        <!---For shipping based on weight, figure the weight in if charging for shipping--->
        <cfif FindProduct.ChargeShipping IS 'Yes'>
        	<cfset Cart.TotalCartWeight = #Cart.TotalCartWeight# + #ThisItemWeight#>
        </cfif>
        <!---For Quantity based shipping, determine if this should be included in the shipping calculation--->
        <cfif FindProduct.ChargeShipping IS 'Yes'>
        	<cfset ShippingItems = #ShippingItems# + (#ListGetAt(Cart.CrtQuantity, IndexCount, " ^")#)>
        </cfif>
        <!---For percentage based and price based shipping, check to see if this is something to
              charge shipping for.  If so add to the price of the items to charge shipping for.--->
        <cfif FindProduct.ChargeShipping IS 'Yes'>
        	<cfset ShippingTotal = #ShippingTotal# + #TotalOfItems#>
        </cfif>
        <!---if at least one item on this order needs to have shipping info collected, then ask for it--->
        <cfif FindProduct.askforshipping IS 'Yes'>
        	<cfset askforshipping = 'Yes'>
        </cfif>
		
       	<cfset afftotal = afftotal + #TotalOfItems#>
        
        <cfoutput> 
		<tr> 
		  <td height="50" align="left" valign="middle" class="cartcontents">
          <div align="left">#ListGetAt(Cart.CrtProductID, IndexCount, "^")# - #ListGetAt(Cart.CrtProductName, IndexCount, "^")#</div>
        	<cfif isrecitem IS 'yes'>
          	<em><strong>This is a subscription item.  You will pay #lscurrencyformat(qIsSub.r_startupfee, "Local")# today and your credit card will be
            billed #lscurrencyformat(qIsSub.r_fee, "Local")# per <cfif qIsSub.r_frequency IS 'M'>month</cfif><cfif qIsSub.r_frequency IS 'Y'>year</cfif></strong></em>
          </cfif>
          
          <!---checks to make sure they are not ordering a duplicate subscription and warns them they are already subscribed.--->
          <cfif isdefined('cookie.CustEmail')>
          	<cfquery name = "qCustLookup" datasource="#request.dsn#">
            SELECT * FROM customerhistory WHERE emailaddress = '#cookie.CustEmail#'
            </cfquery>
            
            <cfif qCustLookup.recordcount GT 0>
				<!---get r_id matching this itemid--->
			  	<cfquery name="qThiss" datasource="#request.dsn#">
            	SELECT * FROM products_subscriptions
                WHERE itemid = '#thisitemid#'
                </cfquery>

            	<cfquery name="qSubs" datasource="#request.dsn#">
            	SELECT * FROM customers_subscriptions
                WHERE customerid = '#qCustLookup.customerid#' AND status = 'Active' AND r_id = '#qThiss.r_id#'
                </cfquery>
               
                <cfif qSubs.recordcount GT 0>
                <p><font color="##FF0000"><strong>You have already purchased this subscription.</strong></font></p>
                <a href = "index.cfm?action=myaccount">Click here</a> to login to your account watch it.
 				</cfif>                  
          	</cfif>
          </cfif>
          
          </td>
		  <td valign="middle" class="cartcontents"> 
			<div align="center"> #ListGetAt(Cart.CrtQuantity, IndexCount, " ^")# </div>
          </td>
		  <td valign="middle" class="cartcontents" align="center"> 
			  <cfif request.EnableEuro IS 'Yes'>
                #lseurocurrencyformat(PriceEach, "Local")#
                <cfelse>
                #lscurrencyformat(PriceEach, "Local")# 
              </cfif>
          </td>
		  <td align="right" class="cartcontents"> 
			<div align="right">
			  <cfif request.EnableEuro IS 'Yes'>
                #lseurocurrencyformat(TotalOfItems, "Local")# 
                  <cfelse>
                  #lscurrencyformat(TotalOfItems, "Local")#
              </cfif>
            </div>
         
		<!---Add in the total of this item to the CrtTotal Variable.  This total is before taxes, discounts and shipping--->
		
		<cfif isrecitem IS 'No'>
			<cfset CrtTotal = CrtTotal + TotalOfItems>
        <cfelse>
        	<cfset recur_total = recur_total + totalofitems>
        </cfif>
<!---If this item is subject to sales tax then add it's total to the tax total variable--->
<cfif FindProduct.ChargeTaxes IS 'Yes'>
	<cfset CartTaxTotal = #CartTaxTotal# + #TotalOfItems#>
</cfif>
<!---If the ship type is 8 this means that they are specifying a shiping price for each item.  So then add in the shipping 
cost for this item now--->
<cfif request.ShippingType IS '8'>
	<cfset TotalShippingCosts = TotalShippingCosts + (#FindProduct.ShippingCosts# * #ListGetAt(Cart.CrtQuantity, IndexCount, " ^")#)>
    <cfset flatrate.TotalShippingCosts = TotalShippingCosts>
</cfif>

         </td>
		</tr>
		</cfoutput> 
		</cfloop>
		
        <!---END DISPLAY OF PRODUCTS--->

		<!---***Figure in coupons***--->
		<cfif listlen(cart.crtCoupons, "^") GT 0>
        <tr> 
        <td colspan="4" valign="middle" class="TableTitles"><div align="left"><strong>Coupon 
          Codes</strong></div></td>
        </tr>
        <tr> 
		<td height="50" colspan="4" valign="middle" class="cartcontents">
			<cfinclude template = "../actions/actfigurecoupons.cfm">
         </td>
		</tr>
		</cfif>

	</table><!---end of table containing items and coupons--->

</td>
</tr>
          
<!---Check for optional URL variables for shipping and taxes.  If they exist, include the action files--->
<cfif isdefined('FigureShipping')>
	<cfif askforshipping IS 'Yes'>
	  <cfinclude template = "../actions/actfigureshipping.cfm">
    </cfif>
</cfif>
<cfif isdefined('FigureTaxes')>
  <cfinclude template = "../actions/actfiguretaxes.cfm">
</cfif>
<cfif isdefined('Figurepromos')>
  <cfinclude template = "../actions/actfigurepromos.cfm">
</cfif>
<!---If an update for shipping was called, set the shipping rate to whatever it was updated to--->
<cfif ISDEFINED('form.ShippingMethod')>
  <cfset request.ShippingMethod = '#form.ShippingMethod#'>
</cfif>
<!---if an update to shipping was called then set the variables--->
<cfif ISDEFINED('form.UPSShipping')>
  <cfset Cart.DefaultService = '#ListGetAt(form.UPSShipping, 1)#'>
  <cfset request.ShippingMethod = '#ListGetAt(form.UPSShipping, 1)#'>
  <cfset request.ShippingCharges = '#ListGetAt(form.UPSShipping, 2)#'>
  <cfset Cart.TotalShippingCosts = '#request.ShippingCharges#'>
</cfif>

<!---show the Cart Total, the shipping, taxes, discounts, and the the grand total--->
<tr>
<td colspan="4">


	<!---CART TOTALS--->
    <table width="100%" cellpadding="4" cellspacing="0">
    
    <!---CartTotal--->
    <tr> 
        <td width="88%" align="right" valign="top">Cart total:</td>
        <td width="25%" align="right" class="CartTotals"><cfoutput>#lscurrencyformat(CrtTotal, "Local")#</cfoutput></td>
    </tr>
    
    <!---Discounts--->
    <cfset GiftSubTotal = CrtTotal>
    <cfif ISDEFINED('CouponsTotal')>
        <cfset GiftSubTotal = CrtTotal - CouponsTotal>
        <cfif CouponsTotal GT 0>
            <tr>
              <td><div align="right">Discounts:</div></td>
              <td align="right" class="CartTotals"> 
              <cfoutput>#lscurrencyformat(CouponsTotal, "Local")#</cfoutput>              </td>					
            </tr>
        </cfif>
    </cfif>
    
    <!---Gift Card Credits--->
    <cfinclude template = "../actions/actfiguregiftcard.cfm">
    <tr>
      <td><div align="right"><cfoutput>#gMessage#</cfoutput>:</div></td>
          <td align="right" class="CartTotals"> 
          <cfoutput> 
                #lscurrencyformat(GiftCardTotal, "Local")#            </cfoutput>          </td>					
    </tr>	
    <!---Taxes--->
    <cfif ISDEFINED('Cart.FiguredTax')>
    <tr>
        <td><div align="right">Taxes:</div></td>
        <td align="right" class="CartTotals"> 
        <cfoutput> 
        #LSCurrencyformat(Cart.FiguredTax, "Local")#        </cfoutput>        </td>
    </tr>
    <cfelse>
          <cfset Cart.FiguredTax = 0>
    </cfif> 
    
    <!---shipping--->
    <cfif isdefined('flatrate.TotalShippingCosts') OR ISDEFINED('Cart.TotalShippingCosts')>   
    <tr>
    <td width="88%" align="right"> 
    <cfif freeshipping IS "Yes"><b>Free</b></cfif> Shipping &amp; Handling<cfif ISDEFINED('form.UPSShipping')>(<strong>Updated</strong>)</cfif>: 
          
      <cfif ISDEFINED('request.ShipFromState')>
        <cfoutput>(From #request.ShipFromState#, #request.ShipFromCountry# 
        <cfif isdefined('Cart.DefaultService')>by #Cart.DefaultService#</cfif>
        <cfif isdefined('Cart.TotalCartWeight')> -  #Cart.TotalCartWeight# #qryCompanyInfo.UnitOfMeasure#)</cfif>)        </cfoutput> 
      </cfif>      </td>
      <td width="25%" align="right" class="CartTotals"> 
      
        <cfif isdefined('flatrate.TotalShippingCosts')>
            <cfset Cart.TotalShippingCosts = flatrate.TotalShippingCosts>
        </cfif>
        <cfif ISDEFINED('Cart.TotalShippingCosts')>
          <cfoutput> 				  
             #LSCurrencyformat(Cart.totalshippingcosts, "Local")#          </cfoutput>
        </cfif>        </td>			
    </tr>
    </cfif>

        <cfif NOT isdefined('Cart.TotalShippingCosts')>
            <cfset Cart.TotalShippingCosts = 0>
        </cfif>

    
    <!---Order Total--->
    <tr>
        <td align="right"><b> Total:</b></td>
        <cfset GrandTotal = CrtTotal + Cart.FiguredTax + Cart.TotalShippingCosts - CouponsTotal - GiftCardTotal + recur_total>
        <td width="25%" align="right" class="CartTotals">
        <cfoutput><strong>#lscurrencyformat(GrandTotal, "Local")#</strong></cfoutput></td>
    </tr>
    </table>
    <!---END CART TOTALS TABLE--->
</td>
</tr>

<!---end cart totals row--->

</table><!---end order table--->	

<!---vars to use in form fields--->
<cfset TotalOrderedItems = GrandTotal - recur_total>
<cfset TotalSubscriptionItems = recur_total>

</cfif><!---end if there are items in the cart (55)--->
</cfif><!---end if process page is yes (54)--->