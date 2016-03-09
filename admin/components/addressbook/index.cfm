<!---This is the header for the address book-- this will appear on all pages--->
<cfparam name = "action" default="">

<table border="0" cellpadding="2" width="100%">
  <tr> 
    <td width="46%" valign="top"> <h2 Align="left">Suppliers </h2>
      <div align="left"><font face="Verdana" size="2"><b><a href="index.cfm?Action=View&AlphaIndex=A">A</a> 
        <a href="index.cfm?Action=View&AlphaIndex=B"> B</a> <a href="index.cfm?Action=View&AlphaIndex=C"> 
        C</a> <a href="index.cfm?Action=View&AlphaIndex=D"> D</a> <a href="index.cfm?Action=View&AlphaIndex=E"> 
        E</a>&nbsp;<a href="index.cfm?Action=View&AlphaIndex=F">F</a> 
        <a href="index.cfm?Action=View&AlphaIndex=G"> G</a> <a href="index.cfm?Action=View&AlphaIndex=H"> 
        H</a> <a href="index.cfm?Action=View&AlphaIndex=I"> I</a> <a href="index.cfm?Action=View&AlphaIndex=J"> 
        J</a> <a href="index.cfm?Action=View&AlphaIndex=K"> K</a><a href="index.cfm?Action=View&AlphaIndex=L"> L</a> 
		<a href="index.cfm?Action=View&AlphaIndex=M"> 
        M</a> <a href="index.cfm?Action=View&AlphaIndex=N"> N</a> <a href="index.cfm?Action=View&AlphaIndex=O"> 
        O</a> <a href="index.cfm?Action=View&AlphaIndex=P"> P</a> <a href="index.cfm?Action=View&AlphaIndex=Q"> 
        Q</a> <a href="index.cfm?Action=View&AlphaIndex=R"> R</a> <a href="index.cfm?Action=View&AlphaIndex=S"> 
        S</a> <a href="index.cfm?Action=View&AlphaIndex=T"> T</a> <a href="index.cfm?Action=View&AlphaIndex=U"> 
        U</a> <a href="index.cfm?Action=View&AlphaIndex=V"> V</a> <a href="index.cfm?Action=View&AlphaIndex=W"> 
        W</a> <a href="index.cfm?Action=View&AlphaIndex=X"> X</a> <a href="index.cfm?Action=View&AlphaIndex=Y"> 
        Y</a> <a href="index.cfm?Action=View&AlphaIndex=Z"> Z</a></b></font> 
      </div>
      <p> 
        <cfinclude template = "forms/frmsearch.cfm">
      </p></td>
    <td width="10%" valign="top"><div align="right"></div></td>
    <td width="10%" valign="top">&nbsp;</td>
    <td width="10%" valign="top">&nbsp;</td>
    <td width="10%" valign="top"><cfoutput><div align="center"></div>
    </cfoutput></td>
  </tr>
  <tr> 
    <td width="93%" colspan="5" valign="top"> 
	<cfswitch expression="#action#">
    	<cfcase value="view">
        	<cfinclude template = "actions/actview.cfm">
        </cfcase>
    	<cfcase value="new">
        	<cfinclude template = "actions/actView.cfm">
        </cfcase>
    	<cfcase value="edit">
        	<cfinclude template = "actions/actView.cfm">
        </cfcase>
    	<cfcase value="delete">
        	<cfinclude template = "actions/actView.cfm">
        </cfcase>
    	<cfcase value="search">
        	<cfinclude template = "actions/actfind.cfm">
        </cfcase>
    	<cfcase value="update">
        	<cfinclude template = "actions/actupdate.cfm">
        </cfcase>
    	<cfcase value="add">
        	<cfinclude template = "actions/actadd.cfm">
        </cfcase>
    </cfswitch>
 </td>
  </tr>
</table>










