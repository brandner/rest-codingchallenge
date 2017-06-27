component extends="taffy.core.resource" taffy_uri="/v1/next" {

	/**
	* @hint "Get current integer value, plus one"
	*/
    function get(){
    	var returnStruct = StructNew();

    	// get current value from the table
    	var current = application.authtable[arguments.key].current;

    	// increment
    	application.authtable[arguments.key].current = current + 1;

		returnStruct["data"]["type"] = "integers as a service";
    	returnStruct["data"]["atributes"]["integer"] = current + 1;
    	returnStruct["links"]["self"] = "//" & CGI.SERVER_NAME & CGI.SCRIPT_NAME & "/v1/current";
    	returnStruct["links"]["next"] = "//" & CGI.SERVER_NAME & CGI.SCRIPT_NAME & "/v1/next";
        return rep(returnStruct);
    }

}