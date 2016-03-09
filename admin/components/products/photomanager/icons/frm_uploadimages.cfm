<h2>Multiple Image Upload</h2>
<br>
<STYLE>
<!--
  .selecttr { background-color: #FFFFFF; cursor: pointer;}
  .initial { background-color: #000000; color:#000000; cursor: pointer; }
  .normal { background-color: #FFFFFF; cursor: pointer; }
  .highlight { background-color: #CCCCCC; cursor: pointer; }
  .delcheckbox {cursor: None;} 
//-->
</style>
<cfparam name = "start" default="1">
<cfparam name = "disp" default="15">
<cfparam name = "end" default="999">
<cfparam name = "sortoption" default="Inactive">

<!---store the current sortoption in this persons session so that if they come back the last category
	 they viewed will be shown--->

<cfif isdefined('form.sortoption') OR isdefined('url.sortoption')>	 
	<cfinclude template = "../actions/act_updateusersession.cfm">
</cfif>

<cfinclude template = "../queries/qry_checktoken.cfm">

<cfif NOT qry_checktoken.sortoption IS ''>
	<cfset sortoption = #qry_checktoken.sortoption#>
</cfif>

<cfinclude template = '../queries/qry_categories.cfm'>
<cfinclude template = "../queries/qry_settings.cfm">
<cfinclude template = "../queries/qry_itemimages.cfm">

<script language="Javascript"> 
   function PopupPic(sPicURL) { 
     window.open( "image-window.html?"+sPicURL, "",  
     "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
</script>

<cfif NOT isdefined('form.searchquery') AND NOT isdefined('url.searchquery')>
	<cfif NOT SortOption IS 'Featured' AND NOT SortOption IS 'OutofStock' 
			AND NOT SortOption IS 'All' AND NOT SortOption IS 'Inactive'>
			<cfinclude template = "../queries/qry_productsincategory.cfm">
	<cfelse>
			<cfinclude template = "../queries/qry_products.cfm">
	</cfif>
</cfif>
 
<!---Display the sort drop down--->
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td width="30%" nowrap> <form method="POST" name="sortform" <cfoutput>action="index.cfm?action=products.images.multipleupload&mytoken=#mytoken#"</cfoutput>>
	<select name="sortoption">
          <option value = "Inactive" <cfif #sortoption# IS 'Inactive'>SELECTED</cfif>>Inactive 
          Items Only</option>
          <option value = "All" <cfif #sortoption# IS 'All'>SELECTED</cfif>>All 
          products</option>
          <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#sortoption#"
				Datasource="#request.dsn#"
				DatasourceUN="#request.dsnun#"
				DatasourcePW="#request.dsnPW#">  
        </select>

		<cfif isdefined('url.deleteid') OR isdefined('url.itemid')>
			<script language="javascript">
				sortform.submit();
			</script>
		</cfif>


        <input type="submit" value="Sort" name="B1"></p></form></td>
	    <td width="30%"> <div align="center"> <cfoutput> 
          <!---Display the page numbers--->
          <cfif disp LT qryproducts.RecordCount + 1>
            <form name = "PageSelect" method="Post" <cfoutput>Action="index.cfm?action=products.images.multipleupload&mytoken=#mytoken#"</cfoutput>>
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryproducts.RecordCount#" Step="#disp#"><a href = "doproducts.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
			 <cfoutput><input type="hidden" value="#sortoption#" name="sortoption" /></cfoutput>
            </form>
          </cfif>
        </cfoutput> </div></td>
    <td width="30%"><form name="Displayoptions" method="POST" <cfoutput>action="index.cfm?action=products.images.multipleupload&mytoken=#mytoken#"</cfoutput>>
		<select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8</option>
			<option value="15" <cfif disp IS '15'>SELECTED</cfif>>Display 15</option>
			<option value="25" <cfif disp IS '25'>SELECTED</cfif>>Display 25</option>
			<option value="50" <cfif disp IS '50'>SELECTED</cfif>>Display 50</option>
			<option value="100" <cfif disp IS '100'>SELECTED</cfif>>Display 100</option>
			<option value="100" <cfif disp IS '9999999'>SELECTED</cfif>>Display All</option>
		</select>
		<cfoutput><input type="hidden" value="#sortoption#" name="sortoption" /></cfoutput>
	</form></td>
    <td width="30%" nowrap> <form name="form1" method="post" <cfoutput>action="index.cfm?action=products.images.multipleupload&mytoken=#mytoken#"</cfoutput>>
        <div align="right"> 
          <input type="text" name="SearchQuery">
          <input type="submit" name="Submit" value="Search">
        </div>
      </form></td>
  </tr>
</table>
<form name = "uploadimages" enctype="multipart/form-data" method="post" <cfoutput>action="index.cfm?action=products.images.upload&mytoken=#mytoken#&start=#start#&disp=#disp#&sortoption=#sortoption#"</cfoutput>>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr bgcolor="#3366CC">
    <td width="1%" align="center"><strong><font color="#FFFFFF"><img src="icons/photoicon.gif" alt="A checkmark appears if there are any images uploaded for this item" title="A checkmark appears if there are any images uploaded for this item"></font></strong></td>
    <td width="10%" align="left"><strong><font color="#FFFFFF">ID</font></strong></td>
    <td width="30%" aling="left"><cfoutput><a href="index.cfm?action=products.images.multipleupload&mytoken=#mytoken#&OrderBy=ProductName"><font color="##FFFFFF"><strong> Name</strong></font></a></cfoutput></td>
    <td width="10%" align="left"><font color="#FFFFFF"><strong>Image File </strong></font></td>
    <cfif qry_Settings.imageprocessor IS 'None'><td width="10%" align="left"><strong><font color="#FFFFFF">Thumbnail</font></strong></td></cfif>
    <cfif qry_Settings.imageprocessor IS 'None'><td width="10%" align="left"><strong><font color="#FFFFFF">TinyThumb</font></strong></td></cfif>
  </tr>
  <cfset RowCount = 0>
  <!---Set up variables for paginating--->
  <CFSET end=Start + disp>
  <CFIF Start + disp GREATER THAN qryproducts.RecordCount>
    <CFSET end=999>
    <CFELSE>
    <CFSET end=Start + disp>
  </CFIF>
  <!---Categories this product belongs to--->
  <cfoutput query = "qryproducts" startRow="#Start#" MaxRows="#End#">
	
		<!---query the images query to see if this item has any images uploaded.  
	If so show the first one in the image preview window--->
				<cfquery name = "qryThumbnail" dbtype="query">
				SELECT * FROM qry_Images WHERE itemid = '#itemid#'
				</cfquery>
				
				<cfset imageinfo = 'Mouse over an item for info'>
				<cfset hasimage = 'No'>
				<script language="javascript">
					document.all('InfoWindow').innerHTML = '#imageinfo#';
				</script>
				
				<cfif qryThumbnail.recordcount GT 0>
           	<cfloop query = "qryThumbnail" startrow="1" endrow="1">
							<cfset thisimage = '#request.ImagesURL#small/#iFileName#'>
							<cfset imageinfo = '#iFileName#'>
							<cfset hasimage = 'Yes'>
						</cfloop>
  			<cfelse>
	           <cfset thisimage = 'images/imagepreview.jpg'>
						 <cfset imageinfo = 'Item has no image'>
  			</cfif>
	 
    <cfset CategoryCount = 0>
    <!---keep track of the number of categories this one belongs to--->
    <tr class="selecttr" onMouseOver="this.className='highlight'; document.ImagePreview.src='#thisimage#'; document.all('InfoWindow').innerHTML = '#imageinfo#';" onMouseOut="this.className='normal'; document.all('InfoWindow').innerHTML = '#imageinfo#';" >
      <td align="center" onclick="window.location.href='index.cfm?action=products.images.productimages&ItemID=#ItemID#&sortoption=#sortoption#&mytoken=#mytoken#&wasdoing=Images'"><cfif hasimage IS 'Yes'><img src="icons/checkgreen.gif" alt="Item has #qryThumbnail.recordcount# image(s)" title="Item has #qryThumbnail.recordcount# image(s)"></cfif></td>
      <td align="left" onclick="window.location.href='index.cfm?action=products.images.productimages&ItemID=#ItemID#&sortoption=#sortoption#&mytoken=#mytoken#&wasdoing=Images'"> 
        #FranchiseID#</td>
      <td align="left" onclick="window.location.href='index.cfm?action=products.images.productimages&ItemID=#ItemID#&sortoption=#sortoption#&mytoken=#mytoken#&wasdoing=Images'">#FranchiseName#</td>
      <td align="left"><input type="Hidden" value = "#ItemID#" name="ItemID">
        <input name="FileContents#ItemID#" type="file" id="FileContents#ItemID#" size="26" />	  </td>
      <cfif qry_Settings.ImageProcessor IS 'None'><td><input name="ThumbFileContents#ItemID#" type="file" id="filefield" size="15"></td></cfif>
      <cfif qry_Settings.ImageProcessor IS 'None'><td><input name="TinyThumbFileContents#ItemID#" type="file" id="filefield" size="15"></td></cfif>
    </tr>
  </cfoutput> 
</table>
<br>
<div name="uploadimg" id="uploadimg" style="display:None">
<center><img src = "icons/uploadanim.gif"><br />
Images are being upload.  Please wait...</center>
</div>
<p align="center"><input type="Submit" Value="Upload Pictures" Name="S1" onclick="this.style.display='none'; uploadimg.style.display = 'block';"></p> 
</form>

































