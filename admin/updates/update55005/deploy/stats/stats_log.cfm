<cfset vis_date = Now()>
<cfset vis_ip = CGI.REMOTE_ADDR>
<cfif vis_ip IS ''>
	<cfset vis_ip= '#CGI.REMOTE_HOST#'>
</cfif>
<cfset vis_useragent = left(CGI.HTTP_USER_AGENT, 255)>
<cfset vis_month = dateformat(vis_date, "m")>
<cfset vis_year = dateformat(vis_date, "yyyy")>
<cfset vis_day = dateformat(vis_date, "d")>

<!---NOTE values are maxed at 250 to database optimal--->
<cfset vis_querystring = left(CGI.QUERY_STRING, 250)>
<cfset vis_startpage = left(CGI.PATH_INFO, 250)>
<cfset vis_referrer = left(CGI.HTTP_REFERER, 250)>

<cfif len(trim(vis_referrer)) IS 0>
	<cfset vis_referrer = 'Direct'>
</cfif>

<cfif len(trim(vis_querystring)) IS 0>
	<cfset vis_querystring = 'None'>
</cfif>


<!---delete all old data first so we don't have too much clutter, the log only stores the current month; it is not needed and will build up too much data
if we let it just log ever visitor indefinately.  We only want it so we can refer to it for a persons session so it doesn't matter that we keep it.  High
traffic sites could even add WHERE vis_day < #vis_day# to delete previous days too.--->
<cfquery name = "qLog" datasource="#request.dsn#">
DELETE FROM stats_log WHERE vis_month < #vis_month# AND vis_year < #vis_year#
</cfquery>

<cfquery name = "qLog" datasource="#request.dsn#">
SELECT * FROM stats_log WHERE vis_ip = '#vis_ip#'
</cfquery>

<cfif qLog.recordcount IS 0>
	<!---log stats--->
    <cfquery name = "qLogStats" datasource="#request.dsn#">
    INSERT INTO stats_log
    (vis_ip, vis_referrer, vis_startpage, vis_date, vis_querystring, vis_month, vis_year, vis_day)
    VALUES
    ('#vis_ip#', '#vis_referrer#', '#vis_startpage#', #createodbcdatetime(vis_date)#, '#vis_querystring#', #vis_month#, #vis_year#, #vis_day#)
    </cfquery>
	
    <!---log unique hit (each day)--->
	<cfquery name = "qHits" datasource="#request.dsn#">
    SELECT * FROM stats_hits
    WHERE stats_month = #vis_month#
    AND stats_year = #vis_year#
    AND stats_day = #vis_day#
    </cfquery>

    <cfif qHits.recordcount IS 0>
    	<cfquery name = "qInsertHits" datasource="#request.dsn#">
        INSERT INTO stats_hits
        (unique_hits, page_views, stats_date, stats_month, stats_year, stats_day)
        VALUES
        (1, 0, #createodbcdate(vis_date)#, #vis_month#, #vis_year#, #vis_day#)
        </cfquery>
	<cfelse>
        <cfquery name = "qUpdateHits" datasource="#request.dsn#">
        UPDATE stats_hits
        SET unique_hits = unique_hits + 1
        WHERE stats_month = #vis_month# 
        AND stats_year = #vis_year#
        AND stats_day = #vis_day#
        </cfquery>
    </cfif>

    	<!---IF IT'S A UNIQUE HIT THEN LOG REFERRER, USERAGENT, ETC.---->
		<!---log Referrer--->
        <cfquery name = "qRefs" datasource="#request.dsn#">
        SELECT referrer FROM stats_referrers
        WHERE stats_month = #vis_month#
        AND stats_year = #vis_year#
        AND stats_day = #vis_day#
        AND referrer = '#vis_referrer#'
        </cfquery>
        
        <cfif qRefs.recordcount IS 0>
            <cfquery name = "qInsertHits" datasource="#request.dsn#">
            INSERT INTO stats_referrers
            (referrer, hit_count, stats_date, stats_month, stats_year, stats_day)
            VALUES
            ('#vis_referrer#', 1, #createodbcdate(vis_date)#, #vis_month#, #vis_year#, #vis_day#)
            </cfquery>
        <cfelse>
            <cfquery name = "qUpdateHits" datasource="#request.dsn#">
            UPDATE stats_referrers
            SET hit_count = hit_count + 1
            WHERE stats_month = #vis_month# 
            AND stats_year = #vis_year# 
            AND stats_day = #vis_day#
            AND referrer = '#vis_referrer#'
            </cfquery>
        </cfif>
        
        <!---log User Agent--->
        <cfquery name = "qUsera" datasource="#request.dsn#">
        SELECT user_agent FROM stats_useragents
        WHERE stats_month = #vis_month#
        AND stats_year = #vis_year#
        AND stats_day = #vis_day#
        AND user_agent = '#vis_useragent#'
        </cfquery>
        
        <cfif qUsera.recordcount IS 0>
            <cfquery name = "qInsertHits" datasource="#request.dsn#">
            INSERT INTO stats_useragents
            (user_agent, hit_count, stats_date, stats_month, stats_year, stats_day)
            VALUES
            ('#vis_useragent#', 1, #createodbcdate(vis_date)#, #vis_month#, #vis_year#, #vis_day#)
            </cfquery>
        <cfelse>
            <cfquery name = "qUpdateHits" datasource="#request.dsn#">
            UPDATE stats_useragents
            SET hit_count = hit_count + 1
            WHERE stats_month = #vis_month# 
            AND stats_year = #vis_year# 
            AND stats_day = #vis_day#
            AND user_agent = '#vis_useragent#'
            </cfquery>
        </cfif>        
	

</cfif>

<!---update page views--->
<cfquery name = "qUpdateHits" datasource="#request.dsn#">
UPDATE stats_hits
SET page_views = page_views + 1
WHERE stats_month = #vis_month# 
AND stats_year = #vis_year#
AND stats_day = #vis_day#
</cfquery>