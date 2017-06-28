#!/usr/bin/env node
var PEG = require("./JSON.js");
var input = process.argv[2] || `var coche = new Object();
coche.marca = "Seat";
coche.modelo = "Ibiza";
coche.ruedas = 4;
coche.cv = 90;
coche.arrayPiezas = ["Motor", "Caja de cambios", 3];`;

console.log(`Object:\n\n${input}\n`);
console.log("JSON:\n")
var r = PEG.parse(input);
console.log(r);
