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

    	returnStruct["data"] = current + 1;
        return rep(returnStruct);
    }

}