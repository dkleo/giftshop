<cfprocessingdirective suppresswhitespace="yes">
<cftry>

<!---load common file--->
<cfinclude template = "common.cfm">

<cfparam name="url.hwl" default="f">
<cfparam name="url.hwr" default="f">
<cfparam name = "action" default = "#request.defaultaction#">

<!---Load site header--->
<cfinclude template = "header.cfm">
<!---Start of outter table--->

<!---if the variable (for use with themes) is found for customlayout then load the custom layout for this theme--->
<cfif isdefined('request.customlayout')>

	<cfinclude template = "themes/#request.themetouse#/layout.cfm">

<!---use default layout this store--->
<cfelse>

<!---Start of outter table--->
<table cellspacing="0" cellpadding="0" <cfoutput>align="#request.Align_Container#"</cfoutput> class="container">
<tr>
<cfif request.BodyShadow IS 'On'><td class="shadowcell_left" background="images/defaults/leftshadow_dark.png" style="background-position: right;"><img src="images/defaults/spacer.gif" /></td></cfif>
<td valign="top" class="innercontainer">
	<!---Start of InnerOuterTable--->
	<table width="100%" cellpadding="0" cellspacing="0" align="center" class="innercontainer_table">
		<tr>
			<td valign="top" class="bodysection">
               <!---Start of InnerTable--->
				<table width="100%" cellspacing="0" cellpadding="0" class="bodysection_Table">
					<!---Header--->
                    <tr class="headersection">
                        <td class="headersection" valign="top"><cfinclude template = "loadheader.cfm"></td>
                  </tr>
                    <!---body--->
                  <tr>
                    <td class="navbar"><cfinclude template = "loadnavbar.cfm"></td>
                  </tr>
                    <!---Widgets and Body--->
                  <tr>
                    <td valign="top" class="sitebody">
                        <!---Widgets table--->
                        <table cellpadding="0" cellspacing="0" width="100%" class="sitebody_table">
                          <tr>
                             <!---url.hwi and url.hwl can be passed to hide the widget colums--->
							 <cfif NOT url.hwl IS 't'><cfif qryWidgetsLeft.recordcount GT 0><td class="widget_column" valign="top"><cfinclude template = "loadwidgetsleft.cfm"></td></cfif></cfif>
                             <td class="bodytable" valign="top"><cfinclude template = "switches.cfm"></td>
                             <cfif NOT url.hwr IS 't'><cfif qryWidgetsRight.recordcount GT 0><td class="widget_column" valign="top"><cfinclude template = "loadwidgetsright.cfm"></td></cfif></cfif>
                          </tr>
                        <!---End Widgets Table--->
                        </table>
                    </td>
                  </tr>
                  <!---Footer--->
                  <tr class="footersection">
                    <td class="footersection"><cfinclude template = "loadfooter.cfm"></td>
                  </tr>
                  <!---End of InnerTable--->
				</table>
			</td>
		</tr>
       <!---End of InnerOuterTable--->
    </table>
	</td>
<cfif request.BodyShadow IS 'On'><td class="shadowcell_right" background="images/defaults/rightshadow_dark.png" style="background-position: left;"><img src="images/defaults/spacer.gif" /></td></cfif>
	</tr>
</table>

</cfif>

<cfcatch type = "any">
	<cfinclude template = "errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>
</BODY>
</HTML>
</cfprocessingdirective>
