This page is derived from the information recorded in the [CapabilityStatement](CapabilityStatement-HaCapabilityStatement.html) resource.
It describes the details of the RESTful interface through which clients can access the data exposed by
healthAlliance on behalf of the DHBs it supports.

Capability Statement describing healthAlliances FHIR APIs  
Status: additional

Currently the subset of API's exposed by healthAlliance are read-only and confined to a small set of resource types.




### Patient

Each DHB exposes its core demographics infomation via the Patient resource.

**This is italic**


#### Interactions

| Code | Documentation |
| --- | --- |
| read | Used to retrieve a Patient resource by Id. Note that this is ***not*** the same as the NHI identifier |
| search-type | Gender and birthDate are required in all searches |


#### Search Parameters

| Name | Type | Documentation |
| --- | --- | --- |
| name | string | Not case sensitive
| identifier | token | Use for NHI queries
| organization | reference | This is the organization (DHB) that is the source of the resoruce

#### Search Includes
managingOrganization
generalPractitioner




### Practitioner

The practitioner resource is the indiviudal delivering care. Currently this is teh GP only.

#### Interactions

| Code | Documentation |
| --- | --- |
| read | Allows a read of a Practitioner resource - eg references from Patient |






### Organization



#### Interactions

| Code | Documentation |
| --- | --- |
| read | Allows a read of an Organization resource - eg references from Patient |






