<style type="text/css">
TABLE.colorChooser { background-color: buttonface; border:0px none; }
.colorChooser TD { border: 1px #000000 solid; cursor: pointer;}
.colorChooserLabel TD { width:6px height:12px; border: 0px none;
	font-family: "MS Sans Serif"; font-size: xx-small; vertical-align: middle
}
TD.colorNone { font-family: "MS Sans Serif"; font-size: xx-small; vertical-align: middle; 
				text-align: center; border: 1px outset buttonface!important; }
</style>

<body topmargin="0" leftmargin="0" style="border: 0px none; margin: 0" onLoad="initialise();">

<script language="JavaScript">

<cfoutput>
function put_back(colorselected){
callerform='#url.form#';
callerfield='#url.field#';
window.opener.document.forms[callerform].elements[callerfield].value = colorselected;
self.close();
}
</cfoutput>
</script>

<table width="100%" class="colorChooser" cellpadding="0" cellspacing="0">
<tr id="main" class="colorChooserLabel"> 
    <td colspan="18">Standard Colors</td>
  </tr>
<tr>
    <td width="12" height="12" bgcolor="#000000" title="#000000" onclick = "put_back('#000000');"><img border="0" src="spacer.gif" width="12" height="12" alt="Black"></td>
    <td width="12" height="12"  bgcolor="#333333" title="#333333" onclick = "put_back('#333333');"><img border="0" src="spacer.gif" width="12" height="12" alt="Dk Grey"></td>
    <td width="12" height="12"  bgcolor="#666666" title="#666666" onclick = "put_back('#666666');"><img border="0" src="spacer.gif" width="12" height="12" alt="Grey"></td>
    <td width="12" height="12"  bgcolor="#999999" title="#999999" onclick = "put_back('#999999');"><img border="0" src="spacer.gif" width="12" height="12" alt="Lt Grey"></td>
    <td width="12" height="12"  bgcolor="#CCCCCC" title="#CCCCCC" onclick = "put_back('#CCCCCC');"><img border="0" src="spacer.gif" width="12" height="12" alt="Silver"></td>
    <td width="12" height="12"  bgcolor="#FFFFFF" title="#FFFFFF" onclick = "put_back('#FFFFFF');"><img border="0" src="spacer.gif" width="12" height="12" alt="White"></td>
    <td width="12" height="12"  bgcolor="#FF0000" title="#FF0000" onclick = "put_back('#FF0000');"><img border="0" src="spacer.gif" width="12" height="12" alt="Red"></td>
    <td width="12" height="12"  bgcolor="#00FF00" title="#00FF00" onclick = "put_back('#00FF00');"><img border="0" src="spacer.gif" width="12" height="12" alt="Green"></td>
    <td width="12" height="12"  bgcolor="#0000FF" title="#0000FF" onclick = "put_back('#0000FF');"><img border="0" src="spacer.gif" width="12" height="12" alt="Blue"></td>
    <td width="12" height="12"  bgcolor="#FFFF00" title="#FFFF00" onclick = "put_back('#FFFF00');"><img border="0" src="spacer.gif" width="12" height="12" alt="Yellow"></td>
    <td width="12" height="12"  bgcolor="#00FFFF" title="#00FFFF" onclick = "put_back('#00FFFF');"><img border="0" src="spacer.gif" width="12" height="12" alt="Purple"></td>
    <td width="12" height="12"  bgcolor="#FF00FF" title="#FF00FF" onclick = "put_back('#FF00FF');"><img border="0" src="spacer.gif" width="12" height="12" alt="Purple"></td>
    <td colspan="6" rowspan="2" class="colorNone"></td>
</tr>
<tr class="colorChooserLabel">
<td colspan="18">Web Safe</td></tr>
<tr>
<script language=JavaScript>

				d = new Array();
				d[1] = "00";
				d[2] = "33";
				d[3] = "66";
				d[4] = "99";
				d[5] = "CC";
				d[6] = "FF";				
				
								
				for (c=1;c<=6;c++){
										
					for (a=1;a<=3;a++){					
							
						for (b=1;b<=6;b++){							
							
							colour = d[a] + d[b] + d[c];
							
							 document.write("<td width='12' height='12' onclick=#request.bslash#"put_back('#"+colour+"')#request.bslash#" bgcolor=#request.bslash#"#"+colour+"#request.bslash#" title=#request.bslash#"#"+colour+"#request.bslash#"><img border='0' src=#request.bslash#"spacer.gif#request.bslash#" width=12 height=12></td>\n");
						    if (a==3 && b==6){
							document.write("</tr>\n<tr>\n");
							}
					
						}
					}
				}				
					for (c=1;c<=6;c++){
										
					for (a=4;a<=6;a++){					
							
						for (b=1;b<=6;b++){							
							
							colour = d[a] + d[b] + d[c];
							
							 document.write("<td width='12' height='12' bgcolor=\"#"+colour+"\" onclick=\"put_back('#"+colour+"')\" title=\"#"+colour+"\"><img border='0' src=\"spacer.gif\" width=12 height=12></a></td>\n");
						    if (a==6 && b==6){
							document.write("</tr>\n<tr>\n");
							}
					
						}
					}
				}
					
				</script>
			
				
</tr>
<tr><td colspan="18" class="colorNone" title="None" align="right"><a href="javascript:self.close()">Close</a></td></tr>
</table>
</body>

<script language="Javascript">
</script>

</html>







