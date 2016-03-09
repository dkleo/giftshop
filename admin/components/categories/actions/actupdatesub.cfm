<!---This script moves this category to a new sub category.--->
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


<!---Check to make sure they are making this a sub of itself and stop if they are--->
<cfif form.CategoryID IS form.SubCategoryOf>
Error:  You can't make a category a sub category of itself.  Therefore, nothing was changed.
<cfabort>
</cfif>

<cfif NOT form.SubCategoryOf IS '0'>
<!---Find the category it's being moved to and get that categories path--->
<cfquery name ="FindNewParent" datasource="#request.dsn#">
SELECT *
FROM categories
WHERE CategoryID = #form.SubCategoryOf#
</cfquery>

<cfset NewCategoryPath = '#FindNewParent.CategoryPath#'>

<cfoutput query = "FindNewParent">
<cfset NewCategoryPath = '#CategoryPath##CategoryID#/'>
</cfoutput>
</cfif>

<cfif form.SubCategoryOf IS '0'>
<cfset NewCategoryPath = '/'>
</cfif>

<!---Now find the categories current location and create a variable for that--->

<cfquery name="GetPath" datasource="#request.dsn#">
SELECT *
FROM categories
WHERE CategoryID = #form.CategoryID#
</cfquery>

<cfoutput query ="GetPath">

<cfset linkalias = GetPath.categoryname>
<cfset linkalias = replace(linkalias, " ", "-", "ALL")>
<cfset linkalias = replace(linkalias, "'", "", "ALL")>
<cfset linkalias = replace(linkalias, "!", "", "ALL")>
<cfset linkalias = replace(linkalias, "@", "", "ALL")>
<cfset linkalias = replace(linkalias, "$", "", "ALL")>
<cfset linkalias = replace(linkalias, "%", "", "ALL")>
<cfset linkalias = replace(linkalias, "^", "", "ALL")>
<cfset linkalias = replace(linkalias, "*", "", "ALL")>
<cfset linkalias = replace(linkalias, "(", "", "ALL")>	
<cfset linkalias = replace(linkalias, ")", "", "ALL")>
<cfset linkalias = replace(linkalias, "/", "", "ALL")>	
<cfset linkalias = replace(linkalias, "\", "", "ALL")>
<cfset linkalias = replace(linkalias, "|", "", "ALL")>
<cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
<cfset linkalias = replace(linkalias, ">", "", "ALL")>    
<cfset linkalias = replace(linkalias, ";", "", "ALL")>
<cfset linkalias = replace(linkalias, ":", "", "ALL")>
<cfset linkalias = replace(linkalias, '"', "", "ALL")>
<cfset linkalias = replace(linkalias, ".", "", "ALL")>	
<cfset linkalias = replace(linkalias, ",", "", "ALL")> 

<cfset OldCategoryPath = '#CategoryPath#'>
</cfoutput>

<cfif NewCategoryPath CONTAINS '/#form.CategoryID#/'>
You cannot move a parent category within a subcategory under itself. 
<cfabort>
</cfif>

<cfquery name = "UpdateCategory" datasource="#request.dsn#">
UPDATE categories
SET SubCategoryOf = '#form.SubCategoryOf#',
CategoryPath = '#NewCategoryPath#'
WHERE CategoryID = #form.categoryid#
</cfquery>

<!---Now update all the categories under this one with the new path--->
<cfquery name = "FindCurrentRelationships" datasource="#request.dsn#">
SELECT * FROM categories
</cfquery>

<cfloop query = "FindCurrentRelationships">
<!---it won't be a main category--->
<cfif NOT FindCurrentRelationships.subcategoryof IS '0'>
	<!---Make sure we are not updating the current category--->
	<cfif NOT FindCurrentRelationships.categoryid IS #form.CategoryID#>
			<cfif FindCurrentRelationships.CategoryPath CONTAINS '#OldCategoryPath##form.CategoryID#/'>
				<cfset thisid = #FindCurrentRelationships.Categoryid#>
				<cfset thenewpath = '#NewCategoryPath##form.Categoryid#/'>
				<cfset theoldpath = '#OldCategoryPath##form.CategoryID#/'>
				<cfset NewSubCategoryPath = replace(FindCurrentRelationships.CategoryPath, theoldpath, thenewpath)>
				<cfquery name = "UpdateSubPath" datasource="#request.dsn#">
					UPDATE categories
					SET CategoryPath = '#NewSubCategoryPath#'
					WHERE categoryid = #thisid#
				</cfquery>			
			</cfif>
	</cfif>
</cfif>
</cfloop>

<cflocation URL = "index.cfm">