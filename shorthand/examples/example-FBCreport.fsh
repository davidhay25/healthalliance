Instance:   fbc-contained
InstanceOf: HaDiagnosticReport
Description: "Full Blood Count example. Uses contained observations"
Usage: #example

* contained = hb
* contained[1] = ery

* status = #final

//the lab report identifier
* identifier.system = "http://sysmex.org"
* identifier.value = "100"

//code identifiying this as a Full Blood count
* code.coding.code = #58410-2
* code.coding.system = "http://loinc.org"

* performer = Reference(sysmex)
* subject = Reference(patient1)

* effectiveDateTime = "2020-04-10T12:00:00Z"

* result = Reference(hb)
* result[1] = Reference(ery)


Instance:   fbc-externalobs
InstanceOf: HaDiagnosticReport
Description: "Full Blood Count example. Uses external observations"
Usage: #example

* status = #final

//the lab report identifier
* identifier.system = "http://sysmex.org"
* identifier.value = "100"

//code identifiying this as a Full Blood count
* code.coding.code = #58410-2
* code.coding.system = "http://loinc.org"

* performer = Reference(sysmex)
* subject = Reference(patient1)

* effectiveDateTime = "2020-04-10T12:00:00Z"


* result = Reference(hb)
* result[1] = Reference(ery)


//---------- Haemoglobin observation
Instance: hb
InstanceOf: Observation
Description: "A haemoglobin Observation"
Usage: #example

* status = #final
* subject = Reference(patient1)
* performer = Reference(sysmex)

//code identifiying this as a Haemoglobin
* code.coding.code = #718-7
* code.coding.system = "http://loinc.org"

* valueQuantity.value = 176
* valueQuantity.unit = "g/L"
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #g/L

* referenceRange.low.value = 135
* referenceRange.low.unit = "g/L"
* referenceRange.low.system = "http://unitsofmeasure.org"
* referenceRange.low.code = #g/L

* referenceRange.high.value = 180
* referenceRange.high.unit = "g/L"
* referenceRange.high.system = "http://unitsofmeasure.org"
* referenceRange.high.code = #g/L

//normal
* interpretation.coding.code = #N
* interpretation.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation"


//------------- Erythrocyte count observation
Instance: ery
InstanceOf: Observation
Description: "An erythrrocyte observation"
Usage: #example


* status = #final
* subject = Reference(patient1)
* performer = Reference(sysmex)

//code identifiying this as a erythrocyte count
* code.coding.code = #789-8
* code.coding.system = "http://loinc.org"

* valueQuantity.value = 5.9
* valueQuantity.unit = "x10*12/L"
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #10*12/L

* referenceRange.low.value = 4.2
* referenceRange.low.unit = "x10*12/L"
* referenceRange.low.system = "http://unitsofmeasure.org"
* referenceRange.low.code = #10*12/L

* referenceRange.high.value = 6.0
* referenceRange.high.unit = "x10*12/L"
* referenceRange.high.system = "http://unitsofmeasure.org"
* referenceRange.high.code = #10*12/L

//normal
* interpretation.coding.code = #N
* interpretation.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation"


Instance: bundleLab
InstanceOf: Bundle
Description: "A bundle with all the FBC resources. Represented as a batch"
Usage: #example

* type = #batch
* entry.resource = patient1             //the patient
* entry.fullUrl = "http://example.com/fhir/Patient/patient1"

* entry[1].resource = fbc-externalobs   //the diagnostic report
* entry[1].fullUrl = "http://example.com/fhir/DiagnosticReport/fbc-exterrnalobs"

* entry[2].resource = sysmex            //the lab
* entry[2].fullUrl = "http://example.com/fhir/Organization/sysmex"

* entry[3].resource = hb                //Haemoglobin rresult
* entry[3].fullUrl = "http://example.com/fhir/Observation/hb"

* entry[4].resource = ery               //erythrocyte result
* entry[4].fullUrl = "http://example.com/fhir/Observation/ery"


