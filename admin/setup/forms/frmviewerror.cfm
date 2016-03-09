<cfquery name = "qryCompanyInfo" datasource="#request.dsn#">
SELECT * FROM companyinfo
</cfquery>

<cfquery name = "qryErrorLog" datasource="#request.dsn#">
SELECT * FROM errorlog
WHERE id = #url.id#
</cfquery>
<h2>Error Report</h2>
<cfoutput query = "qryErrorLog">
<form method="post" action="dosetup.cfm?action=reporterror&errorid=#qryErrorlog.errorid#&id=#id#" name="errorsubmission">
   <input type="submit" name="submitbutton" value="Report This Error!" />
  <br /><strong>Note: </strong>When reporting an error, the homeurl of your website and the error report are sent for informational purposes only. <br />
    No other private information will be transmitted. Sending errors reports that you encounter in your shopping cart will help us<br />
  Improve it. If you solve a problem on your own, please click &quot;Mark Error Resolved&quot; and tell us how you fixed it so that we can<br />
  share your fix with others!</p>
  </form>
<div>
#errordetail#
</div>
<cfset url.errorid = qryErrorLog.errorid>

</cfoutput>

<cfinclude template = "frmerrorfixes.cfm">

