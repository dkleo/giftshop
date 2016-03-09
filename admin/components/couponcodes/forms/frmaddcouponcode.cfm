<h2>New Coupon Code</h2>
<script language="Javascript">
function ShowSymbol() {
if (form1.PromoType.value == 'PercentOff') {
	MoneySign.style.visibility = 'hidden';
	PercentSign.style.visibility = 'visible';
	}
if (form1.PromoType.value == 'AmountOff') {
	MoneySign.style.visibility = 'visible';
	PercentSign.style.visibility = 'hidden';
	}

}
</script>

<cfset TempExpiresOn = now() + 7>

<cfparam name = "PromoCode" default="">
<cfparam name = "ExpiresOn" default='#Dateformat(TempExpiresOn, "m/dd/yyyy")#'>
<cfparam name = "AmountOff" default="">
<cfparam name = "CategoryID" default="0">
<cfparam name = "PromoType" default="PercentOff">
<cfparam name = "TimesAllowed" default="1">
<cfparam name = "CanBeCombined" default="Yes">
<cfparam name = "cLimit" default="1">

<cfif ISDEFINED('form.CategoryID')>
	<cfinclude template = "../queries/qryproducts.cfm">
</cfif>

<p><strong>Create a coupon code:</strong></p>
<cfoutput>
<cfif NOT ISDEFINED('form.CategoryID')>
<cfform name="form1" method="post" action="index.cfm?action=new">
      <table width="100%" border="0" cellspacing="0" cellpadding="1">
        <tr> 
          <td>Code: 
            <cfinput name="promocode" type="text" size="30" value="#PromoCode#" required="Yes" message="You must create a code to represent this coupon"></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>Expiration Date: 
            <cfinput name="ExpiresOn" type="text" id="ExpiresOn" size="10" Value='#ExpiresOn#' required="Yes" message="You must provide a valid end date for this sale"> 
            <a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=ExpiresOn&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false"><img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a></td>
          <td width="18%">Type: 
            <select name="PromoType" id="DiscountType" Onchange="ShowSymbol()">
              <option value="PercentOff" <cfif PromoType IS 'PercentOff'>SELECTED</cfif>>Percent 
              Off</option>
              <option value="AmountOff" <cfif PromoType IS 'AmountOff'>SELECTED</cfif>>Amount 
              Off</option>
            </select></td>
          <td width="20%"><a Name="MoneySign" id="MoneySign" style="visibility: hidden">$</a> 
            <cfinput type = "text" name="AmountOff" size="3" value="#AmountOff#" required="Yes" message="You need to enter an amount off"> 
            <a Name="PercentSign" id="PercentSign" style="visibility: visible">%</a></td>
          <td width="19%">&nbsp;</td>
        </tr>
        <tr> 
          <td>Times this can be used: 
            <input name="TimesAllowed" type="text" id="TimesAllowed" size="4" Value='#TimesAllowed#'></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"><p>Can this coupon code be combined with other coupon 
              codes?<br>
              <font size="1">NOTE: (select 'No' if you don't want your customers 
              using other coupons with this one to get a bigger discount on the 
              specified item or category.)</font></p>
            <p>&nbsp;</p>
            </td>
          <td colspan="2" valign="top"><select name="CanBeCombined">
              <option <cfif CanBeCombined IS 'Yes'>SELECTED</cfif>>Yes</option>
              <option <cfif CanBeCombined IS 'No'>SELECTED</cfif>>No</option>
            </select></td>
          <td></td>
        </tr>
        <tr>
          <td valign="top">Limit: 
            <cfinput name="cLimit" type="text" id="cLimit" value="#cLimit#" size="5" required="Yes" Message="You must enter a value of at least '0' for limit">
            (Enter 0 for no limit)</td>
          <td colspan="2" valign="top"><font size="1">Note: Limit is for coupons 
            applied to a specific category or product only. Limit is not used 
            for coupons applying to the entire store. Coupons applying to the 
            entire store are taken off the orders total.</font></td>
          <td></td>
        </tr>
        <tr> 
          <td valign="top"><p><strong>Choose a Category to Apply this to:</strong></p>
            <p> 
              <cfselect name="CategoryID" size="12" required="Yes" message="Please select a category or choose Entire Catalog" onclick="this.form.submit();">
                <option value = "0">Entire Catalog</option>
                <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#CategoryID#"
				Datasource="#request.dsn#"> 
              </cfselect>
            </p></td>
          <td colspan="2" valign="top"><p><strong>Choose a Product to Apply this 
              to:</strong></p>
            <p> 
              <select name="ProductID" size="12" <cfif NOT ISDEFINED('form.CategoryID')>disabled</cfif>>
                <cfif NOT ISDEFINED('form.CategoryID')>
                  <option value="0">Choose from box on left</option>
                </cfif>
                <cfif ISDEFINED('form.CategoryID')>
                  <option value = "0" SELECTED>Entire Category</option>
                  <cfloop query = 'qryProducts'>
                    <option value = '#ItemID#'>#qryProducts.ProductName#</option>
                  </cfloop>
                </cfif>
              </select>
            </p></td>
          <td></td>
        </tr>
      </table>
