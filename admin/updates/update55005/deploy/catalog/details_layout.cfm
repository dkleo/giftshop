<cfoutput query = "qryproducts">
<form method="post" <cfoutput>action="index.cfm?carttoken=#carttoken#&action=addtocart"</cfoutput> id="DetailsForm" name="DetailsForm" onsubmit="return validateOnSubmit('#FormsList#', 'DetailsForm')">
<table width="100%" border="0" cellspacing="0" cellpadding="8">
  <tr>
  	<td colspan="2" height="20">
    <cfinclude template = "details_buildpath.cfm">
</td>
  </tr>
  <tr>
    <td width="40%" valign="top">
    	<!---image(s)--->
    	<div class="details_image"><cfinclude template = "details_mainimage.cfm"></div>
	    <div class="details_rating"><cfinclude template = "details_rating.cfm"></div>
    </td>
    <td valign="top">
    <!---top info--->
    <table width="100%" cellspacing="0" cellpadding="4">
    <tr>
    <td>
    <div class="toplinks"><cfinclude template = "details_toplinks.cfm"></div>
    <div class="details_title"><cfinclude template = "details_title.cfm"></div>
	<div class="availablility"><cfinclude template = "details_availability.cfm"></div>
    <!---add to cart will appear here if there are fewer than 4 options--->
	<cfif qryProductOptions.recordcount LT 4>
    <cfif qrySubs.recordcount IS 0>
	<cfif NOT qryproducts.listoptions IS 'No'><div class="details_options"><cfinclude template = "details_options.cfm"></div></cfif>
   	<cfif NOT qryproducts.showaddtocartbutton IS 'No'><div class="details_addtocart"><cfinclude template = "details_addtocartbutton.cfm"></div></cfif>
    </cfif>
    </cfif><!---end if less than 4 options--->
    </td>
    </tr>
    <tr>
    <td>
    <div class="details_pricing"><cfinclude template = "details_pricing.cfm"></div>
    </td>
    </tr>
	<cfif NOT qrydiscounts.recordcount IS 0>
	<tr>
    <td>
    <div class="details_discounts">
    <cfinclude template = "details_discounts.cfm">
    </div>
	</td>
    </tr>
    </cfif>
    <tr>
    <td>
    <div class="details_nextprev">
	<cfinclude template = "details_nextprevious.cfm">
    </div>
    </td>
    </tr>
    <cfif qry_ProductImages.recordcount GT 1>
    <tr>
    <td>
    <div class="details_moreimages">
    <cfinclude template = "details_moreimages.cfm">
    </div>
    </td>
    </tr>
    </cfif>
    </table>
    <!---end top info--->
    </td>
  </tr>
  <!---sub items if any--->
  <cfif qrySubs.recordcount GT 0>
  <tr>
    <td colspan="2" class="TableTitles"><strong>Options</strong></td>
  </tr>
  <tr>
    <td colspan="2">    
    <div class="details_subitems"><cfinclude template = "details_subitems.cfm"></div>
    </td>
  </tr>
  <tr>
  	<td colspan="2" align="right"><div align="right" class="details_addtocartbutton"><cfinclude template = "details_addtocartbutton.cfm"></div></td>
  </tr>
  </cfif>
  <!---show option form fields and add to cart button here if there are more than just a few options for this item--->
  <cfif qrySubs.recordcount IS 0>
  <cfif qryProductOptions.recordcount GT 3>
  <tr>
    <td colspan="2" class="TableTitles"><strong>Options</strong></td>
  </tr>
  <tr>
    <td colspan="2">
		<cfif NOT qryproducts.listoptions IS 'No'><div class="details_options"><cfinclude template = "details_options.cfm"></div></cfif>
		<cfif NOT qryproducts.showaddtocartbutton IS 'No'><div align="left" class="details_addtocart"><cfinclude template = "details_addtocartbutton.cfm"></div>		
		</cfif>
    </td>
  </tr>
  </cfif>
  </cfif><!---end if there are no sub items--->
  <!---show product html--->
<cfif fileexists('#request.catalogpath##request.bslash#docs#request.bslash#products#request.bslash#item#itemid#.cfm')>
<cffile action="read" file="#request.catalogpath##request.bslash#docs#request.bslash#products#request.bslash#item#qryproducts.itemid#.cfm" variable="thedetails">
  <cfif NOT theDetails IS ''>
  <tr>
    <td colspan="2" class="TableTitles"><strong>Item Information</strong></td>
  </tr>
  <tr>
    <td colspan="2"><div class="details_details"><cfinclude template = "details_html.cfm"></div></td>
  </tr>
  </cfif>
</cfif>
  <!---related items--->
  <cfif listlen(qryProducts.SimilarItems, "^") GT 0>
  <tr>
    <td colspan="2" class="TableTitles"><strong>Related Items</strong></td>
  </tr>
  <tr>
    <td colspan="2"><div class="details_relateditems"><cfinclude template = "relateditems.cfm"></div></td>
  </tr>
  </cfif>

  <!---related items--->
  <cfif qryReviews.recordcount GT 0>
  <tr>
    <td colspan="2" class="TableTitles"><strong>Reviews</strong></td>
  </tr>
  <tr>
    <td colspan="2"><div class="details_reviews"><cfinclude template = "readreviews.cfm"></div></td>
  </tr>
  </cfif>
</table>
 </form>
</cfoutput>



