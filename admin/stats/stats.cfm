<!---<cftry>--->
<!---This file counts pages viewed by a visitor.  It is called from the index.cfm file of the store.--->

<!---Get todays date--->
<cfset TodaysDate = Now()>
<cfset TodaysDate = #dateformat(TodaysDate, "yyyy-mm-dd")#>
<cfset CurrentTime = Now()>
<cfset CurrentTime = #timeformat(CurrentTime, "HH:mm:ss")#>

<!---Get the visitor IP---->
<cfset VisitorIP = '#REMOTE_ADDR#'>
<!---If it's blocked then check the remoth Host and see if there is an IP address--->
<cfif VisitorIP IS ''>
		<cfset VisitorIP = '#REMOTE_HOST#'>
</cfif>

<!---<cfif ISDEFINED('session.VisitorSession')>
	<!---Session alrady exists so add on to their pageviews count--->
	<cflock scope="session" timeout="30" type="readonly">
		<cfset TempVar.VisitorID = #Session.VisitorSession#>
	</cflock>

	<CFQUERY name = "qryVisitors" datasource="#request.dsn#">
		SELECT * FROM stats WHERE VisitorID = #TempVar.VisitorID#
	</CFQUERY>

	<!---If the record is not found, just abort--->
	<cfif qryVisitors.RecordCount IS 0>
		<!---abort stats--->
	<cfelse>

	<!---if there are more than one instances of this ip address on this day then just get the first one--->
	<cfset ThisVisitorID = #ListGetAt(qryVisitors.VisitorID, 1)#>
	<cfset CurrentPageViews = #ListGetAt(qryVisitors.PageViews, 1)#> 
	
	<!---Add to the pageviews--->
	<cfset PageViews = CurrentPageViews + 1>
	
	<!---Update the stats table--->
	<cfquery name="qryUpdateVisitor" datasource="#request.dsn#">
	UPDATE stats
	Set PageViews = #PageViews#
	WHERE VisitorID = #ThisVisitorID#
	</cfquery>

    </cfif>

</cfif>


<!---For statistical information, start a session if one is not already started---> --->

<cfif NOT ISDEFINED('session.VisitorSession')>
	<!---This might be a new visitor, but their session could have timed out, so query the database
		 to see if anyone with this IP address came today.  If IP is blocked then count as a new
		 visitor --->

	<!---
	<!---Check to see if the visitor already came here today---->
	<CFQUERY name = "qryVisitors" datasource="#request.dsn#">
		SELECT * FROM stats WHERE VisitorIP = '#VisitorIP#' AND Datedata = '#TodaysDate#'
	</CFQUERY>

	<cfif qryVisitors.recordcount IS 0> 		 --->

		<!---Get their Screen Resolution--->
		<!---Get their Screen Resolution--->
		<cfset ScreenResolution = '800x600'>
		<cfset ColorDepth = '32'>
		<!---<CF_Screen_Res>
		<cfset ScreenResolution = '#variables.ScreenResHeight#x#variables.ScreenResWidth#'>
		<cfset ColorDepth = '#variables.ScreenResColorDepth#'>--->
		<!---Get their Browser Information--->
		<cf_getBrowser />
		<cfif ISDEFINED('browser.name')>
			<cfset BrowserName = '#browser.Name#'> 
		    <cfelse>
			<cfset BrowserName = 'Unkown'>
		</cfif>
		<cfif ISDEFINED('browser.version')>
			<cfset BrowserVersion = '#browser.version#'>
			<cfelse>
			<cfset BrowserVersion = '0'>
		</cfif>
		<!---Get the page requested:  This is the page/url they entered the site at--->
		<cfset StartPage = '#CGI.PATH_INFO#?#CGI.QUERY_STRING#'>
		<!---Get the referring page info--->
		<cfset Referer = '#CGI.HTTP_REFERER#'>
	
			<!---Visitor is new so insert a new record--->
			<cfquery name="qryAddVistor" datasource="#request.dsn#">
			INSERT INTO stats 
			(StartPage, Browser, BrowserVersion, timedata, datedata, referer, ColorDepth, Visitorip, ScreenResolution, PageViews)
			VALUES
			('#StartPage#', '#BrowserName#', '#BrowserVersion#', '#CurrentTime#', '#TodaysDate#', '#Referer#', '#ColorDepth#', '#VisitorIP#', '#ScreenResolution#', 1)
			</cfquery>

			<!---Get the VisitorID from the record just entered above--->
			 <cfquery name="getLastID" datasource="#request.dsn#">
			  SELECT MAX(VisitorID) as lastID
			  FROM stats
			</cfquery>

		<!---Now Create a session--->
			<cflock scope="Session" timeout="30" type="exclusive">
				<cfset session.VisitorSession = '#getLastID.LastID#'>
			</cflock>

	<cfelse>
		<!---They already visited today so don't count them as a new visitor--->

		<!---<cflock scope="session" timeout="30" type="readonly">
			<cfset TempVar.VisitorID = #Session.VisitorSession#>
		</cflock>
		<!---<cflock scope="Session" timeout="30" type="exclusive">
			<cfset session.VisitorSession = '#qryVisitors.VisitorID#'>
		</cflock>--->


		<cfset ThisVisitorID = #ListGetAt(TempVar.VisitorID, 1)#>
		<cfset CurrentPageViews = #ListGetAt(qryVisitors.PageViews, 1)#> <!---if there are more than one 
						instances of this ip address on this day then just get the first one--->
		
		<cfset PageViews = CurrentPageViews + 1>
		
		<cfquery name="qryUpdateVisitor" datasource="#request.dsn#">
		UPDATE stats
		Set PageViews = #PageViews#
		WHERE VisitorID = #ThisVisitorID#
		</cfquery>--->

	</cfif>
<!---</cfif>--->
<!---<cfcatch type="any">
<!---Do nothing if an error occures--->
</cfcatch>

</cftry>--->	




