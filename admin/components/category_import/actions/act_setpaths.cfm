<cfsetting requesttimeout="1200">

<cfset ProgressCount = 0>

<!---Build the categorypath to each category--->
<!---Select all subs--->
<cfquery name = "qryCategories" datasource="#request.dsn#">
SELECT * FROM categories
ORDER BY categoryid ASC
</cfquery>

<cfset TotalRecordsToImport = qryCategories.recordcount>

<script language="JavaScript">
	document.all("TitleMsg").innerHTML = 'Building Category Tree.  Please wait!';
</script>

<!---Loop over the categories--->
<cfloop query = "qryCategories">
	
    <cfset progresscount = progresscount + 1>

	<!---Get this ones parent--->
	<cfquery name = "qryParent" dbtype="query">
	SELECT subcategoryof,categoryid,categorypath FROM qryCategories WHERE categoryid = #qryCategories.subcategoryof#
	</cfquery>

	<!---if the parent exists, then set the initial pathstring--->
	<cfif qryParent.recordcount GT 0>
		<!---Set their pathstring to be their parent category--->
		<cfset pathstring = '/#qryCategories.subcategoryof#/'>
		<!---The currentid is now going to be their parent--->
		<cfset currentid = qryParent.categoryid>
	</cfif>

	<!---If the parent doesn't exist then set it to a main category--->
	<cfif qryParent.recordcount IS 0>
		<cfquery name = "qrySetToMain" datasource="#request.dsn#">
		UPDATE categories
		SET subcategoryof = '0'
        WHERE categoryid = #qryCategories.categoryid#
		</cfquery>
		
		<!---Set the categorypath to be a parent category and currentid to 0 to avoid building the categorypath below.--->
		<cfset pathstring = '/'>
		<cfset currentid = '0'>
	</cfif>		

	<!---loop while it's not a top level category--->
	<cfloop condition="NOT currentid IS '0'">	

		<cfquery name = "qryNextParent" dbtype="query">
		SELECT categorypath,subcategoryof,categoryid FROM qryCategories
		WHERE categoryid = #currentid#
		</cfquery>
		
		<!---Update their categorypath--->
		<cfif qryNextParent.recordcount GT 0>
			<!---Set the currentid to the next parent category--->
			<cfset pathstring = '/#qryNextParent.subcategoryof##pathstring#'>
			<cfset currentid = qryNextParent.subcategoryof>
		</cfif>
		
		<!---If the query returns no results, that mean the category is invalid so set it to a main category and exit the loop.--->
		<cfif qryNextParent.recordcount IS 0>
			<cfquery name = "qrySetToMain" datasource="#request.dsn#">
			UPDATE categories
			SET subcategoryof = '0'
            WHERE categoryid = #currentid#
			</cfquery>
			
			<!---remove the invalid id from the categorypath--->
			<cfset pathstring = "/">
			<!---Set the currentid equal to georges--->
			<cfset currentid = '0'>
		</cfif>		
	</cfloop>
	
    <!---remove /0/ from path if it's in there--->
    <cfset pathstring = replace(pathstring, '/0/', '/', 'ALL')>
    
	<!---Update this category with the categorypath built above--->
	<cfquery name = "qryUpdatePath" datasource="#request.dsn#">
	UPDATE categories SET categorypath = '#pathstring#'
	WHERE categoryid = '#qrycategories.categoryid#'
	</cfquery>

        <!---Modify the progress bar--->
    
        <cfset ProgressPercentage = ProgressCount / TotalRecordsToImport>
        <cfset ProgressPercentage = ProgressPercentage * 100>
        <cfset ProgressPercentage = #Round(ProgressPercentage)#>
        
        <cfset NegProgress = 100 - ProgressPercentage>
        
        <cfoutput>
        
        <cfif ProgressPercentage LT 100>
        <script language="JavaScript">
            document.getElementById('progpos').style.width = "#ProgressPercentage#%";
            document.getElementById('progneg').style.width = "#NegProgress#%";
            document.all("StatusMsg").innerHTML = '#ProgressPercentage#% building category paths';
        </script>
        </cfif>
        
        <cfif ProgressPercentage IS 100>
        <script language="JavaScript">
            document.getElementById('progpos').style.width = "#ProgressPercentage#%";
            document.getElementById('progneg').style.width = "#NegProgress#%";
            document.all("StatusMsg").innerHTML = '#ProgressPercentage#% Process Completed!';
        </script>
        </cfif>
        </cfoutput>  
        <!---end progress bar update--->		  

</cfloop>




















