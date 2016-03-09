<cfquery name = "qDeleteTemplate" datasource="#request.dsn#">
DELETE from products_templates
WHERE itemid = #form.itemid#
</cfquery>

<cfquery name = "qDeleteTemplateCatRefs" datasource="#request.dsn#">
DELETE FROM product_categories_templates
WHERE itemid = #form.itemid#
</cfquery>

<cflocation url = "doproducts.cfm?action=newfromtemplate?was_deleted=1">