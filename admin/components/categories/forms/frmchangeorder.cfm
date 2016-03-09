<cfparam name = "CategoryView" default = "Main Categories">

<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.ViewCat = CategoryView>
</cflock>

<cfinclude template = "../queries/qrycategories.cfm">
	
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
    <td><h2>Reorder Categories <cfoutput><a href = "#request.AdminPath#/help/index.cfm?action=view&contentid=38" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#/images/help.gif" border="0" /></b></a></cfoutput></h2>
      <form method="POST" <cfoutput>action="index.cfm?action=changeorder"</cfoutput>>
    Change category: <select size="1" name="CategoryView">
     <option Value="Main Categories" <cfif CategoryView IS 'Main Categories'>SELECTED</cfif>>Main 
            Categories</option>
        <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#CategoryView#"
				Datasource="#request.dsn#"
				FirstIndent="#request.CategoryIndent#"> 
          </select>
        <input type="submit" value="Go" name="B1">
        <cfif isdefined('url.orderupdated')><span style="color: #FF0000">Order was updated!</span></cfif>
    </form></td>
  </tr>
</table>
<cfif qryCategories.recordcount IS 0>
  <p>
<b>There aren't any subcategories under the currently selected category.  Therefore, there is nothing to reorder.  
<br />Please select a different category.</b>
<cfabort>
</cfif>

<form name = "ReorderCategories" method="post" onsubmit="return(validateForm(this));" <cfoutput>action="index.cfm?action=updateorder&orderupdated=true&categoryview=#categoryview#"</cfoutput>>
<table width="95%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="5%" align="right">
        <select name="CategoryOrderBox" size="20" class="categoryorderbox" multiple="multiple">
         <cfset indexcount = 0>
  			<cfoutput query = "qrycategories">
				<option value="#CategoryID#" >#CategoryName#</option>
			</cfoutput>
        </select>
      </td>
    <td valign="top"><p>
      <input type="button" name="MoveUp" value="  Move Up  " onclick="move(this.form,true);">
    </p>
    <p>
      <input type="button" name="MoveDown" value="Move Down" onclick="move(this.form,false);">
	</p>
    <p>
	  <cfoutput><input type="hidden" name="CategoryView" value = "#CategoryView#" /></cfoutput>
      <input type="submit" name="Submit" value="Save Order" >
    </p></td>
  </tr>
</table>
</form>





















