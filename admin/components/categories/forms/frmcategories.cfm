<cfif NOT isdefined('session.ViewCat')>
<cflock scope="session" type="exclusive" timeout="10">
	<cfset Session.ViewCat = "Main Categories">
</cflock>
</cfif>

<cfif isdefined('form.CategoryView')>
<cflock scope="session" type="exclusive" timeout="10">
	<cfset Session.ViewCat = '#form.CategoryView#'>
</cflock>
</cfif>

<cfif isdefined('session.ViewCat')>
<cflock scope="session" type="exclusive" timeout="10">
	<cfset TempVar.ViewCat = "#Session.ViewCat#">
</cflock>
</cfif>

<cfset CurrentLevel = 0>
<cfinclude template = "../queries/qrycategories.cfm"> 
<cfinclude template = "../queries/qrysubscriptions.cfm">

<cfset nextordervalue = 1>
<cfoutput query = "qryCategories">
	<cfif isnumeric(OrderValue)><cfset nextordervalue = OrderValue + 1></cfif>
	
	
	
	
	
</cfoutput>

<h2>Categories</h2>
<table width="100%">
  <tr> 
    <td width="50%"> <form name="form1" method="post" action="index.cfm">
        New: 
        <input name="NewCategory" type="text" id="NewCategory" size="20">
        <input type="hidden" name = "Action" Value="Add">
		<cfoutput><input type="hidden" name = "NextOrderValue" value = "#nextordervalue#" /></cfoutput>
        <input type="submit" name="Submit" value="Add">
      </form></td>
    <td width="50%" align="right"> <form method="POST" action="index.cfm">
        <p> 
          <select size="1" name="CategoryView">
            <option Value="Main Categories" <cfif session.ViewCat IS 'Main Categories'>SELECTED</cfif>>Main 
            Categories</option>
            <option Value="All Categories" <cfif session.ViewCat IS 'All Categories'>SELECTED</cfif>>View 
            All</option>
            <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#TempVar.ViewCat#"
				Datasource="#request.dsn#"> 
          </select>
          <input type="submit" value="Go" name="B1">
      </form></td>
  </tr>
