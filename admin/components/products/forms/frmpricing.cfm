<style type="text/css">
.style1 {
	font-weight: bold;
	color: #FFFFFF;
}
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.selecttr { background-color: #FFFFFF;}
.initial { background-color: #000000; color:#000000; }
.normal { background-color: #FFFFFF; }
.highlight { background-color: #CCCCCC; }
.delcheckbox {cursor: None;} 
.style2 {
	color: #FF0000;
	font-weight: bold;
}
</style>

<h2>Price Adjustments</h2>

<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">
<cfparam name = "WasUpdate" default="false">

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
   <cfset session.start = '#form.start#'>
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

<cfinclude template = '../queries/qrycategories.cfm'>
<cfinclude template = '../queries/qrysuppliers.cfm'>

<script language="Javascript"> 
   function PopupPic(sPicURL) { 
     window.open( "image-window.html?"+sPicURL, "",  
     "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
   </script>

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

<cflock scope="Session" type="Readonly" timeout="10">
  <cfset TempVar.SortOption = #session.SortOption#>
</cflock>

<cfinclude template = "../queries/qrycatalog.cfm">

<div>
<cfif wasupdate IS 'true'>
	<span class="style2">Prices were updated!    </span>
</cfif>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td width="30%" nowrap> <form method="POST" action="doproducts.cfm?action=pricing">
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
          <cfif disp LT qryCatalog.recordcount + 1>
            <form name = "PageSelect" method="Post" Action="doproducts.cfm?action=pricing">
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryCatalog.recordcount#" Step="#disp#"><a href = "doproducts.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
            </form>
          </cfif>
        </cfoutput> </div></td>
    <td width="30%"><form name="Displayoptions" method="POST" Action="doproducts.cfm?action=pricing">
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="100" <cfif disp IS '9999999'>SELECTED</cfif>>Display All</option>
		</select>
	</form></td>
    <td width="30%" nowrap> <form name="form1" method="post" action="doproducts.cfm?action=pricing">
        <div align="right"> 
          <input type="text" name="SearchQuery">
          <input type="submit" name="Submit" value="Search">
        </div>
      </form></td>
  </tr>
</table>
</div>
<div>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
    <form method="post" action="doproducts.cfm?action=globalpricechange">
    <tr>
      <td colspan="4" align="left">Quick adjust:
        <select name="adjust_op" id="adjust_op">
          <option value="add" selected="selected">Add</option>
          <option value="subtract">Subtract</option>
        </select>
        <input name="adjust_amount" type="text" id="adjust_amount" size="6" />
        <select name="adjust_type" id="adjust_type">
          <option value="amount" selected="selected">Amount</option>
          <option value="percent">Percent</option>
        </select>
        <select name="adjust_items" id="adjust_items">
          <option value="shown" selected="selected">Only Items In Current Category/View</option>
          <option value="AllCatalog">All Items in Catalog</option>
        </select>
        <cfoutput><input type="hidden" name="SortOption" value="#tempvar.sortoption#" /></cfoutput>
        <input type="submit" name="button" id="button" value="Update Prices" />      		</td>
   	  </tr>
       </form>
<form method="post" action="doproducts.cfm">
    <tr> 
    <td width="15%" align="left" bgcolor="#3366CC"><strong><font color="#FFFFFF">Sku</font></strong> </td>
    <td align="left" bgcolor="#3366CC"><font color="FFFFFF"><b>Product Name</b></font></td>
    <td width="10%" align="center" bgcolor="#3366CC"><font color="FFFFFF"><b>Supplier</b></font></td>
    <td width="10%" align="center" bgcolor="#3366CC"><span class="style1">Price</span> </td>
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
		<cfoutput><input type = "hidden" name="ProductID" Value="#qryproducts.ItemID#"></cfoutput>        
		 <cfoutput><input name="price_#qryproducts.ItemID#" type="text" id="price_#qryproducts.ItemID#" value="#numberformat(qryproducts.price, '0.00')# " size="5"></cfoutput></div>		 </td>	
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
            </cfloop> </div>			</td>
          <td><div align="center">
		<cfoutput><input type = "hidden" name="ProductID" Value="#ItemID#"></cfoutput>
		 <cfoutput><input name="price_#qryproducts.ItemID#" type="text" id="price_#qryproducts.ItemID#" value="#numberformat(qryproducts.price, '0.00')# " size="5"></cfoutput></div></div>
		 </td>	
         </tr>
	  </cfloop>	  
	  </table>
	  </span>
	  </td>
    </tr>
	</cfif>
	<!---End SubItems---> 
  </cfloop>
  </cfloop>
<tr>
	<td colspan="4">
	<cfif NOT qryCatalog.recordcount IS 0>
    <p align="right">
    <input type="hidden" name="Action" Value="UpdatePricing">
    <input name="SetQuantity" type="submit" id="SetQuantity2" value="Update Pricing"> 
    </p>
    </cfif>
    </td>
</tr>
</form>  
</table>
</div>















