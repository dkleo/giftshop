
<cfparam name="form.okupdate" default="No">
<cfparam name="url.id" default="1">
<cfif #form.okupdate# IS "Yes">
<cfquery name="updpage" datasource="#request.dsn#">
UPDATE afl_pages
Set PageText = '#Form.Pagetext#'
Where ID = 1
</cfquery>
<cfset okupdate = "No">
</cfif>

<cfquery name="getpage" datasource="#request.dsn#">
SELECT * From afl_pages
Where ID = 1
</cfquery>

<TABLE width=750 border=0 align="center" cellPadding=0 cellSpacing=0>
  
  <TR>
    <TD width="590" valign="top">
	
	<form name="form1" method="post" action="pages.cfm">
<cfmodule 
			template="../../../fckeditor/fckeditor.cfm"
			basePath="#request.AdminPath#/fckeditor/"
			instanceName="EditPage"
			value='#pagetext#'
			width="100%"
			height="500"
			>
</cfoutput>
	<input name="okupdate" type="hidden" value="Yes">
	<input name="ID" type="hidden" value="#URL.ID#">
	<input name="Update" type="submit" value="Update">
    </form>    </td>
  </tr>
</table>

















