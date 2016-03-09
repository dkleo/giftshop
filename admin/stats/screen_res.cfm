<!---
Usage:
<CF_Screen_Res>

<CFOUTPUT>
	#variables.ScreenResHeight#<BR>
	#variables.ScreenResWidth#<BR>
	#variables.ScreenResColorDepth#<BR>
	#variables.ScreenResAvailableHeight#<Br>
	#variables.ScreenResAvailableWidth#<Br>
</CFOUTPUT>
--->

<!--- Check For the existence of the cookie Variable that designates that the screen elements have been captured --->
<CFIF (isDefined("cookie.VARIABLESPRESENT")) and (#cookie.VARIABLESPRESENT# Eq "True")>

	<!--- Set the Browser Variables into Local CF Variables --->
	<CFSET caller.ScreenResHeight = cookie.ScreenResHeight>
	<CFSET caller.ScreenResWidth = cookie.ScreenResWidth>
	<CFSET caller.ScreenResColorDepth = cookie.ScreenResColorDepth>
	<CFSET caller.ScreenResAvailableHeight = cookie.ScreenResAvailableHeight>
	<CFSET caller.ScreenResAvailableWidth = cookie.ScreenResAvailableWidth>

	<CFCOOKIE NAME="VARIABLESPRESENT" VALUE="False" EXPIRES="12/31/1970">
	
	<!--- Set any Form Variables saved previously into Local CF Variables --->
	<CFIF isDefined("session.TempForm")>
		<CFIF isStruct(session.TempForm)>
			<CFLOOP COLLECTION="#session.TempForm#" ITEM="item">
				<CFSET form[#item#]  = #session.TempForm[item]#>
			</CFLOOP>
		</CFIF>
	</CFIF>
	
<CFELSE>

	<!--- Insert the JavaScript into the HTML Head --->
	<CFHTMLHEAD TEXT="
	<script language=""JavaScript"">
	//-- First we need some basic information about the client's browser.
	var browserName = navigator.appName
	var browserVersion = navigator.appVersion
	var browserVersionNum = parseFloat(browserVersion)
	var agt=navigator.userAgent
	
	//-- Assign initial values for browser settings to global variables.
	var availheight=""unknown""
	var availwidth=""unknown""
	var colordepth=""unknown""
	var height=""unknown""
	var width=""unknown""
	
	//-- If browser is version 4 or better we can take a deeper look.
	if (browserVersionNum >= 4) {
	  var availheight=screen.availHeight
	  var availwidth=screen.availWidth
	  var colordepth=screen.colorDepth + ""+bit""
	  var height=screen.height
	  var width=screen.width
	}
	
	function SetCookie (name, value) {
        var argv = SetCookie.arguments;
        var argc = SetCookie.arguments.length;
        var expires = (argc > 2) ? argv[2] : null;
        var path = (argc > 3) ? argv[3] : null;
        var domain = (argc > 4) ? argv[4] : null;
        var secure = (argc > 5) ? argv[5] : false;
        document.cookie = name + ""="" + escape (value) +
                ((expires == null) ? """" : (""; expires="" +
			expires.toGMTString())) +
                ((path == null) ? """" : (""; path="" + path)) +
                ((domain == null) ? """" : (""; domain="" + domain)) +
                ((secure == true) ? ""; secure"" : """");
}
	</script>
	">
	
	<!--- Identify any Existing Query Strings --->
	<CFIF ISDEFINED("cgi.query_string")>
		<CFSET temp = "&#cgi.query_string#">
	<CFELSE>
		<CFSET temp = "">
	</CFIF>	
	
	<!--- Save any Existing Form Variables --->
	<CFIF isStruct(FORM)>
		<CFSCRIPT>
			tmpStuct=StructNew();
			tmpStuct = StructCopy(FORM);
			session.TempForm = tmpStuct;
		</CFSCRIPT>
	</CFIF>
			
	<!--- Use the Client JavaScript variables and redirect to the same page --->
	<script language="JavaScript">
	
				window.location = "<CFOUTPUT>#cgi.Script_Name#</CFOUTPUT>";
				SetCookie("ScreenResHeight", height);
				SetCookie("ScreenResWidth", width);
				SetCookie("ScreenResColorDepth", colordepth)
				SetCookie("ScreenResAvailableHeight", availheight)
				SetCookie("ScreenResAvailableWidth", availwidth)
				SetCookie("VARIABLESPRESENT","True")
	</script> 
	
	<!--- Since the redirect happens Client side the rest of the web page needs to be aborted --->
	<CFABORT>
	
</CFIF>



