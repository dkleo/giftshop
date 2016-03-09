<style>
<!--
  .selecttr { background-color: #FFFFFF; cursor: pointer;}
  .initial { background-color: #000000; color:#000000; cursor: pointer; }
  .normal { background-color: #FFFFFF; cursor: pointer; }
  .highlight { background-color: #CCCCCC; cursor: pointer; }
  .style1 {color: #FFFFFF}
-->
</style>

<script language="Javascript"> 
function PopupPic(sPicURL) { 
 window.open( "image-window.html?"+sPicURL, "", "resizable=1,HEIGHT=200,WIDTH=200"); 
} 
</script> 

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popupWin(mypage, myname, w, h, scroll) {
var winl = (screen.width - w) / 2;
var wint = (screen.height - h) / 2;
winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
win = window.open(mypage, myname, winprops)
if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
}
//  End -->
</script>

<script language = "javascript" type="text/javascript">
		function ShowMain() {
			Main.style.display = "block";
			DetailsSec.style.display = "None";
			Options.style.display = "None";
			Images.style.display = "None";
			Discounts.style.display = "None";
			HTMLCode.style.display = "None";
		}
</script>

<script language = "javascript" type="text/javascript">
		function ShowDetails() {
			Main.style.display = "None";
			DetailsSec.style.display = "block";
			Options.style.display = "None";
			Images.style.display = "None";
			Discounts.style.display = "None";
			HTMLCode.style.display = "None";
		}
</script>

<script language = "javascript" type="text/javascript">
		function ShowOptions() {
			Main.style.display = "None";
			DetailsSec.style.display = "None";
			Options.style.display = "block";
			Images.style.display = "None";
			Discounts.style.display = "None";
			HTMLCode.style.display = "None";
		}
</script>

<script language = "javascript" type="text/javascript">
		function ShowImages() {
			Main.style.display = "None";
			DetailsSec.style.display = "None";
			Options.style.display = "None";
			Images.style.display = "block";
			Discounts.style.display = "None";
			HTMLCode.style.display = "None";
		}
</script>

<script language = "javascript" type="text/javascript">
		function ShowDiscounts() {
			Main.style.display = "None";
			DetailsSec.style.display = "None";
			Options.style.display = "None";
			Images.style.display = "None";
			Discounts.style.display = "block";
			HTMLCode.style.display = "None";
		}
</script>

<script language = "javascript" type="text/javascript">
		function ShowHTMLCode() {
			Main.style.display = "None";
			DetailsSec.style.display = "None";
			Options.style.display = "None";
			Images.style.display = "None";
			Discounts.style.display = "None";
			HTMLCode.style.display = "block";
		}
</script>

<script language="Javascript"> 
function showhidesubscriptionfields(issub)
{
	if(issub == 'yes') {
		subscriptionfields.style.display = "block";
		}
	else
	{
		subscriptionfields.style.display = "None";
	}
}
</script>

<CFINCLUDE template = "../queries/qryproducts.cfm">
<CFINCLUDE template = "../queries/qrycategories.cfm">
<CFINCLUDE template = "../queries/qrysuppliers.cfm">
<cfinclude template = "../queries/qrybrands.cfm">
<cfinclude template = "../queries/qryavailability.cfm">
<cfinclude template = "../queries/qrymfgs.cfm">
<cfinclude template = "../queries/qryitemcategories.cfm">
<cfinclude template = "../queries/qryproductoptions.cfm">

<!---Set currency symbol--->
<cfset theprice = '1.00'>
<cfif request.EnableEuro IS 'Yes'>
    <cfset c_symbol = #left(lseurocurrencyformat(theprice, "Local"), 1)#>
    <cfelse>
    <cfset c_symbol = #left(lscurrencyformat(theprice, "Local"), 1)#>
</cfif>

<form method="POST" action="doproducts.cfm" enctype="multipart/form-data" name="form1">
<cfif NOT qryProducts.subof IS ''>
	<cfquery name = "qrySubInfo" datasource="#request.dsn#">
	SELECT * FROM products
	WHERE itemid = #qryProducts.subof#
	</cfquery>

	<cfset subname = "another item">
	<cfoutput query = "qrySubInfo">
		<cfset subname = #productname#>
	</cfoutput>
</cfif>


<CFOUTPUT query = "qryProducts">
<table width="90%" height="480" border="4" align="center" cellpadding="4" cellspacing="0" bordercolor="##000000">

<CFSET OptionFields = 'None'>
<CFSET OptionFields = #formFields#>
  <tr>
    <td valign="top"><table width="95%" border="0" cellspacing="0" cellpadding="4">
          <tr>
            <td><strong><font size="3" face="Verdana, Arial, Helvetica, sans-serif">#ProductName#</font></strong></td>
            <td><div align="right">
         <input type="hidden" value="#ItemID#" name = "ItemID">
          <CFIF ISDEFINED('url.WasSearch')>
            <input type = "hidden" Name="WasSearch" Value="Yes">
          </CFIF>
          <input type="hidden" value="Update" name="Action">
				<input type="submit" name="Submit" value="Save Changes">
              </div></td>
          </tr>
        </table>
      <table width="95%" border="4" align="center" cellpadding="4" cellspacing="0">
        <tr> 
          <td class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'" onClick="javascript:ShowMain()"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong><font color="##000000">BASICS</font></strong></font></div></td>
          <td class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'" onClick="javascript:ShowDetails()"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>DETAILS</strong></font></div></td>
          <td class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'" onClick="javascript:ShowOptions()"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>CATEGORIES</strong></font></div></td>
          <td class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'" onClick="javascript:ShowImages()"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>SETTINGS</strong></font></div></td>
          <td class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'" onClick="javascript:ShowDiscounts()"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>OPTIONS</strong></font></div></td>
          <td class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'" onClick="javascript:ShowHTMLCode()"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>HTML 
              CODE </strong></font></div></td>
        </tr>
      </table>
      <table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
       
        <tr> 
          <td colspan="5">  
		  <span id = "Main"> 
		      <table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
                    <tr>
                      <td>Record Number (ItemID)</td>
                      <td>#itemid#</td>
                      <td width="30%" rowspan="10"><div align="center">                      
                        <cfset thisitemid = url.itemid>
                        <!---If it's a subitem then set the image to the parent item--->
                        <cfif len(subof) GT 0>
                          <cfset thisitemid = subof>
                        </cfif>
                        
                        <cfinclude template = "../queries/qryitemimages.cfm">
                        
                        <cfif qry_Images.recordcount IS 0>
                          <cfset TheThumbnail = "#request.homeURL#photos/nopic.jpg">
                          </cfif>
                        
                        <cfloop query = "qry_Images" startrow="1" endrow="1">
                          <cfset TheThumbnail = "#request.homeURL#photos/small/#qry_Images.iFileName#">
                          
                          <cfset winheight = #qry_Images.iHeight# + 50>
                          <cfset winwidth = #qry_Images.iWidth# + 50>
                          
                          <cfif winheight GT 400>
                            <cfset winheight = 400>
                          </cfif>
                          
                          <cfif winwidth GT 500>
                            <cfset winwidth = 500>
                          </cfif>						  
                          </cfloop>					                       
                        <img src="#TheThumbnail#" border="0" onclick="PopupPic('#TheThumbnail#','Image',400,300,1);" style="cursor: pointer;" /><br><a href="##" onclick="PopupPic('#TheThumbnail#','Image',400,300,1);">Click to view</a>
                        <p>&nbsp;</p>
                      </div></td>
                    </tr>
                  <tr>
                    <td>SKU:</td>
                    <td><input name="sku" type="text" value="#sku#" size="30" /><input type = "hidden" name = "oldsku" value = "#sku#"> 
                      (Must be unique) </td>
                  </tr>
                  <tr> 
                  <td width="20%">Product ID:</td>
                  <td width="45%"><input name="NewProductID" type="text" value="#ProductID#" size="30">
				  <input name="OldProductID" type="hidden" value="#ProductID#" size="30">
				   <cfif len(subof) GT 0><br />Sub Item of <a href = "doproducts.cfm?action=edit&ItemID=#subof#">#subname#</a></cfif>	  				  </td>
                  </tr>
                  <tr>
                    <td valign="top">Brand:</td>
                    <td><select name = "brand">
                  	<option value="Other">Add New Brand --></option>
                  	<cfloop query = "qryBrands">
                    	<cfif LEN(trim(qryBrands.brand)) GT 0>
                        <option value="#qryBrands.brand#" <cfif qryBrands.brand IS qryProducts.brand>SELECTED="selected"</cfif>>#qryBrands.brand#</option>
                        </cfif>
                    </cfloop>
                  </select>
                  <input name="OtherBrand" type="text" id="OtherBrand" size="30" /></td>
                  </tr>
                  <tr> 
                  <td valign="top">Product Name:</td>
                  <td><input name="NewProductName" type="text" value="#htmleditformat(ProductName)#" size="55">
                  <br />
                  <label></label></td>
                </tr>
                <tr> 
                  <td>Price:</td>
                  <td><input name="NewPrice" type="text" value="#Price#" size="13" required="Yes" Message="You must give this item a price.  If you are going to base the product price from options selected then enter 0.00" onchange="form1.r_startupfee.value=this.value"> <label></label></td>
                </tr>
                <tr>
                  <td>Wholesale Price </td>
                  <td>
				  <input name="NewWholesalePrice" type="text" id="NewWholesalePrice" value="#WholesalePrice#" size="13" /></td>
                </tr>
                <tr>
                  <td>List Price </td>
                  <td>
				  <input name="NewListPrice" type="text" id="NewListPrice" value="#ListPrice#" size="13" /></td>
                </tr>
                <tr> 
                  <td>Brief Description:</td>
                  <td>
				
                    <textarea name="BriefDescription" cols="60" rows="4">#BriefDescription#</textarea></td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp; </td>
                </tr>
              </table>
        </span> 
          </td>
        </tr>
        <tr> 
          <td colspan="5"> <span id = "DetailsSec" style="display: none;"> 
            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td> 
				
		<!---if the details file doesn't exist create it from what is in the db....read the file--->
        <cfif NOT fileexists('#request.catalogpath#docs#request.bslash#products#request.bslash#item#itemid#.cfm')>
        	<cffile action="write" file="#request.catalogpath#docs#request.bslash#products#request.bslash#item#itemid#.cfm" output="#details#">
        </cfif>
        
        <cfif fileexists('#request.catalogpath#docs#request.bslash#products#request.bslash#item#itemid#.cfm')>
        	<cffile action="read" file="#request.catalogpath#docs#request.bslash#products#request.bslash#item#itemid#.cfm" variable="thedetails">
		</cfif>            
        
		<textarea name="details" id="details" style="width: 100%;" rows="300">#thedetails#</textarea>
</td>
              </tr>
            </table>
            </span> </td>
        </tr>
        <td width="35%">
        <tr> 
          <td colspan="5"> <span id = "Options" style="display: none;"> 
            <table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
              <tr> 
                <td> <b>Select the category or categories you want to assign this 
                  item to. <br>
                  You can choose more than one by holding down the CTRL key and 
                  selecting them</b> <p>
				<cfif len(subof) GT 0>
			    This item is a sub item of another product.  
				You must change the parent items categories in order to 
				change this ones category assignment
				<input type = "hidden" name = "Category" value = "#qryProducts.Category#" />
				<cfelse>

				<!---build a list of categories this one is in so the correct ones can be selected in the selectbox
				below--->
				<cfset categorylist = "">
				<cfloop query = "qryItemCategories">
                	 <cfset categorylist = listappend(categorylist, qryItemCategories.categoryid, "^")>
                </cfloop>
                
                <cfif listlen(categorylist, "^") IS 0>
                	<cfset categorylist = "^0^">
                </cfif>
                    <select name="Category" size="25" multiple id="Category">
                      <option Value="0" <cfif #trim(categorylist)# IS '0'>SELECTED</cfif>>Inactive (No Category) 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>

                <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#categorylist#"
				Datasource="#request.dsn#"
				FirstIndent="#request.CategoryIndent#"> 
                    </select>
				</cfif>
                </td>
              </tr>
            </table>
            </span> </td>
        </tr>
        <tr> 
          <td colspan="5"> 
            <span id = "Images" style="display: none;"> 
            <table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
              <tr> 
                <td> <table width="100%" border="0" cellspacing="0" cellpadding="4">
					<!---Manufacturer--->
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                      <td><strong>Go straight to checkout when adding this item to the cart?</strong></td>
                      <td><select name="OneClickOrdering" id="OneClickOrdering">
                            <option <cfif OneClickOrdering IS 'Yes'>selected</cfif>>Yes</option>
                            <option <cfif NOT OneClickOrdering IS 'Yes'>selected</cfif>>No</option>
                          </select></td>
                    </tr>
                    <tr>
                      <td bgcolor="##000000"><span class="style3 style1">Specifications</span></td>
                      <td bgcolor="##000000">&nbsp;</td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                      <td><b>Manufacturer:</b></td>
                      <td>                      <select name = "mfg">
                        <option value="Other">Add New Manufacturer --></option>
                    <cfloop query = "qryMfgs">
                        <cfif LEN(trim(qryMfgs.mfg)) GT 0>
                        <option value="#qryMfgs.mfg#" <cfif qryMfgs.mfg IS qryProducts.mfg>SELECTED="selected"</cfif>>#qryMfgs.mfg#</option>
                        </cfif>
                    </cfloop>
                    </select>
                    <input name="OtherMfg" type="text" id="OtherMfg" size="30" /></td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                      <td><b>Supplier </b>(If applicable)<b>:</b></td>
                      <td>
                      <CFSET ThisSupplierID = '#SupplierID#'>
                      <select size="1" name="Supplier">
                          <option value="0" <cfif ThisSupplierID IS '0'>SELECTED</cfif>>None</option>
                          <CFLOOP query="qrySuppliers">
                            <CFIF NOT #CompanyName# IS ''>
                              <option value="#ContactID#" <cfif ContactID IS '#ThisSupplierID#'>SELECTED</cfif>>#CompanyName#</option>
                            </CFIF>
                          </CFLOOP>
                        </select>                      </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                      <td><strong>UPC:</strong></td>
                      <td><input type="text" name="upc" value="#upc#" size="20" /></td>
                    </tr>
                    <tr>
                      <td bgcolor="##000000"><span class="style1"><em><strong>Availablity and Inventory</strong></em></span></td>
                      <td bgcolor="##000000">&nbsp;</td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                      <td><b>Availability:</b></td>
                      <td><select name = "availability">
                        <option value="Other">Add New Availability --></option>
                    <cfloop query = "qryAvailability">
                        <cfif LEN(trim(qryAvailability.availability)) GT 0>
                        <option value="#qryAvailability.availability#" <cfif qryAvailability.availability IS qryProducts.availability>SELECTED="selected"</cfif>>#qryAvailability.availability#</option>
                        </cfif>
                    </cfloop>
                    </select>
                    <input name="OtherAvailability" type="text" id="OtherAvailability" size="30" /> </td>
                    </tr>
                    <cfif NOT request.EnableInventory IS 'No'>
                      <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                        <td ><strong>Items In Stock:</strong></td>
                        <td ><cfoutput><input name="unitsinstock" type = "text" size="6" id="unitsinstock" value="#unitsinstock#"></cfoutput></td>
                      </tr>
                      <cfelse>
                      <cfoutput><input name="unitsinstock" type = "hidden" id="unitsinstock" value="#request.defaultstockvalue#"></cfoutput>
                    </cfif> 
                    <CFIF NOT request.EnableInventory IS 'No'>
                      <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                        <td >
						<strong>Can 
                          this be back ordered?</strong></td>
                        <td >
						<select name="CanBackOrder" size="1" id="CanBackOrder">
                            <option <cfif NOT CanBackOrder IS 'No'>selected</cfif>>Yes</option>
                            <option <cfif CanBackOrder IS 'No'>selected</cfif>>No</option>
                          </select>						  </td>
                      </tr>
                      <CFELSE>
                      <input type="hidden" name="CanBackOrder" Value="No">
                    </CFIF>
                    <tr>
                      <td bgcolor="##000000"><span class="style1"><em><strong>Shipping and Taxes</strong></em></span></td>
                      <td bgcolor="##000000">&nbsp;</td>
                    </tr>
                      <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                        <td> 
                          <p align="left"><strong>Shipping Weight:</strong></td>
                        <td width="62%" > 
						  <input type="text" name="Weight" size="7" value="#Weight#"> (Max 150lbs)
                          #request.UnitOfMeasure# <a href = "../converter/converter.cfm"onClick="NewWindow(this.href,'name','375','250','yes');return false;"><img src="../../icons/calculator.gif" border="0" alt="Click to convert weight measurements" title="Click to convert weight measurements"></a>						  </td>
                      </tr>
                    <CFIF request.ShippingType IS '8'>
					  <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                        <td ><strong>Cost 
                          to ship this item:</strong></td>
                        <td >
						<input name="ShippingCosts" type="text" size="7" Value="#ShippingCosts#" Required="yes" Message="You supply a shipping cost for this item.">
                          each (Number only. No symbols)						  </td>
                      </tr>
                      <CFELSE>
                      <input type="hidden" name="ShippingCosts" Value="#ShippingCosts#">
                    </CFIF>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td > <strong>Item is shipped?</strong></td>
                      <td > <select size="1" name="askforshipping">
                          <option <cfif askforshipping IS 'Yes'>SELECTED</cfif>>Yes</option>
                          <option <cfif NOT askforshipping IS 'Yes'>SELECTED</cfif>>No</option>
                        </select></td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td > <strong>Charge Shipping on this item?</strong></td>
                      <td > <select size="1" name="ChargeShipping">
                          <option <cfif ChargeShipping IS 'Yes'>SELECTED</cfif>>Yes</option>
                          <option <cfif NOT ChargeShipping IS 'Yes'>SELECTED</cfif>>No</option>
                        </select></td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Charge Sales Tax on This Item?</strong></td>
                      <td ><select size="1" name="ChargeTaxes">
                          <option <cfif ChargeTaxes IS 'Yes'> SELECTED </cfif>>Yes</option>
                          <option <cfif ChargeTaxes IS 'No'> SELECTED </cfif>>No</option>
                        </select></td>
                    </tr>
                    <tr>
                    	<td bgcolor="##000000"><span class="style1"><em><strong>Gift Cards and Subscriptions</strong></em></span></td>
                    	<td bgcolor="##000000">&nbsp;</td>
                    </tr>                    
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                    	<td valign="top"><strong>Is this a subscription item (#issubscription#)?</strong></td>
                    	<td>
<select size="1" name="issubscription" onchange="javascript: showhidesubscriptionfields(this.value);">
                          <option value="yes" <cfif issubscription IS 'Yes'>SELECTED</cfif>>Yes</option>
                          <option value="no" <cfif NOT issubscription IS 'Yes'>SELECTED</cfif>>No</option>
                        </select> 
                        
                        <!---get the subscription info for this item--->
                        <cfquery name = "qrySubscriptionInfo" datasource="#request.dsn#">
                        SELECT * FROM products_subscriptions
                        WHERe itemid = #qryProducts.itemid#
                        </cfquery>
                                                
                        <div id="subscriptionfields">
                        <p>
                        <b>Choose Options:</b>
                        <table width="100%" cellpadding="4" cellspacing="0" border="0">
                        <tr>
                        	<td width="30%">One Time Fee:</td>
                            <td width="70%"><cfoutput>#c_symbol#</cfoutput><input name = "r_startupfee" value="#qrySubscriptionInfo.r_startupfee#" size="10" type="text" onchange="form1.NewPrice.value=this.value" /></td>
                        </tr>
                        <tr>
                        	<td width="30%">Recurring Fee:</td>
                            <td width="70%"><cfoutput>#c_symbol#</cfoutput><input name = "r_fee" value="#qrySubscriptionInfo.r_fee#" size="10" type="text" /></td>
                        </tr>
                        <tr>
                        	<td width="30%">Recurring Frequency:</td>
                            <td width="70%"><cfoutput>#c_symbol#</cfoutput>
                            	<select name = "r_frequency">
                                	<option value="N" <cfif #qrySubscriptionInfo.r_frequency# IS 'N'>SELECTED</cfif>>One-Time</option>
                                    <option value="M" <cfif #qrySubscriptionInfo.r_frequency# IS 'M'>SELECTED</cfif>>Per Month</option>
                                    <option value="Y" <cfif #qrySubscriptionInfo.r_frequency# IS 'Y'>SELECTED</cfif>>Per Year</option>
                                </select>                             </td>
                        </tr>
                        <tr >
                        	<td width="30%">Expires in:</td>
                            <td width="70%">
                            	<select name = "r_expiresin">
                                    <option value="1 Day" <cfif qrySubscriptionInfo.r_expiresin IS '1 Day'>SELECTED</cfif>>1 Day</option>
                                    <option value="3 Days" <cfif qrySubscriptionInfo.r_expiresin IS '3 Days'>SELECTED</cfif>>3 Days</option>
                                    <option value="1 Week" <cfif qrySubscriptionInfo.r_expiresin IS '1 Week'>SELECTED</cfif>>1 Week</option>
                                    <option value="1 Month" <cfif qrySubscriptionInfo.r_expiresin IS '1 Month'>SELECTED</cfif>>1 Month</option>
									<option value="3 Months" <cfif qrySubscriptionInfo.r_expiresin IS '3 Months'>SELECTED</cfif>>3 Months</option>
                                    <option value="6 Months" <cfif qrySubscriptionInfo.r_expiresin IS '6 Months'>SELECTED</cfif>>6 Months</option>
                                    <option value="1 Year" <cfif qrySubscriptionInfo.r_expiresin IS '1 Year'>SELECTED</cfif>>1 Year</option>
                                    <option value="2 Years" <cfif qrySubscriptionInfo.r_expiresin IS '2 Years'>SELECTED</cfif>>2 Years</option>
                                    <option value="Never" <cfif qrySubscriptionInfo.r_expiresin IS 'Never'>SELECTED</cfif>>Never</option>			    
                                </select>                             </td>
                        </tr>
                        </table>
                        
                        <cfif qrySubscriptionInfo.recordcount IS 0>
                        	<input type = "hidden" name = "r_id" value="0" />
                        <cfelse>
                        	<cfoutput><input type = "hidden" name = "r_id" value="#qrySubscriptionInfo.r_id#" /></cfoutput>
                        </cfif>
                        </p>
                        </div>                        </td>
                    </tr>                    
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                    	<td><strong>Is this a gift card?</strong></td>
                    	<td><select size="1" name="isgift">
                          <option <cfif isgift IS 'Yes'> SELECTED </cfif>>Yes</option>
                          <option <cfif NOT isgift IS 'Yes'> SELECTED </cfif>>No</option>
                        </select></td>
                    </tr>                    
                    <tr>
                      <td bgcolor="##000000"><span class="style1"><em><strong>View Settings</strong></em></span></td>
                      <td bgcolor="##000000">&nbsp;</td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show add to cart button?</strong></td>
                      <td ><p> 
                          <select name="showaddtocartbutton" id="showaddtocartbutton">
                            <option <cfif NOT showaddtocartbutton IS 'No'>selected</cfif>>Yes</option>
                            <option <cfif showaddtocartbutton IS 'No'>selected</cfif>>No</option>
                          </select>
                        </p></td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show Volume discount table when available?</strong></td>
                      <td > 
					  <select name="showvoldiscounts" id="showvoldiscounts">
                          <option <cfif NOT showvoldiscounts IS 'No'>selected</cfif>>Yes</option>
                          <option <cfif showvoldiscounts IS 'No'>selected</cfif>>No</option>
                        </select>						 </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show Quantity Field?</strong></td>
                      <td ><select name="ShowQuantity">
                          <option <cfif NOT ShowQuantity IS 'No'>SELECTED</cfif>>Yes</option>
                          <option <cfif ShowQuantity IS 'No'>SELECTED</cfif>>No</option>
                        </select></td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>List the option form fields when viewing deatails?</strong> </td>
                      <td ><select size="1" name="listoptions">
                          <option <cfif NOT listoptions IS 'Yes'>SELECTED</cfif>>Yes</option>
                          <option <cfif listoptions IS 'No'>SELECTED</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show the image when viewing details?</strong> </td>
                      <td ><select size="1" name="showimage">
                          <option <cfif showimage IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT showimage IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show the product name form fields when viewing details?</strong> </td>
                      <td ><select size="1" name="showtitle">
                          <option <cfif showtitle IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT showtitle IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show the price when viewing details?</strong> </td>
                      <td ><select size="1" name="showprice">
                          <option <cfif showprice IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT showprice IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show the wholesale price when viewing details?</strong> </td>
                      <td ><select size="1" name="showwsprice">
                          <option <cfif showwsprice IS 'yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT showwsprice IS 'yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show the list price when viewing details?</strong> </td>
                      <td ><select size="1" name="showlistprice">
                          <option <cfif showlistprice IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT showlistprice IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Product is an option for another item (Won't show in catalog)?</strong> </td>
                      <td ><select size="1" name="isoption">
                          <option value="1" <cfif isoption IS '1'>selected="selected"</cfif>>Yes</option>
                          <option value="0" <cfif isoption IS '0'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>                                                                                                     
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                      <td bgcolor="##000000"><span class="style1"><em><strong>Template Settings</strong></em></span></td>
                      <td bgcolor="##000000">&nbsp;</td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                    	<td><input type="checkbox" name="saveastemplate" value="yes" id="template_checkbox" /> <label for = "template_checkbox"><strong>Check here to create a template from this item.</strong></label></td>
                        <td>If saving this as a template, give your template a name: <input type="text" value="" size="25" name="template_name" /></td>
                      </tr>
                  </table></td>
              </tr>
            </table>
            </span></td>
        </tr>
        <tr> 
          <td colspan="5"> <span id = "Discounts" style="display: none;"> 
            <table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
              <tr> 
                  <td>
				  <p>These are the current options assigned to this product. 
                      You can change the options assigned to this product using 
                      the options manager.</p>
                    <table width="90%" border="0" align="center" cellpadding="4" cellspacing="0">
  <CFIF qryProductOptions.recordcount GT 0>
    <CFLOOP query = "qryProductOptions">
      <CFSET ThisOptionField = qryProductOptions.optionid>
	  <CFINCLUDE template = "../queries/qryoptions.cfm">
      <CFLOOP query = "qryoptions"> 
        <tr> 
          <td width="64%">#Caption# #HTMLCode#</td>
          <td width="36%"> 
            </td>
        </tr>
      </CFLOOP> 
    </CFLOOP>
  <CFELSE>
  <center>You do not have any options assigned to this item</center>
  </CFIF>
</table>				
					</p>
					</td>
              </tr>
            </table>
            </span> </td>
        </tr>
        <tr> 
          <td colspan="5"> 
            <!----HTML Code ------>
            <span id = "HTMLCode" style="display: none;"> 
            <cfset producttype = 'Normal'>
			<table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
              <tr> 
                <td> <p><strong>Add To Cart Button HTML:</strong></p>
<cfset ButtonHTML = '<form name = "AddToCartForm" action="#request.HomeURL#?action=addtocart" method="POST">'>

<!---Show Quantity field if they chose to show it--->
<CFIF ShowQuantity IS 'No'>
	<cfset ButtonHTML = ButtonHTML & '<input type="hidden" name="qty" value="1">'>
<cfelse>
	<cfset ButtonHTML = ButtonHTML & 'Qty: <input type="text" name="qty" size="4" value="1">'>
</CFIF>						

<cfset ButtonHTML = ButtonHTML & '<input type = "Hidden" name="ItemID" Value="#ItemID#">
		<input type="image" name="AddToCart" src="#request.secureURL##request.addtocart#">'>
	<cfset ButtonHTML = ButtonHTML & '</form>'>
					
<textarea name="textarea" cols="115" rows="20">
#ButtonHTML#
</textarea>
					               
                </td>
              </tr>
            </table>
            </span> </td>
        </tr>
      </table>
	  <!---Hidden for field to determine if this is a subitem of another--->
	  <input type = "hidden" name = "subof" value = "#subof#" />
	  <input type = "hidden" name = "ordervalue" value="#qryproducts.fordervalue#" />
	  </td>
  </tr>
	
</table>
</cfoutput>
</form>

<script language="javascript">
<!--
//--------------------------------------------------------------------------
  document.form1.sku.focus()
  
  	if(form1.issubscription.value == 'yes') {
		subscriptionfields.style.display = "block";
		}
	else
	{
		subscriptionfields.style.display = "None";
	}
  
//--------------------------------------------------------------------------
// -->
</script>

<cfoutput>
<script type="text/javascript">


	CKEDITOR.replace( 'details',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'				
	});

</script>
</cfoutput>