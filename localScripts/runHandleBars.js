#!/usr/bin/env node

let fs = require('fs');

const Handlebars = require("handlebars");

let contents = JSON.parse(fs.readFileSync("../shorthand/build/input/capabilities/CapabilityStatement-HaCapabilityStatement.json").toString())

let hb = fs.readFileSync("./capStmt.handlebars").toString()


const template = Handlebars.compile(hb);
let md = (template(contents));

fs.writeFileSync("../shorthand/ig-data/input/pagecontent/capStmt.md",md)
fs.writeFileSync("../shorthand/build/input/pagecontent/capStmt.md",md)