<!---
*****************************************************************************************************
*Author: Jon Wallen                                                                                 *
*www.cfshopkart.com                                                                                 *
*                                                                                                   *
*                                                                                                   *
*Performs an insert or an update on a db table.  Form fields that match data columns are updated or *
*inserted.  I developed this CFC because I was tired of writing long insert and update queries.     *
*All you need to do is make sure you type the name of the form field exactly as you have named      *
*the column  If you do not want to update the field just leave the form field out or make sure it's *
*named something different than the column.                                                         *
*                                                                                                   *
*Version:  1.1                                                                                      *
*License:  Freeware.  You may redistribute this code as long as these comments are not removed      *
*          If you make changes please change the version number and add your name and email it to   *
*          me: sales@cfshopkart.com                                                                 *
*****************************************************************************************************

Revision History:

1.1 - Add check for blank field.  Now sets field to empty if form field is blank instead of ignoring it.

Sample use:

Say you have a table name myTable setup in a Coldfusion Datasource called myDSN and it has the 
columns FirstName(VARCHAR), LastName(VARCHAR), IDNumber(VARCHAR), and ID(INT; AUTOINCREMENT).
Your form would have form fields with the same names (i.e. <input type = "text" name="FirstName" size="30" value="#FirstName#">)
On the page where you call for an update or insert, instead of doing a <cfquery> just invoke this cfc like this:

Valid methods:  updatedata 
				insertdata

<cfinvoke component="dbqueries" method="updatedata" returnvariable="outputmsg">
	<cfinvokeargument name="tablename" value="mytable">
	<cfinvokeargument name="dbname" value="myDSN">
	<cfinvokeargument name="wherestring" value="WHERE id = '#form.menuid#'">
</cfinvoke>

