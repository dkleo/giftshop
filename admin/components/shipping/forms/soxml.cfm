<cfsetting enablecfoutputonly="Yes">
<!------------------------------------------------------------------------------
  Custom Tag: SOXML;
  Version: 1.6;
  Released: 5/24/2001;
	Created: 8/18/2000;
	Author: Brett Suwyn; mailto:brett@suwyn.com
  Description: 
    This tag is a simple to use XML interface for ColdFusion;
  Usage: 
    <cf_SOXML
      action="CF2XMLDom|CF2XML|XML2CF|XML2DOM|XML2HTML"
      input="" [required:all actions]
      output="" [required:CF2XMLDom|CF2XML|XML2CF|XML2DOM]
      type="" [required:XML2CF|XML2DOM]
      rootname="" [required:CF2XMLDom|CF2XML]
      progid="" [optional] 
    >
  
  Modifications:
    5/20/2001: Fixed problems with returning object from Transform action
    12/18/2000: Added Transform action;
    12/18/2000: Tweaked XML2HTML code;    
    10/23/2000: Fixed loss of root level name when using XML2CF;
      
    
---------------------------------------------------------------------------------->

<cfparam name="Attributes.ProgId" default="Microsoft.XMLDom">


<cfswitch expression="#Attributes.Action#">

<!--- ~~~CF2XMLDOM~~~ --->
<!--- Build XML Dom object --->
<!--- ~~~~~~~~~~~~~~ --->
<cfcase value="CF2XMLDOM">

<cfparam name="Attributes.Init" default="1">

<cfif Attributes.Init>
  <cfparam name="Attributes.Output" type="string">  
  <cfparam name="Attributes.Input">
  <cfparam name="Attributes.RootName" default="ROOT">
  <cfparam name="Attributes.StandAlone" default="">
  <cfparam name="Attributes.Encoding" default="">
		  
  <cfobject action="CREATE" class="#Attributes.ProgId#" type="COM" name="Request.XMLDoc">
  
  <cfscript>
    Request.XMLDoc.async = 0;
    Request.XMLDoc.loadXML("<?xml version=""1.0""" & IIf(Len(Attributes.Encoding),DE("encoding=" & Chr(34) & Attributes.Encoding & Chr(34)),DE(""))  & IIf(Len(Attributes.StandAlone),DE("standalone=" & Chr(34) & LCase(YesNoFormat(Attributes.StandAlone)) & Chr(34)),DE("")) & "?>" & "<" & UCase(Attributes.RootName) & ">" & "</" & UCase(Attributes.RootName) & ">");
    Attributes.Node = Request.XMLdoc.documentElement;
    oParseError = Request.XMLDoc.ParseError;
  </cfscript>
  
  <!--- if DOM error throw an exception --->
  <cfif oParseError.ErrorCode>
    <cfthrow type="SOXML.ParseError" message="DOM Error" detail="#oParseError.Reason# | Line:#oParseError.Line#">
  </cfif>
  
</cfif>
   
<cfif isStruct(Attributes.Input)>

  <cfloop collection="#Attributes.Input#" item="Key">

    <cfscript>
      ndKey = Request.xmlDoc.createNode (1, UCase(Key),"");
      Attributes.Node.appendChild(ndKey); 
      vCurrent = Attributes.Input[Key];
    </cfscript>
    
    <cf_SOXML action="CF2XMLDOM" init="0" input="#vCurrent#" node="#ndKey#">

  </cfloop>

<cfelseif isQuery(Attributes.Input)>

  <cfloop query="Attributes.Input">
  
    <cfscript>
      ndRow = Request.xmlDoc.createNode (1, "ROW","");
      Attributes.Node.appendChild(ndRow);    
    </cfscript>
  
    <cfloop index="idx" list="#Attributes.Input.ColumnList#">
  
      <cfscript>
        ndColumn = Request.xmlDoc.createNode (1, UCase(idx),"");
        ndRow.appendChild(ndColumn);  
      </cfscript>
  
      <cf_SOXML action="CF2XMLDOM" init="0" input="#Evaluate(idx)#" node="#ndColumn#">    
  
    </cfloop>
  
  </cfloop>

