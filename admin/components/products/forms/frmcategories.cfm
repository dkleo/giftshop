<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">
<cfparam name = "sortoption" default="0">
<cfparam name = "AssignTo" default="0">
<cfparam name = "updated" default="No">

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function checkAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}

function uncheckAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}

function checkOne(field, i)
{
if (field[i].checked == true) {
field[i].checked = false ;
}
else {
field[i].checked = true;
}
}


function checkOne2(field)
{
if (SelectedItems.checked == true) {
SelectedItems.checked = false ;
}
else {
SelectedItems.checked = true;
}
}
-->
</SCRIPT>
<h2>Item Category Assignments</h2>
<p>Use this page to modifty an items assignment to a category. Put a checkmark next to each one and click on the &quot;Set Categories&quot; button to set the displayed items to the selected category.</p>
<p>
<cfif updated IS 'Yes'>
	<h2 style="color: #006633;">Item Category Assignments Were Saved!</h2>
</cfif>
  <STYLE>
<!--
  .selecttr { background-color: #FFFFFF; cursor: pointer;}
  .initial { background-color: #000000; color:#000000; cursor: pointer; }
  .normal { background-color: #FFFFFF; cursor: pointer; }
  .highlight { background-color: #CCCCCC; cursor: pointer; }
  .delcheckbox {cursor: None;} 
//-->
  </style>


<cfif isdefined('form.sortoption')>
	<cflock type="exclusive" scope="session" timeout="10">
		<cfset session.sortoption = #form.sortoption#>
	</cflock>
</cfif>

<cfif isdefined('url.sortoption')>
	<cflock type="exclusive" scope="session" timeout="10">
		<cfset session.sortoption = url.sortoption>
	</cflock>
</cfif>

<cfif isdefined('session.sortoption')>
	<cflock type="readonly" scope="session" timeout="10">
		<cfset sortoption = session.sortoption>
	</cflock>
</cfif>

<cfinclude template = '../queries/qrycategories.cfm'>
<cfinclude template = "../queries/qrycatalog.cfm">
<cfinclude template = "../queries/qrycompanyinfo.cfm">

<script language="Javascript"> 
   function PopupPic(sPicURL) { 
     window.open( "image-window.html?"+sPicURL, "",  
     "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
</script>

<div name="formdiv" style="display:block;" id="formdiv">
<!---Display the sort drop down--->
<form method="POST" name="sortform" <cfoutput>action="doproducts.cfm?action=categories"</cfoutput>>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td width="40%" nowrap>
	View: 
	<select name="sortoption" onchange="formdiv.style.display = 'none'; PleaseWait.style.display = 'block'; sortform.submit();">
          <option value = "Inactive" <cfif #sortoption# IS 'Inactive'>SELECTED</cfif>>Inactive 
          Items Only</option>
          <option value = "All" <cfif #sortoption# IS 'All'>SELECTED</cfif>>All 
          products</option>
        <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#sortoption#"
				Datasource="#request.dsn#"
                FirstIndent="#request.CategoryIndent#">
        </select>

		<cfif isdefined('url.deleteid') OR isdefined('url.itemid')>
			<script language="javascript">
				sortform.submit();
			</script>
		</cfif>
		<cfoutput><input type="hidden" name="assignto" id='assignto' value="#assignto#"></cfoutput>
    <input type="submit" value="Sort" name="B1"></td>
</tr>
</table>
</form>


<form name="form1" method="post" <cfoutput>action="doproducts.cfm?action=setcategories&sortoption=#sortoption#&sortoption=#sortoption#&assignto=#assignto#"</cfoutput>>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
<tr>
	    <td>
		Assign selected items to:
      <select name="assignto" onchange="formdiv.style.display = 'none'; PleaseWait.style.display = 'block'; sortform.assignto.value = this.value; sortform.submit();">
      <option value = "0" <cfif #assignto# IS '0'>SELECTED</cfif>>Inactive</option>
       <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#assignto#"
				Datasource="#request.dsn#"
                FirstIndent="#request.CategoryIndent#">  
		  </select>
          <cfoutput><input type = "hidden" name="sortoption" value="#sortoption#" /></cfoutput>
		  &nbsp;&nbsp;<cfif qryCatalog.recordcount GT 0><input type="submit" name="Submit" value="Set Categories" /></cfif> <cfif qryCatalog.recordcount GT 1><input type="button" name="CheckAllBtn" value="Check All" onclick = "checkAll(document.form1.SelectedItems)" /><input type="button" name="CheckNoneBtn" value="Uncheck All" onclick = "uncheckAll(document.form1.SelectedItems)" /></cfif></td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr bgcolor="#3366CC"> 
    <td width="4%"><div align="center"><b><font color="#FFFFFF">Assign/Remove</font></b></div></td>
    <td width="15%"><strong><cfoutput><font color="##FFFFFF">ProductID</font></cfoutput></strong></td>
    <td width="55%"> <strong><cfoutput><font color="##FFFFFF">Product 
      Name</font></cfoutput></strong></td>
  </tr>
  <!---checkbox to determine--->
  <cfset ItemCount = 0>
  
  <cfloop query = "qryCatalog">
 
 	<cfquery name = "qryProducts" datasource="#request.dsn#">
	SELECT * FROM products WHERE itemid = #qryCatalog.itemid#
	</cfquery>
	 
  <cfoutput query = "qryproducts">
	<cfset AlreadyAssigned = 'No'>
	
    <cfquery name = "qryCheckit" datasource="#request.dsn#">
    SELECT * FROM product_categories
    WHERE itemid = #qryproducts.itemid# AND categoryid = #assignto#
    </cfquery>
    
    <cfif qryCheckit.recordcount GT 0>
    	<cfset AlreadyAssigned = 'Yes'>
    </cfif>
    
    <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
      <td> 
	  	  <center>
	  	      <input type = "Hidden" name="RemovedItems" value="#ItemID#" id="RemovedItems">
			  <input type = "checkbox" name="SelectedItems" value="#ItemID#" id="SelectedItems" <cfif alreadyassigned IS 'Yes'>checked="checked"</cfif>>
	  	    </center>	  	  </td>
      <td <cfif qryCatalog.recordcount GT 1>onclick="checkOne(document.form1.SelectedItems, '#ItemCount#');"<cfelse>onclick="checkOne2('SelectedItems');"</cfif>>#ProductID#</td>
      <td <cfif qryCatalog.recordcount GT 1>onclick="checkOne(document.form1.SelectedItems, '#ItemCount#');"<cfelse>onclick="checkOne2('SelectedItems');"</cfif>>#ProductName#</td>
    </tr>
		<cfset ItemCount = ItemCount + 1>
  </cfoutput> 
  </cfloop>
</table> 
<p align="right">
  <cfif qryCatalog.recordcount GT 0><input type="submit" name="Submit" value="Set Categories" /></cfif>
</p>
</form>
</div>
<p>
<div name = "PleaseWait" id="PleaseWait" style="display:none;">
<p>
<h2>Please wait while the page refreshes...</h2>
</p>
</div>

