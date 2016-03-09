<cfinclude template = "../queries/qrynavigation.cfm">

<!---This script moves an item up and down in the listbox depending on which button is
	pressed. 
	
	f is the form name
	bDir is true or false depending on your direction
	
	--->
	
<script>
function move(f, bDir) {
  var el = f.elements["LinkOrderBox"]
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
	
	var mySelect = myForm.LinkOrderBox;
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
    <td><span style="font-weight: bold; font-size: 14px">Reorder Links</span>
      
        <cfif isdefined('url.orderupdated')><span style="color: #FF0000">Order was updated!</span></cfif>
	</td>
  </tr>
</table>
<form name = "ReorderCategories" method="post" onsubmit="return(validateForm(this));" <cfoutput>action="index.cfm?action=savereorder&orderupdated=true&nView=#nView#&mView=#mView#&level=#level#"</cfoutput>>
<table width="95%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="5%" align="left">
        <select name="LinkOrderBox" size="20" class="LinkOrderBox" multiple="multiple">
         <cfset indexcount = 0>
  			<cfoutput query = "qryNavigation">
				<option value="#ID#" >#LinkTitle#</option>
			</cfoutput>
        </select>
      </td>
    <td align="left" valign="top"><p>
      <input type="button" name="MoveUp" value="  Move Up  " onclick="move(this.form,true);">
    </p>
    <p>
      <input type="button" name="MoveDown" value="Move Down" onclick="move(this.form,false);">
</p>
    <p>
	  <cfoutput><input type="hidden" name="nView" value = "#nView#" />
	  <input type = "hidden" name = "mView" value="#mView#" /></cfoutput>
      <input type="submit" name="Submit" value="Save Order" >
    </p></td>
  </tr>
</table>
</form>



















