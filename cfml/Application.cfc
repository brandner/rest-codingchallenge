component extends="taffy.core.api" {

	this.name = "rest-challenge-taffy";

	// mapping to the taffy directories
	this.mappings['/resources'] = expandPath('./resources');
	this.mappings['/taffy'] = expandPath('./taffy');

	// function runs when the application starts up
	function onApplicationStart() {
		application.authtable = StructNew();
		application.authtable["tonytony"] = StructNew();
		application.authtable["tonytony"].password = "1234";
		application.authtable["tonytony"].email = "tony@brandners.com";
		application.authtable["tonytony"].current = 0;

		return super.onApplicationStart();
	}

	// function runs early in the lifecycle of a Taffy request
	function onTaffyRequest(verb, cfc, reqArgs, mimeExt, headers){

		// special cases - allow register without a key
		if(cfc CONTAINS "register" OR cfc CONTAINS "admin") {
			return true;
		}

		// no authorization bearer token
		if(NOT StructKeyExists(arguments.headers, "authorization")) {
			return noData().withStatus(401, "No key presented");
		}

		// check auth here - first get the token
		var key = Trim(ReplaceNoCase(arguments.headers.authorization,"Bearer",""));

		param name="application.authtable" default=StructNew();

		// see if we have that key registered
		if(NOT StructKeyExists(application.authtable, key)) {
			return noData().withStatus(401, "Key not found");
		}

		arguments.reqArgs.key = key;
		return true;
	}

}