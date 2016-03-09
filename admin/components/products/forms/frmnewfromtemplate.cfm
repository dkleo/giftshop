<cfquery name = "qTemplates" datasource="#request.dsn#">
SELECT * FROM products_templates
</cfquery>

<h2>New Product From Template</h2>

<cfif qTemplates.recordcount IS 0>
You do not have any product templates saved.  To create a product template, add an item to your catalog and then check the box to save it as a template.
<cfelse>
<h3>Create a Product using a template</h3>
Choose the template you want to create a product from.
<form method="post" action="doproducts.cfm?action=new" name="templateform">
<select name = "template_id" id="template_id">
	<cfoutput query = "qTemplates">
		<option value="#itemid#">#productname#</option>
    </cfoutput>
</select>
<input type = "submit" value="Load Template" name="submitbtn" />
</form>
</cfif>
<p>&nbsp</p>
<hr />
<h3>Delete Templates</h3>
If you no longer need a template you may delete it using the form below.
<cfif isdefined('url.was_deleted')><font color="#FF0000"><strong>Template was deleted</strong></font></cfif>
<p>
<cfif qTemplates.recordcount IS 0>
There are no templates available to delete.
<cfelse>
Choose the template you want to create a product from.
<form method="post" action="doproducts.cfm?action=delete_template" name="templateform">
<select name = "itemid" id="itemid">
	<cfoutput query = "qTemplates">
		<option value="#itemid#">#productname#</option>
    </cfoutput>
</select>
<input type = "submit" value="Delete Template" name="submitbtn" />
</form>
</cfif>
</p>
