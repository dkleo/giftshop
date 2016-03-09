<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="PRAGMA" content="NO-CACHE">
<meta http-equiv="EXPIRES" content="-1">
<title>Image Editor -- Close this window when you are done.</title>

<cfoutput>
<script type="text/javascript" src="#request.adminpath#components/imageeditor/cropper/lib/prototype.js" language="javascript"></script>
<script type="text/javascript" src="#request.adminpath#components/imageeditor/cropper/lib/scriptaculous.js?load=builder,dragdrop" language="javascript"></script>
<script type="text/javascript" src="#request.adminpath#components/imageeditor/cropper/cropper.js" language="javascript"></script>
</cfoutput>

<script language="javascript">
function onEndCrop( coords, dimensions ) {
	$( 'x1' ).value = coords.x1;
	$( 'y1' ).value = coords.y1;
	$( 'x2' ).value = coords.x2;
	$( 'y2' ).value = coords.y2;
 	$( 'width' ).value = dimensions.width;
 	$( 'height' ).value = dimensions.height;
 }
</script>

<script language="javascript">
function cleanup() {
   ColdFusion.Window.destroy('diagwin',true);
}	

function closewin() {
   opener.location.reload(true);
}	
</script>

<style>
.editor_area {padding: 10px;}

/* Menu styles */

.yuimenu {
    background-color:#0099CC;
	border:solid 0px;
    padding:1px;
	color: #000000;
	font-size: 12px;
}


/* Submenus styles */
.yuimenu .yuimenu,
.yuimenubar .yuimenu {
	background: #0099CC;
	color: #000000;
	font-size: 12px;
}

/* MenuBar Styles */

.yuimenubar {

    background-color:#0099CC;
	font-size: 12px;
	color: #000000;
    
}

.yuimenubar ul {

    *zoom:1;

}

.yuimenubar ul:after {

    content:".";
    display:block;
    clear:both;
    visibility:hidden;
    height:0;
    line-height:0;
	color: #000000;

}


/* MenuItem and MenuBarItem styles */

.yuimenuitemlabel,
.yuimenubaritemlabel {

    white-space: nowrap;
    font-size:85%;
    display:block;
    text-decoration:none;
	font-size: 12px;
	color: #000000;

}

.yuimenuitemlabel {

    padding:6px 24px;
    outline:none;
	color: #00000;
    
}

.yuimenubaritemlabel {

    border-width:0 0 0 1px;
    border-style:solid;
    border-color:#c4c4be;
    padding:8px 24px;
	color: #000000;

}

.li.first-of-type .yuimenubaritemlabel {

    border-width:0;
	color: #000000;

}

.yuimenuitemlabel .helptext {

    font-style:normal;
    margin:0 0 0 40px;
	color: #000000;
    
}


.yuimenuitemlabel .submenuindicator,
.yuimenuitemlabel .checkedindicator, 
.yuimenubaritemlabel .submenuindicator {
    
    display:hidden;
    height:0px;
    width:0px;
    overflow:hidden;
    vertical-align:middle;
    text-indent:0px;
    background-image:url(map.gif);
    background-repeat:no-repeat;
	color: #000000;

}

.yuimenubaritemlabel .submenuindicator {
	
	color: #000000;
    display:-moz-inline-stack; /* Gecko */
    display:inline-block; /* IE, Opera and Safari */
    font:0/0 arial; /* Gecko */

}

.yuimenuitemlabel .submenuindicator {

    background-position:0 0;
	color: #000000;

}

.yuimenubaritemlabel .submenuindicator {

    background-position:0 -24px;
    margin:0 0 0 10px;
	color: #000000;

}

.yuimenuitemlabel .checkedindicator {

    background-position:0 -48px;

}

.visible .yuimenuitem,
.visible .yuimenuitemlabel {

    *zoom:1;
	color: #000000;

}

.visible .yuimenuitemlabel .helptext {

    float:right;
    width:100%;
    text-align:right;
    margin:-1.2em 0 0 0;
	color: #000000;
    *cursor:hand; /* Required to restore the style of the cursor in IE */

}

.visible .yuimenuitemlabel .submenuindicator {

    margin:-.9em -16px 4px auto;
    *margin:-.9em -16px 0 105%;
	color: #000000;

}

.visible .yuimenuitemlabel .checkedindicator {

    margin:-.9em auto 4px -16px;
    *margin-bottom:0;
	color: #000000;

}


/* Matches selected menu items */

.yuimenuitem a.selected,
.yuimenubaritem a.selected {

    background-color:#AADEFF;
    text-decoration:none;
    color:#000000;

}

.yuimenubaritem a.selected .submenuindicator {

    background-position:0 -32px;
	color: #000000;

}

.yuimenuitem a.selected .submenuindicator {

    background-position:0 -8px;
	color: #000000;

}

.yuimenuitem a.selected .checkedindicator {

    background-position:0 -56px;
	color: #000000;

}


/* Matches disabled menu items */

.yuimenubaritem a.disabled .submenuindicator {

    background-position:0 -40px;
	color: #000000;

}

.yuimenuitem a.disabled {

    cursor:default;
    color:#000000;

}

.yuimenuitem a.disabled .submenuindicator {

    background-position:0 -16px;
	color: #000000;

}

.yuimenuitem a.disabled .checkedindicator {

    background-position:0 -64px;
	color: #000000;

}


</style>

</head>
<body onunload="closewin();">









