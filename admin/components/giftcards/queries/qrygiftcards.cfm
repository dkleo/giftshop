<cfquery name = "qryGiftCards" datasource="#request.dsn#">
SELECT * FROM giftcards
<cfif NOT isdefined('form.searchquery')>
	<cfif isdefined('url.id')>WHERE id = #url.id#</cfif>
	<cfif NOT isdefined('url.id')>
		<cfif showtype IS 'active'>
		WHERE gAmountLeft > 0
		</cfif>
		<cfif showtype IS 'depleted'>
		WHERE gAmountLeft = 0
		</cfif>
	</cfif>
</cfif>
<cfif isdefined('form.searchquery')>
	WHERE gNumber LIKE '%#form.searchquery#%'
</cfif>
</cfquery>





















