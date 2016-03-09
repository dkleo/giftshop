<cfajaximport tags="cfwindow">
<cfmenu name="myMenu" type="horizontal" fontcolor="##FFFFFF">
    <cfmenuitem name="FileMnu" href="##" display="File" menuStyle="z-index:99999;">
	    <!---<cfmenuitem name="open" href="javascript: OpenFileBrowser('dialog/diaopen.cfm?fname=colorform&amp;ffield=bgimage_Footer')" display="Open..."></cfmenuitem>--->
		<cfmenuitem name="save" href="index.cfm?action=save" display="Save"></cfmenuitem>
		<cfmenuitem name="mSaveAs" href="javascript: ColdFusion.Window.create('diagwin', 'SaveAs', 'dialog/diasaveas.cfm', {height:300,width:400,modal:true,closable:true,draggable:false,resizable:false,center:true,initshow:true}); 
        ColdFusion.Window.onHide('diagwin',cleanup);" display="Save As..."></cfmenuitem>
		<cfmenuitem divider />
		<cfmenuitem name="mClose" href="javascript: opener.location.reload(true); self.close();" display="Close Editor"></cfmenuitem>
    </cfmenuitem>
    <cfmenuitem name="EditMnu" href="##" display="Edit" menuStyle="z-index:99998;">
		<cfif undo_enabled IS 'Yes'>
        	<cfmenuitem name="Undo" href="index.cfm?action=undo" display="Undo" style="border-bottom: ##666666 solid 1px;"></cfmenuitem>
        <cfelse>
        	<cfmenuitem name="CantUndo" href="##" display="<i>Can't Undo</i>" style="border-bottom: ##666666 solid 1px;"></cfmenuitem>
		</cfif>
        <cfmenuitem divider />
        <cfmenuitem name="Resize" href="javascript: ColdFusion.Window.create('diagwin', 'Resize', 'dialog/diaresize.cfm', {height:300,width:400,modal:true,closable:true,draggable:false,resizable:false,center:true,initshow:true}); ColdFusion.Window.onHide('diagwin',cleanup);" display="Resize"></cfmenuitem>
		<cfmenuitem name="Crop" href="javascript: document.cropform.submit();" display="Crop to Selection"></cfmenuitem>
        <cfmenuitem name="BrightenImage" href="index.cfm?action=brighten" display="Increase Brightness"></cfmenuitem>
        <cfmenuitem name="DarkenImage" href="index.cfm?action=darken" display="Decrease Brightness"></cfmenuitem>
    </cfmenuitem>
    <cfmenuitem name="EffectsMnu" href="##" display="Effects" menuStyle="z-index:99998;">
        <cfmenuitem name="Dropshadow" display="Drop Shadow" href="javascript: ColdFusion.Window.create('diagwin', 'Dropshadow', 'dialog/diadropshadow.cfm',{height:300,width:400,modal:true,closable:true,draggable:false,resizable:false,center:true,initshow:true}); ColdFusion.Window.onHide('diagwin',cleanup);"></cfmenuitem>
		<cfmenuitem name="Reflection" href="javascript: ColdFusion.Window.create('diagwin', 'Reflection', 'dialog/diareflection.cfm', {height:300,width:400,modal:true,closable:true,draggable:false,resizable:false,center:true,initshow:true}); ColdFusion.Window.onHide('diagwin',cleanup);" display="Add Reflection"></cfmenuitem>
		<cfmenuitem name="Plastic" href="javascript: ColdFusion.Window.create('diagwin', 'Plastic', 'dialog/diaplastic.cfm', {height:300,width:400,modal:true,closable:true,draggable:false,resizable:false,center:true,initshow:true}); ColdFusion.Window.onHide('diagwin',cleanup);" display="Plastic"></cfmenuitem>
        <cfmenuitem name="Roundedcorners" href="javascript: ColdFusion.Window.create('diagwin', 'Roundedcorners', 'dialog/diaroundedcorners.cfm', {height:300,width:400,modal:true,closable:true,draggable:false,resizable:false,center:true,initshow:true}); ColdFusion.Window.onHide('diagwin',cleanup);" display="Rounded Corners"></cfmenuitem>
   		<cfmenuitem name="Border" href="javascript: ColdFusion.Window.create('diagwin', 'Borders', 'dialog/diaborder.cfm', {height:300,width:400,modal:true,closable:true,draggable:false,resizable:false,center:true,initshow:true}); ColdFusion.Window.onHide('diagwin',cleanup);" display="Add Border"></cfmenuitem>
   		<cfmenuitem name="sepiaTone" href="index.cfm?action=sepia" display="Apply Sepia Tone"></cfmenuitem>
        <cfmenuitem name="greyscale" href="index.cfm?action=greyscale" display="Convert To Gray Scale"></cfmenuitem>
    </cfmenuitem>
</cfmenu>
















