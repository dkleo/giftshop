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
	<cfquery name = "qry_UpdatePost" datasource="#request.dsn#">
	UPDATE blog_posts SET blog_headlines = '#form.blog_headlines#',
	blog_contents = '#form.blog_contents#'
	WHERE blog_id = '#form.blog_id#'
	</cfquery>
	
	Blog Post Updated!
	<cfinclude template = "../forms/frm_editposts.cfm">
	
</cfif>

<cfif error>
	<cfinclude template = "../forms/frm_editpost.cfm">
</cfif>



















