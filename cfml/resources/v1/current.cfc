component extends="taffy.core.resource" taffy_uri="/v1/current" {

	/**
	* @hint "Get current integer value"
	*/
    function get(){
    	var returnStruct = StructNew();

    	// get current value from the table
		var current = application.authtable[arguments.key].current;

    	returnStruct["data"] = current;
        return rep(returnStruct);
    }

	/**
	* @hint "Put a new integer value"
	*/
    function put(required numeric current=0){
    	var returnStruct = StructNew();

    	// set current value in the table
    	application.authtable[arguments.key].current = arguments.current;

    	returnStruct["data"] = arguments.current;
        return rep(returnStruct);
    }

}