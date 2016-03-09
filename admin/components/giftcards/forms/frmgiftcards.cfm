<cfparam name="showtype" default="active">

<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">

<cfif ISDEFINED('session.disp')>
	<cflock scope="Session" type="Exclusive" timeout="10">
		<cfset disp = '#session.disp#'>
	</cflock>
</cfif>

<cfif ISDEFINED('form.disp')>
		<cfset disp = '#form.disp#'>
</cfif>

<!---Store the start variable in a session so that the last viewed page can always be called---> 
<cfif ISDEFINED('url.start')>
<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.start= '#url.start#'>
</cflock>
</cfif>

<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.disp = '#disp#'>
</cflock>

<cfif ISDEFINED('form.start')>
<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.start= '#form.start#'>
</cflock>
</cfif>

<cfif ISDEFINED('session.start')>
<cflock scope="Session" type="ReadOnly" timeout="10">
   <cfset start = '#session.start#'>
</cflock>
</cfif>

<cfif NOT ISDEFINED('url.start') AND NOT ISDEFINED('session.start')>
<cflock scope="Session" type="Exclusive" timeout="10">
   <cfset session.start= '#start#'>
</cflock>
</cfif>

<cfinclude template = "../queries/qrygiftcards.cfm">

  <!---Set up variables for paginating--->
  <CFSET end=Start + disp>
<CFIF Start + disp GREATER THAN qryGiftCards.RecordCount>
    <CFSET end=999>
    <CFELSE>
    <CFSET end=Start + disp - 1>
</CFIF>

<h2>Active Gift Certificates</h2>

<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td bgcolor="#FFFFFF"><form id="form1" name="form1" method="post" action="dogiftcards.cfm?action=default">
  <select name="showtype">
    <option value="active" <cfif showtype IS 'active'>SELECTED</cfif>>Currently Active</option>
    <option value="depleted" <cfif showtype IS 'depleted'>SELECTED</cfif>>All Depleted</option>
  </select>
  <input type="submit" name="Submit" value="View" />
</form></td>
    <td colspan="2" align="center" bgcolor="#FFFFFF"><cfoutput> 
          <!---Display the page numbers--->
            <form name = "PageSelect" method="Post" Action="doGiftCards.cfm">
			<cfif disp LT qryGiftCards.RecordCount + 1>
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryGiftCards.RecordCount#" Step="#disp#"><a href = "doGiftCards.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
			</cfif>
        </cfoutput>
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="100" <cfif disp IS '9999999'>SELECTED</cfif>>Display All</option>
		</select>
	</form>		</td>
    <td colspan="2" align="center" bgcolor="#FFFFFF">
	<form name="form1" method="post" action="doGiftCards.cfm">
        <div align="right"> 
          <input type="text" name="SearchQuery">
          <input type="submit" name="Submit" value="Lookup">
        </div>
      </form>	</td>
  </tr>
  <tr>
    <td width="25%" bgcolor="#000000"><span style="color: #FFFFFF; font-weight: bold">Number</span></td>
    <td width="15%" bgcolor="#000000"><span style="color: #FFFFFF; font-weight: bold">Order Number </span></td>
    <td width="10%" align="center" bgcolor="#000000"><span style="color: #FFFFFF; font-weight: bold">Amount</span></td>
    <td width="10%" align="center" bgcolor="#000000"><span style="color: #FFFFFF; font-weight: bold">Balance</span></td>
    <td width="15%" align="right" bgcolor="#000000"><span style="color: #FFFFFF; font-weight: bold">Last Used </span></td>
    <td width="5%" align="right" bgcolor="#000000"><div align="center"><span style="color: #FFFFFF; font-weight: bold">Activated</span></div></td>
  </tr>
<form method="post" action="doGiftCards.cfm?action=UpdateGiftCards" name="GiftCardForm">
<cfoutput query = "qryGiftCards" startrow="#start#" maxrows="#end#">
  <tr>
    <td>#gNumber#</td>
    <td><a href="doGiftCards.cfm?action=vieworder&OrderNumber=#OrderID#&CustomerID=#CustomerID#">#OrderID#</a></td>
    <td align="center">$#numberformat(gAmount, "0.00")#</td>
    <td align="center">$#numberformat(gAmountLeft, "0.00")#</td>
    <td align="right">#LastModified#</td>
    <td align="center">
    <select name = "activated">
    <option value = "Yes" <cfif activated IS 'Yes'>SELECTED</cfif>>Yes</option>
    <option value = "No" <cfif activated IS 'No'>SELECTED</cfif>>No</option>
    </select>
    <input type="hidden" name="id" value="#id#" />    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="center"><input type = "submit" name="submitbutton" value="Update" /></td>
  </tr>
</cfoutput>
	</form>
</table>




















