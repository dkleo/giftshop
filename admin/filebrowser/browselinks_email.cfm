<cfquery name = "qryComponents" datasource="#request.dsn#">
SELECT * FROM components
</cfquery>

<cfset request.homeurl = replace(request.homeurl, "/", "//")>

<cfparam name = "CKEditorFuncNum" default="1">

<cfoutput>
<SCRIPT language="javascript">

function getDoc(template,fileUrl )
{
	var myPath  = '#request.homeurl#'+template+'?Page=docs/'+fileUrl ;
	var funcNum = '#CKEditorFuncNum#' ;
	window.opener.CKEDITOR.tools.callFunction( funcNum, myPath )
	window.top.close() ;
	window.top.opener.focus() ;
}

function getDoc_alias(template,fileUrl )
{
	if(template == 'index.cfm') {
		var myPath  = '#request.homeurl#'+fileUrl ;
	}
	else {
		var myPath  = '#request.homeurl#'+template+'/'+fileUrl ;
	}
	
	var funcNum = '#CKEditorFuncNum#' ;
	window.opener.CKEDITOR.tools.callFunction( funcNum, myPath )
	window.top.close() ;
	window.top.opener.focus() ;
}

function getDoc2(template,fileUrl )
{
	var myPath  = '#request.homeurl#'+template+'?action=viewcategory&category='+fileUrl ;
	var funcNum = '#CKEditorFuncNum#' ;
	window.opener.CKEDITOR.tools.callFunction( funcNum, myPath ) ;
	window.top.close() ;
	window.top.opener.focus() ;
}

function getDoc3(template,fileUrl )
{
	var myPath  = '#request.homeurl#'+template+'?action='+fileUrl ;
	var funcNum = '#CKEditorFuncNum#' ;	
	window.opener.CKEDITOR.tools.callFunction( funcNum, myPath ) ;
	window.top.close() ;
	window.top.opener.focus() ;
}

</SCRIPT>
</cfoutput>
	</HEAD>
	<cfdirectory action="list" directory="#request.catalogpath#docs#request.bslash#" name="qryPages">
    <cfdirectory action="list" directory="#request.catalogpath#" name="qryTemplates">
	<BODY>
		<TABLE height="100%" cellspacing="5" cellpadding="0" width="100%" border="0">
			<TR>	
    <TD width="50%" align="middle" valign="top">
					<TABLE cellSpacing="1" cellPadding="1" width="80%" align="center" border="0" style="border: 1px solid #000000">
					<TR><TD bgcolor="#FFFFCC"><center>
					<form name="form1" action="Post">
					     <h2 align="left"><strong>Page to	Link:</strong></h2>
    <p>
					       <select name="PageURL" size="0">
					          <cfoutput query  = 'qryPages'>
                              <cfif type IS 'file'>
                              
							  <cfif request.use_urlrewrite IS 'Yes'>
								<cfset linkalias = replacenocase(qryPages.name, ".cfm", "", "ALL")>
                                <cfset linkalias = replacenocase(linkalias, ".htm", "", "ALL")>
                                <cfset linkalias = replacenocase(linkalias, ".html", "", "ALL")>
                                <cfset linkalias = replacenocase(linkalias, " ", "-", "ALL")>
                              <cfelse>
                              	<cfset linkalias = qryPages.name>
                              </cfif>
                              
					            <option value="#linkalias#">#name#</option>
                              </cfif>
			                  </cfoutput>
				           </select>
			             </p>
        				<p>
                        Load in frame?
                        <select name = "loadin">
                        	<option value = "" selected="selected">No</option>
                            <option value = "&lf=t">Yes</option>
                      </select>                        
                        <p>
                        Select a Template
                          <select name = "template">
                        <option value = "index.cfm" selected="selected">Main Template (index.cfm)</option>
                        <cfloop query = "qryTemplates">
                        	<cfif qryTemplates.type IS 'file'>
                            	<cfif qryTemplates.name CONTAINS 'index_' AND NOT qryTemplates.name IS 'index.cfm'>
			                        <option value = "#name#">#name#</option>
                                </cfif>
                            </cfif>
                        </cfloop>
                          </select>
                   		  <cfif request.use_urlrewrite IS 'Yes'>
                          	<input type="Button" Name="SelectPage" Value="Select" onClick="javascript:getDoc_alias(form.template.value,form.PageURL.value+form.loadin.value);">	
                          <cfelse>
                          	<input type="Button" Name="SelectPage" Value="Select" onClick="javascript:getDoc(form.template.value,form.PageURL.value+form.loadin.value);">
                          </cfif>
			          </form>
					  </center>
						</TD></TR>
					</TABLE>
					<p>
                    <TABLE cellSpacing="1" cellPadding="1" width="80%" align="center" border="0" style="border: 1px solid #000000">
					<TR><TD bgcolor="#CCCCFF"><center>
					<form name="form2" action="Post">
					     <h2 align="left">Category Link:</h2>
					     <p>
                        <select name="Category" size="0" id="Category" style="width: 200px;">
                        <option value = "0" selected="selected">Main Category</option>
                        <cf_CategoryTree Directory="/"
                        Datasource="#request.dsn#"
                        FirstIndent="#request.CategoryIndent#">
                        </select>
				      </p>
                         <p>
                        Load in frame?
                        <select name = "loadin2">
                        	<option value = "" selected="selected">No</option>
                            <option value = "&lf=t">Yes</option>
                      </select> 
   					  <p>Select a Template: 
                        <select name = "template2">
                        <option value = "index.cfm" selected="selected">Main Template (index.cfm)</option>
                        <cfloop query = "qryTemplates">
                        	<cfif qryTemplates.type IS 'file'>
                            	<cfif qryTemplates.name CONTAINS 'index_' AND NOT qryTemplates.name IS 'index.cfm'>
			                        <option value = "#name#">#name#</option>
                                </cfif>
                            </cfif>
                        </cfloop>
                        </select>
                           <input type="Button" Name="SelectPage2" Value="Select" onClick="javascript:getDoc2(form2.template2.value,form2.Category.value+form2.loadin2.value);">
			          </form>
					  </center>
						</TD></TR>
					</TABLE>
					<p>
                    <TABLE cellSpacing="1" cellPadding="1" width="80%" align="center" border="0" style="border: 1px solid #000000">
					<TR><TD bgcolor="#FFCCFF"><center>
					<form name="form3" action="Post">
					     <h2 align="left">Component Link:</h2>
					     <p>
                          <select name="component" id="component">
                            <cfoutput query = "qryComponents">
                              <option value = "#action#">#name#</option>
                            </cfoutput>
                          </select>
					     </p>
                         <p>
                        Load in frame?
                        <select name = "loadin3">
                        	<option value = "" selected="selected">No</option>
                            <option value = "&lf=t">Yes</option>
                      </select> 
   					  <p>Select a Template: 
                        <select name = "template3">
                        <option value = "index.cfm" selected="selected">Main Template (index.cfm)</option>
                        <cfloop query = "qryTemplates">
                        	<cfif qryTemplates.type IS 'file'>
                            	<cfif qryTemplates.name CONTAINS 'index_' AND NOT qryTemplates.name IS 'index.cfm'>
			                        <option value = "#name#">#name#</option>
                                </cfif>
                            </cfif>
                        </cfloop>
                        </select>
                        <input type="Button" Name="SelectPage3" Value="Select" onClick="javascript:getDoc3(form3.template3.value,form3.component.value+form3.loadin3.value);">
			          </form>
					  </center>
						</TD></TR>
					</TABLE>                    
                    </TD>
		  </TR>
		</TABLE>





