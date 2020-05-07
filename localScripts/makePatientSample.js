#!/usr/bin/env node

/**
 * Generate example data from the spreadsheet. Each patient is presented in 2 ways:
 *  - with the Practitioner & organization as contained resources
 *  - with the Practitioner & organization as separate resources 
 *  - not using PractitionerRole as role is implicit in the relationship (unlike HPI)
 * 
 *  use the .managingOrganization to indicate the source of the patient
 */

let fs = require('fs');
let syncRequest = require('../../common/node_modules/sync-request');


//set up the managing organizations
let hashDhb = {}
hashDhb['cmdhb'] = {resourceType:'Organization',id:'ha-cmdhb',name:'Counties-Manakau DHB',
    identifier:[{system:'https://standards.digital.health.nz/id/hpi-organisation',value:'cmdhb'}]}

hashDhb['adhb'] = {resourceType:'Organization',id:'ha-adhb',name:'Auckland DHB',
    identifier:[{system:'https://standards.digital.health.nz/id/hpi-organisation',value:'adhb'}]}

hashDhb['cwhb'] = {resourceType:'Organization',id:'ha-wdhb',name:'Waitemata DHB',
    identifier:[{system:'https://standards.digital.health.nz/id/hpi-organisation',value:'wdhb'}]}

//load the sample data froom a csv file
let fullFileName = "./hAPatientexamples.csv";
let contents = fs.readFileSync(fullFileName).toString()//, {encoding: 'utf8'})
let validationUrl = 'http://hapi.fhir.org/baseR4/Bundle/$validate'
let dataServer = 'http://hapi.fhir.org/baseR4/';        //where to save the actual resources...

 //remove any BOM
contents = contents.replace(/^\uFEFF/, "")

let bundle = {resourceType:'Bundle',type:'transaction',entry:[]}
let lines = contents.split('\n')
lines.forEach(function(lne,inx){
    if (inx > 1) {
        //ignore fist 2 lines
        let ar = splitLine(lne)
        let id = 'ha-patientSample-'+inx
        let patientName = ar[3] + ' ' + ar[2]

        //construct the patient resource
        let resource = {resourceType:'Patient',id:id,contained:[]}
        let entry = {request:{method:"PUT",url:'Patient/'+id}}
        resource.text = makeNarrative(patientName + " with GP and Practice as contained resources")
        resource.identifier = [{system:"https://standards.digital.health.nz/id/nhi",value:ar[1]}]
        let name = {family:ar[2],given:[]}
        let ar1 = ar[3].split(' ');
        ar1.forEach(function(gn){
            name.given.push(gn)
        })
        
        name.text = patientName;
        resource.name = [name]
        resource.gender = ar[4]
        resource.birthDate = ar[5]

        let phone = {system:'phone',value:ar[6]}
        let email = {system:'email',value:ar[7]}
        resource.telecom=[phone,email]

        let address = {line:[ar[8]]}
        if (ar[9]) {
            address.line.push(ar[9])
        }
        let extSuburb = {url:'http://hl7.org.nz/fhir/StructureDefinition/suburb',valueString:ar[10]}
        address.extension = [extSuburb]
        address.city = ar[11]
        resource.address = [address]

        //add gpname as a contained Practitioner
        let Practitioner = {resourceType:'Practitioner',id:'prac1',name:[{text:ar[12]}]}
        Practitioner.identifier=[{system:'https://standards.digital.health.nz/id/hpi-person',value:ar[13]}]
        Practitioner.text = makeNarrative(ar[12])
        resource.contained.push(Practitioner)

        // ... and save as a separate resource as well (for the separate linkage) - with a different id
        let extPractitioner =  JSON.parse(JSON.stringify(Practitioner))
        extPractitioner.id += '-ext'
        let practitionerEntry = {resource : extPractitioner}
        practitionerEntry.fullUrl = dataServer + 'Practitioner/'+extPractitioner.id
        practitionerEntry.request = {method:'PUT',url:'Practitioner/'+extPractitioner.id}
        bundle.entry.push(practitionerEntry)

        resource.generalPractitioner = [{reference:'#prac1'}]

        //add gp practice as a contained organization
        let Organization = {resourceType:'Organization',id:'org1',name:ar[14]}
        Organization.identifier=[{system:'https://standards.digital.health.nz/id/hpi-organisation',value:ar[14]}]
        Organization.text = makeNarrative(ar[14])
        resource.contained.push(Organization)
        resource.generalPractitioner.push({reference:'#org1'})

        // ... and save as a separate resource as well (for the separate linkage) - with a different id
        let extOrganization =  JSON.parse(JSON.stringify(Organization))
        extOrganization.id += '-ext'

        let organizationEntry = {resource : extOrganization}
        organizationEntry.fullUrl = dataServer + "Organization/"+extOrganization.id
        organizationEntry.request = {method:'PUT',url:'Organization/'+extOrganization.id}
        bundle.entry.push(organizationEntry)
        
        //console.log(resource)
        //set the managingOrganization
        let dhb = ar[15] || 'cmdhb'
        let mo = hashDhb[dhb]
        if (! mo) {
            mo = hashDhb['cmdhb']
        }
        resource.managingOrganization = {reference: 'Organization/'+ mo.id,display:mo.name}

        entry.resource = resource;
        bundle.entry.push(entry)

        //now create a copy of the patient resource that has separate references, rather than contained
        let externalPatient = JSON.parse(JSON.stringify(resource))
        delete externalPatient.contained;
        externalPatient.text = makeNarrative(patientName + " with GP and Practice as referenced resources")
        externalPatient.generalPractitioner.length = 0
        externalPatient.generalPractitioner.push({reference:'Practitioner/'+extPractitioner.id,display:extPractitioner.name[0].text})
        externalPatient.generalPractitioner.push({reference:'Organization/'+extOrganization.id,display:extOrganization.name})
        externalPatient.id += '-extRef'

        //and add to the bundle
        let externalPatientEntry = {resource : externalPatient}
        externalPatientEntry.fullUrl = dataServer + "Patient/"+externalPatient.id
        externalPatientEntry.request = {method:'PUT',url:'Patient/'+externalPatient.id}
        bundle.entry.push(externalPatientEntry)

        //console.log(ar)
    }
})

