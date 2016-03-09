<h2>Editing Affiliate Menu Item</h2>

<cfif isdefined('form.link_title')>
	
    <cfset this_orderval = 1>
    
	<cfquery name = "insertmenuitem" datasource="#request.dsn#">
    UPDATE afl_menu SET link_title = '#form.link_title#',
    link_url = '#form.link_url#', 
    link_target = '#link_target#'
   	WHERE id = #form.id#
    </cfquery>

	<cflocation url = "index.cfm?action=menu">

</cfif>

<cfquery name = "qMenuItem" datasource="#request.dsn#">
SELECT * FROM afl_menu
WHERE id = #url.id#
</cfquery>

<cfoutput query = "qMenuItem">

<form method = "post" action="index.cfm?action=menu_edit">
<table width="600" cellpadding="6" cellspacing="0">
	<tr>
    	<td width="40%">Link Title:</td>
        <td><input type="text" size="30" name="link_title" value="#link_title#" /></td>
    </tr>
    <tr>
    	<td>Link URL:</td>
        <td><input type="text" size="45" name="link_url" value="#link_url#" /></td>
    </tr>
    <tr>
    	<td>Target:</td>
        <td><select name="link_target" id="link_target">
        	<option value="_top" <cfif link_target IS '_top'>selected="selected"</cfif>>Same Window (_top)</option>
            <option value="_blank" <cfif link_target IS '_blank'>selected="selected"</cfif>>New Window (_blank)</option>
           	</select>
        </td>
   </tr>
   <tr>
   		<td>&nbsp;</td>
        <td>
        <input type="hidden" value="#id#" name="id" />
        <input type="submit" value="Update Page" name="sumbmitbtn" id="submitbtn" /></td>
   </tr>
</table>   
</form>
</cfoutput>