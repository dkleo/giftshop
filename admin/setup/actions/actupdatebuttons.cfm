<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qryCurrentButtons" datasource="#Request.dsn#">
SELECT * FROM custom_buttons
</cfquery>

<cfloop query = "qryCurrentButtons">

	<cfset formname = 'form.#button_name#'>
    <cfset buttonval = evaluate(formname)>
    
    <!---if replacing upload to server and update with image name--->
    <cfif len(trim(buttonval)) GT 0>
        <!---delete old--->
        <cfif fileexists('#request.catalogpath#images#request.bslash#buttons#request.bslash##qryCurrentButtons.image_file#')>
            <cffile action = "delete" file="#request.catalogpath#images#request.bslash#buttons#request.bslash##qryCurrentButtons.image_file#">
        </cfif>
        
        <CFFILE Action="Upload"
        FileField = "#formname#"
        Destination = "#request.CatalogPath##request.bslash#images#request.bslash#buttons"
        NameConflict = "overwrite"
        Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg, image/png">
        
        <cfquery name = "qrySetButton" datasource="#request.dsn#">
        UPDATE custom_buttons
        SET image_file = '#cffile.serverfile#'
        WHERE button_name = '#qryCurrentButtons.button_name#'
        </cfquery>
    </cfif>	
</cfloop>

<cfset funcpath = replace(request.absolutepath, "/", "", "ALL")>
<cfif NO len(funcpath) IS 0>
	<cfset funcpath = "#funcpath#.">
</cfif>

<cfinvoke component="#funcpath#admin.functions.dumpsettings" method="WriteSettings" returnvariable="outputmsg">
	<cfinvokeargument name="cfdsn" value="#request.dsn#">
	<cfinvokeargument name="path" value="#request.catalogpath#">
</cfinvoke>
<!---Go back--->
<center><h3>The new buttons have been uploaded</h3></center>







