<cfset docname = replace(form.helptitle, " ", "_", "ALL")>
<cfset docname = lcase(docname)>
<cfset docname = "#docname#.cfm">

<cffile action = "write" file="#request.catalogpath#admin#request.bslash#helpdocs#request.bslash##docname#" mode="777" output="<h3>#form.helptitle#</h3>#form.helpcontent#">

<center>New content was added</center>
<p>
HTML:
<p>

<cfoutput>
<cfset HTMLCode = '<a href = "##request.AdminPath##helpdocs/#docname#" onclick="NewWindow(this.href' & ",'Help','375','450','yes');return false;" & '")><b><img src = "##request.AdminPath##images/help.gif" border="0" /></b></a>'>
</cfoutput>
<p>
<cfoutput><textarea name="textarea" cols="40" rows="10">#HTMLCode#</textarea></cfoutput>
</p>
<p><center><a href = "admin.cfm?action=viewindex">Help Contents</a></center></p>
<p><center><a href = "admin.cfm?action=new">New Contents</a></center></p>







