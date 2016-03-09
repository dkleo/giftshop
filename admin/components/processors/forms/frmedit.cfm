<cfif isdefined('url.id')>

<h2>Edit Processor</h2>

    <cfquery name = "qProc" datasource="#request.dsn#">
    SELECT * from cfsk_processors
    WHERE id = #url.id#
    </cfquery>
    
    <cfset formaction = 'update'>
	<cfset buttonval = 'Update Processor Settings'>
	
	<cfoutput query = "qProc">
    <cfset p_type = "#p_type#">
    <cfset p_name= "#p_name#">
    <cfset p_adminname = "#p_adminname#">
    <cfset p_hash= "#p_hash#">
    <cfset p_id= "#p_id#">
    <cfset p_user= "#p_user#">
    <cfset p_custom= "#p_custom#">
    <cfset p_pass= "#p_pass#">
    <cfset use_echecks= "#use_echecks#">
    <cfset use_testmode= "#use_testmode#">
    <cfset use_token = "#use_token#">
    <cfset use_user = "#use_user#">
    <cfset use_id = "#use_id#">
    <cfset use_pass = "#use_pass#">
    <cfset use_custom = "#use_custom#">
    <cfset use_hash = "#use_hash#">
    <cfset store_info= "#store_info#">
    <cfset script_pay= "#script_pay#">
    <cfset custom_name = "#custom_name#">
    <cfset script_subscribe= "#script_subscribe#">
    <cfset script_callbacks= "#script_callbacks#">
    <cfset script_button= "#script_button#">
    <cfset askforcard= "#askforcard#">
    <cfset accept_echecks= "#accept_echecks#">
    <cfset use_this= "#use_this#">
    <cfset instructions= "#instructions#">
    <cfset p_displayname= "#p_displayname#">
    <cfset p_image= "#p_image#">
    <cfset p_token= "#p_token#">
    <cfset id = "#id#">
    <cfset use_cvs = '#use_cvs#'>
    <cfset is_enabled = '#is_enabled#'>
    <cfset allowed_to_storeit = '#allowed_to_storeit#'>
    <cfset orders_icon = '#orders_icon#'>
    <cfset use_this = '#use_this#'>
    </cfoutput>

<cfelse>

<h2>Add Processor</h2>
	<cfset formaction = 'add'>
    <cfset buttonval = 'Add New Processor'>
    <cfset p_type= "gateway">
    <cfset p_name= "">
    <cfset p_adminname = "">
    <cfset p_hash= "">
    <cfset p_id= "">
    <cfset p_user= "">
    <cfset p_custom= "">
    <cfset p_pass= "">
    <cfset use_echecks= "0">
    <cfset use_testmode= "0">
    <cfset use_token = "0">
    <cfset use_user = "0">
    <cfset use_pass = "0">
    <cfset use_custom = "0">
    <cfset use_hash = "0">
    <cfset use_id = "0">
    <cfset store_info= "0">
    <cfset script_pay= "">
    <cfset script_subscribe= "">
    <cfset script_callbacks= "">
    <cfset script_button= "">
    <cfset askforcard= "0">
    <cfset custom_name = "">
    <cfset accept_echecks= "0">
    <cfset use_this= "0">
    <cfset instructions= "">
    <cfset p_displayname= "">
    <cfset p_image= "">
    <cfset p_token= "">   
	<cfset id = "0">
    <cfset use_cvs = "0">
    <cfset is_enabled = "1">
    <cfset allowed_to_storeit = '0'>
    <cfset orders_icon = ''>
    <cfset use_this = '0'>
</cfif>

