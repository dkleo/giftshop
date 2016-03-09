<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<h2>Edit processor</h2>

<cfquery name = "qUpdate" datasource="#request.dsn#">
UPDATE cfsk_processors
SET p_name='#form.p_name#', 
p_displayname='#form.p_displayname#', 
use_token=#form.use_token#, 
use_user=#form.use_user#, 
use_id=#form.use_id#,
use_pass=#form.use_pass#, 
use_hash=#form.use_hash#, 
use_custom=#form.use_custom#, 
use_testmode=#form.use_testmode#, 
custom_name='#form.custom_name#', 
script_pay='#form.script_pay#', 
script_subscribe='#form.script_subscribe#', 
script_callbacks='#form.script_callbacks#', 
script_button='#form.script_button#', 
askforcard='#form.askforcard#', 
use_echecks='#form.accept_echecks#', 
instructions='#form.instructions#', 
p_adminname='#form.p_adminname#', 
use_cvs='#form.use_cvs#', 
is_enabled=#form.is_enabled#, 
allowed_to_storeit=#form.allowed_to_storeit#, 
p_type='#form.p_type#', 
p_image='#form.p_image#', 
use_this=#form.use_this#,
orders_icon = '#form.orders_icon#'
WHERE id = #form.id#
</cfquery>

<cfquery name = "qUpdateOrder" datasource="#request.dsn#">
UPDATE orders SET paymentmethod = '#form.p_name#'
WHERE paymentmethod = '#form.old_name#'
</cfquery>

Setting were saved.  <a href = "index.cfm">Back to Processor Administration</a>.
