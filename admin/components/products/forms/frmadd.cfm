<cfparam name = "template_id" default="0">
<cfparam name = "s_showtitle" default="Yes">
<cfparam name = "s_showprice" default="Yes">
<cfparam name = "s_showwsprice" default="No">
<cfparam name = "s_showlistprice" default="No">
<cfparam name = "s_showimage" default="Yes">
<cfparam name = "s_details" default="">
<cfparam name = "s_CanBackOrder" default="No">
<cfparam name = "s_availability" default="Other">
<cfparam name = "s_showaddtocartbutton" default="Yes">
<cfparam name = "s_oneclickordering" default="No">
<cfparam name = "s_showvoldiscounts" default="Yes">
<cfparam name = "s_ShowQuantity" default="Yes">
<cfparam name = "s_askforshipping" default="Yes">
<cfparam name = "s_chargeshipping" default="Yes">
<cfparam name = "s_chargetaxes" default="Yes">
<cfparam name = "s_issubscription" default="No">
<cfparam name = "s_isgift" default="No">
<cfparam name = "s_listoptions" default="Yes">
<cfparam name = "s_isoption" default="No">
<cfset categorylist = "">

<cfif NOT template_id IS '0'>

	<!---if loading from a template load the variables--->
    
    <cfquery name = "qTemplate" datasource="#request.dsn#">
    SELECT * FROM products_templates
    WHERE itemid = #template_id#
    </cfquery>
    
    <cfquery name = "qTemplateCats" datasource="#request.dsn#">
    SELECT * FROM product_categories_templates
    WHERE itemid = #template_id#
    </cfquery>
    
    <cfoutput query = "qTemplate">
    <cfset s_showtitle="#showtitle#">
    <cfset s_showprice="#showprice#">
    <cfset s_showwsprice="#showwsprice#">
    <cfset s_showlistprice="#showlistprice#">
    <cfset s_showimage="#showimage#">
    <cfset s_details="#details#">
    <cfset s_CanBackOrder="#canbackorder#">
    <cfset s_availability="#availability#">
    <cfset s_showaddtocartbutton="#showaddtocartbutton#">
    <cfset s_oneclickordering="#oneclickordering#">
    <cfset s_showvoldiscounts="#showvoldiscounts#">
    <cfset s_ShowQuantity="#showquantity#">
    <cfset s_askforshipping="#askforshipping#">
    <cfset s_chargeshipping="#chargeshipping#">
    <cfset s_chargetaxes="#chargetaxes#">
    <cfset s_issubscription="#issubscription#">
    <cfset s_isgift="#isgift#">
    <cfset s_listoptions="#listoptions#">
    <cfset s_isoption="#isoption#">
    </cfoutput>

    <cfif fileexists('#request.catalogpath#docs#request.bslash#products#request.bslash#item#template_id#.cfm')>
        <cffile action="read" file="#request.catalogpath#docs#request.bslash#products#request.bslash#item#template_id#.cfm" variable="s_details">
    </cfif>

	<cfoutput query = "qTemplateCats">
         <cfset categorylist = listappend(categorylist, qTemplateCats.categoryid, "^")>
	</cfoutput>

</cfif>

<cfif listlen(categorylist, "^") IS 0>
	<cfset categorylist = "^0^">
</cfif>


