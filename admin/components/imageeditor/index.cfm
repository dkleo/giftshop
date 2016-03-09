<cftry>
<cfparam name = "action" default="default">

<cfif NOT directoryexists('#request.catalogpath#temp')>
	<cfdirectory action="create" directory="#request.catalogpath#temp#request.bslash#" mode="777">
</cfif>
<cfif not isdefined('cookie.current_step')>
	<cfcookie name="current_step" value="1">
</cfif>

<!---get temp image count--->
<cfdirectory name="imgcount" action="list" directory="#request.catalogpath#temp#request.bslash#">

<!---to keep track of undo we need to set some variables to track changes to the image--->
<cfset nextcount = cookie.current_step + 1>
<cfset lastcount = cookie.current_step>

<cfset nextcount = '#nextcount#_'>
<cfset lastcount = '#lastcount#_'>

<cfset undo_enabled = 'Yes'>
<cfif imgcount.recordcount LT 2>
	<cfset undo_enabled = 'No'>
</cfif>

<cfinclude template = "header.cfm">
<cfswitch expression="#action#">
	<cfcase value="default">
    	<cfinclude template = "forms/frmimageeditor.cfm">
    </cfcase>
	<cfcase value="crop">
    	<cfinclude template = "actions/actcrop.cfm">
    </cfcase>
	<cfcase value="resize">
    	<cfinclude template = "actions/actresize.cfm">
    </cfcase>
	<cfcase value="shadow">
    	<cfinclude template = "actions/actapplydropshadow.cfm">
    </cfcase>
	<cfcase value="plastic">
    	<cfinclude template = "actions/actapplyplastic.cfm">
    </cfcase>
	<cfcase value="reflection">
    	<cfinclude template = "actions/actapplyreflection.cfm">
    </cfcase>
	<cfcase value="roundedcorners">
    	<cfinclude template = "actions/actapplyroundedcorner.cfm">
    </cfcase>            
	<cfcase value="sepia">
    	<cfinclude template = "actions/actapplysepia.cfm">
    </cfcase> 
	<cfcase value="brighten">
    	<cfinclude template = "actions/actbrighten.cfm">
    </cfcase> 
	<cfcase value="darken">
    	<cfinclude template = "actions/actdarken.cfm">
    </cfcase> 
	<cfcase value="undo">
    	<cfinclude template = "actions/actundo.cfm">
    </cfcase> 
	<cfcase value="applyBorder">
    	<cfinclude template = "actions/actapplyborder.cfm">
    </cfcase> 
	<cfcase value="greyScale">
    	<cfinclude template = "actions/actgreyscale.cfm">
    </cfcase> 
	<cfcase value="save">
    	<cfinclude template = "actions/actsave.cfm">
    </cfcase> 
	<cfcase value="saveas">
    	<cfinclude template = "actions/actsaveas.cfm">
    </cfcase> 
</cfswitch>
<cfinclude template = "footer.cfm">

<cfcatch type = "any">
<cfinclude template = "../../errorprocess.cfm">
<cfabort>
</cfcatch>

</cftry>
