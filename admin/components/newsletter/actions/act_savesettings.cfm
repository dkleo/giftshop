<center>
  Settings were saved! 
</center>
<cfquery name = "qryUpdateSettings" datasource="#request.dsn#">
UPDATE nl_settings
SET nl_email = '#form.nl_email#',
nl_mailserver = '#form.nl_mailserver#',
nl_UsePassword = '#form.nl_usepassword#',
nl_MailUsername = '#form.nl_mailusername#',
nl_MailPassword = '#form.nl_mailpassword#',
nl_useserver = '#form.nl_useserver#',
nl_blockeddomains = '#form.nl_blockeddomains#'
</cfquery>




















