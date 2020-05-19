Profile:        HaOrganization
Parent:         Organization
Title:          "hA DHB details"
Description:    "Represents DHB details exposed by healthAlliance systems"

* ^text.status = #additional
* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>healthAlliance Organization profile</div>"

//elements that have been removed
* active 0..0
* type 0..0
* alias 0..0
* telecom 0..0
* address 0..0
* partOf 0..0
* contact 0..0
* endpoint 0..0

//slice identifier for the OrgId number. Other identifiers are allowed
* identifier ^slicing.discriminator.type = #value
// uses 'use' rather than system to allow multiple OrgId's if needed
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd  //allow other identifiers

//just the current Organization Id is specified right now...
* identifier contains 
    orgId 0..1 MS 

* identifier[orgId].system = "https://standards.digital.health.nz/id/hpi-organisation"
* identifier[orgId].use = #official (exactly)

