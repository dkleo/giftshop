<!---Add a customers email to the email list if they chose to have it added
during checkout--->

<cfset FullName = '#form.FirstName# #Form.LastName#'>

<cfif isdefined('Form.ProductUpdates')>
<cfquery name = "CheckForDuplicateEmail" Datasource = "#request.dsn#">
SELECT *
FROM emaillist
WHERE CustomerEmail = '#form.CustEmailAddress#'
</cfquery>

<cfif #CheckForDuplicateEmail.RecordCount# IS 0>
<CFQUERY Name = "AddtoMailingList" Datasource = "#request.dsn#">
INSERT INTO emaillist
(CustomerName, CustomerEmail)
VALUES
('#FullName#', '#form.CustEmailAddress#')
</CFQUERY>	 
</cfif>
</cfif>




















