<cfinclude template="../queries/qrycontacts.cfm">

<CFIF qrycontacts.RecordCount GREATER THAN 0>
You have attempted to enter a duplicate entry.  A contact with that company already
exists in the database.  You should edit the entry instead of adding a new one.
<p>
<a href="javascript:history.go(-1);">Click here</a> to go back and change it
<cfabort>
</cfif>

<CFQUERY Name = "AddTocontacts" Datasource = #request.dsn#>
INSERT INTO contacts (CompanyName, 
FirstName, 
LastName, 
Address, 
City,
StateOrProvince, 
PostalCode, 
PhoneNumber, 
PhoneExtension, 
MobilePhone, 
FaxNumber,
EmailAddress,
InternetSite,
Notes) 
VALUES ('#form.CompanyName#', 
'#form.FirstName#', 
'#form.LastName#', 
'#form.Address#', 
'#form.City#', 
'#form.StateOrProvince#',
'#form.PostalCode#', 
'#form.PhoneNumber#', 
'#form.PhoneExtension#', 
'#form.MobilePhone#', 
'#form.FaxNumber#',
'#form.EmailAddress#',
'#form.InternetSite#',
'#form.Notes#')
</CFQUERY>
<p align="center"><strong>The information was added!</strong></p>
<p align="center"><a href="index.cfm">Back to Address Book</a><br>















