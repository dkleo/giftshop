<cfloop from="1" to = "#listlen(form.activated)#" index="a">
	<cfset thisactivated = listgetat(form.activated, a)>
	<cfset thisid = listgetat(form.id, a)>

    <cfquery name="qryChangeActivation" datasource="#request.dsn#">
    UPDATE giftcards
    SET activated = '#thisactivated#'
    WHERE id = #thisid#
    </cfquery>
</cfloop>

<center><b>Gift Card Settings Were Saved</b></center>



















