<cfif request.dbtype IS 'mysql'>
    <cfquery name = "qryProductOptions" datasource="#request.dsn#">
    SELECT * FROM products_options JOIN options ON options.optionid = products_options.optionid
    <cfif isdefined('url.itemid')>WHERE products_options.itemid = #url.itemid#</cfif>
    <cfif isdefined('form.itemid')>WHERE products_options.itemid = #form.itemid#</cfif>
    Order by options.orderid ASC
    </cfquery>
</cfif>

<cfif request.dbtype IS 'msaccess'>
    <cfquery name = "qryAll" datasource="#request.dsn#">
    SELECT * FROM options
    </cfquery>

	<cfset collist = qryAll.Columnlist>
    <cfset collist = replacenocase(collist, "OptionID", "products_options.optionid", "ALL")>
    <cfset collist = replacenocase(collist, "itemid", "products_options.itemid", "ALL")>

    <cfquery name = "qryProductOptions" datasource="#request.dsn#">
    SELECT #collist# FROM products_options 
    LEFT JOIN options ON options.optionid = products_options.optionid
    <cfif isdefined('url.itemid')>WHERE products_options.itemid = #url.itemid#</cfif>
    <cfif isdefined('form.itemid')>WHERE products_options.itemid = #form.itemid#</cfif>
    Order by options.orderid ASC
    </cfquery>
</cfif>















