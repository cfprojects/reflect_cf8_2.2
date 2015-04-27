<cfcomponent name="InvocationHandler">
	<cffunction name="invokeMethod" output="no" access="private">
		<cfargument name="proxy" type="WEB-INF.cftags.component" />
		<cfargument name="method" type="reflect.Method" />
		<cfargument name="args" type="struct" />
	</cffunction>
</cfcomponent>