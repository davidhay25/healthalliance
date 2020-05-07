Instance:   patient1
InstanceOf: HaPatient
Description: "An example patient with all data items populated. Has a contained Practitioner as the GP."
Usage: #example

* contained = prac1

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


//The general practitioner is described by the practitionerrole1 resource (has references to Practitioner & Location)
* generalPractitioner.reference = "#prac1"

Instance:   prac1
InstanceOf: Practitioner
Description: "Practitioner"
Usage: #inline

* name.text = "Dr  Welby"
* identifier.system = "https://standards.digital.health.nz/id/hpi-person"
* identifier.value = "welby1"



