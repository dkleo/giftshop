<cfparam name = "action" default="">

<cftry>
  <cfswitch expression="#action#">
    <cfcase value ='new'>
    	<cfinclude template = 'forms/frmadd.cfm'>
    </cfcase>
    <cfcase value ='newfromtemplate'>
    	<cfinclude template = "forms/frmnewfromtemplate.cfm">
    </cfcase>
    <cfcase value ='delete_template'>
    	<cfinclude template = "actions/actdeletetemplate.cfm">
    </cfcase>
    <cfcase value ='Delete'>
    	<cfinclude template = 'actions/actdelete.cfm'>
    </cfcase>
    <cfcase value ='Edit'>
    	<cfinclude template = 'forms/frmedit.cfm'>
    </cfcase>
    <cfcase value ='Setoptions'>
    	<cfinclude template = 'forms/frmoptions.cfm'>
    </cfcase>
    <cfcase value ='SetFeatureNo'>
    	<cfinclude template = 'actions/actsetfeatureno.cfm'>
    </cfcase>
    <cfcase value ='SetFeatureYes'>
    	<cfinclude template = 'actions/actsetfeatureyes.cfm'>
    </cfcase>
    <cfcase value ='EditDetails'>
    	<cfinclude template = 'forms/frmeditdetails.cfm'>
    </cfcase>
    <cfcase value ='discounts'>
    	<cfinclude template = "forms/frmdiscounts.cfm">
    </cfcase>
    <cfcase value ='ResetAllStats'>
	    <cfinclude template = "actions/actresetallstats.cfm">
    </cfcase>
    <cfcase value ='ResetStats'>
	    <cfinclude template = "actions/actresetstats.cfm">
    </cfcase>
    <cfcase value ='Duplicate'>
	    <cfinclude template = "actions/actduplicate.cfm">
    </cfcase>
    <cfcase value ='FeaturedItems'>
	    <cfinclude template = "forms/frmfeatureditems.cfm">
    </cfcase>
    <cfcase value ='Categories'>
	    <cfinclude template = "forms/frmcategories.cfm">
    </cfcase>
    <cfcase value ='SetCategories'>
	    <cfinclude template = "actions/actsetcategories.cfm">
    </cfcase>
    <cfcase value ='brochure'>
	    <cfinclude template = "forms/frmbrochure.cfm">
    </cfcase>
    <cfcase value ='newbrochure'>
	    <cfinclude template = "forms/frmnewbrochure.cfm">
    </cfcase>
    <cfcase value ='addBrochure'>
	    <cfinclude template = "actions/actaddbrochure.cfm">
	    <cfinclude template = "forms/frmBrochure.cfm">
    </cfcase>
    <cfcase value ='deleteBrochure'>
	    <cfinclude template = "actions/actdeletebrochure.cfm">
    </cfcase>
    <cfcase value ='changeorder'>
	    <cfinclude template = "forms/frmchangeorder.cfm">
    </cfcase>
    <cfcase value ='savereorder'>
	    <cfinclude template = "actions/actsavereorder.cfm">
    </cfcase>
    <cfcase value ='pricing'>
	    <cfinclude template = "forms/frmpricing.cfm">
    </cfcase>
    <cfcase value ='globalpricechange'>
  	  <cfinclude template = "actions/actglobalpriceupdate.cfm">
    </cfcase>
    <cfcase value ='removerelated'>
 	   <cfinclude template = "actions/actremoverelated.cfm">
    </cfcase>
    <cfcase value ='RelatedItems'>
	    <cfinclude template = "forms/frmselectrelateditems.cfm">
    </cfcase>
    <cfcase value ='downloads'>
	    <cfinclude template = 'forms/frmattachments.cfm'>
    </cfcase>
    <cfcase value ='uploadfiles'>
  	  <cfinclude template = 'forms/frmupload.cfm'>
    </cfcase>
    <cfcase value ='DeleteDownload'>
    	<cfinclude template = 'actions/actdeletedownload.cfm'>
    </cfcase>
    <cfcase value ='DeleteDiscount'>
    	<cfinclude template = 'actions/actdeletediscount.cfm'>
    </cfcase>
    <cfcase value ='PricingLevels'>
    	<cfinclude template = 'forms/frmpricinglevels.cfm'>
    </cfcase>
    <cfcase value = 'Add'>
    	<cfinclude template = 'actions/actadd.cfm'>
    </cfcase>
    <cfcase value = 'Setforms'>
    	<cfinclude template = 'actions/actsetoptions.cfm'>
    </cfcase>
    <cfcase value = 'Update'>
    	<cfinclude template = 'actions/actupdate.cfm'>
    </cfcase>
    <cfcase value = 'viewStats'>
    	<cfinclude template = 'actions/actviewstats.cfm'>
    </cfcase>
    <cfcase value = 'UpdateDetails'>
    	<cfinclude template = 'actions/actupdatedetails.cfm'>
    </cfcase>
    <cfcase value = 'SetSamediscounts'>
    	<cfinclude template = 'actions/actsetsamediscounts.cfm'>
    </cfcase>
    <cfcase value = 'UpdateFeatured'>
    	<cfinclude template = 'actions/actsetfeatures.cfm'>
    </cfcase>
    <cfcase value = 'SetSubscriptionItem'>
    	<cfinclude template = 'actions/actsetsubscriptionitem.cfm'>
    </cfcase>
    <cfcase value = 'UpdatePricing'>
    	<cfinclude template = 'actions/actupdatepricing.cfm'>
    </cfcase>
    <cfcase value = 'UpdateRelated'>
    	<cfinclude template = 'actions/actsetrelated.cfm'>
    </cfcase>
    <cfdefaultcase>
    	<cfinclude template = "forms/frmproducts.cfm">
    </cfdefaultcase>
  </cfswitch>
  <cfcatch type = "any">
    <cfinclude template = "../../errorprocess.cfm">
    <cfabort>
  </cfcatch>
</cftry>
