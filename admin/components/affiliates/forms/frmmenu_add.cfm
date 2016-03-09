<h2>Add Affiliate Menu Item</h2>

<cfif isdefined('form.link_title')>
	
    <cfset this_orderval = 1>
    
	<cfquery name = "qNextOrderVal" datasource="#request.dsn#" maxrows="1">
    SELECT * FROM afl_menu
    ORDER BY ordervalue DESC
    </cfquery>

	<cfif qNextOrderVal.recordcount GT 0>
	<cfoutput query = "qNextOrderVal">
    	<cfset this_orderval = #ordervalue#>
    </cfoutput>
	</cfif>
    
	<cfquery name = "insertmenuitem" datasource="#request.dsn#">
    INSERT INTO afl_menu
    (link_title, link_url, link_target, ordervalue)
    VALUES
    ('#form.link_title#', '#form.link_url#', '#link_target#', #this_orderval#)
    </cfquery>

<b>The new link was added to your affiliate menu.</b>

</cfif>

<form method = "post" action="index.cfm?action=menu_add" name="menuform" id="menuform">
<table width="600" cellpadding="6" cellspacing="0">
	<tr>
    	<td width="40%">Link Title:</td>
        <td><input type="text" size="30" value="" name="link_title" /></td>
    </tr>
    <tr>
    	<td>Link URL:</td>
        <td><input type="text" size="45" value="" name="link_url" />
        <br />
        Example: index.cfm?page=homepage.cfm</td>
    </tr>
    <tr>
    	<td>Target:</td>
        <td><select name="link_target" id="link_target">
        	<option value="_top">Same Window (_top)</option>
            <option value="_blank">New Window (_blank)</option>
           	</select>
        </td>
   </tr>
   <tr>
   		<td>&nbsp;</td>
        <td><input type="submit" value="Add Page" name="sumbmitbtn" id="submitbtn" /></td>
   </tr>
</table>   
</form>