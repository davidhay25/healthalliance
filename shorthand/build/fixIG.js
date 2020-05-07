#!/usr/bin/env node

// replace the page.page node in the IG that sushi clobbers
let fs = require('fs');
IGFileName = "./input/ImplementationGuide-hl7.org.nz.healthalliance.json";
let contents = fs.readFileSync(IGFileName).toString()
let IG = JSON.parse(contents)


IG.definition.page.page = []
IG.definition.page.page.push({nameUrl:"index.html",title:"Home",generation:"markdown"})
IG.definition.page.page.push({nameUrl:"usecases.html",title:"Use Cases",generation:"markdown"})
IG.definition.page.page.push({nameUrl:"design.html",title:"Design notes",generation:"markdown"})
IG.definition.page.page.push({nameUrl:"api.html",title:"API",generation:"markdown"})
IG.definition.page.page.push({nameUrl:"downloads.html",title:"Downloads",generation:"markdown"})
IG.definition.page.page.push({nameUrl:"development.html",title:"Development",generation:"markdown"})

//add references for LM's
let arModels = ['HaPatient','HaPractitioner','HaPractitionerRole','HaLocation','HaOrganization','HaDiagnosticReport','HaLabObservation'];
arModels.forEach(function(modelId){
    modelId += "LM"
    let LMRef = {reference:{reference:"StructureDefinition/"+modelId},exampleBoolean:false}

    LMRef.name = "Logical Model for " + modelId
    LMRef.description = "The Logical Model used to capture the data requirements"
    addReference(LMRef)
})


/*
let PatientLMRef = {reference:{reference:"StructureDefinition/NhiPatientLM"},exampleBoolean:false}

PatientLMRef.name = "Logical Model for Patient"
PatientLMRef.description = "The Logical Model used to capture the data requirements"
addReference(PatientLMRef)
*/

fs.writeFileSync(IGFileName,JSON.stringify(IG));


function addReference(newRef) {
    //is the reference already in the IG (ie if the IGBuilder is being run multiple times)
    for (const ref of IG.definition.resource) {
        if (ref.reference && (ref.reference.reference == newRef.reference.reference)) {
            return
        }
    }
    IG.definition.resource.push(newRef)
}
