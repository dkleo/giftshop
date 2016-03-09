<cfparam name = "CKEditorFuncNum" default="1">

<cfoutput>
  <SCRIPT language="javascript">


function getDoc( fileUrl )
{
	var myPath  = '#request.absolutepath#media/'+fileUrl ;
	var myFunc = '#CKEditorFuncNum#';
	window.opener.CKEDITOR.tools.callFunction( myFunc, myPath )
	window.top.close() ;
	window.top.opener.focus() ;
}
</SCRIPT>
</cfoutput>
</HEAD>
<cfdirectory action="list" directory="#request.catalogpath#media#request.bslash#" name="qryPages">
<cfset flashcount = 0>
<cfloop query = "qryPages">
  <cfif right(name, 4) IS '.swf'>
    <cfset flashcount = flashcount + 1>
  </cfif>
</cfloop>
<BODY>
<TABLE height="100%" cellspacing="5" cellpadding="0" width="100%" border="0">
<TR>
<TD width="50%" align="middle" valign="top">
    <TABLE cellSpacing="1" cellPadding="1" width="80%" align="center" border="0">
    <TR>
    <TD>
        <center>
        <cfif flashcount GT 0>
        <form name="form1" action="Post">
          <p>Select a Flash File:</p>
          <p>
            <select name="PageURL" size="10">
              <cfoutput query  = 'qryPages'>
                <cfif right(name, 4) IS '.swf'>
                <option value="#name#">#name#</option>
                </cfif>
              </cfoutput>
            </select>
          </p>
          <p>
            <input type="Button" Name="SelectPage" Value="Select" onClick="javascript:getDoc(form1.PageURL.value);">
		  </p>
        </form>
       </center>
	   <cfelse>
       	 You do not have any flash files uploaded to your media folder.
	   </cfif>
    </TD>
    </TR>
    </TABLE>
</TD>
</TR>
</TABLE>






