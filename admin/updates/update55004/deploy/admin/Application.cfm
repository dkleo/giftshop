<cfparam name = "is_mobile" default="false">
<cfsetting requesttimeout="1500">

<!---Get the datasource--->
<cfinclude template = "../config/config.cfm">

<cferror type="exception" template="#request.absolutepath#errorstop.cfm">
<cferror type="request" template="#request.absolutepath#errorstop.cfm">
<cferror type="validation" template="#request.absolutepath#errorstop.cfm">

<cfsavecontent variable="bannedlist">
	<cfinclude template="../config/banned.cfm">
</cfsavecontent>

<CFIF LEN(TRIM(cgi.REMOTE_ADDR)) GT 0>
	<cfif bannedlist CONTAINS cgi.REMOTE_ADDR>
		<h2>Access Denied</h2>
        You have been banned because it has been determined that you are attempting to hack our website.  If you have received this message in error, please contact us.
        <cfabort>
	</cfif>
</CFIF>

<CFAPPLICATION NAME="#request.StoreName#" 
CLIENTMANAGEMENT="yes" 
CLIENTSTORAGE="cookie"
SESSIONMANAGEMENT="yes"
SessionTimeOut ="#CreateTimeSpan(0,0,30,0)#"
SetClientCookies="Yes"
scriptprotect="false"
applicationtimeout="#CreateTimeSpan(0,0,30,0)#">

<cfset funcpath = replace(request.absolutepath, "/", "", "ALL")>

<cfif NOT len(funcpath) IS 0>   
	<cfset funcpath = "#funcpath#.">
</cfif>

<cfif isdefined('url.user')>
	<cfcookie name="admin_username" value="#url.user#">
</cfif>
<cfif isdefined('url.pass')>
	<cfcookie name="admin_password" value="#url.pass#">
</cfif>

<!---This javascript is used for opening a seperate window with no status bar or anything.
It is placed here so that it can be loaded for use on the login page.--->
<SCRIPT LANGUAGE="JavaScript">
function NewWindow(mypage, myname, w, h, scroll) {
var winl = (screen.width - w) / 2;
var wint = (screen.height - h) / 2;
winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
win = window.open(mypage, myname, winprops)
if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
}
</script>

<cfif NOT isdefined('url.login')>
	<cfinclude template = "actions/actchecklogin.cfm">
</cfif>

<cfif isdefined('url.login')>
	<cfinclude template = "login.cfm">
    <cfabort>
</cfif>

<cfinclude template = "common.cfm">

<!---This is just a variable that used to figure out how to indent the categories in the drop down box--->
<cfset request.categoryindent = '2'>

<cfoutput><link href="#request.adminpath#controlpanel.css" rel="stylesheet" type="text/css"></cfoutput>





