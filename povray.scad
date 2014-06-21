//echo("*");
povray_gen=1;
povray_defcolor=0;
indentstr="  ";
function indentdelta(n) = (n[0] != "_" ? "" : n[1]!= "_" ? indentstr : ""); // only modules starting with a single '_' will indent
function indent(i) = i>0 ? str(indentdelta(parent_module(i-1)),indent(i-1)) : ""; // construct indent string based on stack
function strvd(v,i) = str(",",v[i],(len(v)-1==i ? ">" : strvd(v,i+1))); // build povray vector
function strv(v) = len(v)==undef ? v : str("<",v[0],strvd(v,1));
function color(c) = len(c) == undef ? c : str("color rgb",(len(c)==4 ? "t " : " "),strv(c));
function pigment(p) = str("pigment {",color(p),"}");

// modules to print out the pov-ray code

povray_code = "POVRAY:";

module pov(s,c) // s = string to print out, c = optional end of line comment
{
    if ($children==0) 
    {
        if (povray_gen) echo(str(povray_code, s, (s=="" ? "" : " "), (c==undef ? "" : str("// ",c))));
    }
    else
    {
        echo(str("#### missing semicolon after pov(",s,c==undef ? "" : str(",",c),") in '",parent_module(1),"'"));       
    }    
}       
module povc(c) pov("",c); // a single line of comment
module pove(e) pov(str("##### ERROR #####: ", e)); 

//povray_color_cube = [0.2,0.5,1];
//povray_color_cylinder = [0.5,1,0.2];
//povray_color_sphere = [1,0.2,0.5];
function parameter(n,v) = (v == undef ? str("  /* ",n, " not defined*/") : str("  ", n, " ",v, "  "));

module pov_init()
{
   pov("#version  3.7;");
   povc("created from OpenSCAD");
   pov("global_settings { assumed_gamma 1.9 }");
   pov(str("#default { texture { pigment { rgb <1,1,0> } finish { ambient 0.15 diffuse 0.85} } }"));
   pov("");
}  

// POV-Ray

module pov_declare(n,v,c) pov(str("#declare ",n," = ",v,";"),c);
module pov_background(c="<0,0,0>") pov(str("background { ", c, " }")); 

module pov_camera(type,location,right,angle,up,rotate,translate,look_at)
{
   pov("camera {");
   pov(str("  ",type));
   pov(parameter("location",location));
   pov(parameter("right", right));
   pov(parameter("angle", angle));
   pov(parameter("up",up));
   pov(parameter("rotate",rotate));
   pov(parameter("translate", translate));
   pov(parameter("look_at", look_at));
   pov("}");
   pov("");
}

module pov_light_source(location,color,m="",translate,rotate)
{
   pov("light_source {");
   pov(str("  ", location, " ", color));
   if (m!= "") pov(m);
   pov(parameter("rotate",rotate));
   pov(parameter("translate", translate));
   pov("}");   
}

// OpenSCAD 

module openscad_background(c="openscad_cornfield")
{
   povc("** OpenSCAD background colors **");
   pov_declare("openscad_cornfield",color([255,255,229]/255));
   pov_declare("openscad_metalic",color([170,170,255]/255));
   pov_declare("openscad_sunset",color([170,68,68]/255));
   pov_background(c=c);
   pov("");
}
  
module openscad_camera(type="perspective", distance=500,width=16,heigth=9)
{
    povc("** OpenSCAD View Port defnition **");
    pov_declare("openscad_vpt",strv($vpt));
    pov_declare("openscad_vpr",strv($vpr));
    // view port distance is not available as special variable (https://github.com/openscad/openscad/issues/839)
    pov_declare("openscad_vpd",distance,"Please set manually"); 
    pov_declare("openscad_vpw",width);
    pov_declare("openscad_vph",heigth);   
    
    pov("#macro openscad_camera_angle(w ,h) (11*pow(w/h,0.5)) #end","OpenSCAD camera angle is dependent on view port aspect ratio. Formula is an estimation");
    pov_camera(
        type =  type,
        location = strv([0,0,"openscad_vpd"]),
        right = strv(["-openscad_vpw/openscad_vph",0,0]),
        angle = "openscad_camera_angle(openscad_vpw,openscad_vph)",
        up = strv([0,0,1]),
        rotate = "openscad_vpr",
        translate = "openscad_vpt",
        look_at = strv([0,0,0])
    );
}

