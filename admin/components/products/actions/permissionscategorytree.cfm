<!---This file builds the category tree in the left nav menu--->

	<!--- Define required parameters --->
	<cfparam name="Attributes.PathView" type="string" default="/">
	<cfparam name="Attributes.ShowBullet" type="string" default="No">
	<cfparam name="Attributes.BulletStyle" type="string" default="&middot;">
	<cfparam name="Attributes.ShowMoreArrow" type="string" default="Yes">
	<cfparam name="Attributes.MoreArrowStyle" type="string" default="&raquo;">
 	<cfparam name="Attributes.Directory" type="string" default="/">
	<cfparam name="Attributes.Datasource" type="string" default="">
	<cfparam name="Attributes.StoreUser" type="string" default="">
	<cfparam name="Attributes.SelectedItem" type="string" default="">
	
	<!--- Define internal tag processing parameters --->
	<cfparam name="Attributes.ParentDirectory" type="string" default="NoParentDirectory">
	<cfparam name="Attributes.TagRecursiveCount" type="numeric" default="0">
	<cfparam name="Attributes.DirectoryToTreeInitialized" type="boolean" default="No">
	<cfparam name="Attributes.ShowCurrentView" default="No">
	<cfparam name="Attributes.FirstIndent" default="5">

	<!--- Execute a query to find the currently passed path--->
	<cfquery name = "qCurrentDirectoryWithoutDotParents" Datasource="#attributes.Datasource#">
	SELECT * FROM categories
	WHERE CategoryPath = '#attributes.Directory#'
	ORDER BY OrderValue ASC
	</cfquery>

	<cfif qCurrentDirectoryWithoutDotParents.recordcount IS 0>
	</cfif>
		 
<!--- Build the directory tree --->
	<cfoutput>
	<cfif Attributes.DirectoryToTreeInitialized></cfif>
			
			<!--- Loop through the directory query to create the drop down box--->
			<cfloop query="qCurrentDirectoryWithoutDotParents">
			<!--- Determine current and parent directories --->
						<cfscript>
							NextDirectory = Attributes.Directory & qCurrentDirectoryWithoutDotParents.CategoryID & "/";
							NextParentDirectory = Attributes.ParentDirectory & qCurrentDirectoryWithoutDotParents.CategoryID;
						</cfscript>
					
					<!---Find out how many '/' characters are in this path.  <br>
						 This will determine the number	of Spaces to use for the indent--->
					
					<CFSET str = "#Attributes.Directory#">
											
					<CFSET key = "/">
					<CFSET keyCnt = 0>
					<CFSET findIdx = -1>
					<CFSET startFind = 1>
	
				   <CFLOOP condition="findIdx NEQ 0">
						   <CFSET findIdx = FindNoCase(key, str, startFind)>
							  <CFIF findIdx GT 0>
						   <CFSET keyCnt = keyCnt + 1>
						   <CFSET startFind = findIdx + 1> 
						  </CFIF> 
				  </CFLOOP>

						<!---Now create a variable to generate the number of spaces for the indent)
						 For main categories this will be a negative -1 so that they are not <br>
						indented --->
						<cfset NumberOfSpaces = #keyCnt#>
								
						   <!--- Now build the element and recurse --->
						   <!---Get the Category ID from the category List--->
							<cfset DirID = #qCurrentDirectoryWithoutDotParents.CategoryID#>

							<cfquery name = "Qrycategories" datasource='#Attributes.Datasource#'>
							SELECT *
							FROM categories
							WHERE CategoryID = #DirID#
							</cfquery>
							
							<!---query the user table to see if the user has persmissions to this categroy
							    if they do the box will get checked--->
								
							<cfquery name = "GetUser" datasource="#Attributes.Datasource#">
							SELECT * FROM Products
							WHERE ProductID = '#attributes.ProductID#'
							</cfquery>
							
							<cfset ThisIsChecked = 'No'>
							<cfloop from="1" to="#listlen(GetUser.Permissions)#" index="MyCount">
								<cfset CurrentPermission = #ListGetAt(GetUser.Permissions, MyCount)#>
								<cfif CurrentPermission IS #DirID#>
									<cfset ThisIsChecked = 'Yes'>
								</cfif>
							</cfloop>
															
							<cfset ThisSubCategoryOf = '#Qrycategories.SubCategoryOf#'>
									<!---Now create the item in the list and loop over the spaces <br>
									(&nbsp;) to determine the amount of indent for this category.--->
									
									<!---Display it only if it's CustPassword protected--->
									<!---<cfif qrycategories.PasswordProtected IS 'Yes'>--->
										<div style="padding-left:2;padding-bottom:5 ">
										<cfloop From="0" To="#NumberOfSpaces#" Index="MyCount">&nbsp;&nbsp;&nbsp;</cfloop>
											<input type = "checkbox" Name="SetPermissions" value="#DirID#" <cfif ThisIsChecked IS 'Yes'>CHECKED</CFIF>>#qrycategories.CategoryName# <cfif qrycategories.PasswordProtected IS 'Yes'><img src="icons/permissions_miniicon.gif" width="14" Height="17"></cfif>
										</div>
									<!---</cfif>--->
									
									<cfmodule Template="permissionscategorytree.cfm"
										Directory="#NextDirectory#"
										ParentDirectory="#NextParentDirectory#"
										TagRecursiveCount="#IncrementValue(Attributes.TagRecursiveCount)#"
										ShowCurrentView="#Attributes.ShowCurrentView#"
										ShowBullet="#Attributes.ShowBullet#"										
										BulletStyle="#Attributes.BulletStyle#"
										ShowMoreArrow="#Attributes.ShowMoreArrow#"
										MoreArrowStyle="#Attributes.MoreArrowStyle#"
										PathView="#attributes.pathview#"
										SelectedITem="#Attributes.SelectedItem#"
										Datasource="#attributes.datasource#"
										FirstIndent="#Attributes.FirstIndent#"
										StoreUser="#Attributes.StoreUser#"
										ProductID="#Attributes.ProductID#"
										DirectoryToTreeInitialized="Yes">							
				</cfloop>
	</cfoutput>















