<cfinclude template = '../queries/qrycategories.cfm'>
<cfif NOT isdefined('form.Sortproducts') AND NOT isdefined('session.sortoption')>
	<cflock scope="Session" type="Exclusive" timeout="10">
		<cfset session.sortoption = 'Featured'>
	</cflock>
</cfif>

<cfif isdefined('form.Sortproducts')>
	<cflock scope="Session" type="Exclusive" timeout="10">
		<cfset session.sortoption = '#form.Sortproducts#'>
	</cflock>
</cfif>

<cfif isdefined('url.session.sortoption')>
	<cflock scope="Session" type="Exclusive" timeout="10">
		<cfset session.sortoption = '#session.sortoption#'>
	</cflock>
</cfif>

<cflock scope="Session" type="Readonly" timeout="10">
	<cfset TempVar.SortOption = #session.SortOption#>
</cflock>

<cfinclude template = "../queries/qrycatalog.cfm">

<!---Display the sort drop down--->
<form method="POST" action="doproducts.cfm">
  <h2 align="left">Item Stats</h2>
  <p>  
    <select name="Sortproducts">
      <cfif NOT request.EnableInventory IS 'No'><option value = "OutofStock" <cfif #session.sortoption# IS 'OutofStock'>SELECTED</cfif>>Out 
      of Stock</option></cfif>
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
	<input type="hidden" name="action" value="ViewStats">
    <input type="submit" value="Submit" name="B1">
    <br>
    <b>Tip:&nbsp; Click on a column header to sort ascending.</b></p> 
