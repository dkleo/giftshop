<cfparam name = "viewtype" default="no">
<cfparam name = "disp" default="50">
<cfparam name = "start" default="1">

<cfinclude template = "../queries/qryreviews.cfm">

<cfset end = start + disp>
<cfif end GT qryReviews.recordcount>
	<cfset end = qryReviews.recordcount>
</cfif>

<script>
	function ExpandReview(Entity) {
		DTT_TableID = Entity;
		DTT_Table = document.getElementById(DTT_TableID);
		if(DTT_Table.style.display == "none") {
			DTT_Table.style.display = "block";		
		}
		else {
			DTT_Table.style.display = "none";
		}
	}
</script>	

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function checkAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}

function uncheckAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}
//  End -->
</script>

<h2>Approve Product Reviews</h2>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<form name="Displayoptions" method="POST" Action="index.cfm">
  <tr>
    <td colspan="2">
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="100" <cfif disp IS '250'>SELECTED</cfif>>Display 250</option>
		</select>
	    <input type="submit" name="Go3" value="Refresh">    </td>
	<td colspan="2"><cfoutput> 
          <!---Display the page numbers--->
          <cfif disp LT qryReviews.RecordCount + 1>
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryReviews.RecordCount#" Step="#disp#"><a href = "index.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
              <input type="submit" name="Go2" value="Refresh">
          </cfif>
        </cfoutput></td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td colspan="3"><div align="right">View: 
	  <select name="viewtype" id="viewtype">
	    <option value="No" <cfif viewtype IS 'no'>selected="selected"</cfif>>Only Unapproved Reviews</option>
	    <option value="Yes" <cfif viewtype IS 'yes'>selected="selected"</cfif>>Only Approved Reviews</option>
	    </select>
        <input type="submit" name="Go" value="Refresh">
    </div></td>
	</tr>
	</form>
  <tr>
    <td width="1%" bgcolor="#000000"><div align="center"><input type="checkbox" name="ApproveAll" value="Check All" onclick="if (this.checked){checkAll(document.myform.Approved)} else if(!this.checked){uncheckAll(document.myform.Approved)};"></div></td>
    <td width="15%" bgcolor="#000000"><span style="font-weight: bold; color: #FFFFFF">Date</span></td>
    <td width="20%" bgcolor="#000000"><span style="font-weight: bold; color: #FFFFFF">Item Name</span></td>
    <td width="15%" bgcolor="#000000"><span style="font-weight: bold; color: #FFFFFF">Reviewed By</span></td>
    <td width="5%" bgcolor="#000000"><div align="center" style="font-weight: bold; color: #FFFFFF">V</div></td>
    <td width="5%" bgcolor="#000000"><div align="center" style="font-weight: bold; color: #FFFFFF">F</div></td>
    <td width="5%" bgcolor="#000000"><div align="center" style="font-weight: bold; color: #FFFFFF">Q</div></td>
    <td width="5%" bgcolor="#000000"><div align="center" style="font-weight: bold; color: #FFFFFF">P</div></td>
    <td width="5%" bgcolor="#000000"><span style="font-weight: bold; color: #FFFFFF">Overall</span></td>
    <td bgcolor="#000000"><span style="color: #FFFFFF"></span></td>
  </tr>
<form method = "post" action="index.cfm" name="myform">
  <cfloop query = "qryReviews" startrow="#start#" endrow="#end#">
 
  <cfset trname = "DetailsSpan_#id#">
  
  <cfquery name = "qryProduct" datasource="#request.dsn#">
  SELECT productname FROM products
  WHERE itemid = #qryReviews.itemid#
  </cfquery>
  
  <cfoutput>
  <tr style="cursor: pointer;">
    <td><div align="center">
      <input type="checkbox" name="Approved" id="Approved" value="#id#">
    </div></td>
    <td onclick="javascript: ExpandReview('#trname#');">#dateformat(qryReviews.review_date, "mmm, dd, yyyy")#</td>
    <td onclick="javascript: ExpandReview('#trname#');">#qryProduct.ProductName#</td>
    <td onclick="javascript: ExpandReview('#trname#');">#qryReviews.reviewer#</td>
    <td onclick="javascript: ExpandReview('#trname#');"><div align="center">#qryReviews.value#</div></td>
    <td onclick="javascript: ExpandReview('#trname#');"><div align="center">#qryReviews.features#</div></td>
    <td onclick="javascript: ExpandReview('#trname#');"><div align="center">#qryReviews.quality#</div></td>
    <td onclick="javascript: ExpandReview('#trname#');"><div align="center">#qryReviews.performance#</div></td>
    <td onclick="javascript: ExpandReview('#trname#');"><div align="center">#qryReviews.rating#</div></td>
    <td><div align="center"><a href="index.cfm?action=read&id=#id#&start=#start#&disp=#disp#&viewtype=#viewtype#">Read Review</a></div></td>
  </tr>
  <tr>
    <td colspan="10">
    <span style="display:none;" <cfoutput>name="#trname#" id="#trname#"</cfoutput>>
    <table width = "100%" cellspacing="0" cellpadding="4">
    <tr>
	    <td>
    	#qryReviews.Details#
        </td>
    </tr>
    </table>
    </span>    </td>
  </tr>
  </cfoutput>
  </cfloop>
  <tr>
  <td colspan="10">
  <cfoutput>
  	<input type = "hidden" name="start" value="#start#" />
  	<input type = "hidden" name="disp" value="#disp#" />
  	<input type = "hidden" name="viewtype" value="#viewtype#" />
  </cfoutput>    
  <select name="action" id="action">
    <option value="default">---Select Action---</option>
    <option value="approve">Approve Selected</option>
    <option value="delete">Delete Selected</option>
    </select> <input type="submit" name="Updatebtn" value="Update Reviews">    </td>
  </tr>
  </form>
</table>
















