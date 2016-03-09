<cfquery name = "qProc" datasource="#request.dsn#">
SELECT * FROM cfsk_processors
WHERE id = #url.id#
</cfquery>

<h2>Settings</h2>
<div style="padding: 5px; background: #EAFFEA; color: #000000; font-weight: bold; border: 1px solid #666666;">
Note:  Values are encrypted and are not shown for security reasons.  Enter a value into a text field to change it.  Leave it blank if you do not want to change the current value.
</div>
<cfoutput query = "qProc">
  <form name="form1" method="post" action="index.cfm?action=savesettings">
  <table width="700" border="0" cellspacing="0" cellpadding="6">
    <tr>
      <td>Name:</td>
      <td>#p_adminname# <input type = "hidden" name = "p_adminname" value="#p_adminname#" /></td>
    </tr>
    <cfif use_user IS 1>
    <tr>
      <td width="30%">Username:</td>
      <td><input type="text" name="p_user" id="p_user"> <cfif len(p_user) GT 0><font color="##006600">Value Set</font> (<a href = "index.cfm?action=clearsetting&clearwhat=p_user&id=#id#">clear setting</a>)<cfelse><font color="##990000">Not Set</font></cfif> </td>
    </tr>
    </cfif>
    <cfif use_id IS 1>
    <tr>
      <td>Login:</td>
      <td><input type="text" name="p_id" id="p_id"> <cfif len(p_id) GT 0><font color="##006600">Value Set</font> (<a href = "index.cfm?action=clearsetting&clearwhat=p_id&id=#id#">clear setting</a>)<cfelse><font color="##990000">Not Set</font></cfif></td>
    </tr>
    </cfif>
    <cfif use_token IS 1>
    <tr>
      <td>Token:</td>
      <td><input type="text" name="p_token" id="p_token"> <cfif len(p_token) GT 0><font color="##006600">Value Set</font> (<a href = "index.cfm?action=clearsetting&clearwhat=p_token&id=#id#">clear setting</a>)<cfelse><font color="##990000">Not Set</font></cfif></td>
    </tr>
    </cfif>
    <cfif use_pass>
    <tr>
      <td>Password:</td>
      <td><input type="text" name="p_pass" id="p_pass"> <cfif len(p_pass) GT 0><font color="##006600">Value Set</font> (<a href = "index.cfm?action=clearsetting&clearwhat=p_pass&id=#id#">clear setting</a>)<cfelse><font color="##990000">Not Set</font></cfif></td>
    </tr>
    </cfif>
    <cfif use_hash IS 1>
    <tr>
      <td>Hash Value:</td>
      <td><input type="text" name="p_hash" id="p_hash"> <cfif len(p_hash) GT 0><font color="##006600">Value Set</font> (<a href = "index.cfm?action=clearsetting&clearwhat=p_hash&id=#id#">clear setting</a>)<cfelse><font color="##990000">Not Set</font></cfif></td>
    </tr>
    </cfif>
    <cfif use_custom IS 1>
    <tr>
      <td>#custom_name#</td>
      <td><input type="text" name="p_custom" id="p_custom"> <cfif len(p_custom) GT 0><font color="##006600">Value Set</font> (<a href = "index.cfm?action=clearsetting&clearwhat=p_custom&id=#id#">clear setting</a>)<cfelse><font color="##990000">Not Set</font></cfif></td>
    </tr>
    </cfif>
    <cfif use_testmode IS 1>
    <tr>
      <td>Put In Test Mode?</td>
      <td><select name="test_mode" id="test_mode">
        <option  <cfif test_mode IS 'true'>selected="selected"</cfif> value="True">Yes</option>
        <option <cfif test_mode IS 'false'>selected="selected"</cfif> value="False">No</option>
      </select>      </td>
    </tr>
    </cfif>
    <cfif qProc.allowed_to_storeit IS 1>
    <tr>
      <td>Store Card Data?</td>
      <td><select name="store_info" id="store_info">
        <option <cfif store_info IS 'Yes'>selected="selected"</cfif> value="Yes">Yes</option>
        <option <cfif store_info IS 'No'>selected="selected"</cfif> value="No">No</option>
      </select></td>
    </tr>
    </cfif>
    <cfif use_echecks IS 1>
    <tr>
      <td>Accept EChecks</td>
      <td><select name="accept_echecks" id="accept_echecks">
        <option <cfif accept_echecks IS 1>selected="selected"</cfif> value="1">Yes</option>
        <option <cfif accept_echecks IS 0>selected="selected"</cfif> value="0">No</option>
      </select></td>
    </tr>
    </cfif>
    <tr>
      <td>Order Value</td>
      <td><input name="ordervalue" type="text" id="ordervalue" size="10" value="#ordervalue#" /></td>
    </tr>
    <tr>
      <td><input type = "hidden" name="id" value="#id#" /></td>
      <td><input type="submit" name="button" id="button" value="Save Settings"></td>
    </tr>
  </table>
</form>
#instructions#
</cfoutput>