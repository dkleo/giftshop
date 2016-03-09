<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qrySaveContactFormSettings" datasource="#request.dsn#">
UPDATE contactform_settings
SET emails_goto = '#form.emails_goto#',
send_emails = 'Yes',
store_indb = 'No',
mailserver = '#form.mailserver#',
UseDefaultServer = '#form.UseDefaultServer#',
UseMailServer = '#form.UseMailServer#',
UseMailLogin = '#form.UseMailLogin#',
mailuser = '#form.mailuser#',
mailpassword = '#form.mailpassword#',
usecaptcha = '#form.usecaptcha#',
thanks_page = '#form.thanks_page#',
subject_line = '#form.subject_line#',
captcha_difficulty = '#form.captcha_difficulty#'
</cfquery>

<cflocation url = "index.cfm?wasupdated=yes">




















