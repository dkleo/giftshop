<!---Imports the image file names from a comma delimited list--->

<cfinclude template = "../queries/qry_checktoken.cfm">

<cfoutput query = "qry_checktoken">
	<cfset theusername = '#username#'>
</cfoutput>

<cfset TodaysDate = now()>
<cfset TheDate = Dateformat(TodaysDate, "mm/dd/yyyy")>
<cfset TheTime = TimeFormat(TodaysDate, "hh:mm tt")>

<cfset datetimestamp = '#TheDate# #TheTime#'>

<cfloop from = "1" to="#ListLen(form.csvimport)#" index="iCount">
	<cfset ThisFile = ListGetAt(form.csvimport, iCount)>
	
			<cfquery name = "qry_InsertFile" datasource="#request.dsn#">
			INSERT INTO user_files
			(name, folder, username, filetype, datelastmodified, size, actualfolder)
			VALUES
			('#ThisFile#', '/images', '#theusername#', 'image', 
			#CreateODBCdatetime(datetimestamp)#, '0', 'images/')
			</cfquery>
</cfloop>

<center>Import process completed!</center>



















