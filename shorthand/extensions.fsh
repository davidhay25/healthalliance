//all extensions in a single file

//extensions defined by this guide

Extension: AuthorizedByPatient
Id: authorizedByPatient
Description: "If true, then indicates that the patient as authorized the use of this address or telecom to contact them."
//* ^url = "http://hl7.org.nz/fhir/StructureDefinition/authorizedByPatient"

* extension 0..0
* value[x] only boolean

Extension: ValidatedByPatient
Id: validatedByPatient
Description: "If true, then indicates that the patient as indicated that the data is correct."
//* ^url = "http://hl7.org.nz/fhir/StructureDefinition/validatedByPatient"

* extension 0..0
* value[x] only boolean

Extension: DomicileCode
Id: domicileCode
Description: "The domicile code."
//* ^url = "http://hl7.org.nz/fhir/StructureDefinition/validatedByPatient"

* extension 0..0
* value[x] only CodeableConcept

/*
// ============================================== todo =============================
//extensions that are defined elsewhere. These need to be packaged so they can be located rather than being re-declared here
Extension: NzEthnicity
Id: nzEthnicity
Description: "The ethnicity of the patient. One to six level 4 codes."
* ^url = "http://hl7.org.nz/fhir/StructureDefinition/ethnicity"

* extension 0..0
* value[x] only CodeableConcept
* valueCodeableConcept from http://standards.digital.health.nz/valueset/ethnic-group-level-4 (preferred)


Extension: Suburb
Id: suburb
Description: "The suburb of the address. This is not the same as 'district' or 'state."
* ^url = "http://hl7.org.nz/fhir/StructureDefinition/suburb"

* extension 0..0
* value[x] only string

Extension: DomicileCode
Id: domicilecode
Description: "The domicile code of the address. A code indicating area that this address corresponds to"
* ^url = "http://hl7.org.nz/fhir/StructureDefinition/domicileCode"

* extension 0..0
* value[x] only CodeableConcept

* valueCodeableConcept from https://standards.digital.health.nz/fhir/ValueSet/domicilecode (preferred)
*/