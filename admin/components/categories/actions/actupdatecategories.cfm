<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif isdefined('form.Categoryid')>
    <cfloop from="1" To="#ListLen(form.CategoryID)#" index="CatCount">
		<cfset TempCategoryID = '#ListGetAt(form.CategoryID, CatCount)#'>
        <cfset TempCategoryName = '#ListGetAt(form.CategoryName, CatCount)#'>
        <cfset TempCategoryLayout = '#ListGetAt(form.CategoryLayout, CatCount)#'>
        <cfset TempPermissions = '#ListGetAt(form.permissions, CatCount)#'>
        <cfset TempShowSubs = '#ListGetAt(form.ShowSubCats, CatCount)#'>
        
        <cfquery name = "UpdateThisCategory" datasource="#request.dsn#">
        UPDATE categories
        SET CategoryName = '#TempCategoryName#',
        CategoryLayout = '#TempCategoryLayout#',
        permissions = '#tempPermissions#',
        ShowSubCats = '#tempShowSubs#'
        WHERE CategoryID = #TempCategoryID#
        </cfquery>   
    </cfloop>
</cfif>
<cflocation url = "index.cfm">





















