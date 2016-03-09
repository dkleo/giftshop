<CFSETTING ENABLECFOUTPUTONLY="YES">
<!--- 
CF_ObjectDump is a Development Tool for quickly displaying 
the contents of complex CFML objects.  CF_ObjectCalls itself
recursively until no more complex object are available.

Support is included for WDDX deserialization

Attributes:
Object - The object 
Deserialize - Yes or No (Default is yes) for deserializing WDDX versus showing the WDDX as a string

Other attributes are included for manipulating the display.  See below for details

A Check to make sure the tag is not executed more than 5,000 times is included to prevent server crashes

No Extra White space is output to the browser

NOTE: AT THIS TIME CF_ObjectDump does not support self-referencing structures

Author: Nathan Dintenfass & Ben Archibald	
nathan@changemedia.com & ben@changemedia.com
1/24/99
Copyright 1999 ChangeMedia, Inc. 


Updated 9/8/1999 to accomodate Binary Data Types in CF 4.5

This code may be used provided this copyright notice is retained 
 --->

<!--- 
INITIALIZE A DEFAULT OBJECT
--->
<CFPARAM NAME="attributes.Object" DEFAULT="No Object Was Passed!">

<!--- MAKE THE OBJECT LOCAL SO INHERIT BELOW DOES NOT OVERWRITE --->
<CFSET LocalObject = attributes.Object>

<!--- 
CHECK TO SEE IF RUNNING IN CONTEXT OF CF_ObjectDump 
and Inherit Attributes 
--->
<CFIF ListContains(ListRest(getbasetaglist()),"CF_OBJECTDUMP")>
	<CFSET attributes = caller.attributes>
<!--- If this is the developer's call to the tag, initialize default attributes --->
<CFELSE>
	<!--- DESERIALIZE IF WDDX BY DEFAULT --->
	<CFPARAM NAME="attributes.Deserialize" DEFAULT="yes">
	<!--- ALLOW FONT AND SIZE TO BE PASSED IN --->
	<CFPARAM NAME="attributes.font" DEFAULT="verdana,Arial">
	<CFPARAM NAME="attributes.fontsize" DEFAULT="1">
	<!--- ALLOW COLORS TO BE PASSED IN --->
	<CFPARAM NAME="attributes.QueryColor" DEFAULT="FFCCFF">
	<CFPARAM NAME="attributes.StructColor" DEFAULT="FFFFCC">
	<CFPARAM NAME="attributes.ArrayColor" DEFAULT="CCFFFF">
	<CFPARAM NAME="attributes.BinaryColor" DEFAULT="CCCCCC">
	<CFPARAM NAME="attributes.SimpleColor" DEFAULT="CCCCCC">
	<CFPARAM NAME="attributes.TitleBGColor" DEFAULT="666666">
	<!--- ALLOW TABLE DISPLAY PARAMETERS TO BE PASSED IN --->
	<CFPARAM NAME="attributes.Cellpadding" DEFAULT="1">
	<CFPARAM NAME="attributes.Cellspacing" DEFAULT="0">
	<CFPARAM NAME="attributes.border" DEFAULT="1">	
	<!--- SET A LIMIT ON THE NUMBER OF INSTANCES OF THE TAG --->
	<CFPARAM NAME="attributes.AllowedInstances" DEFAULT="3000">
</CFIF>

<!--- 
PUT IT IN A QUICK CHECK TO PREVENT TOO MANY INSTANCES
--->
<CFPARAM NAME="attributes.instancenumber" DEFAULT="0">
<CFSET attributes.instancenumber = attributes.instancenumber + 1>
<CFIF attributes.instancenumber GT attributes.allowedinstances>
	<CFOUTPUT>SORRY, THE THRESHOLD OF #attributes.allowedinstances# INSTANCES WAS HIT IN CF_ObjectDump 
	SO YOUR MACHINE WON'T CRASH.<BR>
	YOU CAN SET THIS NUMBER WITH AN ATTRIBUTE CALLED AllowedInstances.</CFOUTPUT>
	<CFABORT>
</CFIF>

<!--- 
CHECK TO SEE IF THE OBJECT IS A WDDX PACKET
 --->
