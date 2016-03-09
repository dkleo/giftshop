<STYLE>
<!--
  .selecttr { background-color: #FFFFFF; cursor: pointer;}
  .initial { background-color: #000000; color:#000000; cursor: pointer; }
  .normal { background-color: #FFFFFF; cursor: pointer; }
  .highlight { background-color: #CCCCCC; cursor: pointer; }
  .delcheckbox {cursor: None;} 
//.style1 {font-size: 14px}
.style2 {
	font-size: 12pt;
	font-weight: bold;
}
-->
</style>
<script language="JavaScript">
 function EditItem(itemid){
		window.location.href = 'dooptions.cfm?action=editoptions&ItemID=' + itemid;
 }
 
 function ExpandItems(Entity) {
	DTT_TableID = Entity;
	DTT_ImageID = "IMG" + Entity;
	DTT_Image = document.getElementById(DTT_ImageID);
	DTT_Table = document.getElementById(DTT_TableID);
	if(DTT_Table.style.display == "none") {
		DTT_Table.style.display = "block";
		DTT_Image.src = 'icons/collapse.gif';
	}
	else {
		DTT_Table.style.display = "none";
		DTT_Image.src = 'icons/expand.gif';
	}
} 
</script>

<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">

<cfif ISDEFINED('session.disp')>
	<cflock scope="Session" type="Exclusive" timeout="10">
		<cfset disp = '#session.disp#'>
	</cflock>
</cfif>

<cfif ISDEFINED('form.disp')>
		<cfset disp = '#form.disp#'>
</cfif>

<!---Store the start varialbe in a session so that the last viewed page can always be called---> 
<cfif ISDEFINED('url.start')>
<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.start= '#url.start#'>
</cflock>
</cfif>

<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.disp = '#disp#'>
</cflock>

<cfif ISDEFINED('form.start')>
<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.start= '#form.start#'>
</cflock>
</cfif>

<cfif ISDEFINED('session.start')>
<cflock scope="Session" type="ReadOnly" timeout="10">
   <cfset start = '#session.start#'>
</cflock>
</cfif>

<cfif NOT ISDEFINED('url.start') AND NOT ISDEFINED('session.start')>
<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.start= '#start#'>
</cflock>
</cfif>

<cfif NOT isdefined('Session.SortOption')>
  <cflock scope="Session" type="Exclusive" timeout="10">
    <cfset session.sortoption = 'Featured'>
	<cfset session.start = '1'>
  </cflock>
</cfif>
<cfif isdefined('form.Sortproducts')>
  <cflock scope="Session" type="Exclusive" timeout="10">
    <cfset session.sortoption = '#form.Sortproducts#'>
    <cfset session.start = "1">
  </cflock>
</cfif>
<cfif isdefined('url.sortoption')>
  <cflock scope="Session" type="Exclusive" timeout="10">
    <cfset session.sortoption = '#url.sortoption#'>
  </cflock>
</cfif>

<cfinclude template = '../queries/qrycategories.cfm'>
<cfinclude template = "../queries/qrycatalog.cfm">
<cfinclude template = "../queries/qryitemcategories.cfm">


<script language="Javascript"> 
   function PopupPic(sPicURL) { 
     window.open( "image-window.html?"+sPicURL, "",  
     "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
   </script>
 
<cflock scope="Session" type="Readonly" timeout="10">
  <cfset TempVar.SortOption = #session.SortOption#>
</cflock>

<!---Display the sort drop down--->
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td colspan="4" nowrap><span class="style2">Select a product you wish to create or edit options for</span> </td>
  </tr>
  <tr> 
    <td width="30%" nowrap> <form method="POST" action="dooptions.cfm">
	<select name="Sortproducts">
          <cfif NOT request.EnableInventory IS 'No'>
            <option value = "OutofStock" <cfif #TempVar.sortoption# IS 'OutofStock'>SELECTED</cfif>>Out 
            of Stock</option>
          </cfif>
          <option value = "Featured" <cfif #TempVar.sortoption# IS 'Featured'>SELECTED</cfif>>Featured 
          Items Only</option>
          <option value = "Inactive" <cfif #TempVar.sortoption# IS 'Inactive'>SELECTED</cfif>>Inactive 
          Items Only</option>
          <option value = "All" <cfif #TempVar.sortoption# IS 'All'>SELECTED</cfif>>All 
          products</option>
          <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#TempVar.SortOption#"
				Datasource="#request.dsn#"
				FirstIndent="#request.CategoryIndent#"> 
        </select>
        <input type="submit" value="Sort" name="B1"></p></form></td>
	    <td width="30%"> <div align="center"> <cfoutput> 
          <!---Display the page numbers--->
          <cfif disp LT qryCatalog.RecordCount + 1>
            <form name = "PageSelect" method="Post" Action="dooptions.cfm">
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryCatalog.RecordCount#" Step="#disp#"><a href = "dooptions.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
            </form>
          </cfif>
        </cfoutput> </div></td>
    <td width="30%"><form name="Displayoptions" method="POST" Action="dooptions.cfm">
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="100" <cfif disp IS '9999999'>SELECTED</cfif>>Display All</option>
		</select>
	</form></td>
    <td width="30%" nowrap> <form name="form1" method="post" action="dooptions.cfm">
        <div align="right"> 
          <input type="text" name="SearchQuery">
          <input type="submit" name="Submit" value="Search">
        </div>
      </form></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr bgcolor="#3366CC"> 
    <td width="10%"><div align="center"><strong> <font color="#FFFFFF">Found In</font></strong></div></td>
    <td width="10%"> <p align="left"><strong> <font color="#FFFFFF">SKU</font></strong></td>
    <td> <strong><a href="dooptions.cfm?OrderBy=ProductName"><font color="#FFFFFF">Product 
      Name</font></a></strong></td>
    <td width="8%"><div align="center"> <font color="#FFFFFF"><strong>Price</strong></font></div></td>
  </tr>
  <cfset RowCount = 0>
  <!---Set up variables for paginating--->
  <CFSET end=Start + disp>
  <CFIF Start + disp GREATER THAN qryCatalog.RecordCount>
    <CFSET end=999>
    <CFELSE>
    <CFSET end=disp>
  </CFIF>
  <!---Categories this product belongs to--->
  <cfloop query = "qryCatalog" startRow="#Start#" endrow="#End#"> 
    <cfset CategoryCount = 0>
    <!---keep track of the number of categories this one belongs to--->
    <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
      <td> 
      <!---get the categories this one is assigned to--->
      <cfquery name = "qryCatAssign" dbtype="query">
      SELECT * FROM qryItemCategories
      WHERE itemid = #qryCatalog.itemid#
      </cfquery>
        <select size="1" name="select" style="width:150;">
          <cfif qryCatAssign.recordcount IS 0>
            <option SELECTED>Inactive</option>
          </cfif>
          <cfloop query = "qryCatAssign">
            <cfquery name = "qryCategory" dbtype="query">
            SELECT * FROM qryCategories
            WHERE categoryid = #qryCatAssign.categoryid#
            </cfquery>
                <cfif qryCategory.recordcount GT 0>
                <cfoutput>
                <option <cfif qryItemCategories.categoryid IS '#session.sortoption#'>SELECTED</cfif>>#qryCategory.CategoryName#</option>
                </cfoutput>
                </cfif>
          </cfloop> 
          </select>  <cfoutput><a name="#ItemID#" id="#qryCatalog.ItemID#"></a></cfoutput></td>
	   <cfoutput>
       <td onclick="EditItem(#qryCatalog.itemid#);"> 
        <!---<p align="center"> 
          <cfif NOT #Thumbnail# IS 'SMnopic.jpg'>
            <img src = "#request.HomeURL#/photos/#thumbnail#" alt="Click to view" width="42" border="0"> 
          </cfif>
          <cfif #Thumbnail# IS 'SMnopic.jpg'>
            No Photo<br></a>
          </cfif>--->
          #qryCatalog.sku#      </td>
      <td onclick="EditItem(#qryCatalog.itemid#);"><a href = "dooptions.cfm?action=editoptions&ItemID=#itemid#">#qryCatalog.ProductName#</a></td>
      <td width="10%" onclick="EditItem(#qryCatalog.itemid#);"><div align="center">
		  <cfif request.EnableEuro IS 'Yes'>
            #lseurocurrencyformat(qryCatalog.Price, "Local")#
            <cfelse>
            #lscurrencyformat(qryCatalog.Price, "Local")#
          </cfif>
        </div></td>
    </cfoutput>
    </tr>
	<cfquery name = "qrySubItems" datasource="#request.dsn#">
	SELECT * FROM products WHERE productid = '#qryCatalog.productid#' AND subof = '#qryCatalog.itemid#'
    ORDER BY fordervalue ASC
	</cfquery>
    
	<cfif qrySubItems.recordcount GT 0>
	<tr>
      <td bgcolor="#FFFFFF" height="5" align="right"><cfoutput><img src="icons/expand.gif" width="9" height="9" onclick="javascript: ExpandItems('items#itemid#');" name="IMGitems#itemid#" id="IMGitems#itemid#" style="cursor:pointer;" /></cfoutput></td>
	  <td colspan="5" bgcolor="#FFFFFF" height="5">Expand/Collapse subitems</td>
    </tr>
      <td></td>
	  <td colspan="5">
	  <span style="display:none;" <cfoutput>name="items#itemid#" id="items#itemid#"</cfoutput>>
	  <table width = "100%" cellspacing="0" cellpadding="4">
	  <tr>
	  <td bgcolor="#000000"><font color="#FFFFFF"><b>Item Name</b></font></td>
	  <td bgcolor="#000000" width="10%"><font color="#FFFFFF" align="center"><b>Price</b></font></td>
	  <td bgcolor="#000000" width="20%"><font color="#FFFFFF"><b></b></font></td>
	  </tr>
	  <cfoutput query = "qrySubItems">
	  <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
	  <td onclick="EditItem(#itemid#);">#ProductName#</td>
	  <td onclick="EditItem(#itemid#);">
	  <cfif request.EnableEuro IS 'Yes'>
		#lseurocurrencyformat(Price, "Local")#
	  <cfelse>
	    #lscurrencyformat(Price, "Local")#
      </cfif>
	  </td>
	  <td align="center"></td>
	  </tr>	  
	  </cfoutput>
	  </table>
	  </span>
	  </td>
    </tr>
	</cfif>
</cfloop> 
</table>
<br>
<cfoutput>
  <table width="100%" border="0" cellspacing="0" cellpadding="1">
    <tr>
      <td width="35%">Found <strong>#qryCatalog.RecordCount#</strong> product<cfif qryCatalog.RecordCount GT 1>s</cfif></td>
      <td><div align="center"></div></td>
      <td width="25%"><table border="0" align="center" cellpadding="10">
          </table></td>
    </tr>
  </table> 
</CFOUTPUT>
