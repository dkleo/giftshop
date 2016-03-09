<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<h2>Adding a New Processor</h2>

<cfquery name = "qUpdate" datasource="#request.dsn#">
INSERT INTO cfsk_processors
(p_name, p_displayname, use_token, use_user, use_id, use_pass, use_hash, use_custom, use_testmode, custom_name, script_pay, script_subscribe, script_callbacks, script_button, askforcard, use_echecks, instructions, p_adminname, use_cvs, is_enabled, allowed_to_storeit, p_type, p_image, use_this)
VALUES
('#form.p_name#', '#form.p_displayname#', #form.use_token#, #form.use_user#, #form.use_id#, #form.use_pass#, #form.use_hash#, #form.use_custom#, #form.use_testmode#, '#form.custom_name#', '#form.script_pay#', '#form.script_subscribe#', '#form.script_callbacks#', '#form.script_button#', '#form.askforcard#', '#form.accept_echecks#', '#form.instructions#', '#form.p_adminname#', '#form.use_cvs#', #form.is_enabled#, #form.allowed_to_storeit#, '#form.p_type#', '#form.p_image#', #form.use_this#)
</cfquery>

New Payment Processor was added. <a href = "index.cfm">Back to processors.</a>




















