
// Aliases
Alias: $suburb = http://hl7.org.nz/fhir/StructureDefinition/suburb
Alias: $preferred = http://hl7.org/fhir/StructureDefinition/iso21090-preferred

Profile:        HaPatient
Parent:         Patient
Title:          "Common Patient profile"
Description:    "Represents patient demographics exposed by healthAlliance systems"

* ^text.status = #additional
* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>healthAlliance Patient profile</div>"

//elements that have been removed
* active 0..0
* photo 0..0
* contact 0..0
* communication 0..0
* link 0..0
* maritalStatus 0..0
* multipleBirth[x] 0..0

//todo - not sure why this was constrained out...
//* deceased[x] only dateTime     //may need to support boolean

//identifier. Slice to have current NHI (fix system and use)
* identifier.type 0..0
* identifier.period 0..0
* identifier.assigner 0..0

* identifier ^slicing.discriminator.type = #value
// uses 'use' rather than system to allow multiple NHI's if needed
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd  //allow other identifiers

//just the current NHI is specified right now...
* identifier contains 
    NHI 0..1 MS 

* identifier[NHI].system = "https://standards.digital.health.nz/id/nhi"
* identifier[NHI].use = #official (exactly)


//Name is required - can have many
* name  1..*
* name.extension contains
    $preferred named preferred 0..1
  

// address is required and has a suburb extension. 
* address.extension contains
    $suburb named suburb 0..1

* address 1..*
* address.line 1..*     //there will always be at least 1 line

//Limit the possible resources for generalPractitioner to a practitioner or an organization.
//If the actual GPis known, then use Practitioner, if the practice then use Organization.
//Note that this might still be a contained resource - that's still supported by this profile
//It might also be possible to use PractitionerRole - but the value of that is unclear at this time.
* generalPractitioner only Reference(HaPractitioner | HaOrganization)

//The managing organization is the DHB where the Patient resource came from
* managingOrganization only Reference(HaDhb)






