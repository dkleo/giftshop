<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qSetAlltoZero" datasource="#request.dsn#">
UPDATE cfsk_processors
SET use_this = 0
WHERE p_type = 'gateway'
</cfquery>

<cfif isdefined('form.proc')>
    <cfquery name = "qSetWhichOneToUse" datasource="#request.dsn#">
    UPDATE cfsk_processors
    SET use_this = 1
    WHERE id = #form.proc#
    </cfquery>
</cfif>

<h2>Remove Gateway Setting</h2>
No gateway is selected now.