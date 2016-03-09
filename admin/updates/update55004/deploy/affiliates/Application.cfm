<cfinclude template = "../config/config.cfm">

<cferror type="exception" template="#request.absolutepath#errorstop.cfm">
<cferror type="request" template="#request.absolutepath#errorstop.cfm">
<cferror type="validation" template="#request.absolutepath#errorstop.cfm">

<!--- Set Timeout --->
<cfapplication name="#request.StoreName#" 
clientmanagement="Yes" 
sessionmanagement="Yes" 
setclientcookies="Yes" 
clientstorage="cookie" 
sessiontimeout="#CreateTimeSpan(0, 12, 0, 1)#" 
applicationtimeout="#CreateTimeSpan(1, 0, 0, 1)#"
scriptprotect="all">

<!---if debug is off, they are not loading a page, and the index file is not called, then redirect to the index page--->
<cfif NOT request.debug IS 'On'>
<cfif NOT CGI.HTTP_REFERER contains 'page=docs/'>
<cfif right(cgi.script_name, Len("index.cfm")) NEQ "index.cfm" AND right (cgi.script_name, 3) NEQ "cfc" AND right(cgi.script_name, Len("ipn.cfm")) NEQ "ipn.cfm">
	<cflocation url="index.cfm" addtoken="no">
</cfif>
</cfif>
</cfif>

<cfparam name = "carttoken" default="0">

<!---load common file--->
<cfinclude template = "../common.cfm">

<cfparam name="action" default = "default.default">
<cfif NOT action IS 'login' and NOT action IS 'lostpwd'>
	<cfinclude template = "actions/actchecklogin.cfm">
</cfif>


