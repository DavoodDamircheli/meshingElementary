// Gmsh project created on Thu Aug 10 12:24:07 2023
SetFactory("OpenCASCADE");
lc = 0.1;
lc2 = 0.1;

Macro myC

 p1 = newp; Point(p1) = {x,y,z,lc};
 p2 = newp; Point(p2) = {-x,y,z,lc};
 p3 = newp; Point(p3) = {x,-y,z,lc};
 c1 = newc; Circle(c1) = {p2,p1,p3};
//c1 = newc; Circle(c1) = {p2,p1,p3,lc2};

Return







For t In {1:1}
 x = 0;
 y = 0;
 z = 0;r = 0.5;
 Call myC;

EndFor
