component extends="taffy.core.resource" taffy_uri="/v1/admin" {

	/**
	* @hint "Helper webservice to check authtable"
	*/
    function get(){
    	var returnStruct = StructNew();
    	returnStruct["data"] = StructNew();

    	param name="application.authtable" default=StructNew();

		returnStruct["data"]["authtable"] = application.authtable;

        return rep(returnStruct);
    }

}