<CFTRY>
	<CFSET IsPacket = 1>
	<CFWDDX ACTION="WDDX2CFML" INPUT="#LocalObject#" OUTPUT="ThePacket">
	<CFCATCH>
		<CFSET IsPacket = 0>
	</CFCATCH>
</CFTRY>

<!--- IF IT IS A PACKET, SEND TO THE LocalObject or Format for output if not Deserializing --->
<CFIF IsPacket>
	<CFIF attributes.Deserialize>
		<CFSET LocalObject = ThePacket>
	<CFELSE>
		<CFSET LocalObject = htmlcodeformat(LocalObject)>
	</CFIF>
</CFIF>

<!--- 
DETERMINE THE TYPE OF OBJECT 
SET NECESSARY OUTPUT VARIABLES
--->

<CFIF IsQuery(LocalObject)>	
	<CFSET Type = "Query">
	<CFSET Colspan = ListLen(LocalObject.columnlist)>
	<CFSET Label = "QUERY OF #LocalObject.recordcount# ROWS">
	<CFSET Color = attributes.QueryColor>
<CFELSEIF IsStruct(LocalObject)>
	<CFSET Type = "Structure">
	<CFSET Colspan = StructCount(LocalObject)>
	<CFSET Label = "STRUCTURE WITH #StructCount(LocalObject)# KEYS">
	<CFSET Color = attributes.StructColor>
<CFELSEIF IsArray(LocalObject)>
	<CFSET Type = "Array">
	<CFSET ColSpan = ArrayLen(LocalObject)>
	<CFSET Label = "ARRAY OF #ArrayLen(LocalObject)# ELEMENTS">	
	<CFSET Color = attributes.ArrayColor>
<CFELSEIF IsBinary(LocalObject)>
	<CFSET Type = "Binary">
	<CFSET Colspan = "1">
	<CFSET Label = "BINARY OBJECT OF #len(LocalObject)# BYTES">
	<CFSET Color = attributes.BinaryColor>	
<CFELSE>
	<CFSET Type = "Simple">
	<CFSET Colspan = "1">
	<CFSET Label = "SIMPLE VALUE">
	<CFSET Color = attributes.SimpleColor>	
</CFIF>

<!--- 
IF THE OBJECT WAS DESERIALIZED
ADD A FLAG TO THE LABEL
 --->
<CFIF IsPacket>
	<CFSET Label = Label & " (was WDDX)">
</CFIF>

<!--- IF A SIMPLE VALUE, CHECK FORMATTING AND OUTPUT THE EXIT ---> 
<CFIF IsSimpleValue(LocalObject)>
	<!--- IF IT IS AN EMPTY STRING, MAKE IT A NON-BREAKING SPACE FOR FORMATTING --->
	<CFIF NOT len(trim(LocalObject))>
		<CFSET LocalObject = "&nbsp;">
	</CFIF>
	<!--- OUTPUT THE STRING --->
	<CFOUTPUT><FONT FACE="#attributes.font#" SIZE="#attributes.fontsize#">#LocalObject#</FONT></CFOUTPUT>	
	<!--- EXIT THE TAG --->
	<CFEXIT>
<CFELSE>
	<!--- MAKE AN HTML TABLE TO FORMAT OUTPUT ---> 
	<CFOUTPUT><TABLE BORDER="#attributes.border#" CELLPADDING="#attributes.cellpadding#" CELLSPACING="#attributes.cellspacing#" BGCOLOR="#Color#"></CFOUTPUT>	
	<!--- MAKE A LABEL FOR THE QUERY OBJECT --->
	<CFOUTPUT><TR></CFOUTPUT>
		<CFOUTPUT><TD COLSPAN="#ColSpan#" BGCOLOR="#attributes.TitleBGColor#"></CFOUTPUT>
			<CFOUTPUT><FONT FACE="#attributes.font#" SIZE="#attributes.fontsize#" COLOR="FFFFFF">#Label#</FONT></CFOUTPUT>
		<CFOUTPUT></TD></CFOUTPUT>
	<CFOUTPUT></TR></CFOUTPUT>
	<CFOUTPUT><TR></CFOUTPUT>
</CFIF>	
	
<!--- 
SWITCH ON THE DIFFERENT TYPES FOR OUTPUT
 --->	
