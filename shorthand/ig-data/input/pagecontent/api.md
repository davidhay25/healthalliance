

### RESTful Patient
Queries that allow individual patients to be returned.

#### Search by NHI
Returns a bundle of patients with matching NHI's. Should only be one.

    GET [host]/Patient?identifier={nhi}
eg


 
#### Search by Demographics

Returns a bundle with matching patients. Elements supported:

* name
* birthDate
* gender

_(there are likely some mandatory elements...)_

    GET [host]/Patient?name={x}&birthDate={y}...

See [the spec](http://hl7.org/fhir/patient.html#search) for details on the searches

### RESTful Encounter
Queries that return encounter

#### Lookup by patient
Return matching encounters

    GET [host]/Encounter?identifier={nhi}

#### 
  