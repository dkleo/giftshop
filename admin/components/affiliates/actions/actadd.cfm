<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset theaffiliateid = '#form.groupid##form.accountid#'>

<cfset thepath = "/">
<!---build their path, base it on the referring affiliate--->
<cfquery name = "qryParent" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateID = '#form.Subaffiliateof#'
</cfquery>

<cfoutput query = "qryParent">
	<cfset thepath = "#path##form.subaffiliateof#/">
</cfoutput>


<cfquery name = "AddAccount" datasource="#request.dsn#">
INSERT INTO afl_affiliates
(groupid, accountid, affiliateid, FirstName, LastName, Birthdate, Email, Phone, address1, address2, city, state, zip, country, TaxID, pnumber, subaffiliateof, path, CustPassword)
VALUES
('#form.groupid#', '#form.accountid#', '#theaffiliateid#', '#form.firstname#', '#form.lastname#', '#form.birthdate#', '#form.Email#', '#form.Phone#', '#form.address1#', '#form.address2#', '#form.city#', '#form.state#', '#form.zip#', '#form.country#',
'#form.TaxID#', '#form.pNumber#', '#form.SubAffiliateOf#', '#thepath#', '#form.CustPassword#')
</cfquery>

<cflocation url = "index.cfm?action=accounts.add&wasadded=yes">











