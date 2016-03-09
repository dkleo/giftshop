<cfparam name="action" default="">

<cfif request.stats_enabled IS 0>
	<h2>Website Stats</h2>
    You do not currently have website statistics turned on for your store.  To turn this feature on, go to the Settinga and Tools menu and click on Store Settings.  Change the drop down next to 'Enable Statistics Logging' to 'Yes'.
    <cfabort>
</cfif>

<cftry>

<cfswitch expression="#action#">
	<cfdefaultcase>
    	<cfinclude template = "forms/frmstats.cfm">
    </cfdefaultcase>
</cfswitch>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>