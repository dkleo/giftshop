<cfparam name = "SortOption" default = "Featured">
<cfparam name = "url.orderby" default = "ordervalue">

<cfif SortOption IS 'Featured'>
	<cfset url.orderby = 'fordervalue'>
</cfif>

<cflock scope="Session" type="exclusive" timeout="10">
  <cfset session.SortOption = SortOption>
</cflock>

<cfinclude template = "../queries/qrycategories.cfm">
<cfinclude template = "../queries/qrycatalog.cfm">

<!---This script moves an item up and down in the listbox depending on which button is
	pressed. 
	
	f is the form name
	bDir is true or false depending on your direction
	
	--->
	
<script>
function move(f, bDir) {
  var el = f.elements["CategoryOrderBox"]
  var idx = el.selectedIndex
  if (idx==-1) 
    alert("You must first select the item to reorder.")
  else {
    var nxidx = idx+( bDir? -1 : 1)
    if (nxidx<0) nxidx=el.length-1
    if (nxidx>=el.length) nxidx=0
    var oldVal = el[idx].value
    var oldText = el[idx].text
    el[idx].value = el[nxidx].value
    el[idx].text = el[nxidx].text
    el[nxidx].value = oldVal
    el[nxidx].text = oldText
    el.selectedIndex = nxidx
  }
}
</script>

<!---This script selects all the items in the list box prior to submission of the form so that the
	 values will be passed so we can save them in the database--->

<script>
function validateForm(myForm)
{
	/* this function makes sure at least one county is 
	seleced before submiting the form 
	*/
	
	var mySelect = myForm.CategoryOrderBox;
	if (mySelect.length == 0)
	{
		alert("Please choose a category to reorder that contains subcategories or reorder the main categories.");
		return(false);
	}
	else
	{//select all of them so they submit
		for (var i=0; i<mySelect.length; i++)
			mySelect[i].selected=true;
		
		myForm.MoveUp.disabled = true;
		myForm.MoveDown.disabled = true;
		myForm.Submit.disabled = true;
		return(true);
	}
}
//-->
</script>


<table width="100%">
  <tr>
    <td><h2><span style="font-weight: bold">Reorder Products</span></h2>
      <form method="POST" <cfoutput>action="doproducts.cfm?action=changeorder"</cfoutput>>
    Change category: <select size="1" name="SortOption">
     <option Value="Featured" <cfif SortOption IS 'Featured'>SELECTED</cfif>>Featured Items</option>
          <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#sortoption#"
				Datasource="#request.dsn#"
                FirstIndent="#request.CategoryIndent#">  
          </select>
        <input type="submit" value="Go" name="B1">
        <cfif isdefined('url.ordersaved')><span style="color: #FF0000">Order was updated!</span></cfif>
    </form></td>
  </tr>
</table>

<cfif qryCatalog.recordcount is 0>
	There are no products in the currently selected category.  Choose a category above to reorder how the products are displayed by default.  
</cfif>

<cfif NOT qryCatalog.recordcount is 0>
  <form name = "ReorderCategories" method="post" onsubmit="return(validateForm(this));" <cfoutput>action="doproducts.cfm?action=savereorder&orderupdated=true&sortoption=#sortoption#"</cfoutput>>
<table width="95%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="5%" align="left">
        <select name="CategoryOrderBox" size="20" class="categoryorderbox" multiple="multiple">
         <cfset indexcount = 0>
  			<cfloop query = "qryCatalog">
				<cfset ShortProductName = ProductName>
				<cfif #Len(ShortProductName)# GT 40>
					<cfset ShortProductName = Left(ShortProductName, 45)>
					<cfset ShortProductName = "#ShortProductname#...">
				</cfif>
					<cfoutput><option value="#qryCatalog.ItemID#" >#qryCatalog.ProductID# - #ShortProductName#</option></cfoutput>
                
                <cfquery name = "qrySubItems" datasource="#request.dsn#">
                SELECT * FROM products WHERE productid = '#qryCatalog.productid#' AND subof = '#qryCatalog.itemid#'
                ORDER BY fordervalue ASC
                </cfquery>

					<cfloop query = "qrySubItems">                   
                    <cfoutput><option value="#qrySubItems.ItemID#" >---->#qrySubItems.SKU# - #qrysubItems.ProductName#</option></cfoutput>
                    </cfloop>                
				</cfloop>

        </select>
      </td>
    <td valign="top"><p>
      <input type="button" name="MoveUp" value="  Move Up  " onclick="move(this.form,true);">
    </p>
    <p>
      <input type="button" name="MoveDown" value="Move Down" onclick="move(this.form,false);">
</p>
    <p>
	  <cfoutput><input type="hidden" name="SortOption" value = "#SortOption#" /></cfoutput>
      <input type="submit" name="Submit" value="Save Order" >
    </p></td>
  </tr>
</table>
</form>
</cfif>















