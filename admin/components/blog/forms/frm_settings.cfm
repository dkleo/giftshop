<cfinclude template = "../queries/qry_blogsettings.cfm">

<cfoutput query = "qry_BlogSettings">
<form name = "settingsform" method="post" action="index.cfm?action=blog.settings.update&mytoken=#mytoken#&isplugin=yes">
<h2><b>Blog Settings</b>
</h2>
<table width="400" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td>Email me when replies are posted? </td>
      <td><select name="notify">
        <option value="1" <cfif notify IS '1'>SELECTED="SELECTED"</cfif>>Yes</option>
        <option value="0" <cfif notify IS '0'>SELECTED="SELECTED"</cfif>>No</option>
      </select>      </td>
    </tr>
    <tr>
      <td>Email to send notifications to: </td>
      <td><input name="notifyemail" type="text" id="notifyemail" size="20" value="#notifyemail#"></td>
    </tr>
    <tr>
      <td>RSS Site Name: </td>
      <td><input name="rss_sitename" type="text" id="rss_sitename" size="20" value="#rss_sitename#"></td>
    </tr>
    <tr>
      <td valign="top">RSS Site Description: </td>
      <td><textarea name="rss_sitedescription" cols="20" rows="5" id="rss_sitedescription" value="#rss_sitedescription#">#rss_sitedescription#</textarea></td>
    </tr>
    <tr>
      <td>Blog Owner: </td>
      <td><input name="blog_owner" type="text" id="blog_owner" size="20" value="#blog_owner#"></td>
    </tr>
    <tr>
      <td>Blog Owner Email Address: </td>
      <td><input name="blog_owner_email" type="text" id="blog_owner_email" size="20" value="#blog_owner_email#"></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><div align="left">
        <p>Link to your blog:</p>
        <p>#request.homeurl#index.cfm?action=showblog </p>
      </div></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><input type="submit" name="Submit" value="Update Blog Settings"></td>
    </tr>
  </table>
</cfoutput>




















