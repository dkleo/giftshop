<!---This file builds the category tree.  It is used in conjunction with a drop down box to build a
list of categories indented under their parent categories=--->

	<!--- Define required parameters --->
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
		<cfif Attributes.DirectoryToTreeInitialized>&nbsp;&nbsp;&nbsp;</cfif>
				
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
							<cfset NumberOfSpaces = #keyCnt# - #Attributes.FirstIndent#>
									
 							   <!--- Now build the element and recurse --->
 		 					   <!---Get the Category ID from the category List--->
								<cfset DirID = #qCurrentDirectoryWithoutDotParents.CategoryID#>

								<cfquery name = "QryCategories" datasource='#Attributes.Datasource#'>
								SELECT *
								FROM categories
								WHERE CategoryID = #DirID#
								</cfquery>
										
					 	 	    <cfset ThisSubCategoryOf = '#QryCategories.SubCategoryOf#'>

										&nbsp;					

										<!---Now create the item in the list and loop over the spaces <br>
										(&nbsp;) to determine the amount of indent for this category.
										If this category name is "Categories" then ignore it because that
										is the main directory name for the categories--->
										<option Value="#DirID#" <cfloop from="1" To="#ListLen(attributes.SelectedItem)#" Index="mycount">
										<cfset CurrentItem = #ListGetAt(Attributes.SelectedItem, mycount)#>
										<cfif #CurrentItem# IS '#DirID#'>SELECTED</cfif></cfloop>>
										<cfloop From="0" To="#NumberOfSpaces#" Index="MyCount">&nbsp;&nbsp;&nbsp;</cfloop>
										#qryCategories.CategoryName#</Option>
										
										<cfmodule Template="categorytree.cfm"
											Directory="#NextDirectory#"
											ParentDirectory="#NextParentDirectory#"
											TagRecursiveCount="#IncrementValue(Attributes.TagRecursiveCount)#"
											ShowCurrentView="#Attributes.ShowCurrentView#"
											SelectedITem="#Attributes.SelectedItem#"
											Datasource="#attributes.datasource#"
											FirstIndent="#Attributes.FirstIndent#"
											StoreUser="#Attributes.StoreUser#"
											DirectoryToTreeInitialized="Yes">
									
					</cfloop>
	</cfoutput>