<cfelseif isArray(Attributes.Input)>

  <cfloop index="idx" from="1" to="#ArrayLen(Attributes.Input)#">
  
    <cfscript>
      ndArray = Request.xmlDoc.createNode (1, "IDX","");
      Attributes.Node.appendChild(ndArray);    
    </cfscript>
   
    <cf_SOXML action="CF2XMLDOM" init="0" input="#Attributes.Input[idx]#" node="#ndArray#">    
  
  </cfloop>  
  
<cfelseif isSimpleValue(Attributes.Input)>

  <cfscript>
    if (ReFind("<|>|&|'|""",Attributes.Input))
      ndSimple = Request.xmlDoc.createNode(4, "", "");
    else
      ndSimple = Request.xmlDoc.createNode(3, "", "");
    ndSimple.text = Attributes.Input;
    
    Attributes.Node.appendChild(ndSimple);
  </cfscript>
    
</cfif>

<cfscript>
  if (Attributes.Init){
    SetVariable("Caller."&Attributes.Output,Request.XMLDoc);    
  }
</cfscript>

</cfcase>

<!--- ~~~CF2XML~~~ --->
<!--- Build XML string --->
<!--- ~~~~~~~~~~~ --->
<cfcase value="CF2XML">

<cfparam name="Attributes.Input">
<cfparam name="Attributes.Init" default="1">
<cfparam name="Attributes.RootName" default="ROOT">


<cfif Attributes.Init>

  <cfparam name="Attributes.Output" type="string"> 
  <cfparam name="Attributes.StandAlone" default="">
  <cfparam name="Attributes.Encoding" default="">
	
  <cfset Request.XMLDoc = "<?xml version=""1.0""" & IIf(Len(Attributes.Encoding),DE(" encoding=" & Chr(34) & Attributes.Encoding & Chr(34)),DE(""))  & IIf(Len(Attributes.StandAlone),DE(" standalone=" & Chr(34) & LCase(YesNoFormat(Attributes.StandAlone)) & Chr(34)),DE("")) & "?>" & "<" & UCase(Attributes.RootName) & ">">
   
</cfif>

<cfif isStruct(Attributes.Input)>

  <cfloop collection="#Attributes.Input#" item="Key">

    <cfset Request.XMLDoc = Request.XMLDoc & "<" & Key & ">">
    
    <cf_SOXML action="CF2XML" init="0" input="#Attributes.Input[Key]#">  
  
    <cfset Request.XMLDoc = Request.XMLDoc & "</" & Key & ">">    
  
  </cfloop>

<cfelseif isQuery(Attributes.Input)>

  <cfloop query="Attributes.Input">

    <cfset Request.XMLDoc = Request.XMLDoc & "<ROW>">  

    <cfloop index="idx" list="#Attributes.Input.ColumnList#">
       
      <cfset Request.XMLDoc = Request.XMLDoc &  "<" & idx & ">">         
      
      <cf_SOXML action="CF2XML" init="0" input="#Evaluate(idx)#">      

      <cfset Request.XMLDoc = Request.XMLDoc & "</" & idx & ">">  

    </cfloop>

    <cfset Request.XMLDoc = Request.XMLDoc & "</ROW>">  

  </cfloop>
  
<cfelseif isArray(Attributes.Input)>

  <cfloop index="idx" from="1" to="#ArrayLen(Attributes.Input)#">

    <cfset Request.XMLDoc = Request.XMLDoc & "<IDX>">  
       
    <cf_SOXML action="CF2XML" init="0" input="#Attributes.Input[idx]#">      

    <cfset Request.XMLDoc = Request.XMLDoc & "</IDX>">  

  </cfloop>

