
### Demographics resources

Resources that are involved in the response to a demographics query. In most queries the response will always be in a Bundle resource containing the resources that match the search. They will be a combination of Patient and other resources linked in a graph (or web) of resources by the references between them. The exception is when a query is retrieving a resource based on it's resource id - in which case the resource alone is 

The following diagram shows the relationship between the key resources.

<img style='width:75%; float:none' src="demographics.png"/>

The resources that are used are:

| Resource | Purpose/s |
| --- | --- |
| Patient | Represents the patient - the person receiving care  | 
| Practitioner | Represents a person delivering healthcare (regardless of qualification). Curently, this is used for the General Practitioner, but could also represent a doctor or nurse within a hospital |
Organization | A group responsible for delivering care. The DHB or General Practice is an example of this. |


<!--
| PractitionerRole | Is a link to a practitioner in a role - as well as a location and organization. It is used here to link the patient to their usual GP and GP Practice <a href="http://clinfhir.com/logicalModeller.html#awiqv" target="_blank">Model</a>|
| Location | Refers to a place where healthcare is delivered - in this case a Hospital <a href="http://clinfhir.com/logicalModeller.html#p8hy1" target="_blank">Model</a>|
| 
| Endpoint | Where information can be sent electronically <a href="http://clinfhir.com/logicalModeller.html#sbauk" target="_blank">Model</a>|

-->

Note that unlike the HPI, there is a direct reference from the Patient to the Practitioner or Organization. The HPI approach does add complexity, but allows significantly more flexibility, for example indicating the role that a Practitioner has at an Organization. especially where a single practitioner can habe multiple roles in different care settings. 

It is the responsibility of the client to correctly identify and process the resources that are returned in a query or referenced by a resource. For example the patients general practitioner is represented by the Patient.generalPractitioner element. This can be a reference to:
* the actual Practitioner resource (if that is known)
* an Organization that represents the practice
* or both. (In this implementation, a PractitionerRole will not be returned)

There are actually a number of responsibilities for a FHIR client to safely use the API - as detailed in the [safety page](http://hl7.org/fhir/safety.html) of the spec.

_(Each resource will likely have it's own API to be used by the client application assembling the Discharge Summary. However, there are a number of ways that the APIs can be structured according the the details of the use case - and the degree to which the 'work' should be performed by the client or the server. For example the client could first retrieve the Encounter resource, then the individual linked resources via separate calls. Alternatively, there could be a custom operation that retrieves all the resource in a single call - though this is a less flexible approach, and can require client customization.)_


### Notes

It is important to distinguish between the id of a resource, and an identifier that it may contain.
* The resource id is part of it's 'location' on the server. It allows a resource to be retrieved across a RESTful interface using a combination of the Server, resource type and id using the pattern __[server url]/{resource type}/{id}__. For example, http://test.org/fhir/Patient/100  would return the Patient resource with an id of 100 from the server at http://test.org/fhir/ (if it exists). If a resource is copied form one server to another, the id will almost certainly change
* The identifier is  a property of the resource, and will not change if the resource is copied between servers. An example of an identifier is the [NHI](), but they are widely used in FHIR. To retrieve a required based on it's identifier use a query of the form: http://test.org/fhir/Patient?identifier=ABC1234. Unlike the retrieval by id, this query will return a [Bundle](http://hl7.org/fhir/bundle.html) containing the matching resources. More advanced queries can be made - see the [FHIR Spec](http://hl7.org/fhir/http.html) for details, and the [API](api.html) page in this spec for what is supported by healthAlliance.



<!--
### Laboratory test

Resources involved in Lab test reporting - especially blood tests and swabs.

<img style='width:75%; float:none' src="fbc.png"/>

| Resource | Purpose/s |
| --- | --- |
| <a href="http://clinfhir.com/logicalModeller.html#cfv1w" target="_blank">DiagnosticReport</a>  | Metadata about the test such as who performed it and panel grouping |
|<a href="http://clinfhir.com/logicalModeller.html#f5tym" target="_blank">Observation</a> | The individual result. It is possible for more than one result be be in a single Observation (If it has components) but that will be unusual in this implementation |

-->