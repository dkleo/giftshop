<cfinclude template = "queries/qrycompanyinfo.cfm">


<cfoutput query = "qrycompanyinfo">
<h2>Notes #CompanyName#</h2>
<p>
#Notes#
</P>
</cfoutput>
<a href = "javascript:history.go(-1);">Back</a>








