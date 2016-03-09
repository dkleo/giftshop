<cffile action = "read" file="#request.catalogpath#config#request.bslash#banned.cfm" variable="bannedips">	

<h2>Banned IPs</h2>

<cfif isdefined('form.bannedips')>
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

   	<b>Banned IP list has been saved.</b><p>&nbsp;</p>
	
    <cffile action = "write" file="#request.catalogpath#config#request.bslash#banned.cfm" output="#form.bannedips#">	
</cfif>

<div>
These are a list of banned ips from the auto-ban feature. You can remove an ip address to unban someone.<br />
This is an extra security feature to help prevent hack attempts. If the system detects a possible hack attempt, the visitor<br />
is autobanned indefinately.
</div>
<div>
<cfoutput>
<form id="form1" name="form1" method="post" action="dosetup.cfm?action=bannedips">
  <textarea name="bannedips" id="bannedips" cols="85" rows="12">#bannedips#</textarea>
  <br /><input type="submit" value="Update Banned IPs" name="submitbutton"
</form>
</form>
</cfoutput>
</div>