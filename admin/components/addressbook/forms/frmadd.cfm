<cfinclude template = "../queries/qrycontacts.cfm">
<p align="center"><h2>New Contact</h2></p>
<form method="POST" action="index.cfm">
  <table border="0" width="100%">
    <tr>
      <td width="52%" valign="top" align="left"><b>Contact or
        Company Name</b></td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="CompanyName" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>If this is a
        company, fill in the contact person's last name and first name below</b>
        <p><b>Contact Person's First Name:</b></p>
      </td>
      <td width="48%" valign="bottom" align="left"><b><input type="text" name="FirstName" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>Contact
        Person's Last Name:</b></td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="LastName" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left">
        <p><b>Address:</b></p>
      </td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="Address" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>City:</b></td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="City" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>State:</b></td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="StateOrProvince" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>Zip Code:</b></td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="PostalCode" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>Phone Number &amp; Extension</b></td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="PhoneNumber" size="25"><input type="text" name="PhoneExtension" size="7"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>Mobile Phone:</b></td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="MobilePhone" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>Fax Number:</b></td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="FaxNumber" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>Email Address:</b></td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="EmailAddress" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>Internet Website URL:</b></td>
      <td width="48%" valign="top" align="left"><b><input type="text" name="InternetSite" size="34"></b></td>
    </tr>
    <tr>
      <td width="52%" valign="top" align="left"><b>Notes:</b></td>
      <td width="48%" valign="top" align="left"><textarea rows="2" name="Notes" cols="28"></textarea></td>
    </tr>
  </table>
  <input type="hidden" name="Action" value="Add">
  <p align="center"><input type="submit" value="Add to Address Book" name="B1"></p>
</form>
</td>
</tr>
</table>




















