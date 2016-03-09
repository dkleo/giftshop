<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset error = 0>
<cfset ErrorMessage = ''>

<cfif form.blog_headlines IS ''>
	<cfset error = 1>
	<cfset ErrorMessage = ErrorMessage & 'You must enter a headline.<br>'>
</cfif>

<cfif form.blog_contents IS ''>
	<cfset error = 1>
	<cfset ErrorMessage = ErrorMessage & 'You must enter some content.<br>'>
</cfif>

<cfif NOT error>
	<cfset postdate = #CreateDate(datepart("yyyy",now()),datepart("m",now()),datepart("d",now()))#>
	<cfset posttime = #CreateODBCTime(now())#>
	<cfset postuuid = #CreateUUID()#>
	<cfset postyear = #datepart("yyyy", postdate)#>
	<cfset postmonth = #datepart("m", postdate)#>

<!---Insert the post into the db for backup--->	
	<cfquery name = "qry_UpdatePost" datasource="#request.dsn#">
	INSERT INTO blog_posts 
	(blog_id, blog_date, blog_time, blog_year, blog_month, blog_headlines, blog_contents, blog_cat)
	VALUES
	('#postuuid#', #postdate#, #posttime#, #postyear#, #postmonth#, '#form.blog_headlines#', '#form.blog_contents#', '#form.blog_cat#')
	</cfquery>
	
	<cflocation url = "index.cfm?action=blog.edit.default&mytoken=#mytoken#&m=#postmonth#&y=#postyear#&isplugin=yes">
</cfif>

<!---Write the post to their catalog path--->

<cfif error>
	<cfinclude template = "../forms/frm_editpost.cfm">
</cfif>



















