<!---this decrypts the processor settings and creates variables for each setting that are used in scripts for gateway and 3rd party processors--->
<cfquery name = "qProc" datasource="#request.dsn#">
SELECT * FROM cfsk_processors
WHERE p_name = <cfqueryparam value="#payment_method#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfoutput query = "qProc">

<cfif len(trim(qProc.p_user)) GT 0>
	<cfset var_user = Decrypt(qProc.p_user, request.seedstring, "CFMX_COMPAT","HEX") />
<cfelse>
	<cfset var_user = "">
</cfif>

<cfif len(trim(qProc.p_pass)) GT 0>
	<cfset var_pass = Decrypt(qProc.p_pass, request.seedstring, "CFMX_COMPAT","HEX") />
<cfelse>
	<cfset var_pass = "">
</cfif>

<cfif len(trim(qProc.p_id)) GT 0>
	<cfset var_id = Decrypt(qProc.p_id, request.seedstring, "CFMX_COMPAT","HEX") />
<cfelse>
	<cfset var_id = "">
</cfif>

<cfif len(trim(qProc.p_token)) GT 0>
	<cfset var_token = Decrypt(qProc.p_token, request.seedstring, "CFMX_COMPAT","HEX") />
<cfelse>
	<cfset var_token = "">
</cfif>

<cfif len(trim(qProc.p_hash)) GT 0>
	<cfset var_hash = Decrypt(qProc.p_hash, request.seedstring, "CFMX_COMPAT","HEX") />
<cfelse>
	<cfset var_hash = "">
</cfif>

<cfif len(trim(qProc.p_custom)) GT 0>
	<cfset var_custom = Decrypt(qProc.p_custom, request.seedstring, "CFMX_COMPAT","HEX") />
<cfelse>
	<cfset var_custom = "">
</cfif>

<!---true or false value--->
<cfset var_istest = qProc.test_mode>
<cfset var_storedata = qProc.store_info>
<cfset var_canstoredata = qProc.allowed_to_storeit><!---won't store it if set to 0 regardless if storedata is set to 1--->
<cfset var_usecvs = qProc.use_cvs>
</cfoutput>