module openscad_light_source()
{
    povc("** OpenSCAD light sources. The location depends on the view port definition **");
    pov_light_source(str(strv([-1,1,1]),"*openscad_vpd + openscad_vpt"), color([1,1,1]), rotate="openscad_vpr");  
    pov_light_source(str(strv([1,-1,-1]),"*openscad_vpd + openscad_vpt"), color([1,1,1]), rotate="openscad_vpr");   
    %union() { // default vpd, as $vpd does not exist (yet)
        rotate($vpr) translate([-1,1,1]*300+$vpt) sphere(r=10);
        rotate($vpr) translate([1,-1,-1]*300+$vpt) sphere(r=10);
    }
    pov("");
}

module openscad_axes(crosshairs=0)
{
    _union()
    {
        _color([1,0,0]) _rotate([0,90,0]) _translate([0,0,4+25]) _cube(size=[2,2,50],center=true);
        _color([0,1,0]) _rotate([-90,0,0]) _translate([0,0,4+25])_cube(size=[4,4,50],center=true);
        _color([0,0,1]) _rotate([0,0,0]) _translate([0,0,4+25]) _cube(size=[8,8,50],center=true);
        _color([1,1,1]) _translate([54,0,0]) _sphere(r=1,$fn=8);
        _color([1,1,1]) _translate([0,54,0]) _sphere(r=2,$fn=8);
        _color([1,1,1]) _translate([0,0,54]) _sphere(r=4,$fn=8);
        if (crosshairs)
        {
            _color([0.2,0.2,0.2]) _rotate([-90+atan(sqrt(2)/2),0,45]) _cylinder(r=1,h=100,center=true);
            _color([0.2,0.2,0.2]) _rotate([-90+atan(sqrt(2)/2),0,-45]) _cylinder(r=1,h=100,center=true);
            _color([0.2,0.2,0.2]) _rotate([90-atan(sqrt(2)/2),0,45]) _cylinder(r=1,h=100,center=true);
            _color([0.2,0.2,0.2]) _rotate([90-atan(sqrt(2)/2),0,-45]) _cylinder(r=1,h=100,center=true);
        }    
    }
}   

module _cube(size = [1, 1, 1], center = false)
{
    cube(size,center);
    assign(psize = (len(size)==undef ? [size,size,size] : size))
    {
        pov(str(
            indent($parent_modules),
            "box {",
            center ? strv(-psize/2) : strv([0,0,0]),",",
            strv(psize/(center ? 2 : 1)),
            povray_defcolor ? pigment(povray_color_cube) : "",
            "}"
        ));
    }
}

module _sphere(r=1)
{
    sphere(r=r);
    if ($fn>0 && $fn<30) povc(str("ignored $fn value:", $fn));
    pov(str(
        indent($parent_modules),
        "sphere {<0,0,0>, ",
        r,
        povray_defcolor ? pigment(povray_color_sphere): "",
        "}"
    ));
}

module __multisided_cone(r1,r2,h,center)
{  
    if (r1 != r2) pove(str("unhandled tapered multisided cone:",r1,"/",r2,"/",h));
    pov(str(indent($parent_modules),"intersection { // ",$fn,"-sided cylinder"));
    for (i = [0:$fn-1])
    {
        pov(str(indent($parent_modules),indentstr,"plane {x, ",cos(180/$fn)*r1," rotate ", strv([0,0,(i + 0.5)*360/$fn]),"}"));
    }
    // top & bottom plane
    pov(str(indent($parent_modules),indentstr,"plane {z, ",(center ? h/2 : h),"}"));
    pov(str(indent($parent_modules),indentstr,"plane {-z, ",(center ? h/2 : 0),"}"));
    pov(str(indent($parent_modules),"}"));
    //pov(str(" bounded_by {sphere{0, 1.5}}"));
}

