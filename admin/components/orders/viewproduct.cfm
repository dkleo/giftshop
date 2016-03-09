<cfinclude template = "queries/qrycompanyinfo.cfm">

<cfquery name = "FindProduct" Datasource = "#Request.dsn#">
SELECT * FROM products
WHERE ItemID = #url.ID#
</cfquery>

<cfoutput query = "FindProduct">
<center>
  <b><font size="2" face="Verdana, Arial, Helvetica, sans-serif">#ProductName#</font></b>
</center>
<p>
<center><img src="#request.PhotoPath#/#ImageURL#"></a></center></p>
<p>
</cfoutput>
<center>
    <a href="javascript:window.close()"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Close 
    Window</font></a>
</center>










