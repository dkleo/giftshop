<cfparam name="ShowButton" default="Yes">
<cfparam name="OriginalPrice" default="0">
<cfparam name = "viewby" default="fordervalue">
<cfparam name = "sortorder" default="ASC">
<cfparam name = "category" default = "0">
<cfparam name = "itemid" default = "0">
<cfparam name = "processpage" default = "Yes">

<h2>Email a Friend</h2>

<cfif NOT isdefined('form.friends_email')>
  <form name = "emailform" method = "post" <cfoutput>action = "index.cfm?action=emailitem&carttoken=#carttoken#&itemid=#itemid#"</cfoutput>>
<table width="100%" border="0" cellspacing="0" cellpadding="8" class="emailfriend_table">
  <tr>
    <td width="20%">Friend's Name:</td>
    <td><input name="friends_name" type="text" id="friends_name" size="45" /></td>
  </tr>
  <tr>
    <td>Friend's Email Address:</td>
    <td><input name="friends_email" type="text" id="friends_email" size="45" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Your First Name:</td>
    <td><input name="firstname" type="text" id="firstname" size="45" /></td>
  </tr>
  <tr>
    <td>Your Last Name:</td>
    <td><input name="lastname" type="text" id="lastname" size="45" /></td>
  </tr>
  <tr>
    <td>Your Email Address:</td>
    <td><input name="emailaddress" type="text" id="emailaddress" size="45" /></td>
  </tr>
  <tr>
    <td colspan="2"><p>Your Messages:</p>
      <p>
        <textarea name="bodyofemail" cols="80" rows="8" id="bodyofemail"></textarea>
      </p></td>
    </tr>
  <tr>
    <td colspan="2"><div align="center">
      <input type="submit" name="Submit2" value="Send Email" />
    </div></td>
  </tr>
</table>
</cfif>

<cfif isdefined('form.friends_email')>

<cfinclude template = "../queries/qryproducts.cfm">
<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfinclude template = "../queries/qrydiscounts.cfm">
<cfinclude template = "../queries/qrycategories.cfm">
<cfinclude template = "../queries/qrysales.cfm">
<cfinclude template = "../queries/qrybrochures.cfm">
<cfinclude template = "../queries/qrywishlistcheck.cfm">
<cfinclude template = "../queries/qrysubproducts.cfm">
<cfinclude template = "../queries/qryproductoptions.cfm">

<cfinclude template = "emaildiv.cfm">

<cfset fromdomain = replacenocase(request.homeurl, 'http://', '', 'ALL')>
<cfset fromdomain = replacenocase(fromdomain, 'www.', '', 'ALL')>
<cfset fromdomain = replacenocase(fromdomain, request.absolutepath, '', 'ALL')>

<cfif request.UseMailServer IS 'Yes'>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail server="#request.MailServer#"
        username="#request.mailuser#"
        password="#request.mailpassword#"
        from="#form.firstname# #form.lastname# <#form.emailaddress#>"
        to="#form.friends_name# <#form.friends_email#>"
        subject="#friends_name#, I saw this on #fromdomain#"
        type="html">
        #form.bodyofemail#
        <p>
        #emaileditem#
        </cfmail>
      <cfelse>
        <cfmail server="#request.MailServer#"
        From="#form.firstname# #form.lastname# <#form.emailaddress#>"
        TO="#form.friends_name# <#form.friends_email#>"
        SUBJECT="#friends_name#, I saw this on #fromdomain#"
        type="html">
        #form.bodyofemail#
        <p>
        #emaileditem#
        </cfmail>       
    </cfif>

<cfelse>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail username="#request.mailuser#"
        password="#request.mailpassword#"
        from="#form.firstname# #form.lastname# <#form.emailaddress#>"
        TO="#form.friends_name# <#form.friends_email#>"
        SUBJECT="#friends_name#, I saw this on #fromdomain#"
        type="html">
        #form.bodyofemail#
        <p>
        #emaileditem#
        </cfmail>
      <cfelse>
        <cfmail From="#form.firstname# #form.lastname# <#form.emailaddress#>"
        TO="#form.friends_name# <#form.friends_email#>"
        SUBJECT="#friends_name#, I saw this on #fromdomain#"
        type="html">
        #form.bodyofemail#
        <p>
        #emaileditem#
        </cfmail>       
    </cfif>

</cfif>

<h3>We sent your message and your friend should get it very soon!</h3>
<p>
<cfoutput><a href = "index.cfm?action=viewdetails&itemid=#itemid#">Continue Shopping</a></p></cfoutput>
</cfif>