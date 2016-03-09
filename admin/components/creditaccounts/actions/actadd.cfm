<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset todaysdate = now()>

<cfquery name = "qryApply" datasource="#request.dsn#">
INSERT INTO creditapps
(request_date, biz_name, address, address2, city, state, zip, owner, work, cell, yearsinbiz, dbrate, trade_name, trade_name2, trade_name2, trade_name3, telephone, telephone2, telephone3, account, account2, account3, creditline, terms, approved, status, amount)
VALUES
(#createodbcdate(todaysdate)#, '#form.businessname#', '#form.address#', '#form.address2#', '#form.city#', '#form.state#', '#form.zip#', '#form.owner#', '#form.workphone#', '#form.cellphone#', '#form.howlong#', '#form.bbrate#', '#form.traderef1#', '#form.traderef2#', '#form.traderef3#','#form.tradephone1#', '#form.tradephone2#', '#form.tradephone3#', '#form.tradeacct1#', '#form.tradeacct2#', '#form.tradeacct3#', '#form.creditline#', '#forms.terms#', 'Waiting fo Review', 'Waiting for Review', '0.00')
</cfquery>

<h2>Credit Application</h2>
You have created the credit application.  <a href = "index.cfm?action=pending_approval">Click here</a> to approve it.



















