# Developer Challenge - Incrementing Ints As A Service

## Task - Develop a REST service that
1. Allows registration as a user via a REST endpoint that accepts an email address and a password and returns an API key.
2. Returns the next integer in a user's sequence when called, secured by an API key.
3. Fetches current integer, secured by API key.
4. Resets user's integer to an arbitrary, non-negative value, secured by API key.

## Challenge Notes
1. The service can be written in a language of your choosing.
2. Remove the need in the calling application for maintaining the state of the last integer.
4. The service should conform to the JSON API spec (http://jsonapi.org) as closely as possible.
5. No UI is necessary. If your service can be called using cURL, that is acceptable.
6. Your service can be sent to us as a zip file or as a link to the Github (or other) repository.
7. This challenge is slightly vague on purpose. Feel free to ask questions or ask for clarification.
8. Feel free to be creative with your solution.

## Implementation Notes
This solution was developed in CFML to be run on ACF or Lucee with the TaffyIO framework.

View demo here, including the UI for testing:
http://projects.brandners.com/rest-codingchallenge/cfml/

API key 'tonytony' is included by default for testing.

```
curl -X "POST" http://projects.brandners.com/rest-codingchallenge/cfml/index.cfm/v1/register --data "email=tony@brandners.com&password=1234"
curl http://projects.brandners.com/rest-codingchallenge/cfml/index.cfm/v1/next -H "Authorization: Bearer tonytony"
curl http://projects.brandners.com/rest-codingchallenge/cfml/index.cfm/v1/current -H "Authorization: Bearer tonytony"
curl -X "PUT" http://projects.brandners.com/rest-codingchallenge/cfml/index.cfm/v1/current -H "Authorization: Bearer tonytony" --data "current=1000"
```

### /v1/register
**POST** with parameters 'email' and 'password.

**Returns** API key.

### /v1/current
**GET** with HTTP authorization token header corresponding to a valid API key.

**Returns** the current integer in the sequence for the corresponding registered user.

**PUT** with a new 'current' value and HTTP authorization token header corresponding to a valid API key.

**Sets and returns** the current integer in the sequence for the corresponding registered user.

### /v1/next
**GET** with HTTP authorization token header corresponding to a valid API key.

**Returns** the next integer in the sequence for the corresponding registered user.

### /v1/admin
**GET** with no parameters.

For testing, returns the table of registered users and integer values.


## Concerns or questions
1. CFML was selected just for the shear ease of development. My development environment is ready and I use TaffyIO on a day to day basis.
2. This code stores a associative array (CFML structure) containing keys for each registered user. They are stored under the API key.
3. The regsitration data is stored in the "application" scope, and does not persist upon an application restart. It could be easily replaced with a different datastore.
4. Passwords are hashed so as to not be stored in readable format.
5. Web service calls return 401 errors if not authorized, via the onTaffyRequest() handler.
6. Additional calls can be made to /v1/register with the same username and password to recall the API key

## Links
In general, these were the only web pages that were open during the coding for this challenge:
- Adobe ColdFusion - http://www.adobe.com/ca/products/coldfusion-family.html
- Lucee Open Source CFML engine - http://lucee.org
- Taffy IO - http://taffy.io and https://github.com/atuttle/Taffy
- ColdFusion documentation - https://cfdocs.org
- JSONAPI documentation - http://jsonapi.org
