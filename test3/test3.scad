/*  Copyright 2014 Pieter Gosselink
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/    
use <../povray.scad>;

// Direct Test
module test1() // transparency/color test
{
    openscad2povray_init();
    _union()
    {
        _difference()
        {
            _union()
            {
                _color([1,0,0]) _cube(size=[20,20,20],center=true);
                _color([0,1,0,.2]) _translate([5,5,10]) _sphere(r=5);
            }
            _translate([-5,5,10]) _cylinder(r=5,h=10,center=true);
        }        
         _color([0.5,1,0.5]) _translate([100,0,-1]) _cube(size=[200,200,2],center=true);
         for (x=[0:10:199])
            for (y=[0:10:199])
               _color([x/200,0,1-x/200,(y+9)/200]) _translate([x+5,-100+y+5,0]) _sphere(r=3);
               
    }
}

module test2obj() 
{
    _translate([-5,-10,0]) 
    _union()
    {
        _color([1,0.5,0.5]) _difference()
        {
            _cube(size=[10,20,30]);
            _cylinder(r=5,h=20,center=true);
            _translate([5,10,15]) _rotate([0,90,0]) _cylinder(r=3,h=11,$fn=6,center=true);
        }
        _translate ([10,10,15]) _color ([0.5,0.5,1,.8]) _sphere(r=5);
        _translate([0.05,10,30]) _rotate([0,90,0]) _color([0.2,1,.2,.8]) 
        _difference()
        {
            _cylinder(r=10,h=9.9);
            _translate([0,0,-0.5]) _cylinder(r=6,h=11);
        }
        _translate([0,10,30]) _rotate([0,-90,0]) _color([1,0,1,0.2]) _cylinder(r1=8,r2=2,h=5);
    }
}

module test2() // Direct Test
{
    openscad2povray_init();
    test2obj();
    _mirror([1,2,3]) _translate([30,0,0]) test2obj();
}

module test3() // Indirect Test
{
    $fn=30;
    module obj(size, color)
    {
        union(){
            color(color) sphere(r=size);
            translate([0,0,size]){ 
                color(color) difference(){
                    sphere(r=size/2);
                    rotate([0,-35,0]) translate([size/2,0,0]) sphere(r=size/10);
                    rotate([0,-35,90]) translate([size/2,0,0]) sphere(r=size/10);
                }    
                color([0.2,0.2,0.2]) {
                    translate([0,0,0.75*size/2]) cylinder(r=size/3,h=size/12,center=false);
                    translate([0,0,0.75*size/2]) cylinder(r=size/4.5,h=size/2,center=false);
                }    
            }
        }
    }

    translate([100,0,5]) obj(5,[1,.5,.5,1]*.8);
    translate([100,15,4]) rotate([0,10,0]) obj(4,[0.5,1,.5,1]*.8);
    translate([80,0,10]) rotate([10,0,0]) obj(10,[0.5,0.5,1,1]*.8);
    translate([50,0,15]) rotate([0,-10,10]) obj(15,[1,1,1,1]*.8);
}

test3();
