
Instance:   HaCapabilityStatement
InstanceOf: CapabilityStatement
Title:          "CapabilityStatement"
Description:    "Represents API exposed by healthAlliance systems"
Usage: #definition
* text.status = #additional
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>Demographics related resources</div>"

* name = "hA_CapabilityStatement"
* title = "Capability Statement describing healthAlliances FHIR APIs"
* description = """
Currently the subset of API's exposed by healthAlliance are read-only and confined to a small set of resource types.
"""

* date = "2020-04-01"
* status = #draft
* kind = #instance
* fhirVersion = #4.0.1
* format = #json

* implementation.description = "The hA endpoint"
* implementation.url = "http://healthAlliance.co.nz/fhir"

* rest.mode = #server

// ============== The patient endpoint
* rest.resource.type = #Patient
* rest.resource.supportedProfile = "http://hl7.org.nz/healthalliance/HaPatient"
* rest.resource.documentation = """
Each DHB exposes its core demographics infomation via the Patient resource.

**This is italic**

"""

//read by id
* rest.resource.interaction.code = #read
* rest.resource.interaction.documentation = "Used to retrieve a Patient resource by Id. Note that this is ***not*** the same as the NHI identifier"
//search by various parameters
* rest.resource.interaction[1].code = #search-type
* rest.resource.interaction[1].documentation = "Gender and birthDate are required in all searches"

//Search by name. todo - may need add docs about dependencies - eg dob as well
* rest.resource.searchParam.name = "name"
* rest.resource.searchParam.type = #string
* rest.resource.searchParam.definition = "http://hl7.org/fhir/SearchParameter/Patient-name"
* rest.resource.searchParam.documentation = "Not case sensitive"

//identifier 
* rest.resource.searchParam[1].name = "identifier"
* rest.resource.searchParam[1].type = #token
* rest.resource.searchParam[1].definition = "http://hl7.org/fhir/SearchParameter/Patient-identifier"
* rest.resource.searchParam[1].documentation = "Use for NHI queries"

//managingOrganization (ie DHB)
* rest.resource.searchParam[2].name = "organization"
* rest.resource.searchParam[2].type = #reference
* rest.resource.searchParam[2].definition = "http://hl7.org/fhir/SearchParameter/Patient-organization"
* rest.resource.searchParam[2].documentation = "This is the organization (DHB) that is the source of the resoruce"

* rest.resource.searchInclude = "managingOrganization"
* rest.resource.searchInclude[1] = "generalPractitioner"

// =============== the Practitioner endpoint
* rest.resource[1].type = #Practitioner
* rest.resource[1].documentation = "The practitioner resource is the indiviudal delivering care. Currently this is teh GP only."
* rest.resource[1].interaction.code = #read
* rest.resource[1].interaction.documentation = "Allows a read of a Practitioner resource - eg references from Patient"


// ================ the Organization endpoint
* rest.resource[2].type = #Organization
* rest.resource[2].interaction.code = #read
* rest.resource[2].interaction.documentation = "Allows a read of an Organization resource - eg references from Patient"