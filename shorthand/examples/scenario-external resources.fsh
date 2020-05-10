Instance:   bundle-patient-external
InstanceOf: Bundle
Description: "An example patient with all external rerferences to GP and GP Practice"
Usage: #example

* type = #document 

* entry.resource = comp-external
* entry[1].resource = patient1


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
* subject = Reference(patient1)


