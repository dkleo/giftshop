<cfif request.EnableInventory IS 'No'>
	Inventory has been disabled.  You need to enable it in the advanced settings in order to use this feature.
	<cfabort>
</cfif>
<STYLE>
<!--
  .selecttr { background-color: #FFFFFF;}
  .initial { background-color: #000000; color:#000000; }
  .normal { background-color: #FFFFFF; }
  .highlight { background-color: #CCCCCC; }
  .delcheckbox {cursor: None;} 
//-->
</style>

<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">
<cfparam name = "viewtype" default="All">
<cfparam name = "searchquery" default="">
<cfparam name = "sortoption" default="Featured">

<script language="JavaScript">
function checkblanks (strng) {
 if (strng == "") {
    alert = ("You have a blank field.  Please enter a value of at least zero!");
 	}
 }
</script>

<script language="JavaScript">
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

<!---Store the start varialbe in a session so that the last viewed page can always be called---> 
<cfinclude template = '../queries/qrycategories.cfm'>
<cfinclude template = '../queries/qrysuppliers.cfm'>
<cfinclude template = "../queries/qrycatalog.cfm">

<script language="Javascript"> 
   function PopupPic(sPicURL) { 
     window.open( "image-window.html?"+sPicURL, "",  
     "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
   </script>


<!---Display the sort drop down--->
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td width="30%" nowrap> 
    <form method="POST" action="doinventory.cfm">
	<select name="sortoption">
          <cfif NOT request.EnableInventory IS 'No'>
            <option value = "OutofStock" <cfif #sortoption# IS 'OutofStock'>SELECTED</cfif>>Out 
            of Stock</option>
          </cfif>
          <option value = "Featured" <cfif #sortoption# IS 'Featured'>SELECTED</cfif>>Featured 
          Items Only</option>
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
        <select name="viewtype" id="viewtype">
        	<option value="All" <cfif viewtype IS 'All'>selected="selected"</cfif>>All Catalog Items</option>
            <option value="ProductsOnly" <cfif viewtype IS 'ProductsOnly'>selected="selected"</cfif>>Products Only</option>
            <option value="OptionsOnly" <cfif viewtype IS 'OptionsOnly'>selected="selected"</cfif>>Option Items Only</option>
        </select>
        <cfoutput>
        <input type = "hidden" name="disp" value="#disp#" />
        <input type = "hidden" name="searchquery" value="#searchquery#" />
        </cfoutput>
        <input type="submit" value="Sort" name="B1">
        </form>
        </td>
	    <td width="30%"> <div align="center"> <cfoutput> 
          <!---Display the page numbers--->
          <cfif disp LT qryCatalog.recordcount + 1>
            <form name = "PageSelect" method="Post" Action="doinventory.cfm">
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryCatalog.recordcount#" Step="#disp#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
            </form>
          </cfif>
          <input type="hidden" name="disp" value="#disp#" />
          <input type = "hidden" name="viewtype" value="#viewtype#" />
          <input type = "hidden" name="searchquery" value="#searchquery#" />
          <input type = "hidden" name="sortoption" value="#sortoption#" />
        </cfoutput> </div></td>
    <td width="30%"><form name="Displayoptions" method="POST" Action="doinventory.cfm">
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="100" <cfif disp IS '9999999'>SELECTED</cfif>>Display All</option>
		</select>
		<cfoutput>
          <input type="hidden" name="start" value="1" />
          <input type = "hidden" name="viewtype" value="#viewtype#" />
          <input type = "hidden" name="searchquery" value="#searchquery#" />
          <input type = "hidden" name="sortoption" value="#sortoption#" />
		</cfoutput>
	</form></td>
    <td width="30%" nowrap> <form name="form1" method="post" action="doinventory.cfm">
        <div align="right"> 
          <cfoutput><input type="text" name="SearchQuery" value="#searchquery#"></cfoutput>
          <input type="submit" name="Submit" value="Search">
          <cfoutput>
          <input type = "hidden" name="start" value="1" />
          <input type = "hidden" name="disp" value="#disp#" />
          <input type = "hidden" name="viewtype" value="#viewtype#" />
          <input type = "hidden" name="sortoption" value="#sortoption#" />          
          </cfoutput>
        </div>
      </form></td>
  </tr>
</table>
<form method="post" action="doinventory.cfm">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr bgcolor="3333CC"> 
    <td width="10%" align="left" bgcolor="#3366CC"><strong><font color="#FFFFFF">Sku</font></strong> </td>
    <td width="14%" align="left" bgcolor="#3366CC"><font color="FFFFFF"><b>Product Name</b></font></td>
    <td width="15%" align="center" bgcolor="#3366CC"><font color="FFFFFF"><b>Supplier</b></font></td>
    <td width="5%" align="center" bgcolor="#3366CC"><font color="FFFFFF"><b> Units Sold</b></font></td>
    <td width="5%" align="center" bgcolor="#3366CC"><font color="FFFFFF"><b> In Stock</b></font></td>
  </tr>
  <cfset RowCount = 0>
  <!---Set up variables for paginating--->
  <CFSET end=Start + disp>
  <CFIF Start + disp GREATER THAN qryCatalog.recordcount>
    <CFSET end=999>
    <CFELSE>
    <CFSET end=end - 1>
  </CFIF>
  
  <cfloop query = "qryCatalog" startrow="#start#" endrow="#end#">
	
	<cfquery name = "qryProducts" datasource="#request.dsn#">
	SELECT * FROM products
	WHERE itemid = #qryCatalog.itemid#
	</cfquery>

  <cfloop query = "qryproducts">

    <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
          <td style="border-bottom: 1px #CCCCCC solid;"><cfoutput><div align="left">#sku#</div>
          </cfoutput></td>
          <td style="border-bottom: 1px #CCCCCC solid;"><cfoutput>#ProductName#</cfoutput></td>
          <td style="border-bottom: 1px #CCCCCC solid;"><div align="center">            
	<cfif isnumeric(SupplierID)>
	  <cfset ThisSupplierID = '#SupplierID#'>
          <cfif ThisSupplierID IS '0'>NONE</cfif> 
		  <cfloop query="qrySuppliers">
              <cfif NOT #CompanyName# IS ''>
                <cfif ContactID IS '#ThisSupplierID#'>
                 <cfoutput>#CompanyName#</cfoutput>
                </cfif>
              </cfif>
            </cfloop> </div>
	   <cfelse>
	   <cfoutput>#SupplierID#&nbsp;</cfoutput>
	   </cfif>	   </td>
          <td style="border-bottom: 1px #CCCCCC solid;"><div align="center">
        <cfoutput><input name="UnitsSold#ItemID#" type="text" id="UnitsSold#qryproducts.ItemID#" value="#qryproducts.UnitsSold#" size="5"></div></cfoutput></td>
          <td style="border-bottom: 1px #CCCCCC solid;"><div align="center">
		<cfoutput><input type = "hidden" name="ProductID" Value="#qryproducts.ItemID#"></cfoutput>        
		 <cfoutput><input name="UnitsInStock#qryproducts.ItemID#" type="text" id="UnitsInStock#qryproducts.ItemID#" value="#qryproducts.UnitsInStock# " size="5"></cfoutput></div>
		 </td>	
      </tr>
	  
	  <!---Show subitems---->
    <cfquery name = "qrySubItems" datasource="#request.dsn#">
    SELECT * FROM products WHERE productid = '#productid#' AND subof = '#itemid#'
    </cfquery>
       
	<cfif qrySubItems.recordcount GT 0>
	
    <tr>
      <td bgcolor="#FFFFFF" height="5" colspan="6" align="left"><cfoutput><img src="icons/expand.gif" width="9" height="9" onclick="javascript: ExpandItems('items#itemid#');" name="IMG#itemid#" id="IMG#itemid#" style="cursor:pointer;" /></cfoutput> <span onclick="javascript: ExpandItems('items#itemid#');">Expand/Collapse subitems</span></td>
    </tr>
	<tr>
	  <td colspan="6" style="border-bottom: 1px #CCCCCC solid;">
	  <span style="display:none;" <cfoutput>name="items#itemid#" id="items#itemid#"</cfoutput>>
	  <table width = "100%" cellspacing="0" cellpadding="4">
	  <tr>
	  <td bgcolor="#000000" width="15%"><font color="#FFFFFF"><b>Sku</b></font></td>
	  <td bgcolor="#000000"><font color="#FFFFFF" align="center"><b>Item Name</b></font></td>
	  <td bgcolor="#000000" width="20%"><font color="#FFFFFF"><b>Supplier</b></font></td>
	  <td bgcolor="#000000" width="10%"><font color="#FFFFFF"><b>Units Sold</b></font></td>
	  <td bgcolor="#000000" width="10%"><font color="#FFFFFF"><b>In Stock</b></font></td>
	  </tr>
	  <cfloop query = "qrySubItems">
	  <tr>
          <td><cfoutput><div align="left">#sku#</div>
          </cfoutput></td>
          <td><cfoutput>#ProductName#</cfoutput></td>
          <td><div align="center">            
	  <cfset ThisSupplierID = '#SupplierID#'>
          <cfif ThisSupplierID IS '0'>NONE</cfif> 
		  <cfloop query="qrySuppliers">
              <cfif NOT #CompanyName# IS ''>
                <cfif ContactID IS '#ThisSupplierID#'>
                 <cfoutput>#CompanyName#</cfoutput>
                </cfif>
              </cfif>
            </cfloop> </div>
			</td>
          <td><div align="center">
        <cfoutput><input name="UnitsSold#qrySubItems.ItemID#" type="text" id="UnitsSold#qrySubItems.ItemID#" value="#qrySubItems.UnitsSold#" size="5"></div></cfoutput></td>
          <td><div align="center">
		<cfoutput><input type = "hidden" name="ProductID" Value="#ItemID#"></cfoutput>
		 <cfoutput><input name="UnitsInStock#qrySubItems.ItemID#" type="text" id="UnitsInStock#qrySubItems.ItemID#" value="#qrySubItems.UnitsInStock# " size="5"></cfoutput></div>
		 </td>	
	  </cfloop>	  
	  </table>
	  </span>
	  </td>
    </tr>
	</cfif>
	<!---End SubItems---> 
  </cfloop>
  </cfloop>
</table>
<br>
<cfif NOT qryCatalog.recordcount IS 0>
<p align="right">
<!---<input type="checkbox" name="setinactive" value="checkbox" />
Set all out of stock items to inactive--->
<input type="hidden" name="Action" Value="Update">
<cfoutput>
<input type = "hidden" name = "start" value="#start#" />
<input type = "hidden" name = "disp" value="#disp#" />
<input type = "hidden" name = "searchquery" value="#searchquery#" />
<input type = "hidden" name = "viewtype" value="#viewtype#" />
<input type = "hidden" name = "sortoption" value="#sortoption#" />
</cfoutput>
<input name="SetQuantity" type="submit" id="SetQuantity2" value="Update Items"> 
</p>
</cfif>
</form>