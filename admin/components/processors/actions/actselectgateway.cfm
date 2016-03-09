<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qSetAlltoZero" datasource="#request.dsn#">
UPDATE cfsk_processors
SET use_this = 0
WHERE p_type = 'gateway'
</cfquery>

<cfquery name = "qSetWhichOneToUse" datasource="#request.dsn#">
UPDATE cfsk_processors
SET use_this = 1
WHERE id = #form.proc#
</cfquery>

<h2>Select Gateway to Use</h2>
<cfoutput>Gateway has been selected.  <a href = "index.cfm?action=settings&id=#form.proc#">Click here to set it up</a>.</cfoutput>