module _cylinder(r1,r2,r = 1,h = 1, center = false)
{
    assign(r1 = (r1==undef ? r : r1), r2 = (r2 == undef ? r : r2))
    {
        cylinder(r1=r1,r2=r2,h=h,center=center);
        if ($fn>0 && $fn<30) 
            __multisided_cone(r1,r2,h,center);
        else
        {
            pov(str(
                indent($parent_modules),
                "cone {", 
                strv(center ? [0,0,-h/2] : [0,0,0]), ",",
                (r1==undef?r:r1), strv(center ? [0,0,h/2] : [0,0,h]), ",", 
                (r2==undef?r:r2), 
                povray_defcolor ? pigment(povray_color_cylinder) : "","}"
            ));
        }
    }  
}

module _polyhedron(points,faces) // ONLY: Convex polygons
{
    polyhedron(points,faces);
    pov(str(indent($parent_modules),"mesh { "));
    for(i=[0:len(faces)-1])
    {
        for(j=[2:len(faces[i])-1])
        {
            pov(str(
                indent($parent_modules),
                "triangle {",
                strv(points[faces[i][0]]),",",
                strv(points[faces[i][j-1]]),",",
                strv(points[faces[i][j]]),"}"
            ));
        }
    }
    pov(indent($parent_modules),str("}"));
}

module __object(type,children,comment)
{
  pov(str(indent($parent_modules), children==1 ? "object" : "union" , " { ",comment));
}

module _translate(v,c="")
{
  __object("translate",$children,c);
  translate(v) { children([0:$children-1]); }
  pov(str(indent($parent_modules),indentstr,"translate ",strv(v)));
  pov(str(indent($parent_modules),"}")); 
}

module _rotate(v,c="")
{
  __object("rotate",$children,c);
  rotate(v) { children([0:$children-1]); }
  pov(str(indent($parent_modules),indentstr,"rotate ",strv(v)));
  pov(str(indent($parent_modules),"}")); 
}

module _scale(v,c="")
{
  __object("scale", $children,c);
  scale(v) { children([0:$children-1]); }
  pov(str(indent($parent_modules),indentstr,"scale ",strv(v)));
  pov(str(indent($parent_modules),"}")); 
}

module _multmatrix(m,c="")
{
  __object("multimatrix", $children,c);
  multmatrix(m) { children([0:$children-1]); }
  pov(str(indent($parent_modules),indentstr,"matrix ",strv([m[0][0],m[1][0],m[2][0],m[0][1],m[1][1],m[2][1],m[0][2],m[1][2],m[2][2],m[0][3],m[1][3],m[2][3]])));
  pov(str(indent($parent_modules),"}")); 
}

module _color(v,c="")
{
  __object("color",$children,c);
  color(v) { children([0:$children-1]); }
  pov(str(indent($parent_modules),indentstr,pigment([v[0],v[1],v[2],len(v)==4 ? 1-v[3] : 0])));
  pov(str(indent($parent_modules),"}")); 
}

module _difference(c="")
{
  //echo("diff",1,$children-1);
  pov(str(indent($parent_modules),"difference { ", c));
  difference() { children(0); if ($children>1) children([1:$children-1]); }
  pov(str(indent($parent_modules),"} ", c));
}

module _intersection(c="")
{
    pov(str(indent($parent_modules),"intersection { ", c));
    intersection() 
    {
        children(0);
        if ($children>1) children(1);
        if ($children>2) children(2);
        if ($children>3) children(3);
        if ($children>4) pove("Not enough child entries in _intersection module");
    }
  pov(str(indent($parent_modules),"} ", c));
}

module _union(c="")
{
  //echo("union",0,$children-1);
  pov(str(indent($parent_modules), "union { ", c));
  union() { children([0:$children-1]); }
  pov(str(indent($parent_modules),"} ", c));
}

module _group()
{
  pov(str(indent($parent_modules), "union { "));
  if ($children>0) group() { children([0:$children-1]); }
  pov(str(indent($parent_modules),"}"));
}

/////////////////////////////////////////////////////////////////


module test()
{
    pov_init();
    openscad_background();
    openscad_camera(type="perspective", distance=300, width= 16, heigth= 9);
    openscad_light_source(); 
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

test();

