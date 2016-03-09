<cfinclude template = "../queries/qrycontacts.cfm">
<cfoutput query = "qrycontacts">
<p align="center"><font color="##FF0000"><b>#CompanyName#</b></p>
<form method="POST" action="index.cfm">
  <input type = "hidden"  name = "ContactID" value = "#url.ContactID#">
  <table border="0" width="100%" height="413">
    <tr>
      <td width="52%" height="25" valign="top"><b>Contact
        or Company Name:</b></td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="CompanyName" size="34" value="#CompanyName#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="25" valign="top"><font size="2" face="Verdana"><b>If
        this is a company, fill in the contact person's last name and first name
        below</b>
        <p><b>First Name</b></p>
      </td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="FirstName" size="34" value="#FirstName#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="25" valign="top"><b>Last Name</b></td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="LastName" size="34" value="#LastName#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="25" valign="top"><b>Address</b></td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="Address" size="34" value="#Address#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="24" valign="top"><b>City</b></td>
      <td width="48%" height="24" valign="top"><b><input type="text" name="City" size="34" value="#City#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="25" valign="top"><b>State</b></td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="StateOrProvince" size="34" value="#StateOrProvince#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="25" valign="top"><b>Zip Code</b></td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="PostalCode" size="34" value="#PostalCode#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="25" valign="top"><b>Phone Number &amp; Extension</b></td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="PhoneNumber" size="25" value="#PhoneNumber#"><input type="text" name="PhoneExtension" size="7" value="#PhoneExtension#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="25" valign="top"><b>Mobile Phone</b></td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="MobilePhone" size="34" value="#MobilePhone#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="25" valign="top"><b>Fax Number</b></td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="FaxNumber" size="34" value="#FaxNumber#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="25" valign="top"><b>Email Address</b></td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="EmailAddress" size="34" value="#EmailAddress#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="25" valign="top"><b>Internet Website URL:</b></td>
      <td width="48%" height="25" valign="top"><b><input type="text" name="InternetSite" size="34" value="#InternetSite#"></b></td>
    </tr>
    <tr>
      <td width="52%" height="62" valign="top"><b>Notes</b></td>
      <td width="48%" height="62" valign="top"><textarea rows="2" name="Notes" cols="28">#Notes#</textarea></td>
    </tr>
  </table>
  <input type="hidden" Name="Action" Value="Update">
  <p align="center"><input type="submit" value="Update" name="B1"></p>
</form>
</cfoutput>
      </td>
    </tr>
  </table>




















