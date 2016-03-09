<!---Update featured items in the database--->

<!---Loop over the list of in the hidden field called FeaturedOff to turn off all the featured
items.  Do this so that we only turn on the ones we want--->

<cfloop from="1" To="#ListLen(form.FeaturedOff)#" index="MyCount">
<cfset ThisItemID = #ListGetAt(form.FeaturedOff, MyCount)#>

<cfquery name = "UpdateOrderValues" datasource="#request.dsn#">
UPDATE products
SET IsFeatured = 'No'
WHERE ItemID = #ThisItemID#
</cfquery>

</cfloop>

<!---Now turn on the ones that need to be set to featured--->
<cfif ISDEFINED('form.FeaturedOn')>
<cfloop from="1" To="#ListLen(form.FeaturedOn)#" index="MyCount">
<cfset ThisItemID = #ListGetAt(form.FeaturedOn, MyCount)#>

<cfquery name = "UpdateOrderValues" datasource="#request.dsn#">
UPDATE products
SET IsFeatured = 'Yes'
WHERE ItemID = #ThisItemID#
</cfquery>

</cfloop>
</cfif>

<cflocation url = "doproducts.cfm?action=FeaturedItems&saved=yes">

















