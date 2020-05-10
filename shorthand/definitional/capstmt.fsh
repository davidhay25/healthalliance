
Instance:   HaCapabilityStatement
InstanceOf: CapabilityStatement

Title:          "CapabilityStatement"
Description:    "Represents API exposed by healthAlliance systems"
Usage: #definition
* text.status = #additional
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>Demographics related resources</div>"

* date = "2020-04-01"
* status = #draft
* kind = #instance
* fhirVersion = #4.0.1
* format = #json

* rest.mode = #server
* rest.resource.type = #Patient
* rest.resource.supportedProfile = "http://hl7.org.nz/healthalliance/HaPatient"

* rest.resource.interaction.code = #read

* rest.resource.interaction[1].code = #search-type
* rest.resource.interaction[1].documentation = "Gender and birthDate are required in all searches"

* rest.searchParam.name = "name"
* rest.searchParam.type = #string

* rest.searchParam[1].name = "identifier"
* rest.searchParam[1].type = #token
