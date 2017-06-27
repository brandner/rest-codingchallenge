component extends="taffy.core.resource" taffy_uri="/v1/register" {

	/**
	* @hint "Register for a bearer token key"
	* @arg1 Valid email address
	* @arg2 Password string, more than 3 characters
	*/
    function post(
    	required string email,
    	required string password
    	){
    	var returnStruct = StructNew();

		// validate input
		if(NOT IsValid("email",arguments.email)) {
			returnStruct["error"]["errors"]["status"] = "400 Bad Request";
			returnStruct["error"]["errors"]["code"] = "400";
			returnStruct["error"]["errors"]["title"] = "Bad Request";
			returnStruct["error"]["code"] = "400";
			returnStruct["error"]["message"] = "Invalid email";

			return rep(returnStruct).withStatus(400, returnStruct["error"]["message"]);
		}
		if(NOT Len(Trim(arguments.password)) GT 3) {
			returnStruct["error"] = StructNew();
			returnStruct["error"]["errors"] = StructNew();
			returnStruct["error"]["errors"]["status"] = "400 Bad Request";
			returnStruct["error"]["errors"]["code"] = "400";
			returnStruct["error"]["errors"]["title"] = "Bad Request";
			returnStruct["error"]["code"] = "400";
			returnStruct["error"]["message"] = "Invalid password";

			return rep(returnStruct).withStatus(400, returnStruct["error"]["message"]);
		}

		param name="application.authtable" default=StructNew();

    	// check to see if email exists without password
    	var authMatches = StructFindValue(application.authtable, arguments.email);
    	if(NOT ArrayIsEmpty(authMatches)) {
    		// array is not empty - check the password
    		if(authMatches[1].owner.password NEQ Hash(arguments.password)) {

				returnStruct["error"] = StructNew();
				returnStruct["error"]["errors"] = StructNew();
				returnStruct["error"]["errors"]["status"] = "401 Not Authorized";
				returnStruct["error"]["errors"]["code"] = "401";
				returnStruct["error"]["errors"]["title"] = "Not Authorized";
				returnStruct["error"]["code"] = "401";
				returnStruct["error"]["message"] = "Invalid password";

				return rep(returnStruct).withStatus(400, returnStruct["error"]["message"]);
    		}

			returnStruct["data"] = StructNew();
    		returnStruct["data"]["type"] = "registration";
    		returnStruct["data"]["atributes"] = StructNew();
    		returnStruct["data"]["atributes"]["apikey"] = ListFirst(authMatches[1].path,".");

        	return rep(returnStruct).withStatus(200);
    	}

		// create a new registration
    	var key = Right(CreateUUID(),8);

		// add to auth table
		application.authtable[key] = StructNew();
		application.authtable[key].password = Hash(arguments.password);
		application.authtable[key].email = arguments.email;
		application.authtable[key].current = 0;

		returnStruct["data"]["type"] = "registration";
		returnStruct["data"]["atributes"] = StructNew();
    	returnStruct["data"]["atributes"]["apikey"] = key;

        return rep(returnStruct).withStatus(201);
    }

}