component extends="taffy.core.resource" taffy_uri="/v1/current" {

	/**
	* @hint "Get current integer value"
	*/
    function get(){
    	var returnStruct = StructNew();

    	// get current value from the table
		var current = application.authtable[arguments.key].current;

    	returnStruct["data"]["type"] = "integers as a service";
    	returnStruct["data"]["atributes"]["integer"] = current;
    	returnStruct["links"]["self"] = "//" & CGI.SERVER_NAME & CGI.SCRIPT_NAME & "/v1/current";
    	returnStruct["links"]["next"] = "//" & CGI.SERVER_NAME & CGI.SCRIPT_NAME & "/v1/next";
        return rep(returnStruct);
    }

	/**
	* @hint "Put a new integer value"
	*/
    function put(required numeric current=0){
    	var returnStruct = StructNew();

    	// set current value in the table
    	application.authtable[arguments.key].current = arguments.current;

		returnStruct["data"]["type"] = "integers as a service";
    	returnStruct["data"]["atributes"]["integer"] = arguments.current;
    	returnStruct["links"]["self"] = "//" & CGI.SERVER_NAME & CGI.SCRIPT_NAME & "/v1/current";
    	returnStruct["links"]["next"] = "//" & CGI.SERVER_NAME & CGI.SCRIPT_NAME & "/v1/next";
        return rep(returnStruct);
    }

}