<!--- 
	<cf_getBrowser />
	<cfif browser.is_ie>
	<cfinclude template="ie_specific.cfm">
	</cfif> 
	
	<cfoutput>
	You are using: #browser.name#, version #browser.version# 
	</cfoutput>
	<cfdump var="#browser#" /> 
--->

<cfparam name="attributes.useragent" default="">
<cfif attributes.useragent is "">
	<cfset userAgent=cgi.HTTP_USER_AGENT>
<cfelse>
	<cfset userAgent=attributes.useragent>
</cfif>
<cfset browser=StructNew()>
<!--- Initiating struct --->
<cfset browser.name="Unknown">
<cfset browser.version=0>
<cfset browser.is_ie=false>
<cfset browser.is_opera=false>
<cfset browser.is_webtv=false>
<cfset browser.is_lynx=false>
<cfset browser.is_links=false>
<cfset browser.is_konqueror=false>
<cfset browser.is_gecko=false>
<cfset browser.is_safari=false>
<cfset browser.is_mozilla=false>
<cfset browser.is_netscape=false>

<cfif userAgent neq "">
	<cfset browser.is_ie=iif(findnocase("MSIE", userAgent,1) is 0, de("false"), de("true"))>
	<cfset browser.is_opera=iif(findnocase("Opera", userAgent,1) is 0, de("false"), de("true"))>
	<cfset browser.is_webtv=iif(findnocase("webtv", userAgent,1) is 0, de("false"), de("true"))>
	<cfset browser.is_lynx=iif(findnocase("Lynx", userAgent,1) is 0, de("false"), de("true"))>
	<cfset browser.is_links=iif(findnocase("Links", userAgent,1) is 0, de("false"), de("true"))>
	<cfset browser.is_konqueror=iif(findnocase("Konqueror",userAgent,1) is 0, de("false"), de("true"))>
	<cfset browser.is_gecko=iif(findnocase("gecko", userAgent,1) is 0, de("false"), de("true"))>
	<cfset browser.is_safari=iif(findnocase("Safari", userAgent,1) is 0, de("false"), de("true"))>
	<cfset browser.is_mozilla=false>
	<cfset browser.is_netscape=iif(findnocase("Mozilla", userAgent,1) is 0, de("false"), de("true"))>
	<!--- Detect Opera Netscape (Mozilla) spoofing, rule out Mozilla compatibles and spoofers --->
	<cfif browser.is_opera or browser.is_safari or (findnocase("compatible", userAgent,1) gt 0 or findnocase("spoofer", userAgent,1) gt 0)>
		<cfset browser.is_netscape=false>
	</cfif>
	<!--- Detect Opera IE spoofing --->
	<cfif browser.is_ie and browser.is_opera>
		<cfset browser.is_ie=false>
	</cfif>
	<!--- IE --->
	<cfif browser.is_ie is TRUE>
		<cfset browser.name = "Internet Explorer">
		<cfset browser.version = val(mid(userAgent,findnocase("MSIE", userAgent,1)+4,4))>
	<!--- Opera --->
	<cfelseif browser.is_opera is TRUE>
		<cfset browser.name = "Opera">
		<cfset browser.version = val(mid(userAgent,findnocase("Opera", userAgent,1)+6,4))>
	<!--- Mac OSX Safari --->
	<cfelseif browser.is_safari>
		<cfset browser.name = "Safari">
		<cfset browser.version= val(mid(userAgent,find("Safari/",userAgent) + 7, 2))>
		<cfset browser.is_gecko=false>
	<!--- Netscape, Mozilla and Mozilla based browsers --->
	<cfelseif browser.is_netscape is true>
		<cfif browser.is_gecko>
			<!--- Nestcape >= 6.X (gecko based) --->
			<cfset nav6_pos=findnocase("Netscape", userAgent,1)>
			<cfif nav6_pos gt 0>
				<cfset startpos=nav6_pos+10>
				<cfset browser.version=val(mid(userAgent,startpos,4))>
				<cfset browser.name = "Netscape">
				<cfset browser.version = versjon>
			<cfelse>
				<cfset browser.is_netscape=false>
				<cfset browser.is_mozilla=true>
				<!--- Mozilla < 1.1 --->
				<cfset browser.version=val(mid(userAgent,findnocase(")",userAgent,1)-5,5))>
				<!--- Mozilla (> 1.1) --->
				<cfif browser.version is 0>
					<cfset parantes = structnew()>
					<cfset parantes.start = find("(",userAgent)>
					<cfset parantes.slutt = find(")",userAgent)>
					<cfif (parantes.start gt 0) and (parantes.slutt gt parantes.start)>
						<cfset browser.version = val(RemoveChars(listlast(mid(user_agent,parantes.start,parantes.slutt - parantes.start), ";"),1,4))>
					</cfif>
				</cfif>
				<cfif Find("Firebird",userAgent) gt 0 or Find("Phoenix", userAgent) gt 0>
					<cfset browser.name = "Mozilla Firebird">
				<cfelseif Find("Camino", userAgent) gt 0 or Find("Chimera", userAgent) gt 0>
					<cfset browser.name = "Camino">
				<cfelse>
					<cfset browser.name = "Mozilla">
				</cfif>
				<cfset browser.geckobuild = val(mid(userAgent,find("Gecko",userAgent) + 6, 8))>
			</cfif>
		<cfelse>
			<!--- Netscape <= 4.x --->
			<cfset versjon=Val(mid(userAgent,9,4))>
		</cfif>
	<!--- Lynx --->
	<cfelseif browser.is_lynx>
		<cfset browser.name = "Lynx">
		<cfset browser.version=Val(mid(userAgent,FindNoCase("Lynx",userAgent) + 5,6))>
 	<!--- Links --->
	<cfelseif browser.is_links>
		<cfset browser.name = "Links">
		<cfset browser.version=Val(mid(userAgent,9,4))>
	<!--- Konqueror (www.konqueror.org) --->
	<cfelseif browser.is_konqueror>
		<cfset browser.name = "Konqueror">
		<cfset browser.version=Val(mid(userAgent,FindNoCase("Konqueror",userAgent)+10,6))>
	<!--- Unknown browser --->
	<cfelse>
		<cfset browser.name = userAgent>
		<cfset browser.version = 0>
	</cfif>
</cfif>
<cfset caller.browser = browser>
<cfset thistag.generatedcontent = "">




