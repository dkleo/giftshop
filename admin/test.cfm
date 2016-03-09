<cfset txt1 = "This is the <b>original txt</b>">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<center>
<form method="POST" action="../doheadermanager.cfm">
  <input type="hidden" id="content" name="content" value="<cfoutput>#Request.KTML4_escapeAttribute(txt1)#</cfoutput>" />
<textarea name="Contents" cols="" rows=""><cfoutput>#txt1#</cfoutput></textarea>
<input type="hidden" Name="Action" Value="Update">
  <input type="submit" value="Update Store Header" name="B1"></p>
</form>
</center>
</body>
</html>






