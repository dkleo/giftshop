<cfdirectory action="list" directory="#request.catalogpath#admin#request.bslash#helpdocs#request.bslash#" name="qryHelp"><p><font size = "4">Help Topics</font> (<a href="admin.cfm?action=new">new topic</a>)</p>
<p>
<cfoutput query = "qryHelp"> 
  <a href = "admin.cfm?action=view&filename=#name#">#name#</a><br>
</cfoutput>








