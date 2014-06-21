openscad2povray
===============

Convert OpenSCAD scripts to POV-Ray scripts. 

Two possible setups:

1) direct wrapper function substitutions
Advantage: 
- custom colors
Disadvantage
- Limited support for alternative parameters specification
Examples:
- module test1() and module test2() in povray.scad)

2) Include OpenSCAD CSG file 
Advantage
- 'mirror' supported
Disadvantage
- Extra step of export of CSG file
Examples
- 

