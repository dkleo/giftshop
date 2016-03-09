<CFQUERY Name = "UpdateACustomer" Datasource = #request.dsn#>
UPDATE customerhistory
SET FirstName= '#Form.FirstName#', 
LastName='#form.LastName#', 
BusinessName='#form.BusinessName#', 
Address='#Form.destaddress#', 
City='#Form.destcity#', 
State='#Form.deststate#', 
ZipCode='#Form.destpostal#', 
Country='#Form.destcountry#', 
PhoneNumber='#Form.PhoneNumber#', 
EmailAddress='#form.EmailAddress#', 
ShipFirstName='#form.ShipFirstName#', 
ShipLastName='#form.ShipLastName#', 
ShipBusinessName='#form.ShipBusinessName#', 
ShipAddress='#form.ShipAddress#', 
ShipCity='#form.ShipCity#', 
ShipState='#form.ShipState#', 
ShipZip='#form.ShipZip#', 
ShipCountry='#form.ShipCountry#',
pricelevel='#form.pricelevel#'
WHERE CustomerID = #form.CustomerID#
</cfquery>

<div align="center"><Strong>Customer Information was updated.</Strong></div>




















