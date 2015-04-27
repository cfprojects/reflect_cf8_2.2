<cfcomponent name="MetaDataInjector"
			 extends="reflect.FunctionDataInjector">

	<cffunction name="init" access="public" output="no">
		<cfargument name="metaData" required="yes" hint="Metadata should be the full metadata for the component from the getMetaData() function call." />

		<cfset super.init( arguments.metaData ) />

		<cfreturn this />
	</cffunction>

	<cffunction name="injectMethods" access="public" output="no" returntype="array">
		<cfargument name="className" type="string" required="yes" />

		<cfset var x = "" />
		<cfset var methodArray = arrayNew(1) />
		<cfset var methodStruct = recurseMethods( variables._metaData, arguments.className ) />

		<cfloop list="#structKeyList( methodStruct )#" index="x">
			<cfset arrayAppend( methodArray, methodStruct[ x ] ) />
		</cfloop>

		<cfreturn methodArray />
	</cffunction>

	<cffunction name="recurseMethods" access="private" output="no">
		<cfargument name="metaData" required="yes" />
		<cfargument name="className" required="yes" />

		<cfset var x = 0 />
		<cfset var methodStruct = structNew() />

		<!--- Load the methods from ancestor to child.  This will make sure overriding methods replace their super's method in the catalog --->
		<cfif structKeyExists( arguments.metaData, "extends" ) AND arguments.metaData.extends.name neq "WEB-INF.cftags.component">
			<cfset methodStruct = recurseMethods( arguments.metaData.extends, arguments.className ) />
		</cfif>

		<cfloop from="1" to="#arrayLen( arguments.metaData.functions )#" index="x">
			<cfif NOT structKeyExists( arguments.metaData.functions[ x ], "access" ) OR arguments.metaData.functions[ x ].access neq "private">
				<cfset methodStruct[ arguments.metaData.functions[ x ].name ] = extractFunction( arguments.className, arguments.metaData.functions[ x ] ) />
			</cfif>
		</cfloop>

		<cfreturn methodStruct />
	</cffunction>
</cfcomponent>
