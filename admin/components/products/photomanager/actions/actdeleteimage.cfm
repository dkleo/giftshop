<!---Deletes an image reference from the database and the file if it's no longer in use--->

<cfinclude template = "../../queries/qrycompanyinfo.cfm">

<cfset request.imagespath = '#request.CatalogPath#photos#request.bslash#'>

<cfquery name = "qry_DeleteReference" datasource="#request.dsn#">
DELETE FROM products_images
WHERE id = #url.id#
</cfquery>

<cfquery name = "qry_CheckinUse" datasource="#request.dsn#">
SELECT * FROM products_images
WHERE iFileName = '#url.iFileName#'
</cfquery>

<cfif qry_CheckinUse.recordcount IS 0>
	<cfif fileexists('#request.imagespath#large#request.bslash##url.iFileName#')>
		<cffile action = "Delete" file="#request.imagespath#large#request.bslash##url.iFileName#">
	</cfif>
	<cfif fileexists('#request.imagespath#small#request.bslash##url.iFileName#')>
		<cffile action = "Delete" file="#request.imagespath#small#request.bslash##url.iFileName#">
	</cfif>
	<cfif fileexists('#request.imagespath#tiny#request.bslash##url.iFileName#')>
		<cffile action = "Delete" file="#request.imagespath#tiny#request.bslash##url.iFileName#">
	</cfif>
	<cfif fileexists('#request.imagespath#medium#request.bslash##url.iFileName#')>
		<cffile action = "Delete" file="#request.imagespath#medium#request.bslash##url.iFileName#">
	</cfif>	
</cfif>

<cflocation url = "dophotomanager.cfm?action=search&itemid=#url.itemid#">