//add the dhbs to the bundle

for (let key in hashDhb) {
    let dhb = hashDhb[key]
    let entry = {resource:dhb,request:{method:'PUT',url:'Organization/'+dhb.id}}
    entry.fullUrl = dataServer + "Organization/"+dhb.id
    bundle.entry.push(entry)


}

//return
fs.writeFileSync('./bundle.json',JSON.stringify(bundle,null,2))
console.log(bundle)

//validate result
var options = {};
options.headers = {"content-type": "application/json+fhir"}
options.timeout = 20000;        //20 seconds
options.body = JSON.stringify(bundle);

var response = syncRequest('POST', validationUrl, options);

console.log("ValidationResult: " + response.statusCode)
console.log(response.body.toString())

if (response.statusCode == 200) {
    //post to data server
    console.log('POSTing bundle to data server: ' +dataServer )
    let url = dataServer;
    var response = syncRequest('POST', url, options);
    console.log("UpdateResult: " + response.statusCode)
    console.log(response.body.toString())

}



return;


function makeNarrative(s) {
    let narrative = {status:'additional'}
    narrative.div = "<div xmlns='http://www.w3.org/1999/xhtml'>" + s + "</div>"
    return narrative
}


//comment out this line to prevent sending the resources to the terminology server
//note that the terminology resources must also be on the same server as thi IG - otherwise updates will be rejected...
let serverRoot = "https://ontoserver.csiro.au/stu3-latest/"
//let serverRoot = "http://home.clinfhir.com:8054/baseR4/"


let path = '../codesystems/';   //path to source csv files
let outFolder = '../codesystems/out/';    //path to output files


fs.readdirSync(path).forEach(function(file) {

    let ar = file.split('.')
    if (ar.length > 1) {
        if (ar.pop() == 'csv' ) {

            console.log('------------ ' + file)
            

            //assume this is a csv file in the required format
            let fullFileName = path + file;
            let contents = fs.readFileSync(fullFileName).toString()//, {encoding: 'utf8'})

            //remove any BOM
            contents = contents.replace(/^\uFEFF/, "")

            let arContents = contents.split('\n')
            let name = splitLine(arContents[0])[0];
           
            let csCanonical = splitLine(arContents[1])[0];
            let vsCanonical = splitLine(arContents[2])[0];
            let title = splitLine(arContents[3])[0];
            let description = splitLine(arContents[4])[0];

            arContents.splice(0,6)      //remove the header lines

            //make the CodeSystem
            let cs = {resourceType:"CodeSystem",id:name,status:"draft",name:name,title:title,description:description,content:'complete'}
            cs.url = csCanonical;
            cs.concept = [];


            arContents.forEach(function(lne){
                lne = lne.replace('\r','')
                let ar = splitLine(lne)
                if (ar[0] && ar[1]) {
                    let concept = {code:ar[0],display:ar[1]}
                    cs.concept.push(concept)
                } else {
                    console.log('Ignoring empty codes or values')
                }
                
            })

            //write out the CodeSystem
            let csFileName = outFolder+name + "-cs.json";
            fs.writeFileSync(csFileName,JSON.stringify(cs))
                    
            //make the ValueSet that refers to the CodeSystem as a whole
            let vs = {resourceType:"ValueSet",id:name,status:"draft",name:name,title:title,description:description};
            vs.url = vsCanonical;
            vs.compose = {include:[{system:csCanonical}]}

            //write out the ValueSet
            let vsFileName = outFolder+name + "-vs.json";
            fs.writeFileSync(vsFileName,JSON.stringify(vs))

            //save to the Terminology server if configured to do so...
            if (serverRoot) {
                PUTFile(serverRoot + "CodeSystem/" + name,cs)
                PUTFile(serverRoot + "ValueSet/" + name,vs)
            }

        }
    }
})

//PUT a file to the server, given url and contents
function PUTFile(url,resource) {

    console.log(url);
    var options = {};
    options.headers = {"content-type": "application/json+fhir"}
    options.timeout = 20000;        //20 seconds
    options.body = JSON.stringify(resource);

    var response = syncRequest('PUT', url, options);
   
    if (response.statusCode !== 200 && response.statusCode !== 201) {
        console.log('  error' + response.body.toString())
        console.log(response.statusCode)
        console.log(JSON.stringify(resource))
        return false
    } else {
        if (response.statusCode == 200) {
            console.log('Updated ' + url)
        } 
        
        if (response.statusCode == 201) {
            console.log('Created ' + url)
        }
       
        return true
    }
}


function splitLine(lne) {
    lne = lne.replace('\r','')
    return lne.split(',')
}
