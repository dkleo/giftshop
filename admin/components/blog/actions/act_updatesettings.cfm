<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qry_UpdateSettings" datasource="#request.dsn#">
UPDATE blog_settings SET notify = #form.notify#,
notifyemail = '#form.notifyemail#',
rss_sitename = '#form.rss_sitename#',
rss_sitedescription = '#form.rss_sitedescription#',
blog_owner = '#form.blog_owner#',
blog_owner_email = '#form.blog_owner_email#'
</cfquery>
<p>
Settings Where Saved!



















