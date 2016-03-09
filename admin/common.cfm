<cfset request.SupportLink = 'http://support.megalinx.com/'>

<!---ckeditor--->
<cfoutput><script type="text/javascript" src="#request.absolutepath#admin/ckeditor/ckeditor.js"></script></cfoutput>

<cfinclude template = "../config/settings.cfm">

<!---Sets up a variable to determine what locale this is (for currency type)--->
<cflock scope="application" type="readonly" timeout="10">
	<cfset oldlocale = SetLocale("#request.location#")>
</cflock>

<cfset TodaysDate = now()>

<!---Set default session view--->
<cfif NOT isdefined('session.sortoption')>
	<cflock scope="session" type="exclusive" timeout="10">
		<cfset session.sortoption = 'Featured'>
	</cflock>
</cfif>

<script>
<!--
function showtip(tip){
document.tool.tip.value=tip
}
//-->
</script>








