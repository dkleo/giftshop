<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif len(trim(form.pagetitle)) IS 0>
	<div align="center"><h2>Error:  You must specify a page name.  Your page was not saved.  Hit your browsers back button to enter a title and then click the save buttong again</h2></div>
    <cfabort>
</cfif>

<cfset NewFileName = form.pagetitle>

<!---Replace all illgegal characters in the link title--->
<cfset NewFileName = replace(NewFileName, " ", "_", "ALL")>
<cfset NewFileName = replace(NewFileName, "'", "", "ALL")>
<cfset NewFileName = replace(NewFileName, '"', '', 'ALL')>
<cfset NewFileName = replace(NewFileName, "*", "", "ALL")>
<cfset NewFileName = replace(NewFileName, "&", "", "ALL")>
<cfset NewFileName = replace(NewFileName, "(", "", "ALL")>
<cfset NewFileName = replace(NewFileName, ")", "", "ALL")>
<cfset NewFileName = replace(NewFileName, ";", "", "ALL")>
<cfset NewFileName = replace(NewFileName, ":", "", "ALL")>
<cfset NewFileName = replace(NewFileName, "!", "", "ALL")>

<cfset NewFileWithExt = NewFileName & '.cfm'>

<!---the following code ensures that the filename is unique each time--->
<cfset wasfound = true>
<cfset filenumber = 0>
<cfloop condition="wasfound IS true">

	<cfif fileexists('#request.CatalogPath#docs#request.bslash##NewFileWithExt#')>
    	<cfset filenumber = filenumber + 1>
        <cfset NewFileWithExt = "#NewFileName##filenumber#.cfm"> 
		<cfset wasfound = True>
    <cfelse>
    	<cfset wasfound = false>
	</cfif>
    
</cfloop>

<cfset NewFileName = NewFileWithExt>
<cfset NewFileName = lcase(NewFileName)>

<cfset thenewpage = form.NewPage>

<CFFILE action = "Write" file = "#request.CatalogPath##request.bslash#docs#request.bslash##NewFileName#" mode="777" Output = "#theNewPage#" nameconflict="makeunique">

<cfset linkalias = replacenocase(NewFileName, ".cfm", "", "ALL")>
<cfset linkalias = replacenocase(linkalias, ".htm", "", "ALL")>
<cfset linkalias = replacenocase(linkalias, ".html", "", "ALL")>
<cfset linkalias = replacenocase(linkalias, " ", "-", "ALL")>

<cfset newline = 'ReWriteRule ^#linkalias#$ index.cfm?page=#newfilename# '>
<cffile action = "append" file="#request.catalogpath#.htaccess" output="#newline#" addnewline="yes" mode="777">

<cflocation url = "dopages.cfm">