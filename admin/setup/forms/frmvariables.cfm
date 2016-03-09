<style>
	td{border-bottom: 1px #CCCCCC solid;}
</style>
<cfparam name = "ShowServerSettings" default="No">
<h2>Store Settings</h2>
<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfinclude template = "../queries/qrysellingareas.cfm"><strong> 
<cfoutput query = "qryCompanyInfo"> 
  <form method="Post" Action="dosetup.cfm">
  <table width="98%" border="3" align="center" cellpadding="0" cellspacing="0" bordercolor="##000000">
    <tr>
      <td><table width="100%" border="0" cellspacing="0" cellpadding="4">
            <tr>
              <td colspan="2" bgcolor="##000000"><strong><font color="##FFFFFF">Website  Settings</font></strong></td>
            </tr>
            
            <tr>
              <td width="40%"><strong>Navigation Menu Type:</strong></td>
              <td width="60%"><select name="NavMenuType" id="NavMenuType">
                <option value="Default" <cfif NavMenuType IS 'Default'>SELECTED</cfif>>Default</option>
                <option value="HTML" <cfif NavMenuType IS 'HTML'>SELECTED</cfif>>Custom HTML</option>
                <option value="Simple" <cfif NavMenuType IS 'Simple'>SELECTED</cfif>>Simple HTML Links (one level)</option>
                <option value="PullDown" <cfif NavMenuType IS 'PullDown'>SELECTED</cfif>>Pulldown Menu (three levels) *CF8 Required*</option>
                <option value="Flash" <cfif NavMenuType IS 'Flash'>SELECTED</cfif>>Flash Pulldown Menu (three levels)</option>
              </select></td>
            </tr>
            <tr>
              <td><strong>Password Protect Entire Site?</strong></td>
              <td><select name="PasswordSite" id="PasswordSite">
                <option <cfif PasswordSite IS 'Yes'>SELECTED</cfif>>Yes</option>
                <option <cfif NOT PasswordSite IS 'Yes'>SELECTED</cfif>>No</option>
              </select> <a href = "#request.AdminPath#helpdocs/password_protect_site.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>If you choose yes above, enter a password:</strong></td>
              <td><input type="text" name="sitepassword" id="sitepassword" value="#sitepassword#" /></td>
            </tr>
            <!---<tr>
              <td><strong>Require The Use of an Access Code To Enter the Site:</strong></td>
              <td><select name="UseAccessCodes" id="UseAccessCodes">
                <option <cfif UseAccessCodes IS 'Yes'>selected</cfif>>Yes</option>
                <option <cfif NOT UseAccessCodes IS 'Yes'>SELECTED</cfif>>No</option>
                </select> 
                <a href="#request.AdminPath#components/accesscodes/index.cfm" target="main">Manage Access Codes</a></td>
            </tr>--->
            <tr>
              <td><strong>Check for Updates:</strong></td>
              <td><select name="checkforupdates" id="checkforupdates" <cfif #left(server.ColdFusion.ProductVersion, 1)# LT 8>disabled="disabled"</cfif>>
                <option <cfif checkforupdates IS 'Yes'>SELECTED</cfif>>Yes</option>
                <option <cfif NOT checkforupdates IS 'Yes'>SELECTED</cfif>>No</option>
              </select>
                <a href = "#request.AdminPath#helpdocs/check_for_updates.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a> <cfif #left(server.ColdFusion.ProductVersion, 1)# LT 8>Disabled because this feature requires CF Server Version 8 or higher to work</cfif>                </td>
            </tr>
            <!---<tr>
              <td><strong>CKEditor Toolbar Mode:</strong></td>
              <td><select name="cckeditor_mode" id="cckeditor_mode">
                <option <cfif ckeditor_mode IS 'basic'>SELECTED</cfif> value="basic">Basic</option>
                <option <cfif ckeditor_mode IS 'full'>SELECTED</cfif> value="full">Advanced</option>
              </select></td>
            </tr>--->
            <tr>
              <td><strong>Use URL Rewrite:</strong></td>
              <td><select name="use_urlrewrite" id="use_urlrewrite">
                <option <cfif use_urlrewrite IS 'Yes'>selected="selected"</cfif>>Yes</option>
                <option <cfif use_urlrewrite IS 'No'>selected="selected"</cfif>>No</option>
              </select> 
                <a href="dosetup.cfm?action=urlrewrite">Rebuild htaccess File</a> <a href = "#request.AdminPath#helpdocs/url_rewriting.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a> <font color="##FF0000"><b>Server must support url rewriting!</b></font></td>
            </tr>
            <tr>
              <td><strong>Enabled Statistics Logging</strong></td>
              <td><select name="stats_enabled" id="stats_enabled">
                <option value="1" <cfif stats_enabled IS 1>SELECTED</cfif>>Yes</option>
                <option value="0" <cfif NOT stats_enabled IS  1>SELECTED</cfif>>No</option>
              </select> <a href = "#request.AdminPath#helpdocs/enable_statistics_logging.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><input type="submit" name="Submit7" value="Update Settings" /></td>
            </tr>
            <tr> 
              <td colspan="2" bgcolor="##000000"><font color="##FFFFFF"><strong>Catalog Images</strong></font></td>
            </tr>
			<input type = "hidden" name = "EnableAutoThumb" value="Yes" />
            
            <tr> 
              <td><strong>View thumbnails when viewing shopping cart:</strong></td>
              <td><select name="CartThumbNails">
                  <option <cfif CartThumbNails IS 'Yes'>SELECTED</cfif>>Yes</option>
                  <option <cfif CartThumbNails IS 'No'>SELECTED</cfif>>No</option>
                </select><a href = "#request.AdminPath#helpdocs/view_thumbnails_in_cart.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a> </td>
            </tr>
            <tr> 
              <td><b>Thumbnail width</b><b>:</b></td>
              <td><input type="text" name="ThumbSize" size="5" value="#ThumbSize#">px<input type = "hidden" name="oldthumbsize" value="#thumbsize#" /> <a href = "#request.AdminPath#/helpdocs/thumbnail_width.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Details Image Width:</strong></td>
              <td><input name="ImageSize" type="text" id="ImageSize" value="#ImageSize#" size="5" />px<input type = "hidden" name="oldimagesize" value="#imagesize#" /> <a href = "#request.AdminPath#/helpdocs/details_image_width.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Custom tag used to process images:</strong></td>
              <td><select name="ImageProcessor">
                <option <cfif ImageProcessor IS 'None'>SELECTED</cfif>>None</option>
                <option value="cfx_image" <cfif ImageProcessor IS 'cfx_image'>SELECTED</cfif>>cfx_image (by Jukka)</option>
                <option value="cfximage" <cfif ImageProcessor IS 'cfximage'>SELECTED</cfif>>cfximage (gafware)</option>
                <option value="imagej" <cfif ImageProcessor IS 'imageJ'>SELECTED</cfif>>ImageJ CFC</option>
                <option value="cfx_imagecr3" <cfif ImageProcessor IS 'cfx_imagecr3'>SELECTED</cfif>>CFX_ImageCR3 (by Efflare)</option>
                <option value="cfx_openimage" <cfif ImageProcessor IS 'cfx_openimage'>SELECTED</cfif>>CFX_OpenImage (by Jukka)</option>				<option value="cf8image" <cfif ImageProcessor IS 'cf8image'>SELECTED</cfif>>CFImage for Coldfusion 8</option>
				<option value="cfxjpegresize" <cfif ImageProcessor IS 'cfxjpegresize'>SELECTED</cfif>>cfx_jpegresize (by chestysoft)</option>
              </select> <a href = "#request.AdminPath#/helpdocs/custom_tag_used_to_process_images.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr> 
              <td>&nbsp;</td>
              <td><input type="submit" name="Submit6" value="Update Settings" /></td>
            </tr>
            <tr bgcolor="##000000"> 
              <td colspan="2"><strong><font color="##FFFFFF">Inventory</font></strong></td>
            </tr>
            <tr> 
              <td><strong>Enable Inventory Feature?</strong></td>
              <td><select name="EnableInventory" id="select3">
                  <option <cfif EnableInventory IS 'Yes'>SELECTED</cfif>>Yes</option>
                  <option <cfif EnableInventory IS 'No'>SELECTED</cfif>>No</option>
                </select> <a href = "#request.AdminPath#/helpdocs/enable_inventory_feature.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr> 
              <td><b>Default number of items in stock: </b></td>
              <td><input type="text" name="DefaultStockValue" size="5" value="#DefaultStockValue#"> <a href = "#request.AdminPath#/helpdocs/default_number_of_items_in_stock.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a> </td>
            </tr>
            <tr> 
              <td><strong>Show out of stock items in catalog?</strong></td>
              <td><select name="ShowOutOfStockItems" id="select4">
                  <option <cfif ShowOutOfStockItems IS 'Yes'>SELECTED</cfif>>Yes</option>
                  <option <cfif NOT ShowOutOfStockItems IS 'Yes'>SELECTED</cfif>>No</option>
                </select> <a href = "#request.AdminPath#/helpdocs/show_out_of_stock_items.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr> 
              <td><strong>Show Item Availability when viewing details?</strong></td>
              <td><select name="ShowItemAvailability" id="select5">
                  <option <cfif ShowItemAvailability IS 'Yes'>SELECTED</cfif>>Yes</option>
                  <option <cfif ShowItemAvailability IS 'No'>SELECTED</cfif>>No</option>
                </select> <a href = "#request.AdminPath#/helpdocs/show_item_availability.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr> 
              <td>&nbsp;</td>
              <td><input type="submit" name="Submit5" value="Update Settings" /></td>
            </tr>
            <tr bgcolor="##000000"> 
              <td colspan="2"><strong><font color="##FFFFFF">Catalog Settings</font></strong><input type="hidden" name="MaxRecords" value="#MaxRecords#"> </td>
            </tr>
            <!---
			<tr> 
              <td><b>Show &quot;Services Provided By&quot; in cart? (<a href = "#request.AdminPath#/help/index.cfm?action=view&contentid=14" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><img src = "#request.adminpath#images/help.gif" border="0" /></a>)</b></td>
              <td><select name="ShowPoweredBy">
                  <option <cfif ShowPoweredBy IS 'Yes'>SELECTED</cfif>>Yes</option>
                  <option <cfif ShowPoweredBy IS 'No'>SELECTED</cfif>>No</option>
                </select></td>
            </tr>
			--->
			<input type = "hidden" name = "showpoweredby" value = "yes" />
            <tr>
              <td><strong>Default Action When Website Loads</strong></td>
              <td valign="middle">
<select name="defaultaction">
<option value = "loadhomepage" <cfif defaultaction IS 'loadhomepage'>SELECTED="SELECTED"</cfif>>
Load Homepage HTML Only</option>
<option value = "ShowFeatured" <cfif defaultaction IS 'ShowFeatured'>SELECTED="SELECTED"</cfif>>
Load Featured Items Only</option>
<option value = "ShowFeaturedAndHomepage" <cfif defaultaction IS 'ShowFeaturedAndHomepage'>SELECTED="SELECTED"</cfif>>
Load Featured With Homepage HTML below</option>
<option value = "ShowFeaturedAndHomepage2" <cfif defaultaction IS 'ShowFeaturedAndHomepage2'>SELECTED="SELECTED"</cfif>>
Load Featured With Homepage HTML above</option>
<option value = "ShowBestSellers" <cfif defaultaction IS 'ShowBestSellers'>SELECTED="SELECTED"</cfif>>
Load Best Sellers Only</option>
<option value = "ShowBestSellersAndHomepage" <cfif defaultaction IS 'ShowBestSellersAndHomepage'>SELECTED="SELECTED"</cfif>>      Load Best Sellers With Homepage HTML below</option>
<option value = "LoadMainCategories" <cfif defaultaction IS 'LoadMainCategories'>SELECTED="SELECTED"</cfif>>
Display The Main Categories</option>
<option value = "LoadMainCategoriesAndHomepage" <cfif defaultaction IS 'LoadMainCategoriesAndHomepage'>SELECTED="SELECTED"</cfif>>
Display The Main Categories With Homepage Below</option>
</select> <a href = "#request.AdminPath#helpdocs/default_action_when_website_loads.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a>              </td>
            </tr>
            <tr>
              <td><strong>Currency Locale:</strong></td>
              <td valign="middle"><select name="MyLocation">
                <option <cfif #Location# IS "Chineese (China)">SELECTED</cfif>>Chineese (China)</option>
                <option <cfif #Location# IS "Chineese (Hong Kong)">SELECTED</cfif>>Chineese (Hong Kong)</option>
                <option <cfif #Location# IS "Chineese (Taiwan)">SELECTED</cfif>>Chineese (Taiwan)</option>
                <option <cfif #Location# IS "Dutch (Belgian)">SELECTED</cfif>>Dutch (Belgian)</option>
                <option <cfif #Location# IS "Dutch (Belgian)">SELECTED</cfif>>Dutch (Belgian)</option>
                <option <cfif #Location# IS "Dutch (Standard)">SELECTED</cfif>>Dutch (Standard)</option>
                <option <cfif #Location# IS "English (Australian)">SELECTED</cfif>>English (Australian)</option>
                <option <cfif #Location# IS "English (Canadian)">SELECTED</cfif>>English (Canadian)</option>
                <option <cfif #Location# IS "English (New Zealand)">SELECTED</cfif>>English (New Zealand)</option>
                <option <cfif #Location# IS "English (UK)">SELECTED</cfif>>English (UK)</option>
                <option <cfif #Location# IS "English (US)">SELECTED</cfif>>English (US)</option>
                <option <cfif #Location# IS "French (Belgian)">SELECTED</cfif>>French (Belgian)</option>
                <option <cfif #Location# IS "French (Canadian)">SELECTED</cfif>>French (Canadian)</option>
                <option <cfif #Location# IS "French (Standard)">SELECTED</cfif>>French (Standard)</option>
                <option <cfif #Location# IS "French (Swiss)">SELECTED</cfif>>French (Swiss)</option>
                <option <cfif #Location# IS "German (Austrian)">SELECTED</cfif>>German (Austrian)</option>
                <option <cfif #Location# IS "German (Standard)">SELECTED</cfif>>German (Standard)</option>
                <option <cfif #Location# IS "German (Swiss)">SELECTED</cfif>>German (Swiss)</option>
                <option <cfif #Location# IS "Italian (Standard)">SELECTED</cfif>>Italian (Standard)</option>
                <option <cfif #Location# IS "Italian (Swiss)">SELECTED</cfif>>Italian (Swiss)</option>
                <option <cfif #Location# IS "Japaneese">SELECTED</cfif>>Japaneese</option>
                <option <cfif #Location# IS "Korean">SELECTED</cfif>>Korean</option>
                <option <cfif #Location# IS "Norwegian (Bokmal)">SELECTED</cfif>>Norwegian (Bokmal)</option>
                <option <cfif #Location# IS "Norwegian (Nynorsk)">SELECTED</cfif>>Norwegian (Nynorsk)</option>
                <option <cfif #Location# IS "Portuguese (Brazilian)">SELECTED</cfif>>Portuguese (Brazilian)</option>
                <option <cfif #Location# IS "Portuguese(Standard)">SELECTED</cfif>>Portuguese(Standard)</option>
                <option <cfif #Location# IS "Spanish(Mexican)">SELECTED</cfif>>Spanish(Mexican)</option>
                <option <cfif #Location# IS "Spanish(Modern)">SELECTED</cfif>>Spanish(Modern)</option>
                <option <cfif #Location# IS "Spanish(Standard)">SELECTED</cfif>>Spanish(Standard)</option>
                <option <cfif #Location# IS "Swedish">SELECTED</cfif>>Swedish</option>
              </select> <a href = "#request.AdminPath#/helpdocs/your_locale.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Use Euro?</strong></td>
              <td><select name="EnableEuro" id="EnableEuro">
                <option <cfif #EnableEuro# IS 'Yes'>selected</cfif>>Yes</option>
                <option <cfif #EnableEuro# IS 'No'>selected</cfif>>No</option>
              </select> <a href = "#request.AdminPath#helpdocs/use_euro.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr> 
              <td><b>Default Product layout when adding category:</b></td>
              <td><select name="ProductLayout" id="select6">
                  <option value="1" <cfif #ProductLayout# IS '1'>SELECTED</cfif>>Side-by-side                  </option>
                  <option value="2" <cfif #ProductLayout# IS '2'>SELECTED</cfif>>List 
                  with Thumbnail</option>
                  <option value="3" <cfif #ProductLayout# IS '3'>SELECTED</cfif>>List 
                  without Thumbnail</option>
                  <!---<option value="4" <cfif #ProductLayout# IS '4'>SELECTED</cfif>>List 
              with options/discounts</option>--->
                </select> <a href = "#request.AdminPath#/helpdocs/default_product_layout.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a></td>
            </tr>
            
            <tr> 
              <td><strong>Show SKU When Browsing Categories?</strong></td>
              <td><select name="ShowProductID">
                  <option <cfif NOT ShowProductID IS 'No'>SELECTED</cfif>>Yes</option>
                  <option <cfif ShowProductID IS 'No'>SELECTED</cfif>>No</option>
                </select> <a href = "#request.AdminPath#helpdocs/show_sku_when_browsing_categories.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr> 
              <td><strong>Default Country Selected on Checkout form:</strong></td>
              <td><select name="defaultcountry">
                  <cfloop query = "qrysellingareas">
                    <cfloop index = 'Mycount' From = "1" To = "#ListLen(qrysellingareas.SelectedCountries)#">
                      <cfset ThisCountry = #ListGetAt(qrysellingareas.SelectedCountries, mycount)#>
                      <cfset ThisCountryCode = #ListGetAt(qrysellingareas.SelectedCCodes, mycount)#>
                      <option value = "#ThisCountryCode#" <cfif qryCompanyInfo.defaultcountry IS ThisCountryCode>SELECTED</cfif>>#ThisCountry#</option>
                    </cfloop>
                  </cfloop>
                </select> <a href = "#request.AdminPath#helpdocs/default_country_at_checkout.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            
            <tr> 
              <td><strong>All Weights are in:</strong></td>
              <td><select name="UnitOfMeasure">
                  <option value="KG" <cfif UnitOfMeasure IS 'KG'>SELECTED</cfif>>Kilograms</option>
                  <option value="G" <cfif UnitOfMeasure IS 'G'>SELECTED</cfif>>Grams</option>
                  <option value="LBS" <cfif UnitOfMeasure IS 'LBS'>SELECTED</cfif>>Pounds</option>
                  <option value="OZ" <cfif UnitOfMeasure IS 'OZ'>SELECTED</cfif>>Ounces</option>
                </select> <a href = "#request.AdminPath#helpdocs/weight_unit_of_measure.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Display Links In Categories Widget As:</strong></td>
              <td><select name="CategoryDisplay" id="CategoryDisplay">
              <option value = "HTML" <cfif CategoryDisplay IS 'HTML'>SELECTED</cfif>>HTML</option>
              <option value = "HTMLTree" <cfif CategoryDisplay IS 'HTMLTree'>SELECTED</cfif>>HTML Tree</option>
              <option value = "Image" <cfif CategoryDisplay IS 'Image'>SELECTED</cfif>>Images</option>                            
              </select> <a href = "#request.AdminPath#helpdocs/display_links_in_categories_widget_as.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Display Links in Links Widget As:</strong></td>
              <td><select name="LinksDisplay" id="LinksDisplay">
              <option value = "HTML" <cfif LinksDisplay IS 'HTML'>SELECTED</cfif>>HTML</option>
              <option value = "Image" <cfif LinksDisplay IS 'Image'>SELECTED</cfif>>Images</option>                            
              </select> <a href = "#request.AdminPath#helpdocs/display_links_in_links_widget_as.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Number of Columns In Side-By-Side View:</strong></td>
              <td><select name="sidebysidecols" id="sidebysidecols">
              <option value = "2" <cfif sidebysidecols IS '2'>SELECTED</cfif>>2 Columns</option>
              <option value = "3" <cfif sidebysidecols IS '3'>SELECTED</cfif>>3 Columns</option>
              <option value = "4" <cfif sidebysidecols IS '4'>SELECTED</cfif>>4 Columns</option>
              <option value = "5" <cfif sidebysidecols IS '5'>SELECTED</cfif>>5 Columns</option>
              <option value = "6" <cfif sidebysidecols IS '6'>SELECTED</cfif>>6 Columns</option>
              </select> <a href = "#request.AdminPath#helpdocs/number_of_columns_in_side-by-side_view.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Enable Product Reviews:</strong></td>
              <td><select name="showproductreviews" id="showproductreviews">
                <option value = "Yes" <cfif ShowProductReviews IS 'Yes'>SELECTED</cfif>>Yes</option>
                <option value = "No" <cfif NOT ShowProductReviews IS 'Yes'>SELECTED</cfif>>No</option>
              </select> <a href = "#request.AdminPath#helpdocs/enable_product_reviews.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Enable Create New Account in Customer Login Area:</strong></td>
              <td><select name="enablecreateaccount" id="enablecreateaccount">
                <option value = "Yes" <cfif NOT enablecreateaccount IS 'No'>SELECTED</cfif>>Yes</option>
                <option value = "No" <cfif enablecreateaccount IS 'No'>SELECTED</cfif>>No</option>
              </select> <a href = "#request.AdminPath#helpdocs/enable_create_new_account.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Allow Coupon Entry In Shopping Cart:</strong></td>
              <td><select name="enablecoupons" id="enablecoupons">
                <option value = "Yes" <cfif NOT enablecoupons IS 'No'>SELECTED</cfif>>Yes</option>
                <option value = "No" <cfif enablecoupons IS 'No'>SELECTED</cfif>>No</option>
              </select> <a href = "#request.AdminPath#helpdocs/allow_coupon_entry_in_shopping_cart.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <!---reserved for next verion release<tr>
              <td><strong>Disable The Shopping Cart</strong></td>
              <td><select name="DisableShoppingCart" id="DisableShoppingCart">
                <option value = "Yes" <cfif DisableShoppingCart IS 'Yes'>SELECTED</cfif>>Yes</option>
                <option value = "No" <cfif NOT DisableShoppingCart IS 'Yes'>SELECTED</cfif>>No</option>
              </select></td>
            </tr>--->
            <tr>
              <td><strong>Show Gift Card Field at Bottom of Checkout Form?</strong></td>
              <td><select name="ShowGiftCardAtCheckout" id="ShowGiftCardAtCheckout">
                <option value = "Yes" <cfif NOT ShowGiftCardAtCheckout IS 'No'>SELECTED</cfif>>Yes</option>
                <option value = "No" <cfif ShowGiftCardAtCheckout IS 'No'>SELECTED</cfif>>No</option>
              </select> <a href = "#request.AdminPath#helpdocs/show_gift_card_field.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Enable Wish List Feature?</strong></td>
              <td><select name="EnableWishLists" id="EnableWishLists">
                <option value = "Yes" <cfif NOT EnableWishLists IS 'No'>SELECTED</cfif>>Yes</option>
                <option value = "No" <cfif EnableWishLists IS 'No'>SELECTED</cfif>>No</option>
              </select> <a href = "#request.AdminPath#helpdocs/enable_wishlist_feature.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Order Number Prefix</strong></td>
              <td><input name="OrderNumber_Prefix" type="text" id="OrderNumber_Prefix" value="#ordernumber_prefix#" size="10" /> <a href = "#request.AdminPath#helpdocs/order_number_prefix.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Require Customer Agree To Terms and Conditions At Checkout</strong></td>
              <td><select name="checkout_terms" id="checkout_terms">
                <option value = "Yes" <cfif NOT checkout_terms IS 'No'>SELECTED</cfif>>Yes</option>
                <option value = "No" <cfif checkout_terms IS 'No'>SELECTED</cfif>>No</option>
              </select>
              <a href = "#request.AdminPath#helpdocs/terms_at_checkout.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Style of Checkout</strong></td>
              <td><select name="checkoutstyle" id="checkoutstyle">
              <option value = "1" <cfif checkoutstyle IS '1'>selected="selected"</cfif>>Single Column with Login at Top</option>
              <option value = "2" <cfif checkoutstyle IS '2'>selected="selected"</cfif>>Two Column with Login on the Right</option>
              </select> <a href = "#request.AdminPath#helpdocs/checkout_style.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a>              </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><input type="submit" name="Submit2" value="Update Settings" /></td>
            </tr>
            <tr>
              <td bgcolor="##000000"><strong><font color="##FFFFFF">Affiliate   System</font></strong></td>
              <td bgcolor="##000000">&nbsp;</td>
            </tr>
            <tr>
              <td><strong>Affiliate Commission Type:</strong></td>
              <td><select name="commtype" id="commtype">
                <option value="flat" <cfif commtype IS 'flat'>selected="selected"</cfif>>Set Dollar Amounts</option>
                <option value="percent" <cfif commtype IS 'percent'>selected="selected"</cfif>>Percentage</option>
              </select></td>
            </tr>
            <tr>
              <td><strong>Affiliate Commission Rate:</strong></td>
              <td><input name="CommRate" type="text" value="#Commrate#" size="4" />
              % <font size="2"><strong>(Do NOT put in the % sign)</strong></font> <a href = "#request.AdminPath#helpdocs/affiliate_commission.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td valign="top"><strong>Affiliate Commission Rate Sub Affiliate Referrals:</strong></td>
              <td><input name="CommRate_2" type="text" value="#Commrate_2#" size="4" />
                <font size="2"><strong>(Do NOT put in the % or $sign)</strong></font></td>
            </tr>
            <tr>
              <td valign="top"><strong>Custom Affiliate Code When Site Loads:</strong></td>
              <td><textarea name="CustomAffiliateCodeStartup" id="CustomAffiliateCodeStartup" cols="55" rows="6">#CustomAffiliateCodeStartup#</textarea> <a href = "#request.AdminPath#helpdocs/custom_affiliate_code_when_site_loads.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td valign="top"><strong>Custom Affiliate Code At End of Checkout:</strong></td>
              <td><textarea name="CustomAffiliateCodeCheckout" id="CustomAffiliateCodeCheckout" cols="55" rows="6">#CustomAffiliateCodeCheckout#</textarea> <a href = "#request.AdminPath#helpdocs/custom_affiliate_code_at_checkout.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><input type="submit" name="Submit3" value="Update Settings" /></td>
            </tr>
            <tr>
              <td bgcolor="##000000"><strong><font color="##FFFFFF">Mail Server Settings </font></strong></td>
              <td bgcolor="##000000">&nbsp;</td>
            </tr>
            <tr>
              <td><strong>Specify a Mail Server?</strong></td>
              <td><select name="UseMailServer">
                <option <cfif UseMailServer IS 'Yes'>SELECTED</cfif>>Yes</option>
                <option <cfif NOT UseMailServer IS 'Yes'>SELECTED</cfif>>No</option>
              </select> <a href = "#request.AdminPath#helpdocs/specify_a_mail_server.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Outgoing Mail Server: </strong></td>
              <td><input name="mailserver" type="text" id="mailserver" size="35" value="#mailserver#" /> <a href = "#request.AdminPath#helpdocs/specify_a_mail_server.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Server Requires a Username and Password:</strong> </td>
              <td><select name="UseMailLogin">
                <option <cfif UseMailLogin IS 'Yes'>SELECTED</cfif>>Yes</option>
                <option <cfif NOT UseMailLogin IS 'Yes'>SELECTED</cfif>>No</option>
              </select><a href = "#request.AdminPath#helpdocs/mail_server_username_and_password.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Mail Server Username:</strong></td>
              <td><input name="mailuser" type="text" id="mailuser" size="35" value="#mailuser#"/> <a href = "#request.AdminPath#helpdocs/mail_server_username_and_password.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td><strong>Mail Server Password: </strong></td>
              <td><input name="mailpassword" type="CustPassword" id="mailpassword" size="35" value="#mailpassword#"/> <a href = "#request.AdminPath#helpdocs/mail_server_username_and_password.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><input type="submit" name="Submit4" value="Update Settings" /></td>
            </tr>
			<input type = "hidden" name = "UseMyAccount" value="Yes" />
     <tr>
      <td colspan="2" bgcolor="##000000"><strong><font color="##FFFFFF">Custom Order Messages</font></strong> </td>
    </tr>
    <tr> 
      <td colspan="2"><b>End Of Order Message:</b> <a href = "#request.AdminPath#/helpdocs/end_of_order_message.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a> <br> 
      <textarea rows="6" name="EndOrderMessage" cols="65">#EndOrderMessage#</textarea>      </td>
    </tr>
    <tr> 
      <td colspan="2" valign="top"><p><b>Order Email Message:</b> <a href = "#request.AdminPath#/helpdocs/email_message.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a><br />
        Subject: 
          <input name="EndOrderSubj" type="text" id="EndOrderSubj" value="#EndOrderSubj#" size="40">
          <br>
          <textarea rows="5" name="EmailText" cols="65">#EmailText#</textarea></p></td>
    </tr>
    <tr>
      <td colspan="2" valign="top" bgcolor="##000000"><strong><font color="##FFFFFF">Default Website Meta Tags </font></strong></td>
    </tr>
    <tr> 
      <td colspan="2" valign="top"><b>Website Title:</b><a href = "#request.AdminPath#/helpdocs/website_title.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b> <img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a><br />
        <br> <textarea rows="5" name="WebsiteTitle" cols="65">#WebsiteTitle#</textarea>
        <p> <b>Meta Tag Description:</b><a href = "#request.AdminPath#/helpdocs/meta_description.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b> <img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a><br>
          <textarea rows="5" name="MetaDescription" cols="65">#MetaDescription#</textarea>
        </p>
        <p><b>Meta Tag Keywords:</b><a href = "#request.AdminPath#/helpdocs/meta_tag_keywords.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b> <img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a><br>
          <textarea rows="5" name="MetaKeywords" cols="65">#MetaKeywords#</textarea>
        </td>
    </tr>
  </table>
    <p align="center"> 
 	  <input type = "hidden" name = "useaffiliatesys" value="Yes" />
	  <input type = "hidden" name = "FeaturedLayout" value="1">
      <input type="hidden" name="action" value="UpdateVariables">
      <input type="submit" name="Submit" value="Update Settings">
    </p>
        </td>
    </tr>
    </table>
  </form>
</cfoutput> 


<cfoutput>
<script type="text/javascript">
	CKEDITOR.replace( 'EndOrderMessage',
	{
		height:"150", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse_email.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash_email.cfm'
	});
</script>
</cfoutput>

<cfoutput>
<script type="text/javascript">
	CKEDITOR.replace( 'EmailText',
	{
		height:"150", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse_email.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash_email.cfm'
	});
</script>
</cfoutput>

