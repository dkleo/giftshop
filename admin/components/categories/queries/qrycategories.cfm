<cfquery name = "qrycategories" datasource="#request.dsn#">
SELECT * FROM categories
<cfif NOT isdefined('session.ViewCat')>
WHERE SubCategoryOf = '0'  
</cfif>
<cfif isdefined('session.ViewCat')>
<cfif session.ViewCat IS 'Main categories'>WHERE SubCategoryOf = '0'  </cfif>
<cfif session.ViewCat IS 'All categories'>  </cfif>
<cfif NOT session.ViewCat IS 'Main categories' AND NOT session.ViewCat IS 'All categories'>WHERE SubCategoryOf = '#session.ViewCat#' </cfif>
</cfif>
ORDER BY OrderValue ASC
</cfquery>

<cfquery name = "qrycategoriesAll" datasource="#request.dsn#">
SELECT * FROM categories
ORDER BY OrderValue ASC
</cfquery>

<cfif isdefined('url.CategoryID')>
<cfquery name = "qrycategories" datasource="#request.dsn#">
SELECT * FROM categories
WHERE categoryid = #url.CategoryID#
</cfquery>
</cfif>






















