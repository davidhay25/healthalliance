This page has links to external sites used during development and are present to assist the temam members and reviewers. The page will be removed once the IG has been completed.


### links to working docs

(Resource and API considerations)[https://docs.google.com/document/d/1LTygQUy3LwJb8QFeODPnMBQVJkjqsypefQpgms7wHxI/edit#]

(Patient samples (raw data))[https://docs.google.com/spreadsheets/d/1IetmbfEvxld8mI6wrE4Qndm6fLQvpQM8GusEkAfcm3Q/edit#gid=0]


### Process

The following process is being used (roughly) to develop this guide.

1. Technical [use cases](usecases.html) are identified to describe the nature of client API access requirements.
2. Existing descriptions (schema, bespoke API) are used to help inform the content of the API. These are expressed as resource [Profiles](http://hl7.org/fhir/profiling.html), and describe how the base resource types are adapted to the specific healthAlliance requirements. The use cases also inform this process.
3. From these requirements, Logical Models are developed using the clinFHIR tooling. These are an intermediary information model that display the data requirements in an easy to visualize format which is useful for review. 
4. The information in the Logical Models are then converted into FHIR artifacts using the [FHIR shorthand language (FSH)](http://hl7.org/fhir/uv/shorthand/2020May/), and the [sushi](http://hl7.org/fhir/uv/shorthand/2020May/sushi.html) tooling that implements FSH. These artifacts are listed in the [artifacts](artifacts.html) tab of this guide, and contain the detailed information about the profiles needed by implementers.
5. Other FHIR artifacts like the [API descripions](api.html), examples and security are created and documented.


### Business Use Cases

These are business focussed Use Cases that are being used to drive the API design (the [technical usecases](usecases.html) are derived from these.) Note that these documents may not be publically available.

> Add links to the business use cases. Might want to keep these long term...

<a href="https://teams.microsoft.com/l/file/D1F42DEC-13AF-4CEB-8BD2-8162E09EF8F4?tenantId=494a2d87-24b5-42d8-8a3d-77448be1d46f&fileType=docx&objectUrl=https%3A%2F%2Fnorthernregion.sharepoint.com%2Fsites%2FhA-RegionalVendorAggregation%2FShared%20Documents%2FCore%20Data%2FUse%20Cases%2FUC-Reviewing%20a%20lab%20test.docx&baseUrl=https%3A%2F%2Fnorthernregion.sharepoint.com%2Fsites%2FhA-RegionalVendorAggregation&serviceName=teams&threadId=19:de0544d25929446caae97c3872737c87@thread.skype&groupId=c10bd23b-63fa-464f-86d5-97a6567556ed">Lab use cases




### Comments

> Link to comments dashboard

### Models

The following models are currently being developed in the clinFHIR logical modeller. Clicking the link will open the model in read-only mode.

| Model / Resource type | Purpose |
| --- | --- |
| <a href="http://clinfhir.com/logicalModeller.html#blf51" target="_blank">Patient</a> | Represents the patient. Generally there will be a single Patient resource for each patient    | 
| <a href="http://clinfhir.com/logicalModeller.html#87aoz" target="_blank">Practitioner</a> | Represents a person delivering healthcare (regardless of qualification).|
| <a href="http://clinfhir.com/logicalModeller.html#awiqv" target="_blank">PractitionerRole</a> | Is a link to a practitioner in a role - as well as a location and organization. An example would be to represent a patients usual GP and GP Practice |
| <a href="http://clinfhir.com/logicalModeller.html#p8hy1" target="_blank">Location</a> | Refers to a place where healthcare is delivered - for example a Hospital |
|  <a href="http://clinfhir.com/logicalModeller.html#fkxor" target="_blank">Organization</a> | A group responsible for delivering care. The DHB is an example of this.|
| <a href="http://clinfhir.com/logicalModeller.html#cfv1w" target="_blank">DiagnosticReport</a> | The 'header' for lab data - grrouping into panels, identifying the lab and so forth. |
| <a href="http://clinfhir.com/logicalModeller.html#f5tym" target="_blank">Lab Observation</a> | An observation for lab data - parrticularly blood work and swabs  |

