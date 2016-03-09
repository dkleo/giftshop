<cfif isdefined('form.ShowThese')>
	<!---Set all to No--->
	<cfquery name = "UpdateStateShow" datasource="#request.dsn#">
	UPDATE states
	SET showthis = 'No'
	</cfquery>
	
	<!---Loop over the ones to show and then update them to yes--->
	<cfloop from = "1" to = "#ListLen(ShowThese)#" index="cCount">
		<cfset thisStateID = ListGetAt(ShowThese, cCount)>
		
		<cfquery name = "UpdateStateShow" datasource="#request.dsn#">
		UPDATE states
		SET showthis = 'Yes'
		WHERE id = #thisStateID#
		</cfquery>
	</cfloop>
</cfif>

<!---Wants to hide them all--->
<cfif NOT isdefined('form.ShowThese')>
	<cfquery name = "UpdateStateShow" datasource="#request.dsn#">
	UPDATE states
	SET showthis = 'No'
	</cfquery>
</cfif>

State/Province Settings Saved!<br />
