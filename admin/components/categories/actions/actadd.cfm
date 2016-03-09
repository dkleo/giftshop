<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif NOT form.NewCategory IS ''>

	<cfoutput>
	<cflock scope="session" type="Exclusive" timeout="10">
	<cfset TempVar.ViewCat = '#session.ViewCat#'>
	</cflock>
	</cfoutput>

	<cfset linkalias = form.NewCategory>
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

	<cfif NOT TempVar.ViewCat IS 'Main categories' AND NOT TempVar.ViewCat IS 'All categories'>
		<cfset SubCat = '#TempVar.ViewCat#'>
	</cfif>

	<cfif TempVar.ViewCat IS 'Main categories' OR TempVar.ViewCat IS 'All categories'>
		<cfset SubCat = '0'>
	</cfif>

	<!---***Construct the Category path to put in the database***--->

	<!---Find the Parent directory(category) and map a path to the new one (if this is being put into
	another category --->
	<cfif NOT TempVar.ViewCat IS 'Main categories' AND NOT TempVar.ViewCat IS 'All categories'>
		<cfquery Name="FindParentCategory" Datasource="#request.dsn#">
			SELECT * FROM categories
			WHERE CategoryID = #TempVar.ViewCat# 
		</cfquery>

		<cfoutput query="FindParentCategory">
			<cfset ThisCategoryPath = '#CategoryPath##CategoryID#/'>
            <cfset linkalias = '#linkalias#-#CategoryID#'>
		</cfoutput>
	</cfif>
    
	<!---If the currently viewed Category is Main or all, just make this a main category--->
	<!---So If this is being put in the main directory then just set the path to the 
	main category path--->
	<cfif TempVar.ViewCat IS 'Main categories' OR TempVar.ViewCat IS 'All categories'>
		<cfset ThisCategoryPath = '/'>
	</cfif>    

 	<cfquery name = "AddCategory" datasource="#request.dsn#">
	INSERT INTO categories
	(CategoryName, CategoryImage, SubCategoryOf, CategoryLayout, Ordervalue, CategoryPath, permissions, urlrw)
	VALUES
	('#form.NewCategory#', 'None', '#SubCat#', '#request.ProductLayout#', #form.NextOrderValue#, '#ThisCategoryPath#', '0', '#linkalias#')
	</cfquery>

	<!---find this one just entered--->
    <cfquery name = "qFind" datasource="#request.dsn#">
    SELECT * FROM categories
    WHERE urlrw = '#linkalias#'
    </cfquery>

	<cfset newline = 'ReWriteRule ^#linkalias#-#qFind.Categoryid#$ index.cfm?action=viewcategory&category=#qFind.categoryid# '>
	<cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes">
	
    <cfquery name = "qSet" datasource="#request.dsn#">
    UPDATE categories SET urlrw = '#linkalias#-#qFind.Categoryid#'
    WHERE categoryid = #qFind.categoryid#
    </cfquery>

</cfif>
<!---Now go back to the category manager--->
<cflocation URL = "index.cfm">
