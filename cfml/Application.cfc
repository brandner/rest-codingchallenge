component extends="taffy.core.api" {

	this.name = "rest-challenge-taffy";

	// mapping to the taffy directories
	this.mappings['/resources'] = expandPath('./resources');
	this.mappings['/taffy'] = expandPath('./taffy');

	// function runs when the application starts up
	function onApplicationStart() {
		application.authtable = StructNew();
		application.authtable["tonytony"] = StructNew();
		application.authtable["tonytony"].password = Hash("1234");
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

			var returnStruct = StructNew();
			returnStruct["error"] = StructNew();
			returnStruct["error"]["errors"] = StructNew();
			returnStruct["error"]["errors"]["status"] = "401 Not Authorized";
			returnStruct["error"]["errors"]["code"] = "401";
			returnStruct["error"]["errors"]["title"] = "Not Authorized";
			returnStruct["error"]["code"] = "401";
			returnStruct["error"]["message"] = "Authorization bearer token required";

			return rep(returnStruct).withStatus(200, returnStruct["error"]["message"]);
		}

		// check auth here - first get the token
		var key = Trim(ReplaceNoCase(arguments.headers.authorization,"Bearer",""));

		param name="application.authtable" default=StructNew();

		// see if we have that key registered
		if(NOT StructKeyExists(application.authtable, key)) {

			var returnStruct = StructNew();
			returnStruct["error"] = StructNew();
			returnStruct["error"]["errors"] = StructNew();
			returnStruct["error"]["errors"]["status"] = "401 Not Authorized";
			returnStruct["error"]["errors"]["code"] = "401";
			returnStruct["error"]["errors"]["title"] = "Not Authorized";
			returnStruct["error"]["code"] = "401";
			returnStruct["error"]["message"] = "API Key not found";

			return rep(returnStruct).withStatus(401, returnStruct["error"]["message"]);
		}

		arguments.reqArgs.key = key;
		return true;
	}

}