 
<script language='javascript'> 
window.moveTo(1,1);
</script>

<cfquery name="GetOptionCode" datasource="#request.dsn#">
SELECT *
FROM options
WHERE OptionID = #url.OptionID#
</cfquery>

<cfset TheHTMLCode = #GetOptionCode.htmlCode#>

<cfif GetOptionCode.FieldType IS 'TextArea'>
	<cfset TheHTMLCode = #Replace(GetOptionCode.htmlCode, "<", "&lt;", "ALL")#>
	<cfset TheHTMLCode = #Replace(TheHTMLCode, ">", "&gt;", "ALL")#>	 
</cfif>

<p>The HTML code for this option form field is shown in the box below. You can 
  copy and paste the HTML code into the details section of your product instead 
  of assigning it through the control panel, giving you greater flexibility over 
  the layout of your catalog.</p>
<p>
<cfoutput>
  <textarea name="textarea" cols="55" rows="12">#TheHTMLCode#</textarea>
</cfoutput>
</p>
<p align = "Center"><a href = "#" onclick="javascript:window.close();">Close Window</a></p>










