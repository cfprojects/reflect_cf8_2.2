<cfcomponent name="FunctionDataInjector"
			 implements="reflect.Injector">

	<cfset variables._metaData = "" />

	<cffunction name="init" access="public" output="no">
		<cfargument name="metaData" required="yes" hint="Metadata should be the full metadata for the component from the getMetaData() function call." />

		<cfset variables._metaData = arguments.metaData />

		<cfreturn this />
	</cffunction>

	<cffunction name="injectMethods" access="public" output="no" returntype="array">
		<cfargument name="className" type="string" required="yes" />

		<cfset var x = "" />
		<cfset var methodArray = arrayNew(1) />

		<cfloop from="1" to="#arrayLen( variables._metaData )#" index="x">
			<cfset arrayAppend( methodArray, extractFunction( arguments.className, variables._metaData[ x ] ) ) />
		</cfloop>

		<cfreturn methodArray />
	</cffunction>

	<cffunction name="extractFunction" access="private" output="no">
		<cfargument name="className" required="yes" />
		<cfargument name="functionData" required="yes" />

		<cfset var access = "public" />
		<cfset var returntype = "any" />

		<cfif structKeyExists( arguments.functionData, "access" )>
			<cfset access = arguments.functionData[ "access" ] />
		</cfif>
		<cfif structKeyExists( arguments.functionData, "returntype" )>
			<cfset returntype = arguments.functionData[ "returntype" ] />
		</cfif>

		<cfreturn createObject( "component", "reflect.Method" ).init( class="#arguments.className#",
																	  name="#arguments.functionData.name#",
																	  params="#arguments.functionData.parameters#",
																	  returntype="#returntype#",
																	  modifier="#access#" ) />
	</cffunction>
</cfcomponent>