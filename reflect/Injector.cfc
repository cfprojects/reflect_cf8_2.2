<cfinterface name="Injector">
	<cffunction name="injectMethods" access="public" output="no" returntype="array">
		<cfargument name="className" type="string" required="yes" />
	</cffunction>
</cfinterface>