</table>
<form action="index.cfm" method="POST"  name="form4">
  <table width="100%" border="0" cellspacing="0" cellpadding="2">
    <cfoutput>
    <tr> 
      <td width="25%" height="30" bgcolor="##000000"><font color="##FFFFFF"><strong>Category Name <a href = "#request.AdminPath#helpdocs/category_name.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" align="absmiddle" /></b></a></strong></font></td>
      <td width="10%" bgcolor="##000000"><div align="center"><font color="##FFFFFF"><strong>Parent</strong></font> <a href = "#request.AdminPath#helpdocs/category_parent.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" align="absmiddle" /></b></a></div></td>
      <td width="10%" bgcolor="##000000"><div align="center"><font color="##FFFFFF"><strong>Layout</strong></font> <a href = "#request.AdminPath#helpdocs/category_layout.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" align="absmiddle" /></b></a></div></td>
      <td width="10%" bgcolor="##000000"><div align="center"><font color="##FFFFFF"><strong> 
          Image <a href = "#request.AdminPath#helpdocs/category_image.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" align="absmiddle" /></b></a></strong></font><br />
          <font color="##FFFFFF" size="1">(Not Actual Size)</font></div></td>
      <td width="10%" nowrap="nowrap" bgcolor="##000000"><div align="center"><strong><font color="##FFFFFF">Link Image</font></strong><br />
        <font color="##FFFFFF" size="1">(Not Actual Size)</font><font color="##FFFFFF"><strong><a href = "#request.AdminPath#helpdocs/category_link_image.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" align="absmiddle" /></b></a></strong></font></div></td>
      <td width="10%" nowrap="nowrap" bgcolor="##000000"><div align="center"><font color="##FFFFFF"><strong>Show Subs</strong></font> <a href = "#request.AdminPath#helpdocs/category_showsubs.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" align="absmiddle" /></b></a></div></td>
      <td width="1%" nowrap="nowrap" bgcolor="##000000"><div align="center">.<strong><font color="##FFFFFF">Permissions</font></strong> <a href = "#request.AdminPath#helpdocs/category_permissions.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" align="absmiddle" /></b></a></div></td>
      <td width="5%" bgcolor="##000000"><div align="center"><a href = "#request.AdminPath#helpdocs/category_actions.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;"><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></div></td>
    </tr>
    </cfoutput>
    <cfloop query = "qryCategories">
      <cfset ThisSubCategoryOf = #SubCategoryOf#>
      <tr valign="middle" <cfif qryCategories.CurrentRow MOD 2>bgcolor="#CCCCCC"</cfif>> 
        <td height="66" valign="middle"> 
          <cfoutput> 
            <input name="OldCategory" type="hidden" id="OldCategoy" value="#CategoryName#">
            <input name="CategoryName" type="text" id="CategoryName" value="#CategoryName#" size="40">
            <input type="Hidden" value = "#CategoryID#" Name = "CategoryID">
          </cfoutput></td>
        <td valign="middle"><div align="center"> 
            <cfquery name="FindSubCat" Datasource = "#Request.dsn#">
            Select * from categories WHERE CategoryID = #ThisSubCategoryOf#
            </cfquery><cfoutput>
            <cfif NOT FindSubCat.RecordCount IS 0>
              <a href="index.cfm?action=ChangeSubCategory&CategoryID=#CategoryID#"> 
              #FindSubCat.CategoryName#<font size="1"></font></a> 
              <cfelse>
              <a href="index.cfm?action=ChangeSubCategory&CategoryID=#CategoryID#"> 
              None<font size="1"></font></a>
            </cfif>
          </div></cfoutput>        </td>
        <td valign="middle"><cfoutput>
          <div align="center"> 
            <select name="CategoryLayout" id="CategoryLayout">
              <option value="1" <cfif #CategoryLayout# IS '1'>SELECTED</cfif>>Side-by-side</option>
              <option value="2" <cfif #CategoryLayout# IS '2'>SELECTED</cfif>>List w/Thums</option>
              <option value="3" <cfif #CategoryLayout# IS '3'>SELECTED</cfif>>List Basic</option>
            </select></cfoutput>
            </div></td>
        <td valign="middle">
        <div align="center">
		    <cfoutput> 
			<cfif NOT #CategoryImage# IS 'None'> 
                <a href="index.cfm?action=SetImage&CategoryID=#CategoryID#"> 
                <img src="#request.HomeURL#images/#CategoryImage#" width = "64" alt="#CategoryName#" title="#CategoryName#" 
                name="CatPic" border="0" <cfif NOT #CategoryRImage# IS 'None'>onmouseover="this.src='#request.HomeURL#images/#CategoryRImage#';" onmouseout="this.src='#request.homeURL#images/#CategoryImage#';"</cfif>></a><br>
                <a href="index.cfm?action=SetImage&CategoryID=#CategoryID#">Change</a> | <a href="index.cfm?Action=RemovePic&CategoryID=#CategoryID#">Remove<font size="1"></font></a></div>
		  </cfif> 
          <cfif #CategoryImage# IS 'None'>
            <a href="index.cfm?action=SetImage&CategoryID=#CategoryID#">Set 
            Image<font size="1"></font></a> 
		   </cfif>
		   </cfoutput> 
        </div>
        </td>
        <td valign="middle">
        <div align="center">
		    <cfoutput> 
			<cfif NOT #LinkImage# IS 'None'> 
                <a href="index.cfm?action=SetLinkImage&CategoryID=#CategoryID#"> 
                <img src="#request.HomeURL#images/#LinkImage#" width = "64" alt="#LinkImage#" title="#LinkImage#" 
                name="LinkImgPic" border="0" <cfif NOT #LinkRImage# IS 'None'>onmouseover="this.src='#request.HomeURL#images/#LinkRImage#';" onmouseout="this.src='#request.homeURL#images/#LinkImage#';"</cfif>></a><br>
                <a href="index.cfm?action=SetLinkImage&CategoryID=#CategoryID#">Change</a> | <a href="index.cfm?Action=RemoveLinkPic&CategoryID=#CategoryID#">Remove<font size="1"></font></a></div>
		  </cfif> 
          <cfif #LinkImage# IS 'None'>
            <a href="index.cfm?action=SetLinkImage&CategoryID=#CategoryID#">Set Image<font size="1"></font></a> 
		   </cfif>
		   </cfoutput> 
        </div>        
        </td>
        <td valign="middle"><div align="center">
          <select name="ShowSubCats" id="ShowSubCats">
            <option <cfif ShowSubCats IS 'Yes'>selected="selected"</cfif> value="Yes">Yes</option>
            <option <cfif ShowSubCats IS 'No'>selected="selected"</cfif> value="No">No</option>
          </select>
          </div></td>
        <td valign="middle"><div align="center"> 
            <select name="permissions" id="permissions">
              <option <cfif qryCategories.permissions IS '0'>SELECTED</cfif> value="0">Public</option>
              <cfloop query = "qrySubscriptions">
              	<cfoutput><option <cfif qryCategories.permissions IS qrySubscriptions.r_id>SELECTED</cfif> value="#qrySubscriptions.r_id#">#r_name#</option></cfoutput>
              </cfloop>
            </select>
          </div></td>
        <td valign="middle" nowrap="nowrap"><div align="center"> <cfoutput><a href="index.cfm?action=Delete&CategoryID=#CategoryID#"><img src="../../icons/delete.gif" alt="Delete" width="16" height="16" border="0"></a> &nbsp; <a href="index.cfm?action=EditDetails&CategoryID=#CategoryID#&categoryname=#categoryname#"><img src="../../icons/edit.gif" alt="Edit Description" width="16" height="16" border="0" /></a> 
        </cfoutput></div></td>
      </tr>
    </cfloop>
  </table>
  <div align="right"> 
    <input type="hidden" name="action" value="UpdateCategories">
    <input type="submit" name="Submit" value="Update Categories">
  </div>
</form>
<script language="javascript">
<!--
//--------------------------------------------------------------------------
  var tmp = document.form1.NewCategory; 
  if (tmp) {
  document.form1.NewCategory.focus()
  }
//--------------------------------------------------------------------------
// -->
</script>






















