<CFFILE	Action="Upload"
FileField = "FileData"
Destination = "#request.downloadspath#"
NameConflict = "overwrite">
				
<cfset filename = "#cffile.ServerFile#">
<cfset filesize = "#cffile.FileSize#">

<cfquery name = "qryInsertFile" datasource="#request.dsn#">
INSERT INTO product_files
(filename, filesize, allowedDls, timesdownloaded, itemid)
VALUES
('#filename#','#filesize#',7,0,'#url.itemid#')
</cfquery>















