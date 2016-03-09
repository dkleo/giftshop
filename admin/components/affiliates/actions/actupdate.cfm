<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "UpdateAccount" datasource="#request.dsn#">
UPDATE afl_affiliates
SET FirstName='#form.firstname#',
LastName='#form.lastname#', 
Email='#form.Email#', 
Phone='#form.Phone#', 
address1='#form.address1#', 
address2='#form.address2#', 
city='#form.city#', 
state='#form.state#', 
zip='#form.zip#', 
country='#form.country#',
c_override_on = '#form.c_override_on#',
c_override = '#form.c_override#',
c_override_2 = '#form.c_override_2#',
c_override_199 = '#form.c_override_199#',
c_override_199_2 = '#form.c_override_199_2#',
c_override_type = '#form.c_override_type#',
<cfif isdefined('form.has1099')>has1099 = 'Yes',</cfif>
groupid='#form.groupid#',
account_status = '#form.account_status#'
WHERE affiliateID = #form.affiliateID#
</cfquery>

<cflocation url = "index.cfm?action=accounts.view&updateid=#form.affiliateID#&disp=#form.disp#&start=#form.start#&searchbox=#form.searchbox#&sortby=#form.sortby#&sortorder=#form.sortorder#">











