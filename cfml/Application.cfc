component extends="taffy.core.api" {

	this.name = "rest-challenge-taffy";
	THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 1, 0 );

	this.mappings['/resources'] = expandPath('./resources');
	this.mappings['/taffy'] = expandPath('./taffy');

}