<CFSWITCH EXPRESSION="#Type#">
	<!--- IF A QUERY, DUMP IT TO THE SCREEN --->	
	<CFCASE VALUE="Query">
		<!--- OUTPUT THE COLUMN NAMES --->
		<CFLOOP LIST="#LocalObject.columnlist#" INDEX="ColumnName">
			<CFOUTPUT><TD valign="top"></CFOUTPUT>	
				<CFOUTPUT><B></CFOUTPUT>
				<CFSETTING ENABLECFOUTPUTONLY="NO">
				<CF_ObjectDump Object="#ColumnName#"><CFOUTPUT></B></CFOUTPUT>
			<CFOUTPUT></TD></CFOUTPUT>	
		</CFLOOP>
		<CFOUTPUT></TR></CFOUTPUT>	
		<!--- OUTPUT OVER EACH ROW --->
		<CFLOOP FROM="1" TO="#LocalObject.recordcount#" INDEX="RowIndex">
			<CFOUTPUT><TR></CFOUTPUT>
			<!--- LOOP THROUGH EACH COLUMN FOR EACH ROW --->
			<CFLOOP LIST="#LocalObject.columnlist#" INDEX="ColumnName">
				<CFOUTPUT><TD valign="top"></CFOUTPUT>
					<CFSETTING ENABLECFOUTPUTONLY="NO">
					<CF_ObjectDump Object="#LocalObject[ColumnName][RowIndex]#">
				<CFOUTPUT></TD></CFOUTPUT>
			</CFLOOP>		
			<CFOUTPUT></TR></CFOUTPUT>
		</CFLOOP>	
	</CFCASE>	
	<!--- IF THE OBJECT IS A STRUCTURE --->
	<CFCASE VALUE="Structure">
			<!--- OUTPUT THE KEYS OF THE STRUCTURE --->
			<CFLOOP COLLECTION="#LocalObject#" ITEM="KeyName">
				<CFOUTPUT><TD valign="top"></CFOUTPUT>	
					<CFOUTPUT><B></CFOUTPUT>
					<CFSETTING ENABLECFOUTPUTONLY="NO">
					<CF_ObjectDump Object="#KeyName#"><CFOUTPUT></B></CFOUTPUT>
				<CFOUTPUT></TD></CFOUTPUT>	
			</CFLOOP>
			<CFOUTPUT></TR></CFOUTPUT>	
			<CFOUTPUT><TR></CFOUTPUT>
			<!--- DUMP THE VALUE OF EACH KEY --->
			<CFLOOP COLLECTION="#LocalObject#" ITEM="KeyName">
				<CFOUTPUT><TD valign="top"></CFOUTPUT>	
					<CFSETTING ENABLECFOUTPUTONLY="NO">
					<CF_ObjectDump Object="#LocalObject[KeyName]#">
				<CFOUTPUT></TD></CFOUTPUT>	
			</CFLOOP>
			<CFOUTPUT></TR></CFOUTPUT>	
	</CFCASE>	
	<!--- IF THE OBJECT IS AN ARRAY --->
	<CFCASE VALUE="Array">
			<!--- LOOP THROUGH THE ARRAY AND DUMP EACH ELEMENT --->
			<CFLOOP FROM="1" TO="#ArrayLen(LocalObject)#" INDEX="Index">
				<CFOUTPUT><TD valign="top"></CFOUTPUT>	
					<CFSETTING ENABLECFOUTPUTONLY="NO">
					<CF_ObjectDump Object="#LocalObject[Index]#">
				<CFOUTPUT></TD></CFOUTPUT>	
			</CFLOOP>
			<CFOUTPUT></TR></CFOUTPUT>		
	</CFCASE>
	<CFCASE VALUE="Binary">
		<CFOUTPUT><TD valign="top"></CFOUTPUT>
		<CFSETTING ENABLECFOUTPUTONLY="NO">
		<CF_ObjectDump Object="[Binary Data]">
		<CFOUTPUT></TD></TR></CFOUTPUT>
	</CFCASE>
</CFSWITCH>
<CFOUTPUT></TABLE></CFOUTPUT>
<CFSETTING ENABLECFOUTPUTONLY="NO">
