<STYLE>
<!--
  .selecttr { background-color: #FFFFFF; cursor: pointer;}
  .initial { background-color: #000000; color:#000000; cursor: pointer; }
  .normal { background-color: #FFFFFF; cursor: pointer; }
  .highlight { background-color: #FFFFCC; cursor: pointer; }
//.style1 {
	color: #FFFFFF;
	font-style: italic;
	font-weight: bold;
}
.style1 {color: #FFFFFF}
.style3 {
	color: #FFFFFF;
	font-style: italic;
	font-weight: bold;
}
-->
</style>

<script language="Javascript"> 
   function PopupPic(sPicURL) { 
     window.open( "image-window.html?"+sPicURL, "", "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
</script>

<script language="Javascript"> 
function ShowMain() {
	Main.style.display = "block";
	DetailsSec.style.display = "None";
	Options.style.display = "None";
	Images.style.display = "None";
}
</script>

<script language="Javascript"> 
function ShowDetails() {
	Main.style.display = "None";
	DetailsSec.style.display = "block";
	Options.style.display = "None";
	Images.style.display = "None";
}
</script>

<script language="Javascript"> 
function ShowOptions() {
	Main.style.display = "None";
	DetailsSec.style.display = "None";
	Options.style.display = "block";
	Images.style.display = "None";
}
</script>

<script language="Javascript"> 
function ShowImages() {
	Main.style.display = "None";
	DetailsSec.style.display = "None";
	Options.style.display = "None";
	Images.style.display = "block";
}
</script>

<script language="Javascript"> 
function opencats(windowref)
{
	var a = window.open(windowref,'CategoryEditor','width=640,height=480,scrollbars=1');
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

<cfinclude template = "../queries/qrycategories.cfm">
<cfinclude template = "../queries/qrysuppliers.cfm">
<cfinclude template = "../queries/qrybrands.cfm">
<cfinclude template = "../queries/qryavailability.cfm">
<cfinclude template = "../queries/qrymfgs.cfm">

<!---Set currency symbol--->
<cfset theprice = '1.00'>
<cfif request.EnableEuro IS 'Yes'>
    <cfset c_symbol = #left(lseurocurrencyformat(theprice, "Local"), 1)#>
    <cfelse>
    <cfset c_symbol = #left(lscurrencyformat(theprice, "Local"), 1)#>
</cfif>


<form method="POST" action="doproducts.cfm" enctype="multipart/form-data" name="form1">
<table width="90%" height="480" border="4" align="center" cellpadding="4" cellspacing="0" bordercolor="##000000">
  <tr>
    <td valign="top"><table width="95%" border="0" cellspacing="0" cellpadding="4">
          <tr>
            <td width="51%"><strong><font size="3" face="Verdana, Arial, Helvetica, sans-serif">Adding a New Product </font></strong></td>
            <td width="49%"><div align="right">
          <cfif ISDEFINED('url.WasSearch')>
            <input type = "hidden" Name="WasSearch" Value="Yes">
          </cfif>
          <input type="hidden" value="Add" name="Action">
				<input type="submit" name="Submit" value="Add Item">
            </div></td>
          </tr>
        </table>
      <table width="95%" border="4" align="center" cellpadding="4" cellspacing="0">
        <tr> 
          <td class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'" onClick="javascript:ShowMain()"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong><font color="##000000">BASICS</font></strong></font></div></td>
          <td class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'" onClick="javascript:ShowDetails()"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>DETAILS</strong></font></div></td>
          <td class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'" onClick="javascript:ShowOptions()"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>CATEGORIES</strong></font></div></td>
          <td class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'" onClick="javascript:ShowImages()"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>SETTINGS</strong></font></div></td>
        </tr>
      </table>
      <table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
       
        <tr> 
          <td colspan="5">  
		  <span id = "Main"> 
		      <table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
                <tr>
                  <td>SKU:</td>
                  <td><input name="sku" type="text" id="sku" size="30" required="yes" message="You must provide a unique Product ID for this item" /> 
                  (Must be unique) </td>
                </tr>
                <tr> 
                  <td width="20%">Product ID:</td>
                  <td width="80%"><input name="NewProductID" type="text" size="30" required="yes" Message="You must provide a unique Product ID for this item"></td>
                </tr>
                <tr>
                <!---get brands--->
                  <td valign="top">Brand:</td>
                  <td>
                  <select name = "brand">
                  		<option value="Other">Add New Brand --></option>
                  	<cfoutput query = "qryBrands">
                    	<cfif LEN(trim(brand)) GT 0>
                        <option value="#brand#">#brand#</option>
                        </cfif>
                    </cfoutput>
                  </select>
                  <input name="OtherBrand" type="text" id="OtherBrand" size="30" /></td>
                </tr>
                <tr> 
                  <td valign="top">Product Name:</td>
                  <td><input name="NewProductName" type="text" size="55" required="yes" Message="You must give this product a name!"></td>
                </tr>
                <tr> 
                  <td>Price:</td>
                  <td><cfoutput>#c_symbol#</cfoutput><input name="NewPrice" type="text" value="0.00" size="13" required="Yes" onchange="form1.r_startupfee.value=this.value"></td>
                </tr>
                <tr>
                  <td>Wholesale Price </td>
                  <td><cfoutput>#c_symbol#</cfoutput><input name="NewWholesaleprice" type="text" id="NewWholesaleprice" value="0.00" size="13" required="Yes" /></td>
                </tr>
                <tr>
                  <td>List Price </td>
                  <td><cfoutput>#c_symbol#</cfoutput><input name="NewListPrice" type="text" id="NewListPrice" value="0.00" size="13" required="Yes" /></td>
                </tr>
                <tr> 
                  <td>Brief Description:</td>
                  <td>
				   
			    <textarea name="Briefdescription" cols="60"></textarea></td>
				</tr>
                <tr>
                  <td>Image</td>
                  <td><input name="filecontents" type="file" id="filecontents" size="30" />
                  <strong>Note</strong>: You can leave this blank and upload an image later</td>
                </tr>
                <cfif request.ImageProcessor IS 'None'>
				<tr> 
                  <td>Medium Image:</td>
                  <td><INPUT NAME = "LargeThumbFile" Type = "file" id="LargeThumbFile" size = "30"></td>
                </tr>
				<tr>
				  <td>Thumbnail:</td>
				  <td><input name = "ThumbFile" type = "file" id="ThumbFile" size = "30" /></td>
				  </tr>
				<tr>
				  <td>Tiny Thumbnail: </td>
				  <td><input name = "TinyThumbFile" type = "file" id="TinyThumbFile" size = "30" /></td>
				  </tr>
				</cfif>
              </table>
        </span> 
          </td>
        </tr>
        <tr> 
          <td colspan="5"> 
		  <span id = "DetailsSec" style="display: None;"> 
            <table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
              <tr> 
                <td> 
			<cfoutput><textarea name="details" id="details" style="width: 100%;" rows="300">#s_details#</textarea></cfoutput>
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
                  selecting them</b>
				  <!---Category editor window--->
					<!---<cfoutput><input type = "button" value="Category Editor" onclick="javascript:opencats('#request.adminpath#/components/categories/docategories.cfm');" /></cfoutput>--->
				   <p>
                    <select name="Category" size="25" multiple id="Category">
                      <option Value="0" <cfif categorylist IS '^0^'>selected="selected"</cfif>>Inactive (No Category)
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                      <cf_categorytree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#categorylist#"
				Datasource="#request.dsn#"
				FirstIndent="#request.CategoryIndent#"> 
                    </select>
                </td>
              </tr>
            </table>
            </span> </td>
        </tr>
        <tr> 
          <td colspan="5"> 
            <!---settings--->
            <span id = "Images" style="display: none;">
            <table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
              <tr> 
                <td><table width="100%" border="0" cellspacing="0" cellpadding="4">
					<!---onclick ordering--->
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td><strong>Go straight to checkout when adding to cart?</strong></td>
                      <td><p> 
                          <select name="OneClickOrdering" id="OneClickOrdering">
                            <option <cfif s_oneclickordering IS 'Yes'>selected="selected"</cfif>>Yes</option>
                            <option <cfif NOT s_oneclickordering IS 'Yes'>selected="selected"</cfif>>No</option>
                          </select>
                        </p></td>
                    </tr>                    

					<!---Manufacturer--->
                    <tr>
                      <td bgcolor="#000000"><span class="style3">Specifications</span></td>
                      <td bgcolor="#000000">&nbsp;</td>
                   <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td width="38%"><b>Manufacturer:</b></td>
                      <td width="62%">
                      <select name = "mfg">
                        <option value="Other">Add New Manufacturer --></option>
                    <cfoutput query = "qryMfgs">
                        <cfif LEN(trim(mfg)) GT 0>
                        <option value="#mfg#">#mfg#</option>
                        </cfif>
                    </cfoutput>
                    </select>
                    <input name="OtherMfg" type="text" id="OtherMfg" size="30" />                    </td>
                    </tr>                    
                    <!---supplier--->
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td width="38%"><b>Supplier </b>(If applicable)<b>:</b></td>
                      <td width="62%">
                        <select size="1" name="Supplier">
                          <option value="0" selected="selected">None</option>
                          <cfloop query="qrySuppliers">
                            <cfif NOT #CompanyName# IS ''>
                              <cfoutput><option value="#ContactID#">#CompanyName#</option></cfoutput>
                            </cfif>
                            <cfif #CompanyName# IS '' AND NOT LastName IS ''>
                              <cfoutput><option value="#ContactID#">#FirstName# #LastName#</option></cfoutput>
                            </cfif>
                          </cfloop>
                        </select></td>
                    </tr>                    
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td><strong>UPC:</strong></td>
                      <td><input type="text" name="upc" value="" size="20" /></td>
                    </tr>

                   
                    <tr>
                      <td bgcolor="#000000"><span class="style1"><em><strong>Availablity and Inventory</strong></em></span></td>
                      <td bgcolor="#000000">&nbsp;</td>
                    </tr>
					<!---Availability--->
                    <tr> 
                      <td width="38%"><b>Availability:</b></td>
                      <td width="62%">
                      <select name = "availability">
                        <option value="Other" <cfif s_availability IS 'Other'>selected="selected"</cfif>>Add New Availability --></option>
                    <cfoutput query = "qryAvailability">
                        <cfif LEN(trim(availability)) GT 0>
                        <option value="#availability#" <cfif s_availability IS '#availability#'>selected="selected"</cfif>>#availability#</option>
                        </cfif>
                    </cfoutput>
                    </select>
                    <input name="OtherAvailability" type="text" id="OtherAvailability" size="30" />                    </td>
                    </tr>
                    <cfif NOT request.EnableInventory IS 'No'>
                      <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                        <td ><strong>Initial Items In Stock:</strong></td>
                        <td ><cfoutput><input name="unitsinstock" type = "text" size="6" id="unitsinstock" value="#request.defaultstockvalue#"></cfoutput></td>
                      </tr>
                      <cfelse>
                      <cfoutput><input name="unitsinstock" type = "hidden" id="unitsinstock" value="#request.defaultstockvalue#"></cfoutput>
                    </cfif> 
                     <cfif NOT request.EnableInventory IS 'No'>
                      <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                        <td ><strong>Can 
                          this be back ordered?</strong></td>
                        <td ><select name="CanBackOrder" size="1" id="CanBackOrder">
                            <option <cfif s_canbackorder IS 'Yes'>selected="selected"</cfif>>Yes</option>
                            <option <cfif NOT s_canbackorder IS 'Yes'>selected="selected"</cfif>>No</option>
                          </select></td>
                      </tr>
                      <cfelse>
                      <input type="hidden" name="CanBackOrder" Value="No">
                    </cfif>
                   
                    <!---shipping taxes settings--->
                    <tr>
                      <td bgcolor="#000000"><span class="style1"><em><strong>Shipping and Taxes</strong></em></span></td>
                      <td bgcolor="#000000">&nbsp;</td>
                    </tr>
                    <cfif request.ShippingType IS '5' OR request.ShippingType IS '10' OR request.ShippingType IS '11' OR request.ShippingType IS '12'>
                      <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                        <td> 
                          <p align="left"><strong>Shipping Weight:</strong></td>
                        <td width="62%" > 
                          <input type="text" name="Weight" size="7" value="1.00"> (Max 150lbs)
                          <cfoutput>#request.UnitOfMeasure#</cfoutput> <a href = "../converter/converter.cfm"onClick="NewWindow(this.href,'name','375','250','yes');return false;"><img src="../../icons/calculator.gif" border="0" alt="Click to convert weight measurements" title="Click to convert weight measurements"></a></td>
                      </tr>
                      <cfelse>
                      <input type="hidden" name="Weight" Value="1.00">
                    </cfif>                    
                    <cfif request.ShippingType IS '8'>
                      <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                        <td ><strong>Cost to ship this item:</strong></td>
                        <td ><input name="ShippingCosts" type="text" size="7" Value="0.00"> each (Number only. No symbols)</td>
                      </tr>
                      <cfelse>
                      <input type="hidden" name="ShippingCosts" Value="0.00">
                    </cfif>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Item is shipped?</strong></td>
                      <td ><p> 
                          <select name="askforshipping" id="askforshipping">
                            <option <cfif s_askforshipping IS 'Yes'>selected="selected"</cfif>>Yes</option>
                            <option <cfif NOT s_askforshipping IS 'Yes'>selected="selected"</cfif>>No</option>
                          </select>
                        </p></td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td > <strong>Charge Shipping on this item?</strong></td>
                      <td > <select size="1" name="ChargeShipping">
                          <option <cfif s_chargeshipping IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_chargeshipping IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select></td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Charge Sales Tax on This Item?</strong></td>
                      <td ><select size="1" name="ChargeTaxes">
                          <option <cfif s_chargetaxes IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_chargetaxes IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select></td>
                    </tr>
                    
                    <!---gift cards and subscriptions--->
                    <tr>
                      <td bgcolor="#000000"><span class="style1"><em><strong>Gift Cards and Subscriptions</strong></em></span></td>
                      <td bgcolor="#000000">&nbsp;</td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td valign="top"><strong>Is this a subscription item?</strong> </td>
                      <td ><select size="1" name="issubscription" onchange="javascript: showhidesubscriptionfields(this.value);">
                          <option value="yes" <cfif s_issubscription IS 'yes'>selected="selected"</cfif>>Yes</option>
                          <option value="No" selected="selected" <cfif NOT s_issubscription IS 'yes'>selected="selected"</cfif>>No</option>
                        </select> 
                        
                        <div id="subscriptionfields" <cfif s_issubscription IS 'Yes'>style="display: block;"</cfif>>
                        <p>
                        <b>Choose Options:</b>
                        <table width="100%" cellpadding="4" cellspacing="0" border="0">
						<tr>
                        	<td width="30%">Subscription Fee:</td>
                            <td width="70%"><cfoutput>#c_symbol#</cfoutput><input type="text" name = "r_startupfee" value="0.00" size="10" onchange="form1.NewPrice.value=this.value" /></td>
                        </tr>
                        <tr>
                        	<td width="30%">Recurring Fee:</td>
                            <td width="70%"><cfoutput>#c_symbol#</cfoutput><input type="text" name = "r_fee" value="0.00" size="10" /></td>
                        </tr>
                        <tr>
                        	<td width="30%">Recurring Frequency:</td>
                            <td width="70%"><cfoutput>#c_symbol#</cfoutput>
                            	<select name = "r_frequency">
                                    <option value="N" selected="selected">One-Time</option>
									<option value="M" selected="selected">Per Month</option>
                                    <option value="Y">Per Year</option>
                                </select>                             </td>
                        </tr>
                        <tr>
                        	<td width="30%">Expires in:</td>
                            <td width="70%">
                            	<select name = "r_expiresin">
                                    <option value="1 Day">1 Day</option>
                                    <option value="3 Days">3 Days</option>
                                    <option value="1 Week">1 Week</option>
                                    <option value="1 Month" selected="selected">1 Month</option>
									<option value="3 Months">3 Months</option>
                                    <option value="6 Months" >6 MOnths</option>
                                    <option value="1 Year" >1 Year</option>
                                    <option value="2 Years" >2 Years</option>
                                    <option value="Never" >Never</option>			    
                                </select>                             </td>
                        </tr>
                        </table>
                        </p>
                        </div>                        </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td><strong>Is this item a gift certificate/card?</strong> </td>
                      <td><select size="1" name="isgift">
                          <option <cfif s_isgift IS 'yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_isgift IS 'yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>					

                    
                    <!---view settings--->
                    <tr>
                      <td bgcolor="#000000"><span class="style1"><em><strong>View Settings</strong></em></span></td>
                      <td bgcolor="#000000">&nbsp;</td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show add to cart button?</strong></td>
                      <td ><p> 
                          <select name="showaddtocartbutton" id="showaddtocartbutton">
                            <option <cfif s_showaddtocartbutton IS 'Yes'>selected="selected"</cfif>>Yes</option>
                            <option <cfif NOT s_showaddtocartbutton IS 'Yes'>selected="selected"</cfif>>No</option>
                          </select>
                        </p></td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show Volume discount table when available?</strong></td>
                      <td > <select name="showvoldiscounts" id="showvoldiscounts">
                          <option <cfif s_showvoldiscounts IS 'yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_showvoldiscounts IS 'yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show Quantity Field?</strong></td>
                      <td ><select name="ShowQuantity">
                          <option <cfif s_showquantity IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_showquantity IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select></td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>List the option form fields when viewing details?</strong> </td>
                      <td ><select size="1" name="listoptions">
                          <option <cfif s_listoptions IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_listoptions IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show the image when viewing details?</strong> </td>
                      <td ><select size="1" name="showimage">
                          <option <cfif s_showimage IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_showimage IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show the product name form fields when viewing details?</strong> </td>
                      <td ><select size="1" name="showtitle">
                          <option <cfif s_showtitle IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_showtitle IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show the price when viewing details?</strong> </td>
                      <td ><select size="1" name="showprice">
                          <option <cfif s_showprice IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_showprice IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show the wholesale price when viewing details?</strong> </td>
                      <td ><select size="1" name="showwsprice">
                          <option <cfif s_showwsprice IS 'yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_showwsprice IS 'yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Show the list price when viewing details?</strong> </td>
                      <td ><select size="1" name="showlistprice">
                          <option <cfif s_showlistprice IS 'Yes'>selected="selected"</cfif>>Yes</option>
                          <option <cfif NOT s_showlistprice IS 'Yes'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>                                                                                
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
                      <td ><strong>Product is an option for another item (Won't show in catalog)?</strong> </td>
                      <td ><select size="1" name="isoption">
                          <option value="1" <cfif s_isoption IS '1'>selected="selected"</cfif>>Yes</option>
                          <option value="0" <cfif s_isoption IS '0'>selected="selected"</cfif>>No</option>
                        </select> </td>
                    </tr>  
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                      <td bgcolor="#000000"><span class="style1"><em><strong>Template Settings</strong></em></span></td>
                      <td bgcolor="#000000">&nbsp;</td>
                    </tr>
                    <tr onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
                    	<td><input type="checkbox" name="saveastemplate" value="yes" /> <strong>Check here to create a template from this item.</strong> </td>
                        <td>If saving this as a template, give your template a name: <input type="text" value="" size="25" name="template_name" /></td>
                      </tr>
                    <tr>
                    	<td>&nbsp;</td>
                        <td align="right"><div align="right"><input type="submit" name="Submit" value="Add Item"></div></td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            </span></td>
        </tr>
      </table></td>
  </tr>
</table>
<cfoutput><input type = "hidden" name="template_id" value="#template_id#" /></cfoutput>
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