use <povray.scad>

pov_init();
openscad_background();
openscad_camera(type="perspective", distance=300, width= 16, heigth= 9);
openscad_light_source();


_translate([-5,-10,-15]) 
_union()
{
  _color([1,0.5,0.5]) _difference()
  {
    _cube(size=[10,20,30]);
    _cylinder(r=5,h=20,center=true);
    _translate([5,10,15]) _rotate([0,90,0]) _cylinder(r=3,h=11,$fn=6,center=true);
  }
  _translate ([10,10,15]) _color ([0.5,0.5,1]) _sphere(r=5);
  _translate([0.05,10,30]) _rotate([0,90,0]) _color([0.2,1,.2,.8]) 
  _difference()
  {
    _cylinder(r=10,h=9.9);
    _translate([0,0,-0.5]) _cylinder(r=6,h=11);
  }
  _translate([0,10,30]) _rotate([0,-90,0]) _color([1,0,1,0.2]) _cylinder(r1=8,r2=2,h=5);
}


