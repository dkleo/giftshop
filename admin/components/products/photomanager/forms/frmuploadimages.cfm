<h2>Multiple Product Image Upload Tool</h2>
<a href="dophotomanager.cfm?action=selectimages">Click here to use Image Selector</a>
<p>
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

<!---store the current sortoption in this persons session so that if they come back the last category
	 they viewed will be shown--->

<cfset request.imagesurl = '#request.HomeURL#photos/'>

<script language="Javascript"> 
   function PopupPic(sPicURL) { 
     window.open( "image-window.html?"+sPicURL, "",  
     "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
</script>

<cfinclude template = '../../queries/qrycategories.cfm'>
<cfinclude template = "../../queries/qrycompanyinfo.cfm">
<cfinclude template = "../../queries/qryitemimages.cfm">

<cfif ISDEFINED('session.disp')>
	<cflock scope="Session" type="Exclusive" timeout="10">
		<cfset disp = '#session.disp#'>
	</cflock>
</cfif>

<cfif ISDEFINED('form.disp')>
		<cfset disp = '#form.disp#'>
</cfif>

<!---Store the start varialbe in a session so that the last viewed page can always be called---> 
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
   <cfset session.start = '#form.start#'>
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

<cfif NOT isdefined('Session.SortOption')>
  <cflock scope="Session" type="Exclusive" timeout="10">
    <cfset session.sortoption = 'Featured'>
	<cfset session.start = '1'>
  </cflock>
</cfif>
<cfif isdefined('form.SortOption')>
  <cflock scope="Session" type="Exclusive" timeout="10">
    <cfset session.sortoption = '#form.SortOption#'>
    <cfset session.start = "1">
  </cflock>
</cfif>
<cfif isdefined('url.sortoption')>
  <cflock scope="Session" type="Exclusive" timeout="10">
    <cfset session.sortoption = '#url.sortoption#'>
  </cflock>
</cfif>

<cflock scope="Session" type="Readonly" timeout="10">
  <cfset SortOption = #session.SortOption#>
</cflock>

<cfinclude template = "../../queries/qrycatalog.cfm">
 
<!---Display the sort drop down--->
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td width="30%" nowrap> <form method="POST" name="sortform" <cfoutput>action="dophotomanager.cfm?action=multipleupload"</cfoutput>>
	<select name="sortoption">
          <option value = "0" <cfif #sortoption# IS '0'>SELECTED</cfif>>Inactive 
          Items Only</option>
          <option value = "All" <cfif #sortoption# IS 'All'>SELECTED</cfif>>All 
          products</option>
          <cf_CategoryTree Directory="/"
				ShowCurrentView="Yes"
				SelectedItem="#sortoption#"
				Datasource="#request.dsn#"
				FirstIndent="#request.CategoryIndent#">  
        </select>

		<cfif isdefined('url.deleteid') OR isdefined('url.itemid')>
			<script language="javascript">
				sortform.submit();
			</script>
		</cfif>


        <input type="submit" value="Sort" name="B1"></p></form></td>
	    <td width="30%"> <div align="center"> <cfoutput> 
          <!---Display the page numbers--->
          <cfif disp LT qryCatalog.RecordCount + 1>
            <form name = "PageSelect" method="Post" <cfoutput>Action="dophotomanager.cfm?action=multipleupload"</cfoutput>>
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryCatalog.RecordCount#" Step="#disp#"><a href = "doproducts.cfm?start=#Pages#">
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
			 <cfoutput><input type="hidden" value="#sortoption#" name="sortoption" /></cfoutput>
            </form>
          </cfif>
        </cfoutput> </div></td>
    <td width="30%"><form name="Displayoptions" method="POST" <cfoutput>action="dophotomanager.cfm?action=multipleupload"</cfoutput>>
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
    <td width="30%" nowrap> <form name="form1" method="post" <cfoutput>action="dophotomanager.cfm?action=multipleupload"</cfoutput>>
        <div align="right"> 
          <input type="text" name="SearchQuery">
          <input type="submit" name="Submit" value="Search">
        </div>
      </form></td>
  </tr>
</table>
<form name = "uploadimages" enctype="multipart/form-data" method="post" <cfoutput>action="dophotomanager.cfm?action=uploadimages&start=#start#&disp=#disp#&sortoption=#sortoption#"</cfoutput>>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr bgcolor="#3366CC">
    <td width="1%" align="center"><strong><font color="#FFFFFF"><img src="icons/photoicon.gif" alt="A checkmark appears if there are any images uploaded for this item" title="A checkmark appears if there are any images uploaded for this item"></font></strong></td>
    <td width="10%" align="left"><strong><font color="#FFFFFF">ID</font></strong></td>
    <td width="30%" aling="left"><cfoutput><a href="dophotomanager.cfm?action=multipleupload&OrderBy=ProductName"><font color="##FFFFFF"><strong> Name</strong></font></a></cfoutput></td>
    <td width="10%" align="left"><font color="#FFFFFF"><strong>Image File </strong></font></td>
  </tr>
  <cfset RowCount = 0>
  <!---Set up variables for paginating--->
  <CFSET end=Start + disp>
  <CFIF Start + disp GREATER THAN qryCatalog.RecordCount>
    <CFSET end=999>
    <CFELSE>
    <CFSET end=Start + disp>
  </CFIF>
  <!---Categories this product belongs to--->
  <cfoutput query = "qryCatalog" startRow="#Start#" MaxRows="#End#">
	
		<!---query the images query to see if this item has any images uploaded.--->
				<cfquery name = "qryThumbnail" dbtype="query">
				SELECT * FROM qry_Images WHERE itemid = '#itemid#'
				</cfquery>
				
				<cfset imageinfo = 'Mouse over an item for info'>
				<cfset hasimage = 'No'>
				
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
    <tr class="selecttr" onMouseOver="this.className='highlight';" onMouseOut="this.className='normal';" >
      <td align="center" onclick="window.location.href='dophotomanager.cfm?action=productimages&ItemID=#ItemID#&sortoption=#sortoption#&wasdoing=Images'"><cfif hasimage IS 'Yes'><img src="icons/checkgreen.gif" alt="Item has #qryThumbnail.recordcount# image(s)" title="Item has #qryThumbnail.recordcount# image(s)"></cfif></td>
      <td align="left" onclick="window.location.href='dophotomanager.cfm?action=productimages&ItemID=#ItemID#&sortoption=#sortoption#&wasdoing=Images'"> 
        #ProductID#</td>
      <td align="left" onclick="window.location.href='dophotomanager.cfm?action=productimages&ItemID=#ItemID#&sortoption=#sortoption#&wasdoing=Images'"><a href = "dophotomanager.cfm?action=productimages&ItemID=#ItemID#&sortoption=#sortoption#&wasdoing=Images">#ProductName#</a></td>
      <td align="left"><input type="Hidden" value = "#ItemID#" name="ItemID">
        <input name="FileContents#ItemID#" type="file" id="FileContents#ItemID#" size="26" />	  </td>
    </tr>
  </cfoutput> 
</table>
<br>
<div name="uploadimg" id="uploadimg" style="display:None">
<center><img src = "icons/uploadanim.gif"><br />
Images are being upload.  Please wait...</center>
</div>
<p align="center"><input type="Submit" Value="Upload Product Images" Name="S1" onclick="this.style.display='none'; uploadimg.style.display = 'block';">
</p> 
</form>