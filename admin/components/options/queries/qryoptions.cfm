<cfquery name = "qryoptions" datasource="#request.dsn#">
SELECT * FROM options
<cfif isdefined('url.optionid')>WHERE OptionID = #url.optionid#</cfif>
<cfif isdefined('ThisOptionField')>WHERE OptionID = #ThisOptionField#</cfif>
<cfif isdefined('form.fieldtype')>
	<cfif NOT form.fieldtype IS 'All'>
		WHERE FieldType = '#form.FieldType#'
	</cfif>
</cfif>
ORDER BY OrderID ASC
</cfquery>




















