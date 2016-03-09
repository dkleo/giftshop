<!---This allows a user to edit the featured items they want displayed on the homepage and to also change
the order in which items are displayed in the featured section and catalog--->
<cfinclude template = '../queries/qrycategories.cfm'>

<cfparam name = "ritem" default="0">
<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">

  <script language="Javascript"> 
   function PopupPic(sPicURL) { 
     window.open( "image-window.html?"+sPicURL, "",  
     "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
   </script> 

<cfif NOT isdefined('Session.SortOption')>
  
  <cflock scope="Session" type="Exclusive" timeout="10">
<cfset session.sortoption = 'Featured'>
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
<p>

<cflock scope="Session" type="Readonly" timeout="10">
<cfset TempVar.SortOption = #session.SortOption#>
</cflock>

<!---These parameters are for the paginating feature--->
<cfif NOT ISDEFINED('session.Start')>
  
  <cflock scope="Session" type="Exclusive" timeout="10"> 
<cfset session.start="1">
</cflock>
</cfif>

<cfif ISDEFINED('url.start')>
  
<cflock scope="Session" type="Exclusive" timeout="10">  
<cfset session.start ="#url.start#">
</cflock>
</cfif>

<cflock scope="Session" type="ReadOnly" timeout="10">  
<cfset TempVar.Start = #session.Start#>
</cflock>

<!--- Number of records to display on a page --->
<CFPARAM name="disp" default="#request.MaxRecords#">

<cfinclude template = "../queries/qryitem.cfm">
<cfinclude template = "../queries/qrycatalog.cfm">
  <!---Display the sort drop down--->
<cfoutput><h2>Related Items for #qryItem.ProductName#</h2></cfoutput>
  </p>
  
  <cfinclude template = "frmrelateditems.cfm">

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td width="53%">
	<form method="POST" <cfoutput>action="doproducts.cfm?action=RelatedItems&ritem=#ritem#"</cfoutput>>
        Category: 
        <select name="Sortproducts">
	<cfif NOT request.EnableInventory IS 'No'><option value = "OutofStock" <cfif #TempVar.sortoption# IS 'OutofStock'>SELECTED</cfif>>Out of Stock</option></cfif>
	<option value = "Featured" <cfif #TempVar.sortoption# IS 'Featured'>SELECTED</cfif>>Featured Items</option>
	<option value = "Inactive" <cfif #TempVar.sortoption# IS 'Inactive'>SELECTED</cfif>>Inactive Items Only</option>
	<option value = "All" <cfif #TempVar.sortoption# IS 'All'>SELECTED</cfif>>All products</option>
	  <cf_CategoryTree Directory="/"
		ShowCurrentView="Yes"
		SelectedItem="#TempVar.SortOption#"
		Datasource="#request.dsn#"
		FirstIndent="#request.CategoryIndent#"> 
    </select>
<input type="submit" value="Submit" name="B1"></p>
        <a name="TheproductsTop"></a>
</form>
	</td>
    <td width="47%"><div align="right">
          <!---Display the page numbers--->
		 <form name = "PageSelect" method="Post" <cfoutput>action="doproducts.cfm?action=relateditems&ritem=#ritem#"</cfoutput>>
          <cfif disp LT qryCatalog.RecordCount + 1>
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryCatalog.RecordCount#" Step="#disp#">
                  <cfoutput>
				  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option>
				  </cfoutput>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
		    </cfif>
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="100" <cfif disp IS '9999999'>SELECTED</cfif>>Display All</option>
		</select>	  
            </form>
		</div>
	</td>
  </tr>
</table>

<form name="ProductTable" <cfoutput>method="post" action="doproducts.cfm?ritem=#ritem#"</cfoutput>>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr bgcolor="#3366CC"> 
    <td width="10%"> <div align="left"><b><a href="doproducts.cfm?OrderBy=ProductID"><font color="#FFFFFF">Product 
        ID</font></a> </b> </div></td>
    <td> <strong><a href="doproducts.cfm?OrderBy=ProductName"><font color="#FFFFFF">Product 
      Name</font></a></strong></td>
    <td width="10%"><div align="center"> <font color="#FFFFFF"><strong>Price</strong></font></div></td>
    <td width="10%"> <p align="center"><font color="#FFFFFF"><strong> Add to Related Items?<br>
        </strong></font></td>
  </tr>

    <!---Set up variables for paginating--->
	  <!---Set up variables for paginating--->
	  <CFSET end=Start + disp>
	  <CFIF Start + disp GREATER THAN qryCatalog.RecordCount>
		<CFSET end=999>
		<CFELSE>
		<CFSET end=Start + disp - 1>
	  </CFIF>
  <cfset RowCount = 0>	
    <cfoutput query = "qryCatalog" startRow="#Start#" MaxRows="#End#"> 
        <tr <cfif RowCount IS 0>bgcolor="E5E5E5"</cfif>> 
          <td> <div align="left">#productid# </div></td>
          <td>#ProductName#</td>
          <td><div align="center">#dollarformat(Price)#</div></td>
          <td> <p align="center"> 
		  	  <input type = "checkbox" name="addrelated" value="#ItemID#">
          </td>
        </tr>
      <cfif RowCount IS 1>
      </cfif>
      <cfset RowCount=RowCount + 1>
        <cfif Rowcount GREATER THAN 1>
          
          <cfset RowCount = 0>
      </cfif>
    </cfoutput> 
</table>
<div align="right"><input type="hidden" name="action" value="UpdateRelated">
<input type="submit" name="submit" value="Set Related Items">
</div>
</form>















