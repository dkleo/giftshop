<!---Query the options table.  If there are none available, then do not proceed--->
<cfinclude template = "../queries/qryoptions.cfm">
<cfinclude template = "../queries/qryproductoptions.cfm">
<cfinclude template = "../queries/qrycategories.cfm">
<cfif #qryoptions.RecordCount# IS 0>
  <div align="center"> 
    <p>You do not have any options to choose from. <br>
      You need to create option drop downs or option text fields first. 
      </p>
  </div>
  <cfabort>
</cfif>
<!---Now query the products table and get the list of options currently assigned to this item.
     If the option field is in the list then check the box next to that option to indicate it
	 is currently assigned--->
<cfinclude template = "../queries/qryproducts.cfm">

<!---get what categories it's listed in--->
<cfquery name = "qryItemCategories" datasource="#request.dsn#">
SELECT * FROM product_categories
WHERE itemid = #qryProducts.itemid#
</cfquery>
  
Select the options you would like to assign to this product and then 
click update. To edit options form fields and the order they 
appear in, use the options Manager on the main menu.  
<form name="form1" method="post" action="doproducts.cfm">
  <table width="100%" border="0" align="center" cellpadding="4" cellspacing="0">
    <tr bgcolor="#CCCCCC"> 
      <td width="14%" ><b> Assign?</b></td>
      <td width="10%" >ID</td>
      <td width="25%" ><b> Caption</b></td>
      <td width="61%" align="left" ><b> Preview</b></td>
    </tr>
    <cfoutput query = "qryoptions"> 
      
      <cfquery name = "qryThisOption" dbtype="query">
      SELECT * FROM qryProductOptions
      WHERE itemid = #qryProducts.itemid# AND optionid = #qryoptions.optionid#
      </cfquery>
      
	  <cfset IsChecked = 'No'>
	  
      <cfif qryThisOption.recordcount GT 0>
      	<cfset IsChecked = 'Yes'>
      </cfif>
      
      <tr> 
        <td width="14%">
        <input name="OptionChecked" type="checkbox" id="OptionChecked" value="#OptionID#" <cfif #IsChecked# IS 'Yes'>CHECKED</cfif>></td>
        <td>#optionid#</td>
        <td width="25%"> <div align="left"> #Caption#</div></td>
        <td width="61%"  align="left">#HTMLCode#</td>
      </tr>
    </cfoutput> 
  </table>
  <p> 
    <!--- give the user the option to make all products in one of the categories this product belongs to the 
  same as this one.  This saves time if the user needs a bunch of products to have the same form fields in 
  a category.  Also allow an option to make every single item in a catalog the same as this one! --->
    </p>
  <p> 
    <input type="checkbox" name="MakeSame" value="ON">
    Make all in 
    <select size="1" name="SameCategory">
      <option>Entire Catalog</option>
      <cfloop query = "qryItemCategories">
      
      <cfquery name = "qryCategoryName" datasource="#request.dsn#">
      SELECT * FROM categories
      WHERE categoryid = #qryItemCategories.categoryid#
      </cfquery>
      
        <cfoutput> 
            <option Value = "#qryCategoryName.CategoryID#" SELECTED>#qryCategoryName.CategoryName#</option>
        </cfoutput> 
      </cfloop>
    </select>
    the same as this one</p>
  <p> 
    <input name="listoptions" type="checkbox" id="listoptions" value="Yes" <cfif qryproducts.listoptions IS 'No'>CHECKED</cfif>>
    Do NOT automatically list these options in the product details section of 
    the catalog</p>
  <cfoutput> 
    <input type = "hidden" Name="ItemID" Value = "#url.ItemID#">
  </cfoutput> 
  <input type="hidden" name="action" value="Setforms">
	<cfif ISDEFINED('url.WasSearch')>
	<input type = "hidden" Name="WasSearch" Value="Yes">
	</cfif>
  <input type="submit" name="Submit" value="Set Form Fields">
</form>
