<cfoutput>
<form action="index.cfm?action=#formaction#" method="post" name="add_proc">
  <table width="700" border="0" cellspacing="0" cellpadding="6">
    <tr>
      <td>Processor Enabled:</td>
      <td><select name="is_enabled" id="is_enabled">
        <option value="1" <cfif is_enabled IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif is_enabled IS 0>selected="selected"</cfif>>No</option>
      </select></td>
    </tr>
    <tr>
      <td width="54%">Type:</td>
      <td width="46%"><select name="p_type" id="p_type">
        <option value="3rdparty" <cfif p_type IS '3rdparty'>selected="selected"</cfif>>Optional 3rd Party Processor</option>
        <option value="gateway" <cfif p_type IS 'gateway'>selected="selected"</cfif>>Primary Gateway</option>
      </select>      </td>
    </tr>
    <tr>
      <td>Nick Name (no spaces):</td>
      <td><input name="p_name" type="text" id="p_name" size="40" value="#p_name#" />
      <input type = "hidden" name="old_name" value="#p_name#" /></td>
    </tr>
    <tr>
      <td>Display Name:</td>
      <td><input name="p_displayname" type="text" id="p_displayname" size="40" value="#p_displayname#" /></td>
    </tr>
    <tr>
      <td>Admin Display Name:</td>
      <td><input name="p_adminname" type="text" id="p_adminname" size="40" value="#p_adminname#" /></td>
    </tr>
    <tr>
      <td>Checkout Image File Name:</td>
      <td><input name="p_image" type="text" id="p_image" size="40" value="#p_image#" /></td>
    </tr>
    <tr>
      <td>Uses a Token:</td>
      <td><select name="use_token" id="use_token">
        <option value="1" <cfif use_token IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif use_token IS 0>selected="selected"</cfif>>No</option>
      </select>      </td>
    </tr>
    <tr>
      <td>Uses a Username:</td>
      <td><select name="use_user" id="use_user">
        <option value="1" <cfif use_user IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif use_user IS 0>selected="selected"</cfif>>No</option>
            </select></td>
    </tr>
    <tr>
      <td>Uses an ID Number:</td>
      <td><select name="use_id" id="use_id">
        <option value="1" <cfif use_id IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif use_id IS 0>selected="selected"</cfif>>No</option>
        </select></td>
    </tr>
    <tr>
      <td>Uses a Password:</td>
      <td><select name="use_pass" id="use_pass">
        <option value="1" <cfif use_pass IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif use_pass IS 0>selected="selected"</cfif>>No</option>
            </select></td>
    </tr>
    <tr>
      <td>Uses a Hash Value:</td>
      <td><select name="use_hash" id="use_hash">
        <option value="1" <cfif use_hash IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif use_hash IS 0>selected="selected"</cfif>>No</option>
        </select></td>
    </tr>
    <tr>
      <td>Uses a Custom Value:</td>
      <td><select name="use_custom" id="use_custom">
        <option value="1" <cfif use_custom IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif use_custom IS 0>selected="selected"</cfif>>No</option>
            </select></td>
    </tr>
    <tr>
      <td>If Using a Custom Value, What is it called?</td>
      <td><input name="custom_name" type="text" id="custom_name" size="40" value="#custom_name#" /></td>
    </tr>
    <tr>
      <td>Payment Script File Name:</td>
      <td><input name="script_pay" type="text" id="script_pay" size="40" value="#script_pay#" /></td>
    </tr>
    <tr>
      <td>Subscription Script File Name:</td>
      <td><input name="script_subscribe" type="text" id="script_subscribe" size="40" value="#script_subscribe#" /></td>
    </tr>
    <tr>
      <td>Script File Name for all Callbacks:</td>
      <td><input name="script_callbacks" type="text" id="script_callbacks" size="40" value="#script_callbacks#" /></td>
    </tr>
    <tr>
      <td>File Name for Button Code (if no script file or is 3rd party):</td>
      <td><input name="script_button" type="text" id="script_button" size="40" value="#script_button#" /></td>
    </tr>
    <tr>
      <td>If Gateway, does script support EChecks?</td>
      <td><select name="use_echecks" id="use_echecks">
        <option value="1" <cfif use_echecks IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif use_echecks IS 0>selected="selected"</cfif>>No</option>
      </select></td>
    </tr>
    <tr>
      <td> &nbsp;&nbsp;&nbsp;If so, enable eChecks now?</td>
      <td><select name="accept_echecks" id="accept_echecks">
        <option value="1" <cfif accept_echecks IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif accept_echecks IS 0>selected="selected"</cfif>>No</option>
      </select></td>
    </tr>
    <tr>
      <td>Supports Test Mode?</td>
      <td><select name="use_testmode" id="use_testmode">
        <option value="1" <cfif use_testmode IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif use_testmode IS 0>selected="selected"</cfif>>No</option>
      </select></td>
    </tr>
    <tr>
      <td>Show Credit Card Payment Form?</td>
      <td><select name="askforcard" id="askforcard">
        <option value="1" <cfif askforcard IS 1>selected="selected"</cfif>>Yes</option>
        <option value="0" <cfif askforcard IS 0>selected="selected"</cfif>>No</option>
      </select></td>
    </tr>
    <tr>
      <td>Uses CVS/AVS?</td>
      <td><select name="use_cvs" id="use_cvs">
        <option value="1">Yes</option>
        <option value="0">No</option>
      </select></td>
    </tr>
    <tr>
      <td>Give Option to Store Card Data (or partial card data)</td>
      <td><select name="allowed_to_storeit" id="allowed_to_storeit">
        <option <cfif allowed_to_storeit IS 1>selected="selected"</cfif>value="1">Yes</option>
        <option <cfif allowed_to_storeit IS 0>selected="selected"</cfif>value="0">No</option>
      </select></td>
    </tr>
    <tr>
      <td>Order Screen Icon File Name:</td>
      <td><input type="text" name="orders_icon" id="orders_icon" value="#orders_icon#" /></td>
    </tr>
    <tr>
      <td><p>Special Instructions</p></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td colspan="2"><textarea name="instructions" id="instructions" cols="45" rows="5" style="width: 100%; height: 480px;">#instructions#</textarea></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right">
        <input type = "hidden" name="id" value="#id#" />
        <input type = "hidden" name="use_this" value="#use_this#" />
        <input type="submit" name="button" id="button" value="#buttonval#" />
      </div></td>
    </tr>
  </table>
</form>
</cfoutput>

<script type="text/javascript">
	CKEDITOR.replace( 'instructions',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '/admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '/admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '/admin/filebrowser/browseflash.cfm'		
	});
</script>
