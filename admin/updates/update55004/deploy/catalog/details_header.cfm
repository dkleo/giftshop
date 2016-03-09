<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfinclude template = "../queries/qrydiscounts.cfm">
<cfinclude template = "../queries/qrycategories.cfm">
<cfinclude template = "../queries/qrysales.cfm">
<cfinclude template = "../queries/qrybrochures.cfm">
<cfinclude template = "../queries/qrywishlistcheck.cfm">
<cfinclude template = "../queries/qrysubproducts.cfm">
<cfinclude template = "../queries/qryproductoptions.cfm">
<cfinclude template = "../queries/qryProductimages.cfm">

<!---If viewing a specific category then get all the items in this category so that next/previous can be displayed--->
<cfif isdefined('url.category')>
	<cfset currentcategory = url.category>
	<cfinclude template = "../queries/qrycatalog.cfm">
</cfif>

<!---If the item is a sub item then redirect to the parent--->
<cfif len(qryProducts.subof) GT 0>
	<cflocation url = "index.cfm?action=ViewDetails&ItemID=#qryProducts.subof#&carttoken=#carttoken#">
</cfif>

<!---See if there is a sale on this item--->
<cfset OriginalPrice = '#qryProducts.Price#'>

<cfif request.pricinglevel GT 0>        
	<cfset OriginalPrice = levelprice>
</cfif>

<cfset TheItemID = '#ItemID#'>
<cfset TheCategoryID = '#Category#'>           
<cfset SalePrice = OriginalPrice>
<cfset TodaysDate = #Now()#>
<cfset TodaysDate = dateformat(TodaysDate, "mm/dd/yyyy")>

<cfif NOT qryproducts.isgift IS 'Yes'>
	<cfinclude template = "../cart/crtcheckforsale.cfm">
</cfif>

<cfset OptionsList = #qryProducts.FormFields#>

<!---build javascript for option form fields validation--->
<cfset FormsList = ''>
<cfloop from="1" to="#listlen(qryProducts.FormFields)#" index="mycount">
	<cfset ThisOptionField = ListGetAt(qryProducts.FormFields, mycount)>
	<cfif NOT ThisOptionField IS 'None'>
		<cfinclude template = "../queries/qryoptions.cfm">
	<!---If this one is required then add it to the list of forms fields to check for--->
	<cfif qryOptions.isRequired IS 'Yes'>
	  <cfif ListLen(FormsList) IS 0>
			<cfset FormsList = FormsList & 'ffield#ThisOptionField#js'>
		<cfelse>
			<cfset FormsList = FormsList & ',ffield#ThisOptionField#js'>
	  </cfif>
	 </cfif>
    </cfif>
</cfloop>

<SCRIPT TYPE="text/javascript">
// Used for form field validation.
 function validateOnSubmit(formslist, formname) {
  
  var ThisFormName = formname;
  var mylist = formslist;
  var myarray = new Array();
  var elem;
  var errs=0;
  myarray = mylist.split(",");
  if (!(myarray[0] == '')) 
	  {
		  for (var i=(myarray.length-1); i>-1 ;i=i-1) {
			ThisForm = myarray[i];
			ThisSpan = "msg" + ThisForm
			if (typeof document.forms[ThisFormName].elements[ThisForm] != 'undefined')
			{
			ThisSpan = document.getElementById(ThisSpan);
				if (document.forms[ThisFormName].elements[ThisForm].value.length == 0)
					{
						errs += 1;
						ThisSpan.style.visibility = "visible";
						ReqError.style.visibility = "visible";
					}
					else {
						ThisSpan.style.visibility = "hidden";
					}
				}	
			  }
    if (errs>1)  
	{
	alert('Some required fields are not filled in.  Please fill in the required fields before adding this item to your shopping cart.');
	}
    if (errs==1) 
	{
	alert('Please fill in the required field before adding this item to your shopping cart!');
	}

    return (errs==0);
	}
  }; 
</SCRIPT>

<!---update hit count--->
<cfoutput Query = "qryproducts">
<cfset OldTimesViewed = #TimesViewed#>
<cfset NewTimesViewed = #OldTimesViewed# + 1>
<cfset OptionFields = #FormFields#>
</cfoutput>

<!---write the details file if it doesn't exist (this is here as a backup and to make it so that imported data will display properly)--->
<cfif NOT fileexists('#request.catalogpath##request.bslash#docs#request.bslash#products#request.bslash#item#itemid#.cfm')>
	<cffile action = "write" file="#request.catalogpath##request.bslash#docs#request.bslash#products#request.bslash#item#itemid#.cfm" output="#qryproducts.details#">
</cfif>

<cfinclude template = "../cart/crtupdatehitcount.cfm">

<!---If this is a subitem then get it's parent info--->
<cfset ItemParentName = ''>
<cfif len(qryProducts.subof) GT 0>
	<cfinclude template = "../queries/qryparentproducts.cfm">

	<cfoutput query = "qryParent">
	<cfset ItemParentName = '#ProductName# - '>
	</cfoutput>
</cfif>