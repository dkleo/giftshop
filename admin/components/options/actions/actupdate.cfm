
<cfquery name = "UpdateOptionCode" datasource="#application.dsn#">
UPDATE options
SET OptionCode = '#form.OptionCode#',
Caption = '#form.caption#'
WHERE OptionID = #form.OptionID#
</cfquery>

<p align="center">Option Form Field Updated!</p>

