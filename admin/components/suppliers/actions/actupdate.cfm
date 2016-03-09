<CFQUERY NAME="UpdateContact" DATASOURCE=#request.dsn#>
UPDATE contacts
SET CompanyName ='#form.CompanyName#',
    FirstName ='#form.FirstName#',
    LastName = '#form.LastName#',
    Address = '#form.Address#',
    City= '#form.City#',
    StateOrProvince= '#form.StateOrProvince#',
    PostalCode = '#form.PostalCode#',
    PhoneNumber = '#form.PhoneNumber#',
    PhoneExtension = '#form.PhoneExtension#',
    MobilePhone = '#form.MobilePhone#',
    FaxNumber = '#form.FaxNumber#',
    EmailAddress = '#form.EmailAddress#',
    InternetSite = '#form.InternetSite#',
    Notes = '#form.Notes#'
WHERE ContactID = #form.ContactID#
</CFQUERY>
<div align="center"><b>The Information has been Updated!</b> </div>
<p align="center"><a href="index.cfm?Action=View">Return 
  to the Address Book</a> 















