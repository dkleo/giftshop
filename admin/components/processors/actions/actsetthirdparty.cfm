<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qSetAlltoZero" datasource="#request.dsn#">
UPDATE cfsk_processors
SET use_this = 0
WHERE p_type = '3rdparty'
</cfquery>

<cfif isdefined('form.procs')>
    <cfloop from = "1" to = "#listlen(form.procs)#" index="p">

		<cfset this_proc = listgetat(form.procs, p)>
        
        <cfquery name = "qSetWhichOneToUse" datasource="#request.dsn#">
        UPDATE cfsk_processors
        SET use_this = 1
        WHERE id = #this_proc#
        </cfquery>

	</cfloop>
</cfif>

<h2>Select Third Party Processors</h2>
<cfoutput>Third Party Processors have been selected.  <a href = "index.cfm?action=select3rdparty">Click here to set them up</a>.</cfoutput>