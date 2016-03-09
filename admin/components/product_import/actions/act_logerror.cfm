<!---Log error message--->
<cfset carttoken="NULL_adminerror">
<cfset errorbrief="Not Specified.">
<cfset fullerror="No error report could be generated.">

<cfsavecontent variable="extradetail">
<cfoutput>
<style>
td,th{font:11px verdana;}
th{text-align:left;font-weight:bold;background-color:##EEE;}
th,td{vertical-align:top;}
</style>
<h4>Error Report</h4>
<table cellpadding="5" cellspacing="1" border="0" width="100%">
	<tr>
		<th>Date:</th>
		<td>#dateFormat(now(),"m/d/yy")# #timeFormat(now(),"h:mm tt")#</td>
	</tr>
	<tr>
		<th>URL:</th>
		<td><cfset theURL = replace(GetDirectoryFromPath("http://"&cgi.server_name& cgi.path_info),"#request.bslash#","")>
			<cfset theURL = theURL & cgi.script_name>
			<cfif Len(CGI.query_string)>
				<cfset theURL = theURL & "?" & CGI.query_string>
			</cfif>
			<cfset theURL = replace(theURL,"//","/","ALL")>
			<a href="#theURL#">#theURL#</a>
		</td>
	</tr>
	<tr>
		<th>Visitor IP:</th>
		<td>#cgi.REMOTE_ADDR#
	  </td>
	</tr>    
	<tr>
		<th>Browser:</th>
		<td>#cgi.HTTP_USER_AGENT#
	  </td>
	</tr>   
	<tr>
		<th>Application:</th>
		<td><cfif isdefined('application.applicationname')>#Application.applicationname#</cfif></td>
	</tr>
	<cfset infoList = "Message,Type,Browser,Httpreferer,Rootcause,Tagcontext">
	<cfloop list="#infoList#" index="errorItem">
		<cfif StructKeyExists(cfcatch,errorItem)>
		<tr>
			<th>#errorItem#:</th>
			<td><cfdump var="#cfcatch[errorItem]#"></td>
		</tr>
        
        <cfif errorItem IS 'Message'>
        	<cfset errorbrief = "PRODUCT IMPORT ERROR: #replace(cfcatch.message, '#request.bslash#', '#request.bslash##request.bslash#', 'ALL')#  Error Occurred on line #cfcatch.Tagcontext[1].LINE# in #replace(cfcatch.Tagcontext[1].template, '#request.bslash#', '#request.bslash##request.bslash#', 'ALL')# #extrainfo#">
		</cfif>      
        
		</cfif>
	</cfloop>
    
    <tr>
    	<th>Token:</th>
        <td><cfif isdefined('carttoken')>#carttoken#</cfif></td>    
</table>
</cfoutput>
</cfsavecontent>

<cfset extradetail = replacenocase(extradetail, "#request.bslash#", "#request.bslash##request.bslash#", "ALL")>
<cfset fullerror = '#extradetail#'>

<cfquery name = "qryLogError" datasource="#request.dsn#">
INSERT INTO errorlog
(errordetail, errordate, brief)
VALUES
('#fullerror#', #createodbcdatetime(now())#, '#errorbrief#')
</cfquery>
















