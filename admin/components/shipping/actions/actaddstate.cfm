<cfquery name = "AddState" datasource="#request.dsn#">
INSERT INTO states
(State, StateCode, ShowThis, Country)
VALUES
('#form.state#', '#form.statecode#', 'Yes', '#form.Country#')
</cfquery>

<cflocation url = "doshipping.cfm?action=editstates&SelectedCountry=#form.Country#">
