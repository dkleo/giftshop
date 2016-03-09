<cftry>
 
<script language="Javascript"> 
   function PopupPic(OptionID) { 
     window.open("htmlcode.cfm?OptionID="+OptionID, "", "resizable=1,HEIGHT=500,WIDTH=500"); 
   } 
</script>

<script language="javascript">
function OpenFileBrowser( url )
{
	var winwidth = ( screen.width * .8);
	var winheight = ( screen.height * .8);
	var iLeft = ( screen.width  - winwidth ) / 2 ;
	var iTop  = ( screen.height - winheight ) / 2 ;

	var sOptions = "toolbar=no,status=yes,resizable=yes,dependent=yes,scrollbars=1" ;
	sOptions += ",width=" + winwidth ;
	sOptions += ",height=" + winheight ;
	sOptions += ",left=" + iLeft ;
	sOptions += ",top=" + iTop ;

	window.open( url, 'FileBrowserWindow', sOptions ) ;
}

function SetUrl(fileurl,formname,formfield) 
{
 document.forms[formname].elements[formfield].value = fileurl ;
}
</script>


<cfparam name="category" default="">
<cfparam name="productid" default="">
<cfparam name="productname" default="">
<cfparam name="price" default="">
   
<table width="100%" border="0" cellspacing="3" cellpadding="3">
  
  <tr valign="top"> 
    <td width="1000%" colspan="10"> 
      <cfif NOT ISDEFINED ('url.action') AND NOT ISDEFINED ('form.action')>
		<cfinclude template = "forms/frmproducts.cfm">
      </cfif>
      <cfif ISDEFINED('url.action')>
        <cfif url.action is 'AddDropDown'>
          <cfinclude template = 'forms/frmdropdown.cfm'>
        </cfif>
        <cfif url.action is 'AddRadioList'>
          <cfinclude template = 'forms/frmradiolist.cfm'>
        </cfif>
        <cfif url.action is 'EditOptions'>
          <cfinclude template = 'forms/frmassignoptions.cfm'>
        </cfif>
        <cfif url.action is 'AddFormField'>
          <cfif url.Type IS 'TextBox'>
            <cfinclude template = 'forms/frmcreatetextbox.cfm'>
          </cfif>
          <cfif url.Type IS 'TextArea'>
            <cfinclude template = 'forms/frmcreatemtextbox.cfm'>
          </cfif>
          <cfif url.Type IS 'CheckBox'>
            <cfinclude template = 'forms/frmcreatecheckbox.cfm'>
          </cfif>
          <cfif url.Type IS 'Hidden'>
            <cfinclude template = 'forms/frmcreatehidden.cfm'>
          </cfif>
        </cfif>
        <cfif url.action is 'Edit'>
          <cfif url.Type IS 'DropDown'>
            <cfinclude template = 'forms/frmDropDown.cfm'>
          </cfif>
          <cfif url.Type IS 'RadioList'>
            <cfinclude template = 'forms/frmRadioList.cfm'>
          </cfif>
          <cfif url.Type IS 'TextBox'>
            <cfinclude template = 'forms/frmedittextbox.cfm'>
          </cfif>
          <cfif url.Type IS 'TextArea'>
            <cfinclude template = 'forms/frmeditmtextbox.cfm'>
          </cfif>
          <cfif url.Type IS 'CheckBox'>
            <cfinclude template = 'forms/frmeditcheckbox.cfm'>
          </cfif>
          <cfif url.Type IS 'Hidden'>
            <cfinclude template = 'forms/frmedithidden.cfm'>
          </cfif>
        </cfif>
        <cfif url.action is 'EditAllOptions'>
          <cfinclude template = 'forms/frmeditoptions.cfm'>
        </cfif>
        <cfif url.action is 'RemoveOption'>
          <cfinclude template = 'actions/actremoveoption.cfm'>
        </cfif>
        <cfif url.action is 'Delete'>
          <cfinclude template = 'actions/actdelete.cfm'>
        </cfif>
        <cfif url.action is 'DeleteListItem'>
          <cfinclude template = 'actions/actremoveddi.cfm'>
        </cfif>
        <cfif url.action is 'DeleteRadioItem'>
          <cfinclude template = 'actions/actremoveradioitem.cfm'>
        </cfif>
        <cfif url.action IS 'ViewCode'>
          <cfinclude template = 'forms/frmHTMLCode.cfm'>
        </cfif>
        <cfif url.action is 'Exit'>
          <cflocation URL = '#request.AdminPath#'>
        </cfif>
        <cfif url.action is 'CopyOption'>
          <cfinclude template = 'forms/frmcopyoption.cfm'>
        </cfif>
        <cfif url.action is 'SelectItemToCopy'>
          <cfinclude template = 'forms/frmselectoptiontocopy.cfm'>
        </cfif>
        <cfif url.action is 'SelectOptionToCopy'>
          <cfinclude template = 'actions/actcopyoption.cfm'>
        </cfif>
        <cfif url.action is 'duplicate'>
          <cfinclude template = 'actions/actduplicate.cfm'>
        </cfif>
        <cfif url.action IS 'UpdateOrder2'>
          <cfinclude template = 'actions/actupdateorder2.cfm'>
        </cfif>
        <cfif url.action IS 'MoveDDItemUp'>
          <cfinclude template = 'actions/actmovedditemup.cfm'>
        </cfif>
        <cfif url.action IS 'MoveDDItemDown'>
          <cfinclude template = 'actions/actmovedditemdown.cfm'>
        </cfif>
        <cfif url.action IS 'MoveRBItemUp'>
          <cfinclude template = 'actions/actmoverbitemup.cfm'>
        </cfif>
        <cfif url.action IS 'MoveRBItemDown'>
          <cfinclude template = 'actions/actmoverbitemdown.cfm'>
        </cfif>
        
      </cfif> 
	  
	  <cfif ISDEFINED('form.action')>

        <cfif form.action IS 'AddDropDown'>
          <cfinclude template = 'actions/actadddropdown.cfm'>
        </cfif>
        <cfif form.action IS 'AddRadioList'>
          <cfinclude template = 'actions/actaddradiolist.cfm'>
        </cfif>
        <cfif form.action IS 'UpdateDropDown'>
          <cfinclude template = 'actions/actupdatedropdown.cfm'>
        </cfif>
        <cfif form.action IS 'UpdateRadioListItems'>
          <cfinclude template = 'actions/actupdateradiolistitems.cfm'>
        </cfif>
        <cfif form.action IS 'CreateFormField'>
          <cfinclude template = 'actions/actaddformfield.cfm'>
        </cfif>
        <cfif form.action IS 'UpdateFormField'>
          <cfinclude template = 'actions/actupdateformfield.cfm'>
        </cfif>
        <cfif form.action is 'AddOption'>
          <cfinclude template = 'actions/actaddoption.cfm'>
        </cfif>
        <cfif form.action is 'AddRadioItem'>
          <cfinclude template = 'actions/actaddradioitem.cfm'>
        </cfif>
        <cfif form.action IS 'UpdateOrder'>
          <cfinclude template = 'actions/actupdateorder.cfm'>
        </cfif>
        <cfif form.action IS 'UpdateOrder2'>
          <cfinclude template = 'actions/actUpdateOrder2.cfm'>
        </cfif>
        <cfif form.action IS 'Update'>
          <cfinclude template = 'actions/actupdate.cfm'>
        </cfif>
        <cfif form.action IS 'UpdateListItems'>
          <cfinclude template = 'actions/actupdatelistitems.cfm'>
        </cfif>
      </cfif> </td>
  </tr>
</table>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>
