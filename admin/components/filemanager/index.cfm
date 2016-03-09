<cfparam name = "action" default="">

<cfswitch expression="#action#">
    <cfcase value="files.browse">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.CreateFolder">
        <cfinclude template = "actions/act_createfolder.cfm">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.DeleteFolder">
        <cfinclude template = "actions/act_deletefolder.cfm">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.CreatePage">
        <cfinclude template = "actions/act_createpage.cfm">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.EditPage">
        <cfinclude template = "forms/frm_editfile.cfm">
    </cfcase>
    <cfcase value="files.SaveFile">
        <cfinclude template = "actions/act_savefile.cfm">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.DeleteFile">
        <cfinclude template = "actions/act_deleteafile.cfm">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.RenameFile">
        <cfinclude template = "actions/act_renamefile.cfm">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.CopyAFile">
        <cfinclude template = "forms/frm_copyafile.cfm">
    </cfcase>
    <cfcase value="files.CopyFileHere">
        <cfinclude template = "actions/act_copyafile.cfm">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.MoveAFile">
        <cfinclude template = "forms/frm_moveafile.cfm">
    </cfcase>
    <cfcase value="files.MoveFileHere">
        <cfinclude template = "actions/act_moveafile.cfm">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.uploadfile">
        <cfinclude template = "actions/act_upload.cfm">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.viewimage">
        <cfinclude template = "displays/dsp_imagefile.cfm">
    </cfcase>
    <cfcase value="files.editform">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.download">
        <cfinclude template = "actions/act_download.cfm">
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfcase>
    <cfcase value="files.upload">
        <cfinclude template = "forms/frmupload.cfm">
    </cfcase>
    <cfdefaultcase>
        <cfinclude template = "forms/frm_filemanager.cfm">
    </cfdefaultcase>
</cfswitch>









