<cfswitch expression="#url.action#">
	<cfcase value="selectimage">
		<cflocation url = "#request.homeurl#/admin/index.cfm?action=filebrowser.files.selectimage&template=blank&mytoken=NULL">
	</cfcase>
	<cfcase value="selectfile">
		<cflocation url = "#request.homeurl#/admin/index.cfm?action=filebrowser.files.selectfile&template=blank&mytoken=NULL">
	</cfcase>
	<cfcase value="selectflash">
		<cflocation url = "#request.homeurl#/admin/index.cfm?action=filebrowser.files.selectflash&template=blank&mytoken=NULL">
	</cfcase>
	<cfdefaultcase>
		<cflocation url = "#request.homeurl#/admin/index.cfm?action=filebrowser.files.selectimage&template=blank&mytoken=NULL">	
	</cfdefaultcase>
</cfswitch>





