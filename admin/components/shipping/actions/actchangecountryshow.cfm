<cfif isdefined('form.ShowThese')>
	<!---Set all to No--->
	<cfquery name = "UpdateCountryShow" datasource="#request.dsn#">
	UPDATE countries
	SET showthis = 'No'
	</cfquery>
	
	<!---Loop over the ones to show and then update them to yes--->
	<cfloop from = "1" to = "#ListLen(ShowThese)#" index="cCount">
		<cfset thisCountryID = ListGetAt(ShowThese, cCount)>
		
		<cfquery name = "UpdateCountryShow" datasource="#request.dsn#">
		UPDATE countries
		SET showthis = 'Yes'
		WHERE id = #thisCountryID#
		</cfquery>
	</cfloop>
</cfif>

<!---Wants to hide them all--->
<cfif NOT isdefined('form.ShowThese')>
	<cfquery name = "UpdateCountryShow" datasource="#request.dsn#">
	UPDATE countries
	SET showthis = 'No'
	</cfquery>
</cfif>

Country Settings Saved!<br />

