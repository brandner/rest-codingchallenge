component extends="taffy.core.resource" taffy_uri="/v1/register" {

	/**
	* @hint "Register for a bearer token key"
	* @arg1 Valid email address
	* @arg2 Password string, more than 3 characters
	* @returnType string
	*/
    function post(
    	required string email,
    	required string password
    	){
    	var returnStruct = StructNew();

		// validate input
		if(NOT IsValid("email",arguments.email)) {
			return noData().withStatus(401, "Invalid email");
		}
		if(NOT Len(Trim(arguments.password)) GT 3) {
			return noData().withStatus(401, "Invalid password");
		}

		param name="application.authtable" default=StructNew();

    	// check to see if email exists without password
    	var authMatches = StructFindValue(application.authtable, arguments.email);
    	if(NOT ArrayIsEmpty(authMatches)) {
    		// array is not empty - check the password
    		if(authMatches[1].owner.password NEQ arguments.password) {
    			return noData().withStatus(401, "Invalid password");
    		}

    		returnStruct["key"] = ListFirst(authMatches[1].path,".");
        	return rep(returnStruct).withStatus(200);
    	}

		// create a new registration
    	var key = Right(CreateUUID(),8);

		// add to auth table
		application.authtable[key] = StructNew();
		application.authtable[key].password = arguments.password;
		application.authtable[key].email = arguments.email;
		application.authtable[key].current = 0;

		returnStruct["key"] = key;

        return rep(returnStruct).withStatus(201);
    }

}