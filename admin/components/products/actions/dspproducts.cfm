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
<cfinclude template = "../queries/qryproducts.cfm">

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
    <td width="30%" nowrap> <form method="POST" action="doproducts.cfm">
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
          <cfif disp LT qryproducts.RecordCount + 1>
            <form name = "PageSelect" method="Post" Action="doproducts.cfm">
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryproducts.RecordCount#" Step="#disp#"><a href = "doproducts.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
            </form>
          </cfif>
        </cfoutput> </div></td>
    <td width="30%"><form name="Displayoptions" method="POST" Action="doproducts.cfm">
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="100" <cfif disp IS '9999999'>SELECTED</cfif>>Display All</option>
		</select>
	</form></td>
    <td width="30%" nowrap> <form name="form1" method="post" action="doproducts.cfm">
        <div align="right"> 
          <input type="text" name="SearchQuery">
          <input type="submit" name="Submit" value="Search">
        </div>
      </form></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr bgcolor="#3366CC"> 
    <td width="20%"><div align="center"><strong> <font color="#FFFFFF">Found In</font></strong></div></td>
    <td width="10%"> <p align="center"><strong> <font color="#FFFFFF">Image</font></strong></td>
    <td width="20%"> <div align="left"><b><a href="doproducts.cfm?OrderBy=ProductID"><font color="#FFFFFF">Product 
        ID</font></a> </b> </div></td>
    <td width="20%"> <strong><a href="doproducts.cfm?OrderBy=ProductName"><font color="#FFFFFF">Product 
      Name</font></a></strong></td>
    <td width="10%"><div align="center"> <font color="#FFFFFF"><strong>Price</strong></font></div></td>
    <td width="10%"><div align="center"> <font color="#FFFFFF"><strong>options</strong></font></div></td>
    <td width="10%"> <p align="center"><font color="#FFFFFF"><strong> Featured<br>
        Item?</strong></font></td>
  </tr>
  <cfset RowCount = 0>
  <!---Set up variables for paginating--->
  <CFSET end=Start + disp>
  <CFIF Start + disp GREATER THAN qryproducts.RecordCount>
    <CFSET end=999>
    <CFELSE>
    <CFSET end=disp>
  </CFIF>

  <cfoutput query = "qryproducts" startRow="#Start#" MaxRows="#End#"> 
    <tr <cfif qryproducts.CurrentRow MOD 2>bgcolor="E5E5E5"</cfif>> 
      <td width="20%"> 
        <select size="1" name="select">
          <cfif Category IS '^0^'><option SELECTED>Inactive</option></cfif>
          <cfloop index="MyCount" from="1" to="#ListLen(Category, "^")#">
            <cfset ThisCategory = "#ListGetAt(Category, MyCount, "^")#">
            <cfloop query="qryCategories">
              <cfif #CategoryID# IS #thisCategory#>
                <option <cfif ThisCategory IS '#session.sortoption#'>SELECTED</cfif>>#CategoryName#</option>
              </cfif>
            </cfloop>
          </cfloop>
        </select> <a name="#ItemID#" id="#ItemID#"></a></td>
      <td width="10%"> 
        <p align="center"> 
          <cfif NOT #Thumbnail# IS 'SMnopic.jpg'>
            <a href="javascript:PopupPic('#request.HomeURL#/photos/#ImageURL#')"><img src = "#request.HomeURL#/photos/#thumbnail#" alt="Click to view" width="42" border="0"></a> 
          </cfif>
          <cfif #Thumbnail# IS 'SMnopic.jpg'>
            No Photo<br></a>
          </cfif>
      </td>
      <td width="20%"> <div align="left"><a href="doproducts.cfm?action=edit&ItemID=#ItemID#">#productid#</a> </div></td>
      <td width="20%"><a href="doproducts.cfm?action=edit&ItemID=#ItemID#">#ProductName#</a></td>
      <td width="10%"><div align="center"><cfif request.EnableEuro IS 'Yes'>#lseurocurrencyformat(Price, "Local")#<cfelse>#lscurrencyformat(Price, "Local")#</cfif></div></td>
      <td width="10%" nowrap><div align="center"><a href="doproducts.cfm?action=Delete&DeleteID=#ItemID#"><img src="icons/delete_miniicon.gif" alt="Delete" width="24" height="21" border="0"></a><a href="doproducts.cfm?action=Setoptions&ItemID=#ItemID#"><img src="icons/options_miniicon.gif" alt="Set options" width="24" height="21" border="0"></a><a href="photomanager/dophotomanager.cfm?Action=Search&Searchquery=#ProductID#"><img src="icons/editpictures_miniicon.gif" alt="Upload Image" width="24" height="21" border="0"></a><a href="doproducts.cfm?action=discounts&ItemID=#ItemID#"><img src="icons/discounts_miniicon.gif" alt="Volume discounts" width="24" height="21" border="0"></a><a href="doproducts.cfm?action=EditDetails&ItemID=#ItemID#"><img src="icons/editremarks_miniicons.gif" alt="Edit Product Details" width="24" height="21" border="0"></a> 
          <a href="doproducts.cfm?action=Duplicate&ItemID=#ItemID#"> 
          <img src="icons/duplicate_miniicon.gif" alt="Create a copy of this item" width="24" height="21" border="0" hiight="21" ></a></div></td>
      <td width="10%"> <p align="center"> 
          <cfif IsFeatured IS 'Yes'>
            <a href = "doproducts.cfm?action=SetFeatureNo&ItemID=#ItemID#">Yes</a> 
          </cfif>
          <cfif IsFeatured IS 'No'>
            <a href = "doproducts.cfm?action=SetFeatureYes&ItemID=#ItemID#">No</a> 
          </cfif>
      </td>
    </tr>
  </cfoutput> 
</table>
<br>
<cfoutput>
  <table width="100%" border="0" cellspacing="0" cellpadding="1">
    <tr> 
      <td width="35%">Found <strong>#qryproducts.RecordCount#</strong> product<cfif qryproducts.RecordCount GT 1>s</cfif></td>
      <td><div align="center"><a href="##TheproductsTop">Back to Top</a></div></td>
      <td width="25%"><table border="0" align="center" cellpadding="10">
          <tr> 
            <!--- Display prev link --->
            <cfif start NOT EQUAL 1>
              <cfif start GTE disp>
                <cfset prev=disp>
                <cfset prevrec=start - disp>
                <cfelse>
                <cfset prev=start - 1>
                <cfset prevrec=1>
              </cfif>
              <td><font face="wingdings">ç</font> <a href="doproducts.cfm?start=#prevrec#">Previous 
                #prev#</a></td>
            </cfif>
            <!---Display the page numbers--->
            <cfif disp LT qryproducts.RecordCount + 1>
              <cfset PageCount = 1>
              <td><cfloop index="Pages" from="1" to="#qryproducts.RecordCount#" step="#disp#">
                  <a href = "doproducts.cfm?start=#Pages#">#PageCount#</a>&nbsp;&nbsp; 
                  <cfset PageCount = PageCount + 1>
                </cfloop> </td>
            </cfif>
            <!--- Display next link --->
            <cfif end LT qryproducts.RecordCount>
              <cfif start + disp * 2 GTE qryproducts.RecordCount>
                <cfset next=qryproducts.RecordCount - start - disp + 1>
                <cfelse>
                <cfset next=disp>
              </cfif>
              <td><a href="doproducts.cfm?start=#Evaluate("start + disp")#"> 
                Next #next#</a> <font face="wingdings">è</font></td>
            </cfif>
        </table></td>
    </tr>
  </table>
  
</CFOUTPUT>















