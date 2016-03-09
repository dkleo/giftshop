<h2>Subcategory Setting</h2>
<cfquery name = "GetCategory" Datasource = "#Request.DSN#">
SELECT * FROM categories
WHERE CategoryID = #url.CategoryID#
</cfquery>

<form name="form3" method="post" action="index.cfm">

  <cfoutput>           
  <p>Change the sub category of #GetCategory.CategoryName# below:</p>
            <input type="hidden" name="CategoryID" value="#url.CategoryID#">
          </cfoutput> 
          <input type="hidden" name="action" value="UpdateSub">
		  <cfset ThisSubCategoryof = #GetCategory.SubCategoryOf#>
          <select name="SubCategoryOf">
            <option <cfif #ThisSubCategoryOf# IS '0'>SELECTED</cfif> Value='0'>None</option>
			<cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#ThisSubCategoryOf#"
				Datasource="#request.dsn#">
          </select>
          <input name="UpdateButton" type="submit" id="UpdateButton" value="Update">
        </form>
<p><a href="index.cfm">Go Back</a></p>






