<cfelseif isSimpleValue(Attributes.Input)>

  <cfscript>
    if (ReFind("<|>|&|'|""", Attributes.Input))
      Request.XMLDoc = Request.XMLDoc & "<![CDATA[" & Attributes.Input & "]]>";
    else
      Request.XMLDoc = Request.XMLDoc & Attributes.Input;
  </cfscript>

</cfif>

<cfscript>
  if (Attributes.Init){
    Request.XMLDoc = Request.XMLDoc & "</" & UCase(Attributes.RootName) & ">";  
    SetVariable("Caller."&Attributes.Output ,Request.XMLDoc);    
  }
</cfscript>

</cfcase>

<!--- ~~~~~XML2CF~~~~~~~ --->
<!--- Build CF object from XML --->
<!--- ~~~~~~~~~~~~~~~~ --->
<cfcase value="XML2CF">

  <cfparam name="Attributes.Init" default="1">
  
  <cfif Attributes.Init>
    <cfparam name="Attributes.Input">
    <cfparam name="Attributes.Output" default="Struct">
    <cfparam name="Attributes.Type" default="Variable">   
    
    <cfobject action="CREATE" class="#Attributes.ProgId#" type="COM" name="XMLDoc">
    <cfscript>
      XMLDoc.async = 0;
      if (Attributes.Type eq "File") 
        XMLDoc.Load(Attributes.Input);
      else 
        XMLDoc.loadXML(Attributes.Input);
      oParseError = XMLDoc.ParseError;
    </cfscript>
  
    <!--- if DOM error throw an exception --->
    <cfif oParseError.ErrorCode>
      <cfthrow type="SOXML.ParseError" message="DOM Error" detail="#oParseError.Reason# | Line:#oParseError.Line#">
    </cfif>
    
    <cfscript>
      Attributes.Node = XMLDoc;
      Attributes.Struct = StructNew();
    </cfscript>
  </cfif>
  
  <cfloop collection="#Attributes.Node.childNodes#" item="ThisNode">
    <cfswitch expression="#ThisNode.NodeType#">
    <cfcase value="1">
      <cfset CurrentNode = StructNew()> <!---  initialize node structure --->
  
      <!--- Write Attributes to Structure --->
      <cfset CurrentNode["Attributes"] = StructNew()>
      <cfloop collection="#ThisNode.Attributes#" item="ThisAttribute">
        <cfset CurrentNode.Attributes[ThisAttribute.Name] = ThisAttribute.Value>
      </cfloop> 
      <cfif StructIsEmpty(CurrentNode["Attributes"])>
        <cfset StructDelete(CurrentNode,"Attributes")>
      </cfif>
      
      <!--- Write current node to Structure --->
      <cfscript>
        if(isArray(Attributes.Struct)) // Currently part of a collection
          Attributes.Struct[ArrayLen(Attributes.Struct)+1] = CurrentNode;
        else if(structKeyExists(Attributes.Struct,ThisNode.NodeName)){ // Duplicate keys found
          if (isArray(Attributes.Struct[ThisNode.NodeName]))  // Collection already exists
            Attributes.Struct[ThisNode.NodeName][ArrayLen(Attributes.Struct[ThisNode.NodeName])+1] = CurrentNode;
          else{ // Create new collection
            TempCollection = ArrayNew(1);
            TempCollection[1] = Attributes.Struct[ThisNode.NodeName];
            TempCollection[2] = CurrentNode;
            Attributes.Struct[ThisNode.NodeName] = TempCollection; 
          }
        }else // Single element
          Attributes.Struct[ThisNode.NodeName] = CurrentNode; 
      </cfscript>
      
      <!--- Recurse if children nodes exist --->
      <cfif ThisNode.hasChildNodes()>
        <cf_SOXML action="XML2CF" init="0" struct="#CurrentNode#" node="#ThisNode#">
      <cfelse>
        <cfset CurrentNode.Value = "">
      </cfif>    
      
    </cfcase>
    <cfcase value="3,4">
      <cfset Attributes.Struct.Value = ThisNode.NodeValue>
    </cfcase>
    <cfcase value="8">
      <cfset Attributes.Struct.Comment = ThisNode.NodeValue>
    </cfcase>
    </cfswitch>
  </cfloop>

  <cfif Attributes.Init>
  <!--- Return the new structure to the calling template --->
  <cfset "Caller.#Attributes.Output#"= Attributes.Struct>
  </cfif>
