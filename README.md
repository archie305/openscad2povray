# openscad2povray

OpenSCAD2POV-Ray is a OpenSCAD library that allows you to convert OpenSCAD scripts to POV-Ray scripts. See wiki for what is supported.

## Setups:

### Direct wrapper function substitutions
* Advantage: 
 * one step less in the workflow (no intermediate csg file)
 * [future: custom textures could be possible too]
* Disadvantage
 * Limited support for alternative parameters specification
 * need to use the wrapper modules directly
* Examples:
 * module 'test1()' and module 'test2()' in povray.scad

### Include OpenSCAD CSG file 
* Advantage
 * all aternative ways of specifying parameters supported
* Disadvantage
 * Extra step of exporting the CSG file
* Examples
 * radial6 from thingiverse 
  * preview model `radial6.scad` 
  * export CSG as -> `radial6.csg`
  * subsitute `^(\s*)([a-z])` by `$1_$2` and save as  -> `radial6.pov.csg`
  * create file `radial6.pov.scad` as follows:
```
    use <povray.scad>
    openscad2povray_init();
    include <radial6.pov.csg>
```
  * preview model `radial6.pov.scad`
  * copy all lines starting with `ECHO: "POVRAY:` (use right mouse click) 
  * paste in new file as save -> `radial6.pov`
  * remove `ECHO: "POVRAY:` and trailing `"` from file `radial6.pov`
  * render `radial6.pov` in POV-Ray

