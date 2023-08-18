lc= 1e-2;
//---------------- `Point'------------------------- 
//A Point is uniquely identified by 
//a tag (a strictly positive integer; here `1') 
// defined by a list of four numbers:
// three coordinates (X, Y and Z) 
// the target mesh size (lc) close to the
// point:

Point(1) = {0,0,0,lc};
Point(2) = {0.1,0,0,lc};
Point(3) = {0.1,.3,0,lc};
Point(4) = {0,0.3,0,lc};



//---------------- `Curve'-------------------------
//  amongst curves,
// straight lines are the simplest.
// A straight line is identified by a tag and
// is defined by a list of two point tags. 

//In the commands below, for example,
// the line 1 starts at point 1 and ends at point 2.
Line(1) = {1,2};
Line(2) = {3,2};
Line(3) = {3,4};
Line(4) = {4,1};

//---------------- `surface`-------------------------
//--------1- curve loop has first to be defined

//A curve loop is also identified by a tag (unique amongst curve loops)
// and defined by an ordered list of connected curves,
// a sign being associated with each curve 
//(depending on the orientation of the curve to form a loop):

Curve Loop(1) = {4,1,-2,3};

//------2- define the surface as a list of curve loops

Plane Surface(1) = {1};

//---------------- `Grouping (optional)`-------------------------
Physical Curve(5) = {1, 2, 4};
Physical Surface("My surface") = {1};


//---------------- `meshing`-------------------------

// Now that the geometry is complete, you can
// - either open this file with Gmsh and select `2D' in the `Mesh' module to
//   create a mesh; then select `Save' to save it to disk in the default format
//   (or use `File->Export' to export in other formats);
// - or run `gmsh t1.geo -2` to mesh in batch mode on the command line.

// You could also uncomment the following lines in this script:
//
   Mesh 2;
//   Save "t1.msh";
//---------------- `Include`-------------------------
//Include "t1.geo";

Point(5) = {0,.4,0,lc};

Line(5)= {4,5};

//---------------- `Transformation-------------------------

//------------Translate
//Trandslate{xDirection,yDirecgtion,zDirectopn}{Point{Targe};}

Translate {-0.02,0,0}{ Point{5};}

//------------Rotate
//--Rotate{{xDirec, zDirec, zDirc},{around the point x,y,x}, angle}{point{target};}

Rotate {{0,0,1},{0,0.3,0}, -Pi/4}{Point{5};}

//------------Duplicate and Translate

Translate {0,0.05,0} { Duplicata{ Point{3};}}

//------------some new point and lines--------------

Line(7) ={3,6};

Line(8) = {6,5};

Curve Loop(10) = {5,-8,-7,3};
Plane Surface(11) = {10};

//--------------Return of Tag and others--------------

my_new_surfs[] = Translate{0.12,0,0}{Duplicata{Surface{1,11};}};

// my_new_surfs[] (note the square brackets, and the `;' at the end of the
// command) denotes a list, which contains the tags of the two new surfaces
// (check `Tools->Message console' to see the message):

Printf("New surfaces '%g' and '%g'", my_new_surfs[0], my_new_surfs[1]);


//---------------------Volume---------------------------
// In the same way  one defines curve loops to build surfaces, 
//1-one has to define surface loops (i.e. `shells') to build volumes.

Point(100) = {0., 0.3, 0.12, lc};
Point(101) = {0.1, 0.3, 0.12, lc};
Point(102) = {0.1, 0.35, 0.12, lc};

xyz[] = Point{5}; //-------------- Get coordinates of point 5
Point(103) = {xyz[0], xyz[1], 0.12, lc};

Line(110) = {4, 100};   Line(111) = {3, 101};
Line(112) = {6, 102};   Line(113) = {5, 103};
Line(114) = {103, 100}; Line(115) = {100, 101};
Line(116) = {101, 102}; Line(117) = {102, 103};


Curve Loop(118) = {115, -111, 3, 110};  Plane Surface(119) = {118};
Curve Loop(120) = {111, 116, -112, -7}; Plane Surface(121) = {120};
Curve Loop(122) = {112, 117, -113, -8}; Plane Surface(123) = {122};
Curv Loop(124) = {114, -110, 5, 113};  Plane Surface(125) = {124};
Curve Loop(126) = {115, 116, 117, 114}; Plane Surface(127) = {126};


Surface Loop(128) = {127, 119, 121, 123, 125, 11};
Volume(129) = {128};

//--------------------Extrud--------------
//    Very PowerFULL!!
//you can think of "extruding" as pulling or pushing a shape into a new dimension, 
// instead of all point, lines and curves!!!!!!!!

Extrude{0,0,0.12} {Surface{my_new_surfs[1]};}

//------------------Meshing-----------------

// The following command permits to manually assign a mesh size to some of the
// new points:

MeshSize {103, 105, 109, 102, 28, 24, 6, 5} = lc * 3;

//Mesh 3;