</cfcase>

<!--- ~~~~~XML2DOM~~~~ --->
<!--- Loads XML into DOM      --->
<!--- ~~~~~~~~~~~~~~~~ --->
<cfcase value="XML2DOM">

  <cfparam name="Attributes.Input">
  <cfparam name="Attributes.Output">
  <cfparam name="Attributes.Type" default="Variable">
  
  <cfobject action="CREATE" class="#Attributes.ProgId#" type="COM" name="XMLDoc">
  
  <cfscript>
      XMLDoc.async = 0;
      if (Len(Attributes.Input)) {
        if (Attributes.Type eq "File")
          XMLDoc.Load(Attributes.Input);
        else
          XMLDoc.loadXML(Attributes.Input);
      }
      oParseError = XMLDoc.ParseError;
  </cfscript>
  
  <cfif oParseError.ErrorCode>
    <cfthrow type="SOXML.ParseError" message="DOM Error" detail="#oParseError.Reason# | Line:#oParseError.Line#">
  </cfif>
    
  <cfset "Caller.#Attributes.Output#"= XMLDoc>

</cfcase>

<!--- ~~~~~Transform~~~~~~~~~~~~   --->
<!--- Transforms XML from XSL Template   --->
<!--- ~~~~~~~~~~~~~~~~~~~~~~~~   --->
<cfcase value="Transform">

  <cfparam name="Attributes.Input">
  <cfparam name="Attributes.Type" default="Variable">  
  <cfparam name="Attributes.XSLInput">  
  <cfparam name="Attributes.XSLType" default="File">
  <cfparam name="Attributes.Output">    
  <cfparam name="Attributes.r_Type" default="Text">
  
  <!--- Load the XSL Document --->
  <cf_SOXML action="XML2DOM" progid="#Attributes.ProgId#" input="#Attributes.XSLInput#" output="XSLDoc" type="#Attributes.XSLType#"> 
  <!--- Load the XML Document --->
  <cf_SOXML action="XML2DOM" progid="#Attributes.ProgId#" input="#Attributes.Input#" output="XMLDoc" type="#Attributes.Type#">
  <cfif Attributes.r_Type EQ "Object">
    <!--- Create a result xml DOM object --->
    <cf_SOXML action="XML2DOM" progid="#Attributes.ProgId#" input="" output="oResult">    
    <cfscript>// Do the transformation
      XMLDoc.transformNodeToObject(XSLDoc,oResult);     
      "Caller.#Attributes.Output#" = oResult;
    </cfscript>    
  <cfelse>
    <cfscript>// Do the transformation
        sResult = XMLDoc.transformNode(XSLDoc);      
        "Caller.#Attributes.Output#" = sResult;
    </cfscript>  
  </cfif>
</cfcase>

<!--- ~~~~~XML2HTML~~~~~~~ --->
<!--- Output XML to HTML inline    --->
<!--- ~~~~~~~~~~~~~~~~~~~ --->
<cfcase value="XML2HTML">

  <cfparam name="Attributes.Input">
  <cfparam name="Attributes.Type" default="Variable">
  
  <cf_SOXML action="Transform" input="#Attributes.Input#" type="#Attributes.Type#" xslinput="http://www.siteobjects.com/downloads/soxml.xsl" xsltype="File" output="strValue" r_type="Text">
  
  <cfoutput>#strValue#</cfoutput>

</cfcase>

<!--- ~~INVALID ACTION~~ --->
<!---        Throw error           --->
<!--- ~~~~~~~~~~~~~~~ --->
<cfdefaultcase>
  <cfthrow type="SOXML.Error" message="cf_SOXML Error" detail="Invalid action">
</cfdefaultcase>

</cfswitch>
<cfsetting enablecfoutputonly="No">















