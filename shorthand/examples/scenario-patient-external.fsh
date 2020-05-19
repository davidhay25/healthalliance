Instance:   bundle-patient-external
InstanceOf: Bundle
Description: "An example patient with all external references to GP and GP Practice"
Usage: #example

* type = #document 
* timestamp = "2020-04-10T12:00:00Z"
* identifier.system = "http://clinfir.com/NamingSystem/scenarios"
* identifier.value = "patient-externalGP"

* entry.fullUrl = "http://example.com/fhir/Composition/comp-external"
* entry.resource = comp-external

* entry[1].fullUrl = "http://example.com/fhir/Patient/cPatient"
* entry[1].resource = cPatient

* entry[2].fullUrl = "http://example.com/fhir/Practitioner/cGP"
* entry[2].resource = cGP

* entry[3].fullUrl = "http://example.com/fhir/Organization/cPractice"
* entry[3].resource = cPractice

* entry[4].fullUrl = "http://example.com/fhir/Organization/cmdhb"
* entry[4].resource = cmdhb



//The composition describes the scenario
Instance:   comp-external
InstanceOf: Composition
Description: "describes the scenario"
Usage: #inline

* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>Patient with GP</div>"
* text.status = #additional

* status = #final
* type = $LOINC#11503-0 "Medical Records"
* date = "2020-05-10"
* author.display = "From scenario in IG" 
* title = "A patient with external links to GP and GP Practice"
* subject = Reference(cPatient)


//The patient.
Instance:   cPatient
InstanceOf: HaPatient
Description: "The patient."
Usage: #example


* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>John Doe</div>"
* text.status = #additional

//the current NHI
* identifier.use = #official
* identifier.system = "https://standards.digital.health.nz/id/nhi"
* identifier.value = "WER4568"

* name.family = "Doe"
* name.given = "John"
* name.given[1] = "Albertus"

* name.extension[preferred].valueBoolean = true
* deceasedBoolean = false
* gender = #male
* birthDate = "1989-12-12"

* address.text = "23 Thule St"

* generalPractitioner = Reference(cGP)
* generalPractitioner[1] = Reference(cPractice)

* managingOrganization = Reference(cmdhb)

//The GP (as a provider)
Instance:  cGP
InstanceOf: HaPractitioner
Description: "An example of practitioner. Used as a target by some of the other examples"
Usage: #example
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>Dr Richard Kildaire</div>"
* text.status = #additional

* name.text = "Dr Richard Kildaire"

* identifier.system = "https://standards.digital.health.nz/id/hpi-person"
* identifier.value = "cpn-1"


//The GP Practice (as an organization)
Instance:   cPractice
InstanceOf: HaOrganization
Description: "Good Health Medical centre"
Usage: #example
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>Good Health Medical centre</div>"
* text.status = #additional

* name = "Good Health Medical centre"

* identifier.system = "https://standards.digital.health.nz/id/hpi-organization"
* identifier.value = "org-1"