tablename (required):  The name of the table in your db you want to insert into or update.
dbname (required): The datasource name you setup in your cf administrator.
dbuser (optional): The username for the datasource.
dbpass (optional): The CustPassword for the datasource.
wherestring (required for updatedata): The full sql WHERE string if you want to udpate a specific record (i.e. WHERE id = 1).
--->
<cfcomponent>
	
	<!---****INSERTS*****---->
	<cffunction name="Insertdata" returntype="string" description="Performs an insert on a db table">
	<cfargument name = "tablename" type="string" required="yes" hint="Enter the name of the table you want to insert into">
	<cfargument name = "dbname" type="string" required="yes" hint="Enter the dsn to perform this action against.">
	<cfargument name = "dbuser" type="string" required="No" default="" hint="dsn username (optional)">
	<cfargument name = "dbpass" type="string" required="No" default="" hint="dsn Password (optional)">

	<!---Get the columns in the called table--->
	<cfquery name = "qryCols" datasource="#dbname#" username="#dbuser#"Password="#dbpass#">
	SELECT * FROM #tablename#
	</cfquery>
	
	<cfset colsmeta=getMetaData(qryCols)>
	
	<cfset cList = qryCols.columnlist>
	<cfset icount = 0>
		
	<!---Insert default values passed into corresponding columns--->
	<cfquery name = "qInsertData" datasource="#dbname#" username="#dbuser#" Password="#dbpass#">
	INSERT INTO #tablename#
	(<cfloop from = "1" to="#listlen(cList)#" index="cCount">
		<cfset thiscol = listgetat(cList, cCount)>
		<cfset thiscol = lcase(thiscol)>
		<cfset thisvar = "form.#thiscol#">
		<!---If the corresponding form field is found then insert into db (this portion builds the list of columns)--->
		<cfif isdefined(thisvar)>
		<cfset icount = icount + 1>
		<cfset thisval = '#evaluate(thisvar)#'>
			<cfif icount IS 1>#thiscol#<cfelse>,#thiscol#</cfif>
		</cfif>
	</cfloop>)
	VALUES
	(<cfset icount = 0><cfloop from = "1" to="#listlen(cList)#" index="vCount">
	<!---This section builds the values to insert into each corresponding column (forms must be named after their db column)--->
		<cfset thiscol = listgetat(cList, vCount)>
		<cfset thiscol = lcase(thiscol)>
		<cfset thisvar = "form.#thiscol#">
		<cfif isdefined(thisvar)>
		<cfset icount = icount + 1>
		<cfset thisval = '#evaluate(thisvar)#'>
		<cfset coltype = #qryCols.GetMetaData().GetColumnTypeName(JavaCast( 'int', vCount ))#>
			<!---Determine if we are at the start of the list, if not then put in a leading comma--->
			<cfif icount IS 1>
				<!---Determine if the value for this field needs quotes (string) or not (numeric/datetime)--->
				<cfif coltype IS 'VARCHAR' OR coltype IS 'LONGTEXT' OR coltype IS 'TEXT' OR coltype IS 'MEDIUMTEXT'
				OR coltype IS 'BLOB'>
				'#evaluate(thisvar)#'<cfelse>#evaluate(thisvar)#</cfif>
				<!---Otherwise it's the end of the statement so don't put a trailing comma--->
			<cfelse>
				<!---Same as above: determine column type--->
				<cfif coltype IS 'VARCHAR' OR coltype IS 'LONGTEXT' OR coltype IS 'TEXT' OR coltype IS 'MEDIUMTEXT'
				OR coltype IS 'BLOB'>
					,'#evaluate(thisvar)#'<cfelse>,#evaluate(thisvar)#
				</cfif>
			</cfif>
		</cfif>
	</cfloop>)
	</cfquery>
	</cffunction>
	
	<!---****UPDATES*****---->
	<cffunction name="updatedata" returntype="string" description="Performs an update on a db table">
	<!---Table name must be defined--->
	<cfargument name = "tablename" type="string" required="yes" hint="Enter the name of the table you want to update">
	<cfargument name = "wherestring" type="string" required="yes" hint="Full WHERE statement for update query">
	<cfargument name = "dbname" type="string" required="yes" hint="Enter the dsn to perform this action against">
	<cfargument name = "dbuser" type="string" required="No" default="" hint="dsn username (optional)">
	<cfargument name = "dbpass" type="string" required="No" default="" hint="dsn Password (optional)">
	
	<!---Get the columns in the called table--->
	<cfquery name = "qryCols"datasource="#dbname#" username="#dbuser#" Password="#dbpass#">
	SELECT * FROM #tablename#
	</cfquery>
	
	<cfset colsmeta=getMetaData(qryCols)>
	
	<cfset cList = qryCols.columnlist>
	<cfset icount = 0>
	
	<cfquery name = "qUpdatedata" datasource="#dbname#" username="#dbuser#" Password="#dbpass#">
	UPDATE #tablename#
	SET <cfloop from = "1" to="#listlen(cList)#" index="cCount">
			<cfset thiscol = listgetat(Clist, cCount)>
			<cfset thiscol = lcase(thiscol)>
			<cfset thisvar = "form.#thiscol#">
			<cfif isdefined(thisvar)>
				<cfset thisval = '#evaluate(thisvar)#'>
					<cfset coltype = colsmeta[cCount].TypeName>
					<!---If it's a type that is a string then include quotes around the value--->
					<cfif coltype IS 'VARCHAR' OR coltype IS 'LONGTEXT' OR coltype IS 'TEXT' OR coltype IS 'MEDIUMTEXT'
					OR coltype IS 'BLOB' OR coltype IS 'MEMO'>
						<cfset icount = icount + 1>
						<!---If it's the first one then do not include a comma--->		
						<cfif iCount IS 1>
							#thiscol#='#thisval#'
						<!---If it's after the first one then put a leading comma in--->
						<cfelse>
						<cfif len(thisval) GT 0>
                        	,#thiscol#='#thisval#'
                        <cfelse>
                        	,#thiscol#=''
                        </cfif><!---End if the length is GT 0--->
						</cfif>
					<!---If not, then do not include the quotes--->
					<cfelse>
						<cfif isnumeric(thisval)>
							<cfset icount = icount + 1>
							<cfif iCount IS 1>
								#thiscol#=#thisval#
							<cfelse>
							<cfif len(thisval) GT 0>
                            	,#thiscol#=#thisval#
                            </cfif><!---End if the lenght is GT 0--->
							</cfif>
					</cfif><!---end if the value is a number--->
				</cfif><!---End if it's a string type field--->				
			</cfif><!---End if the form field is present--->
		</cfloop>
	#replacenocase(wherestring, "''", "'", "ALL")#
	</cfquery>
	</cffunction>
</cfcomponent>