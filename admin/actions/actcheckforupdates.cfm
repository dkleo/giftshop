<!---check cfshopkart.com for updates and, if there is one, downloads the zip file and uncompresses it to the updates folder to
be ran--->

<cftry>

<cfquery name = "qryVersion" datasource="#request.dsn#">
SELECT version,build from versioninfo
</cfquery>

<script language="javascript">
	document.getElementById('updatecheckdiv').innerHTML = 'Checking for updates...';
</script>

<cfhttp method="post" url="#request.supporturl#checkforupdate.cfm" result="chkupdate">
<cfhttpparam type="formfield" name="version" value="#qryVersion.version#">
<cfhttpparam type="formfield" name="build" value="#qryVersion.build#">
</cfhttp>

<cfset updatechk = chkupdate.filecontent>

<!---if update found then get file and newversion number--->
<cfif listlen(updatechk, "|") GT 1>
	
    <!---disable the menu so the update is not interrupted--->
    <cfoutput>
    <script language="javascript">
		parent.leftFrame.location.href = '#request.absolutepath#admin/updatemsg.cfm';
	</script>
    </cfoutput>

	<cfset isupdate = listgetat(updatechk, 1)>

			<script language="javascript">
               document.getElementById('updatecheckdiv').innerHTML = 'Update found, downloading and installing (DO NOT INTERUPT THIS PROCESS)...';
            </script>    

			<cfflush>

			<cfset updatefound = 'Yes'>	
            <cfset updatefile = trim(listgetat(updatechk, 3, "|"))>
            <cfset newversion = trim(listgetat(updatechk, 4, "|"))>
            <cfset newbuild = trim(listgetat(updatechk, 5, "|"))>
            <cfset updatefolder = trim(listgetat(updatechk, 6, "|"))>

        	<!---stream the zip file to the server--->
            <cfhttp url="#request.supporturl#updates/#updatefile#" getasbinary="yes" method="get" file="#updatefile#" path="#request.catalogpath#admin#request.bslash#updates"></cfhttp>

			<!---pause for a bit to give it a chance to download (download files sizes are not that big)--->
			<cfset sleep(5000)>
	        
            <!---now unzip the file we just downloaded--->
            <cfzip action="unzip" overwrite="yes" file="#request.catalogpath#admin#request.bslash#updates#request.bslash##updatefile#" recurse="yes" destination="#request.catalogpath#admin#request.bslash#updates#request.bslash#">
            </cfzip>
			
            <cfflush>    		
            <cfinclude template = "../updates/#updatefolder#/index.cfm">
            
			<script language="javascript">
                document.getElementById('updatecheckdiv').innerHTML = 'Update complete!';
            </script>    

			<!---restore the admin menu--->
			<cfoutput>
            <script language="javascript">
                parent.leftFrame.location.href = '#request.absolutepath#admin/navmenu/menu.cfm';
            </script>
            </cfoutput>

<cfelse>
<script language="javascript">
	document.getElementById('updatecheckdiv').innerHTML = '<font color="#006600"> Update check completed.  There are no updates available at this time.</font>';
</script>            
</cfif>

<cfcatch type="any">

<cfoutput>
<script language="javascript">
	parent.leftFrame.location.href = '#request.absolutepath#admin/navmenu/menu.cfm';
</script>
</cfoutput>

<script language="javascript">
	document.getElementById('updatecheckdiv').innerHTML = 'The update failed.  Nothing was changed, so you will remain at the current version.  To do a manual update, click on help.';
</script>            

The error was logged in your control panel.
<br />&nbsp;<br />

	<cfinclude template = "../errorprocess.cfm">

<cfabort>
</cfcatch>

</cftry>