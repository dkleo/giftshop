<cfinclude template = "config/config.cfm">

<cferror type="exception" template="#request.absolutepath#errorstop.cfm">
<cferror type="request" template="#request.absolutepath#errorstop.cfm">
<cferror type="validation" template="#request.absolutepath#errorstop.cfm">

<cfsavecontent variable="bannedlist">
	<cfinclude template="config/banned.cfm">
</cfsavecontent>

<CFIF LEN(TRIM(cgi.REMOTE_ADDR)) GT 0>
	<cfif bannedlist CONTAINS cgi.REMOTE_ADDR>
		<h2>Access Denied</h2>
        You have been banned because it has been determined that you are attempting to hack our website.  If you have received this message in error, please contact us.
        <cfabort>
	</cfif>
</CFIF>

<!--- Set Timeout --->
<cfapplication name="#request.StoreName#" 
clientmanagement="No" 
sessionmanagement="Yes" 
setclientcookies="Yes" 
clientstorage="cookie" 
sessiontimeout="#CreateTimeSpan(0, 12, 0, 1)#" 
applicationtimeout="#CreateTimeSpan(1, 0, 0, 1)#"
scriptprotect="all">

<!---if debug is off, they are not loading a page, and the index file is not called, then redirect to the index page--->
<cfif NOT request.debug IS 'On'>
<cfif NOT CGI.HTTP_REFERER contains 'page=docs/'>
<cfif right(cgi.script_name, Len("index.cfm")) NEQ "index.cfm" AND right (cgi.script_name, 3) NEQ "cfc" AND right(cgi.script_name, Len("ipn.cfm")) NEQ "ipn.cfm" AND right(cgi.script_name, Len("showterms.cfm")) NEQ "showterms.cfm" AND right(cgi.script_name, Len("error.cfm")) NEQ "error.cfm">
	<cflocation url="#request.absolutepath#
index.cfm" addtoken="no">
</cfif>
</cfif>
</cfif>