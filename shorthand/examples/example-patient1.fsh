Instance:   patient1
InstanceOf: HaPatient
Description: "An example patient with all data items populated. Has a contained Practitioner as the GP and contained Organization GP Practice."
Usage: #example

* contained = gp-prac1
* contained[1] = gp-org1

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

//email address & phone
* telecom.system = #email
* telecom.value = "johndoe@erewhon.com"
* telecom[1].system = #phone
* telecom[1].value = "+64 9 000 0000"

//physical address
* address.line = "23 Thule St"
* address.city = "Waipu"
* address.extension[suburb].valueString = "Waipu river"

//The Managing organization describes the DHB that supplied this record. This will always be an external resource.
* managingOrganization = Reference(cmdhb)   //DHB is Counties Manukau

//The general practitioner is described by the contained practitioner resource)
* generalPractitioner.reference = "#gp-prac1"       //the GP
* generalPractitioner[1].reference = "#gp-org1"       //the GP Practice

//The GP as a contained Practitioner
Instance:   gp-prac1
InstanceOf: Practitioner
Description: "Practitioner"
Usage: #inline

* name.text = "Dr  Welby"
* identifier.system = "https://standards.digital.health.nz/id/hpi-person"
* identifier.value = "welby1"

//The GP practice as a contained Organization
Instance:   gp-org1
InstanceOf: Organization
Description: "GP Practice"
Usage: #inline

* name = "GP Medical centre"
* identifier.system = "https://standards.digital.health.nz/id/hpi-organisation"
* identifier.value = "gpprac"
