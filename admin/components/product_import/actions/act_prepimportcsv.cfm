<!---Upload the csv file--->
<cffile action = "upload" filefield="csvfilefield" destination="#request.catalogpath#docs#request.bslash#"	nameconflict="Overwrite">

<cflocation url = "index.cfm?action=import_step_3&csvfile=#cffile.ServerFile#&importmethod=csv&hascolumns=#form.hascolumns#">