</form>
<table width="100%" border="0" cellspacing="0" cellpadding="4" style="border-collapse: collapse" bordercolor="#111111">
  <tr> 
    <td colspan="6"><div align="right"><a href="doproducts.cfm?action=ResetAllStats">Click 
        here to reset all stats</a></div></td>
  </tr>
  <tr bgcolor="#3366CC"> 
    <td width="91"><strong><a href="doproducts.cfm?action=ViewStats&OrderBy=ProductID"><font color="#FFFFFF">Product 
      ID</font></a></strong></td>
    <td width="276"><strong><a href="doproducts.cfm?action=ViewStats&OrderBy=ProductName"><font color="#FFFFFF">Product 
      Name</font></a></strong></td>
    <td width="105"> <p align="center"><strong><a href="doproducts.cfm?action=ViewStats&OrderBy=TimesViewed"><font color="#FFFFFF">Times 
        Viewed</font></a></strong></td>
    <td width="88"><div align="center"><strong><a href="doproducts.cfm?action=ViewStats&OrderBy=UnitsSold"><font color="#FFFFFF">Units<br>
        Sold</font></a> </strong></div></td>
    <td width="56"><div align="center"><strong><a href="doproducts.cfm?action=ViewStats&OrderBy=UnitsInStock"><font color="#FFFFFF">Units 
        In<br>
        Stock</font></a></strong></div></td>
    <td width="56"><div align="center"><font color="#FFFFFF"><strong>Reset</strong>*</font></div></td>
  </tr>
  <cfset RowCount = 0>
  <cfif TempVar.sortoption IS 'Featured' OR TempVar.sortoption IS 'OutofStock' OR TempVar.sortoption IS 'All' OR TempVar.sortoption IS 'Inactive'>
    <cfoutput query = "qryCatalog"> 
      <cfset ThisSupplierID = '#SupplierID#'>
      <cfif RowCount IS 0>
        <tr valign="middle" <cfif UnitsInStock IS 0 AND NOT request.EnableInventory IS 'No'>bgcolor="##FFA4B1"</cfif>> 
          <td width="91"> 
            #ProductID#</td>
          <td width="276">#ProductName#</td>
          <td width="105" align="center"> 
            #TimesViewed# </td>
          <td width="88" align="center"><div align="center">#UnitsSold#</div></td>
          <td width="56"><div align="center"> 
              <cfif NOT request.EnableInventory IS 'No'>
                #UnitsInStock#
              </cfif>
              <cfif request.EnableInventory IS 'No'>
                Inventory<br>
                Disabled
              </cfif>
            </div>
            &nbsp;</b> </td>
          <td width="56"><div align="center"><a href="Doproducts.cfm?action=ResetStats&ItemID=#ItemID#">Reset</a></div></td>
        </tr>
      </cfif>
      <cfif RowCount IS 1>
        <tr <cfif NOT UnitsInStock IS 0>bgcolor="##CCCCCC"</cfif><cfif UnitsInStock IS 0 AND NOT request.EnableInventory IS 'No'>bgcolor="##FF0000"</cfif>> 
          <td width="91" bgcolor="##CCCCCC">#ProductID#</td>
          <td width="276" bgcolor="##CCCCCC">#ProductName#</td>
          <td width="105" bgcolor="##CCCCCC" align="center"> 
            #TimesViewed#</td>
          <td width="88" align="center" bgcolor="##CCCCCC"><div align="center">#UnitsSold#</div></td>
          <td width="56" bgcolor="##CCCCCC"><div align="center"> 
              <cfif NOT request.EnableInventory IS 'No'>
                #UnitsInStock#
              </cfif>
              <cfif request.EnableInventory IS 'No'>
                Inventory<br>
                Disabled
              </cfif>
            </div></b>
            </td>
          <td width="56" bgcolor="##CCCCCC"><div align="center"><a href="Doproducts.cfm?action=ResetStats&ItemID=#ItemID#">Reset</a></div></td>
        </tr></form>
      </cfif>
      <cfset RowCount=RowCount + 1>
      <cfif Rowcount GREATER THAN 1>
        <cfset RowCount = 0>
      </cfif>
    </cfoutput> 
  </cfif>
  <cfif NOT TempVar.sortoption IS 'Featured' AND NOT TempVar.sortoption IS 'OutofStock' AND NOT TempVar.sortoption IS 'All' AND NOT TempVar.sortoption IS 'Inactive'>
    <cfoutput query = "qryCatalog"> 
      <cfif Category CONTAINS '#session.SortOption#'>
        <cfset ThisSupplierID = '#SupplierID#'>
        <cfif RowCount IS 0>
          <tr valign="middle" <cfif UnitsInStock IS 0 AND NOT request.EnableInventory IS 'No'>bgcolor="##FF0000"</cfif>> 
            <td width="91"> 
              #ProductID#</td>
            <td width="276">#ProductName#</td>
            <td width="105" align="center"> 
              #TimesViewed#</td>
            <td width="88" align="center"><div align="center">#UnitsSold#</div></td>
            <td width="56"><div align="center"> 
                <cfif NOT request.EnableInventory IS 'No'>
                  #UnitsInStock#
                </cfif>
                <cfif request.EnableInventory IS 'No'>
                  Inventory<br>
                  Disabled
                </cfif>
              </div>
              &nbsp;</b> </td>
            <td width="56"><div align="center"><a href="Doproducts.cfm?action=ResetStats&ItemID=#ItemID#">Reset</a></div></td>
          </tr>
        </cfif>
        <cfif RowCount IS 1>
          <tr <cfif NOT UnitsInStock IS 0>bgcolor="##CCCCCC"</cfif><cfif UnitsInStock IS 0 AND NOT request.EnableInventory IS 'No'>bgcolor="##FF0000"</cfif>> 
            <td width="91" bgcolor="##CCCCCC">#ProductID#</td>
            <td width="276" bgcolor="##CCCCCC">#ProductName#</td>
            <td width="105" bgcolor="##CCCCCC" align="center"> 
              #TimesViewed#</td>
            <td width="88" align="center" bgcolor="##CCCCCC"><div align="center">#UnitsSold#</div></td>
            <td width="56" bgcolor="##CCCCCC"><div align="center"> 
                <cfif NOT request.EnableInventory IS 'No'>
                  #UnitsInStock#
                </cfif>
                <cfif request.EnableInventory IS 'No'>
                  Inventory<br>
                  Disabled
                </cfif>
              </div></b>
              </td>
            <td width="56" bgcolor="##CCCCCC"><div align="center"><a href="Doproducts.cfm?action=ResetStats&ItemID=#ItemID#">Reset</a></div></td>
          </tr></form>
        </cfif>
        <cfset RowCount=RowCount + 1>
        <cfif Rowcount GREATER THAN 1>
          <cfset RowCount = 0>
        </cfif>
      </cfif>
    </cfoutput> 
  </cfif>
</table>
<p>* Clicking Reset will reset the times viewed to zero for that particular item. 
  Clicking on the Reset All link will set all of the times viewed for each item 
  in your database to zero. If you want to change the number of units sold, go 
  to the Inventory manager.</p>