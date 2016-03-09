<CFQUERY Name = "AddACustomer" Datasource = #request.dsn#>
INSERT INTO customerhistory
(CustPassword, FirstName, LastName, BusinessName, Address, City, State, ZipCode, Country, PhoneNumber, EmailAddress,
ShipFirstName, ShipLastName, ShipBusinessName, ShipAddress, ShipCity, ShipState, ShipZip, ShipCountry)
VALUES
('#form.CustPassword#', '#Form.FirstName#', '#form.LastName#','#form.BusinessName#', 
'#Form.destaddress#', '#Form.destcity#', '#Form.deststate#', '#Form.destpostal#', '#Form.destcountry#', 
'#Form.PhoneNumber#', '#form.CustEmailAddress#', '#form.ShipFirstName#', '#form.ShipLastName#', '#form.ShipBusinessName#', 
'#form.ShipAddress#', '#form.ShipCity#', '#form.ShipState#', '#form.ShipZip#', '#form.ShipCountry#')
</CFQUERY>

<!---If this person wanted to be added to the mailing list, then add their email address to it--->
<cfinclude template = "../actions/actaddtoemaillist.cfm">


<p><b><center>Customer Added</center></b></p>




















