<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset Thumbnail = 'None'>
<cfset Thumbnail2 = 'None'>

<cfquery name = "AddLink" datasource="#request.dsn#">
INSERT INTO Links
(LinkOrder, LinkTitle, LinkRef, LinkDescription, LinkTarget, LinkImage, LinkRImage)
VALUES
('#form.LinkOrder#', '#form.LinkTitle#', '#form.LinkRef#', '#form.LinkDescription#', '#TheTarget#', '#Thumbnail#', '#Thumbnail2#')
</cfquery>



