</cfform>

<cfelse>

<cfform name="form1" method="post" action="index.cfm">
      <table width="100%" border="0" cellspacing="0" cellpadding="1">
        <tr> 
          <td>Code: 
            <cfinput name="promocode" type="text" size="30" value="#PromoCode#" required="Yes" message="You must create a code to represent this coupon"></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>Expiration Date: 
            <cfinput name="ExpiresOn" type="text" id="ExpiresOn" size="10" Value='#ExpiresOn#' required="Yes" message="You must provide a valid end date for this sale"> 
            <a href = "Calendar Control" onClick="JavaScript:window.open('calendar.html?form=form1&field=ExpiresOn&format=S&bgcolor=Yellow&txtcolor=Blue&hdrcolor=CornFlowerBlue&todaycolor=White&offset=0','cal','noresize,width=225,height=160');return false"><img border="0" src="icons/calendar.gif" width="16" height="16" alt="Select Date from Calendar"></a></td>
          <td width="18%">Type: 
            <select name="PromoType" Onchange="ShowSymbol()">
              <option value="PercentOff" <cfif PromoType IS 'PercentOff'>SELECTED</cfif>>Percent 
              Off</option>
              <option value="AmountOff" <cfif PromoType IS 'AmountOff'>SELECTED</cfif>>Amount 
              Off</option>
            </select></td>
          <td width="20%"><a Name="MoneySign" id="MoneySign" style="visibility: hidden">$</a> 
            <input type = "text" name="AmountOff" size="3" value="#AmountOff#"> 
            <a Name="PercentSign" id="PercentSign" style="visibility: visible">%</a></td>
          <td width="19%">&nbsp;</td>
        </tr>
        <tr> 
          <td>Times it can be used: 
            <input name="TimesAllowed" type="text" id="TimesAllowed" value="#TimesAllowed#" size="4"></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"><p>Can this coupon code be combined with other coupon 
              codes?</p>
            <p><font size="1">NOTE: (select 'No' if you don't want your customers 
              using other coupons with this one to get a bigger discount on the 
              specified item or category.</font></p></td>
          <td colspan="2" valign="top"><select name="CanBeCombined">
              <option <cfif CanBeCombined IS 'Yes'>SELECTED</cfif>>Yes</option>
              <option <cfif CanBeCombined IS 'No'>SELECTED</cfif>>No</option>
            </select></td>
          <td></td>
        </tr>
        <tr> 
        <tr>
          <td valign="top">Limit: 
            <cfinput name="cLimit" type="text" id="cLimit" value="#cLimit#" size="5" required="Yes" message="You must enter a value of at least '0' for limit."></td>
          <td colspan="2" valign="top"><font size="1">Note: Limit is for coupons 
            applied to a specific category or product only. Limit is not used 
            for coupons applying to the entire store. Coupons applying to the 
            entire store are taken off the orders total.</font></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"><p><strong>Choose a Category to Apply this to:</strong></p>
            <p> 
              <select name="CategoryID" size="12" disabled>
                <option value = "0" <cfif form.CategoryID IS '0'>SELECTED</cfif>>Entire 
                Catalog</option>
                <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#CategoryID#"
				Datasource="#request.dsn#"> 
              </select>
              <input type = "hidden" Name="CategoryID" Value="#form.categoryID#">
            </p></td>
          <td colspan="2" valign="top"><p><strong>Choose a Product to Apply this 
              to:</strong></p>
            <p> 
              <select name="ProductID" size="12" <cfif NOT ISDEFINED('form.CategoryID')>disabled</cfif>>
                <cfif NOT ISDEFINED('form.CategoryID')>
                  <option value="0">Choose from box on left</option>
                </cfif>
                <cfif ISDEFINED('form.CategoryID')>
                  <cfif NOT form.CategoryID IS '0'>
                    <option value = "0" SELECTED>Entire Category</option>
                    <cfelse>
                    <option value = "0" SELECTED>Entire Catalog</option>
                  </cfif>
                  <cfloop query = 'qryProducts'>
                    <option value = '#ItemID#'>#qryProducts.ProductName#</option>
                  </cfloop>
                </cfif>
              </select>
            </p></td>
          <td> <cfif ISDEFINED('form.categoryID')>
              <input type="hidden" name="action" value="add">
              <input type="submit" value="Create Coupon" name="submitbutton">
            </cfif></td>
        </tr>
      </table>
</cfform>
</cfif>
</cfoutput>
<p><strong></strong></p>
<p>&nbsp;</p>
</body>
</html>




















