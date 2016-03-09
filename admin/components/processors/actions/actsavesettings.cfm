<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qProc" datasource="#request.dsn#">
SELECT * FROM cfsk_processors
WHERE id = #form.id#
</cfquery>

<!---encrypt values of the id, user, pass, hash, token, and custom fields if present--->
<cfif isdefined('form.p_id')>

</cfif>
<cfif isdefined('form.p_id')>
	<cfif len(trim(form.p_id)) GT 0>
		<cfset enc_id = #encrypt(form.p_id, request.seedstring,"CFMX_COMPAT","HEX")#>
        <cfset enc_id = #replace(enc_id, "/", "//", "ALL")#>
        <cfset enc_id = #replace(enc_id, "\", "\\", "ALL")#>
    </cfif>
</cfif>
<cfif isdefined('form.p_user')>
	<cfif len(trim(form.p_user)) GT 0>
		<cfset enc_user = #encrypt(form.p_user, request.seedstring,"CFMX_COMPAT","HEX")#>
        <cfset enc_user = #replace(enc_user, "/", "//", "ALL")#>
        <cfset enc_user = #replace(enc_user, "\", "\\", "ALL")#>
	</cfif>
</cfif>
<cfif isdefined('form.p_pass')>
	<cfif len(trim(form.p_pass)) GT 0>
		<cfset enc_pass = #encrypt(form.p_pass, request.seedstring,"CFMX_COMPAT","HEX")#>
        <cfset enc_pass = #replace(enc_pass, "/", "//", "ALL")#>
        <cfset enc_pass = #replace(enc_pass, "\", "\\", "ALL")#>
	</cfif>
</cfif>
<cfif isdefined('form.p_hash')>
	<cfif len(trim(form.p_hash)) GT 0>
		<cfset enc_hash = #encrypt(form.p_hash, request.seedstring,"CFMX_COMPAT","HEX")#>
        <cfset enc_hash = #replace(enc_hash, "/", "//", "ALL")#>
        <cfset enc_hash = #replace(enc_hash, "\", "\\", "ALL")#>
	</cfif>
</cfif>
<cfif isdefined('form.p_token')>
	<cfif len(trim(form.p_token)) GT 0>
		<cfset enc_token = #encrypt(form.p_token, request.seedstring,"CFMX_COMPAT","HEX")#>
        <cfset enc_token = #replace(enc_token, "/", "//", "ALL")#>
        <cfset enc_token = #replace(enc_token, "\", "\\", "ALL")#>
	</cfif>
</cfif>
<cfif isdefined('form.p_custom')>
	<cfif len(trim(form.p_custom)) GT 0>
		<cfset enc_custom = #encrypt(form.p_custom, request.seedstring,"CFMX_COMPAT","HEX")#>
        <cfset enc_custom = #replace(enc_custom, "/", "//", "ALL")#>
        <cfset enc_custom = #replace(enc_custom, "\", "\\", "ALL")#>
	</cfif>
</cfif>

<cfquery name = "qUpdateProc" datasource="#request.dsn#">
UPDATE cfsk_processors
SET p_adminname = '#form.p_adminname#',
ordervalue = #ordervalue#
<cfif isdefined('form.p_id')>
<cfif isdefined('enc_id')>
, p_id = '#enc_id#'
</cfif>
</cfif>
<cfif isdefined('form.p_user')>
<cfif isdefined('enc_user')>
, p_user = '#enc_user#'
</cfif>
</cfif>
<cfif isdefined('form.p_pass')>
<cfif isdefined('enc_pass')>
, p_pass = '#enc_pass#'
</cfif>
</cfif>
<cfif isdefined('form.p_token')>
<cfif isdefined('enc_token')>
, p_token= '#enc_token#'
</cfif>
</cfif>
<cfif isdefined('form.p_hash')>
<cfif isdefined('enc_hash')>
, p_hash = '#enc_hash#'
</cfif>
</cfif>
<cfif isdefined('form.p_custom')>
<cfif isdefined('enc_custom')>
, p_custom = '#enc_custom#'
</cfif>
</cfif>
<cfif isdefined('form.test_mode')>
, test_mode = '#form.test_mode#'
</cfif>
<cfif isdefined('form.store_info')>
, store_info = '#form.store_info#'
</cfif>
<cfif isdefined('form.accept_echecks')>
, accept_echecks = '#form.accept_echecks#'
</cfif>
WHERE id = #form.id#
</cfquery>

<h2>Processor Settings</h2>
Settings were saved.