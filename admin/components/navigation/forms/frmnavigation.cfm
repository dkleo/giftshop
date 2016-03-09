<h2>Site Navigation</h2>

<cfif NOT request.navmenutype IS 'default' AND NOT request.navmenutype IS 'HTML'>
<cfparam name = "LastOrderValue" default="0">
<cfset nextlevel = level + 1>

<cfinclude template = "../queries/qrynavigation.cfm">
<cfinclude template = "../queries/qrynavstyle.cfm">

<!---Get the last OrderValue--->
<cfoutput query = "qryNavigation">
	<cfset LastOrderValue = #OrderValue# + 1>
</cfoutput>
<table width="100%" cellpadding="3" cellspacing="0"> 
  <tr>
    <td height="50" colspan="2" align="left">
    <table width="100%" align="center" cellpadding="6" cellspacing="0">  
  <tr>
    <td width="50%"><cfoutput><a href="index.cfm?action=newlink&amp;nView=#nView#&amp;ov=#LastOrderValue#&amp;mView=#mView#&amp;level=#level#">
     Insert Link</a> | <a href="index.cfm?action=ReOrder&amp;nView=#nView#&amp;mView=#mView#&amp;level=#level#">
     Reorder Links</a> | <a href="index.cfm?action=EditStyles&amp;nView=#nView#&amp;mView=#mView#&amp;level=#level#">Edit Menu Styles</a></cfoutput></td>
    <td align="right">	
	<cfif level IS 2>
	<cfoutput> <a href = "index.cfm?nView=0&mView=#mView#&pLinkID=0Level=1">Go Back To Top Level</a></cfoutput>
    </cfif>
    <cfif level IS 3>
    
    <cfquery name = "qryGetParent" datasource="#request.dsn#">
    SELECT * FROM nav_links
    WHERE id = #nview#
    </cfquery>
    
   	<cfset parentid = 0>
    <cfoutput query = "qryGetParent"><cfset parentid = #SubLinkOf#></cfoutput>
    
	<cfoutput><a href = "index.cfm?nView=#parentid#&mView=#mView#&pLinkID=#pLinkID#&level=2">Go Up One Level</a></cfoutput>
    </cfif>
</td>
  </tr>        
</table>
</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
    <tr bgcolor="#000066">
      <td width="25%" bgcolor="#003366"><span style="color: #FFFFFF"><strong>Link Title</strong></span> </td>
      <td bgcolor="#003366"><div align="left" style="color: #FFFFFF"><strong>Link URL</strong></div></td>
      <td width="8%" bgcolor="#003366"><div align="left" style="color: #FFFFFF">Type<strong></div></td>
      <td width="20%" bgcolor="#003366"><div align="center"></div></td>
    </tr>
    <cfloop query = "qryNavigation">
      <cfset ThisRelation = #SubLinkOf#>
      <tr valign="middle" <cfif qryNavigation.CurrentRow MOD 2>bgcolor="#CCCCCC"</cfif>>
        <td height="35" valign="middle"> 
          <cfoutput> 
	  	 <cfif linktype IS 'PageLink'>
		 <cfset thefilename = ListGetAt(filename, 1, "&")>
		 <cfset urlstring = '?action=editpagelink&nView=#nView#&id=#id#&mView=#mView#&level=#level#'>
		 #LinkTitle#
            </cfif>
	  	 <cfif linktype IS 'CustomLink'>
			<cfset urlstring = '?action=editCustomLink&nView=#nView#&id=#id#&mView=#mView#&level=#level#'>
			#LinkTitle#	
            </cfif>
	  	 <cfif linktype IS 'PluginLink'>
			<cfset urlstring = '?action=editPluginLink&nView=#nView#&id=#id#&mView=#mView#&level=#level#'>
			#LinkTitle#	
            </cfif>
	  	 <cfif linktype IS 'CategoryLink'>
			<cfset urlstring = '?action=editCategoryLink&nView=#nView#&id=#id#&mView=#mView#&level=#level#'>
			#LinkTitle#	
         </cfif>
		 <cfif UseSSL IS 'Yes'><img src = "../icons/lock_16.gif" alt="This link will use SSL">
		 </cfif>
	    </cfoutput>		 </td>
        <td valign="middle">
		<cfoutput>#linkurl#</cfoutput>        </td>
        <td valign="middle" nowrap="nowrap" align="center"><cfif linktype IS 'pagelink'>Site Link</cfif>
        <cfif linktype IS 'pluginlink'>Component</cfif><cfif linktype IS 'CategoryLink'>Category</cfif><cfif linktype is 'CustomLink'>Custom/Off Site</cfif></td>
        <td valign="middle" nowrap="nowrap" align="center"><cfoutput><a href = "index.cfm#urlstring#">Edit Link</a> | <a href="index.cfm?action=deletelink&amp;delid=#id#&amp;nView=#nView#&amp;mView=#mView#&amp;level=#level#">Remove Link</a> 
          <cfif request.navmenutype IS 'flash' OR request.navmenutype IS 'pulldown'><cfif level LT 3> | <a href = "index.cfm?nView=#id#&amp;mView=#mView#&amp;level=#nextlevel#">Edit Sub Menu</a></cfif>
        </cfif></cfoutput></td>
      </tr>
    </cfloop>
	<tr>
	<td colspan="4" align="left"></td>
	</tr>
</table>
</cfif>

<!---if the nav menu type is the default one then display a message letting them know--->

<cfif request.navmenutype IS 'default'>
	<center><strong>You are currently using the default navigation menu.  You cannot edit the default menu.  If you would like to edit your
    <br />navigation menu, click on Store Settings in the Setup Menu and change the Navigation Menu Type.
    </strong></center>
</cfif>

<!---if it's custom html then show the html editor--->
<cfif request.navmenutype IS 'HTML'>
	<cfif NOT fileexists('#request.catalogpath#docs#request.bslash#navigation.cfm')>
        <cffile action="write" file="#request.catalogpath#docs#request.bslash#navigation.cfm" output="">
    </cfif>

	<cffile action="read" file="#request.catalogpath#docs#request.bslash#navigation.cfm" variable="NavContent">

    <center>
    <cfoutput>
    <form method="POST" action="index.cfm?action=updatehtml">
	<textarea name = "NavContent" id = "NavContent" style="width: 100% height: 600px;">#NavContent#</textarea>
      <p align="center">
      <input type="submit" value="Update Navigation" name="B1"></p>
    </form>
    </cfoutput>
    </center>	

<cfoutput>
<script type="text/javascript">


	CKEDITOR.replace( 'NavContent',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'				
	});

</script>
</cfoutput>

</cfif>