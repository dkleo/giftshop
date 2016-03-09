<STYLE>
<!--
  .selecttr { background-color: #FFFFFF;}
  .initial { background-color: #000000; color:#000000;}
  .normal { background-color: #FFFFFF;}
  .highlight { background-color: #CCCCCC;}
  .delcheckbox {cursor: None;} 
//.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">
<cfparam name = "subscription" default = "0">
<cfparam name = "searchstring" default = "null">
<!--- Start displaying with record 1 if not specified via url --->

<!---Establish a start/end date to display in drop down etc.--->
<cfset todayDate = Now()>
<cfset StartYear = #DatePart("yyyy", todaydate)#>
<cfset EndYear = StartYear + 2>
<cfparam name = "SortOrder" default="ASC">
<cfparam name = "SortBy" default="LastName">

<!---QUERY THE DATABASE--->
<cfinclude template='../queries/qrycustomers.cfm'>
<cfinclude template = "../queries/qrysubscriptions.cfm">

    <table width="100%" border="0" cellpadding="4" cellspacing="0">
      <tr>
        <td colspan="9" align="left"><strong>Select a Customer To Add</strong></td>
      </tr>
      <tr>
        <td colspan="4" align="left">
        <cfoutput>
        <form name="searchform" method="post" action="index.cfm?action=addaccounts&subscription=#subscription#&start=#start#&disp=#disp#">
        <input name="SearchString" type="text" size="25">
        <input type="submit" name="Submit" value="Search">
		</form>
        </cfoutput>        </td>
        <td align="left">&nbsp;</td>
        <td align="left">
		<cfoutput> 
          <!---Display the page numbers--->
          <cfif disp LT qryCustomers.RecordCount + 1>         
			<form name = "PageSelect" method="Post" <cfoutput>action="index.cfm?action=addaccounts&subscription=#subscription#&disp=#disp#&searchstring=#searchstring#"</cfoutput>>
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryCustomers.RecordCount#" Step="#disp#">
				<a href = "doproducts.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
            </form>
          </cfif>
        </cfoutput></td>
        <td align="left"><form name="Displayoptions" method="POST" <cfoutput>action="index.cfm?action=addaccounts&subscription=#subscription#&searchstring=#searchstring#"</cfoutput>>
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
		</select>
	</form>    </td>
        <td colspan="2" align="left"><div align="right">
        <form method="post" <cfoutput>action="index.cfm?action=addaccounts&start=#start#&disp=#disp#&searchstring=#searchstring#"</cfoutput> name="changesubscription">
          <select name="subscription" id="subscription">
            <option <cfif subscription IS '0'>SELECTED</cfif> value="0">---Select Subscription---</option>
            <cfloop query = "qrySubscriptions">
              <cfoutput>
                <option <cfif subscription IS qrySubscriptions.r_id>SELECTED</cfif> value="#qrySubscriptions.r_id#">#r_name#</option>
              </cfoutput>
            </cfloop>
          </select> <input type="submit" name="button" id="button" value="View">
          </form>        
        </div></td>
      </tr>

      <tr bgcolor="#000000"> 
        <td width="12%" height="30" align="left"><b> <font color="#FFFFFF" size="1">Name</font></b></td>
        <td align="left"><b> <font color="#FFFFFF" size="1">Address</font></b></td>
        <td width="10%" align="left"><b> <font color="#FFFFFF" size="1">City</font></b> </td>
        <td width="7%" align="left"><b><font color="#FFFFFF" size="1">State</font></b></td>
        <td width="8%" align="left"><b> <font color="#FFFFFF" size="1">Zip</font></b></td>
        <td width="12%" align="left"> <b> <font color="#FFFFFF" size="1">Country</font></b></td>
        <td width="10%" align="left"><strong><font color="#FFFFFF" size="1">Email</font></strong></td>
        <td width="10%" align="left"><font color="#FFFFFF" size="1"><strong>Phone</strong></font></td>
        <td width="20%" align="left"><div align="center" class="style1"><font color="#FFFFFF" size="1"><strong>Expires In</strong></font></div></td>
      </tr>
	  <cfset rowcount = 0>

		  <!---Set up variables for paginating--->
		  <CFSET end=Start + disp>
		  <CFIF Start + disp GREATER THAN qryCustomers.RecordCount>
			<CFSET end=qryCustomers.RecordCount>
		  <CFELSE>
			<CFSET end=start + disp>
		  </CFIF>
		  
	  <cfset BlankAccountsList = "">
      <cfoutput>
	  <cfloop query ="qryCustomers" startRow="#Start#" endrow="#End#">
          <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
            <td height="25"><font size="1"><cfif NOT #LastName# IS '' AND NOT #FirstName# IS ''>#LastName# #FirstName#<cfelse>EDIT BLANK ACCT<cfset BlankAccountsList = BlankAccountsList & "^#CustomerID#"></cfif></font></td>
            <td><font size="1">#Address#</font></a></td>
            <td><font size="1">#City#</font></td>
            <td><font size="1">#State#</font></td>
            <td><font size="1">#Zipcode#</font></td>
			<td><font size="1">#Country#</font></td>
            <td><a href="mailto:#EmailAddress#"><font size="1">#EmailAddress#</font></a></td>
            <td><font size="1">#PhoneNumber#</font></td>
            <td><div align="center">
            <cfquery name = "qryCustSubscriptions" datasource="#request.dsn#">
            SELECT * FROM customers_subscriptions
            WHERE customerid = '#customerid#' AND r_id = '#subscription#'
            </cfquery>
            
            <cfif qryCustSubscriptions.recordcount IS 0>
            <form method = "post" action="index.cfm?action=addaccount&subscription=#subscription#&start=#start#&disp=#disp#&customerid=#customerid#&searchstring=#searchstring#">
            <select name = "r_expiresin">
                <option value="1 Week">1 Week</option>
                <option value="1 Month" selected="selected">1 Month</option>
                <option value="3 Months">3 Months</option>
                <option value="6 Months" >6 MOnths</option>
                <option value="1 Year" >1 Year</option>
                <option value="2 Years" >2 Years</option>
                <option value="Never" >Never</option>			    
            </select>
            <input type = "submit" value="Add" name="addcustomer" />
            </form>
            <cfelse>
            	<cfif NOT qryCustSubscriptions.status IS 'Expired'>
            	Already a Member
                <cfelse>
                <form method = "post" action="index.cfm?action=addaccount&subscription=#subscription#&start=#start#&disp=#disp#&customerid=#customerid#&searchstring=#searchstring#">
                <select name = "r_expiresin">
                    <option value="1 Week">1 Week</option>
                    <option value="1 Month" selected="selected">1 Month</option>
                    <option value="3 Months">3 Months</option>
                    <option value="6 Months" >6 MOnths</option>
                    <option value="1 Year" >1 Year</option>
                    <option value="2 Years" >2 Years</option>
                    <option value="Never" >Never</option>			    
                </select>
                <input type = "submit" value="Renew" name="addcustomer" />
                </form>                
                </cfif>
            </cfif>
</div></td>
          </tr>
        </cfloop>
	</cfoutput> 
  </table>
















