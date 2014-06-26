use <../povray.scad>

pov_init();
openscad_background();
openscad_camera(type="perspective", distance=500, width= 16, heigth= 9);
openscad_light_source();

include <radial6.pov.csg>

